import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:home_work/views/confirm_job/widget/confirm_job_component.dart';
import 'package:day_night_time_picker/lib/state/time.dart';
import 'package:home_work/views/reject_job/widget/reject_job_component.dart';

import '../../common/show_dialog.dart';
import '../../utils/app_colors.dart';

class RejectJobView extends StatefulWidget {
  const RejectJobView({super.key});

  @override
  State<RejectJobView> createState() => _RejectJobViewState();
}

class _RejectJobViewState extends State<RejectJobView> {
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


  Time? _parseTime(String? timeString) {
    if (timeString == null) return null;
    try {
      final timeRegExp = RegExp(r'(\d{1,2}):(\d{2})\s?(AM|PM)', caseSensitive: false);
      final match = timeRegExp.firstMatch(timeString);
      if (match != null) {
        int hour = int.parse(match.group(1)!);
        final int minute = int.parse(match.group(2)!);
        final String period = match.group(3)!.toUpperCase();

        if (period == 'PM' && hour != 12) {
          hour += 12;
        } else if (period == 'AM' && hour == 12) {
          hour = 0;
        }

        return Time(hour: hour, minute: minute, second: 0);
      }
    } catch (e) {
      print('Error parsing time string: $e');
    }
    return null; // Return null if parsing fails
  }

  Future<void> _checkUserRole() async {
    User? currentUser = FirebaseAuth.instance.currentUser;
    if (currentUser != null) {
      DocumentSnapshot userDoc = await FirebaseFirestore.instance.collection('users').doc(currentUser.uid).get();
      setState(() {
        userRole = userDoc['user_role'];
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    User? currentUser = FirebaseAuth.instance.currentUser;
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
          'Reject Jobs',

          style: TextStyle(color: Colors.white,fontWeight: FontWeight.w500,fontSize: 18),
        ),
      ),
      body: StreamBuilder<QuerySnapshot>(
        stream: userRole == 'admin'
            ? FirebaseFirestore.instance.collection('reject_job').snapshots()
            : FirebaseFirestore.instance.collection('reject_job').where('user_id', isEqualTo: currentUser!.uid).snapshots(),
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
              var data = document.data() as Map<String, dynamic>;
              var confirmedDate = data.containsKey('date') ? data['date'] : 'Date not available';
              var timeString = data.containsKey('time') ? data['time'] : null;
              var time = _parseTime(timeString);

              return Padding(
                padding: const EdgeInsets.all(8.0),
                child: RejectJobComponent(
                  onTap: (){
                    CommonDialogUtil.showAppDialog(
                      context: context,
                      title: 'Success',
                      description: 'Do you need to delete reject Job ?',
                      negativeButtonText: 'No',
                      positiveButtonText: 'Yes',
                      onPositiveCallback: () async {
                        try {
                          var jobData = document.data() as Map<String, dynamic>;
                          jobData['status'] = 'reject';
                          jobData['rejected_at'] = Timestamp.now(); // optional

                          // Save to done_job table
                          await FirebaseFirestore.instance
                              .collection('done_job')
                              .doc(document.id)
                              .set(jobData);

                          await FirebaseFirestore.instance
                              .collection('reject_job')
                              .doc(document.id)
                              .delete();
                        } catch (e) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(content: Text('Error deleting job: $e')),
                          );
                        }
                      },
                    );
                  },
                  adminDescription: document['admin_description'],
                  confirmedDate: confirmedDate,
                  time: time,
                  name: document['category'],
                  title: document['device'],
                  location: document['location'],
                  userName: document['name'],
                ),
              );
            },
          );
        },
      ),
    );
  }
}
