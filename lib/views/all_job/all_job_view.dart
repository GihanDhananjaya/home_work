import 'package:day_night_time_picker/lib/daynight_timepicker.dart';
import 'package:day_night_time_picker/lib/state/time.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart'; // Import FirebaseAuth
import 'package:home_work/views/all_job/widget/all_job_component.dart';
import 'package:intl/intl.dart';

import '../../common/show_dialog.dart';
import '../../utils/app_colors.dart';

class AllJobView extends StatefulWidget {
  const AllJobView({super.key});

  @override
  State<AllJobView> createState() => _AllJobViewState();
}

class _AllJobViewState extends State<AllJobView> {
  User? currentUser = FirebaseAuth.instance.currentUser;
  Map<String, Time> _jobTimes = {};
  DateTime selectedDate = DateTime.now();
  String? selectedFormatDate;
  String userRole = '';
  bool _initialLoading = true;

  @override
  void initState() {
    super.initState();
    _checkUserRole();

    Future.delayed(Duration(seconds: 1), () {
      setState(() {
        _initialLoading = false;
      });
    });
  }

  Future<void> _checkUserRole() async {
    User? currentUser = FirebaseAuth.instance.currentUser;
    if (currentUser != null) {
      DocumentSnapshot userDoc = await FirebaseFirestore.instance
          .collection('users')
          .doc(currentUser.uid)
          .get();

      if (userDoc.exists && userDoc.data() != null) {
        var data = userDoc.data() as Map<String, dynamic>;
        setState(() {
          userRole = data['user_role'] ?? ''; // මෙහි null නම් හිස් string එකක් දමනවා
        });
      } else {
        setState(() {
          userRole = '';
        });
      }
    }
  }


  Future<void> _deleteDocument(String docId) async {
    try {
      await FirebaseFirestore.instance.collection('job').doc(docId).delete();
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Error deleting item: $e')));
    }
  }


  Future<void> _confirmJob(
      String docId, String category, String description, Time time, String date, String adminDescription,
      String device, String location, String userName,String userId,String userRole) async {
    try {
      final hour = time.hour > 12 ? time.hour - 12 : time.hour == 0 ? 12 : time.hour;
      final period = time.hour >= 12 ? 'PM' : 'AM';
      final formattedTime = "${hour.toString().padLeft(2, '0')}:${time.minute.toString().padLeft(2, '0')} $period";


      await FirebaseFirestore.instance.collection('confirm_job').add({
        'category': category,
        'description': description,
        'time': formattedTime,
        'date': date,
        'admin_description': adminDescription,
        'device': device,
        'location': location,
        'name': userName,
        'user_id': userId,
        'user_role': userRole,
      });
      await _deleteDocument(docId);

      CommonDialogUtil.showAppDialog(
        context: context,
        title: 'Success',
        description: 'Your job confirm successfully!',
        negativeButtonText: 'Ok',

      );
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Error confirming job: $e')));
    }
  }

  Future<void> _rejectJob(
      String docId, String category, String description, Time time, String date, String adminDescription,
      String device, String location, String userName,String userId,String userRole) async {
    try {
      final hour = time.hour > 12 ? time.hour - 12 : time.hour == 0 ? 12 : time.hour;
      final period = time.hour >= 12 ? 'PM' : 'AM';
      final formattedTime = "${hour.toString().padLeft(2, '0')}:${time.minute.toString().padLeft(2, '0')} $period";


      await FirebaseFirestore.instance.collection('reject_job').add({
        'category': category,
        'description': description,
        'time': formattedTime,
        'date': date,
        'admin_description': adminDescription,
        'device': device,
        'location': location,
        'name': userName,
        'user_id': userId,
        'user_role': userRole,
      });
      await _deleteDocument(docId);
      CommonDialogUtil.showAppDialog(
        context: context,
        title: 'Success',
        description: 'Your job reject successfully!',
        negativeButtonText: 'Ok',

      );
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Error reject job: $e')));
    }
  }


  @override
  Widget build(BuildContext context) {
    User? currentUser = FirebaseAuth.instance.currentUser;
    if (currentUser == null) {
      return Scaffold(
        backgroundColor: AppColors.containerColor7,
        appBar: AppBar(
          flexibleSpace: Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  AppColors.btnGradient1,
                  AppColors.fontColorDark,
                ],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
            ),
          ),
          title: Text(
            'All Jobs',
            style: TextStyle(color: Colors.white,fontWeight: FontWeight.w500,fontSize: 18),
          ),
        ),
        body: Center(
          child: Text('User not logged in'),
        ),
      );
    }

    return Scaffold(
      backgroundColor: AppColors.containerColor7,
      appBar: AppBar(
        flexibleSpace: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [
                AppColors.btnGradient1,
                AppColors.fontColorDark,
              ],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
          ),
        ),
        title: Text(
          'All Jobs',
          style: TextStyle(color: Colors.white,fontWeight: FontWeight.w500,fontSize: 18),
        ),
      ),
      body: StreamBuilder(
        stream: userRole == 'admin'
            ? FirebaseFirestore.instance.collection('job').snapshots()
            : FirebaseFirestore.instance.collection('job').where('user_id', isEqualTo: currentUser.uid).snapshots(),
        builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (_initialLoading ||snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          }
          if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
            return Center(child: Text('No data available'));
          }
          return ListView.builder(
            itemCount: snapshot.data!.docs.length,
            itemBuilder: (context, index) {
              var document = snapshot.data!.docs[index];
              var docId = document.id;
              var jobTime = _jobTimes[docId] ?? Time(hour: 11, minute: 30, second: 0);
              var adminDescriptionController = TextEditingController();
              return Padding(
                padding: const EdgeInsets.all(8.0),
                child: AllJobComponent(
                  isAdmin: userRole,
                  adminDescriptionController: adminDescriptionController,
                  description: document['description'],
                  title: document['device'],
                  mobileNumber: document['mobile_number'],
                  userName: document['name'],
                  addedDate: document['date'],
                  showDate: selectedFormatDate,
                  setDate: () {
                    _selectDate(context);
                  },
                  showTime: jobTime,
                  onTap: () {
                    if (selectedFormatDate == null || _jobTimes[docId] == null) {
                      CommonDialogUtil.showAppDialog(
                        context: context,
                        title: 'Error',
                        description: 'Please select your available Date and time',
                        negativeButtonText: 'Ok',

                      );
                    } else {
                      _confirmJob(
                        docId,
                        document['category'],
                        document['description'],
                        _jobTimes[docId]!,
                        selectedFormatDate!,
                        adminDescriptionController.text,
                        document['device'],
                        document['location'],
                        document['name'],
                        document['user_id'],
                        document['user_role'],
                      );
                    }

                  },
                  deleteTap: (){
                    if (adminDescriptionController.text.trim().isEmpty) {
                      CommonDialogUtil.showAppDialog(
                        context: context,
                        title: 'Error',
                        description: 'Please enter a reason before rejecting the job.',
                        negativeButtonText: 'Ok',
                      );
                    } else {
                      _rejectJob(
                        docId,
                        document['category'],
                        document['description'],
                        jobTime,
                        selectedFormatDate ?? '', // can be empty string
                        adminDescriptionController.text,
                        document['device'],
                        document['location'],
                        document['name'],
                        document['user_id'],
                        document['user_role'],
                      );
                    }
                  },
                  name: document['category'],
                  location: document['location'],
                  setTime: () {
                    Navigator.of(context).push(
                      showPicker(
                        context: context,
                        value: _jobTimes[docId] ?? Time(hour: 11, minute: 30, second: 0),
                        onChange: (Time newTime) {
                          setState(() {
                            _jobTimes[docId] = newTime;
                          });
                        },
                      ),
                    );
                  },
                ),
              );
            },
          );
        },
      ),
    );
  }

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: selectedDate,
      firstDate: DateTime(2015, 8),
      lastDate: DateTime(2101),
    );
    if (picked != null && picked != selectedDate) {
      setState(() {
        selectedDate = picked;
        selectedFormatDate = DateFormat('MMM d, yyyy').format(selectedDate);
      });
    }
  }


}
