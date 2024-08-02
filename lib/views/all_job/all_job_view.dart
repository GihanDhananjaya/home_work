import 'package:day_night_time_picker/lib/daynight_timepicker.dart';
import 'package:day_night_time_picker/lib/state/time.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:home_work/views/all_job/widget/all_job_component.dart';
import 'package:intl/intl.dart';

import '../../utils/app_colors.dart';

class AllJobView extends StatefulWidget {
  const AllJobView({super.key});

  @override
  State<AllJobView> createState() => _AllJobViewState();
}

class _AllJobViewState extends State<AllJobView> {
  Map<String, Time> _jobTimes = {};
  DateTime selectedDate = DateTime.now();
  String? selectedFormatDate;

  // Method to delete a document from Firestore
  Future<void> _deleteDocument(String docId) async {
    try {
      await FirebaseFirestore.instance.collection('job').doc(docId).delete();
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Item deleted successfully')));
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Error deleting item: $e')));
    }
  }

  // Method to show a dialog for editing a document
  Future<void> _editDocument(String docId, String firstName, String lastName,) async {
    TextEditingController firstNameController = TextEditingController(text: firstName);
    TextEditingController lastNameController = TextEditingController(text: lastName);

    return showDialog<void>(
      context: context,
      barrierDismissible: false, // User must tap a button to close the dialog
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Edit Details'),
          content: SingleChildScrollView(
            child: ListBody(
              children: <Widget>[
                TextField(
                  controller: firstNameController,
                  decoration: InputDecoration(labelText: 'First Name'),
                ),
                TextField(
                  controller: lastNameController,
                  decoration: InputDecoration(labelText: 'Last Name'),
                ),
              ],
            ),
          ),
          actions: <Widget>[
            TextButton(
              child: Text('Cancel'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            TextButton(
              child: Text('Save'),
              onPressed: () async {
                try {
                  await FirebaseFirestore.instance.collection('personal_details').doc(docId).update({
                    'first_name': firstNameController.text,
                    'last_name': lastNameController.text,
                  });
                  Navigator.of(context).pop();
                  ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Item updated successfully')));
                } catch (e) {
                  ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Error updating item: $e')));
                }
              },
            ),
          ],
        );
      },
    );
  }

  // Method to move a document from 'job' to 'confirm_job' and then delete it
  Future<void> _confirmJob(String docId, String category, String description, Time time, String date,
      String adminDescription,String device,String location,String userName) async {
    try {
      // Format the time with AM/PM
      final hour = time.hour > 12 ? time.hour - 12 : time.hour == 0 ? 12 : time.hour;
      final period = time.hour >= 12 ? 'PM' : 'AM';
      final formattedTime = "${hour.toString().padLeft(2, '0')}:${time.minute.toString().padLeft(2, '0')} $period";

      // Add the document to 'confirm_job' collection
      await FirebaseFirestore.instance.collection('confirm_job').add({
        'category': category,
        'description': description,
        'time': formattedTime,
        'date': date,
        'admin_description': adminDescription,
        'device': device,
        'location': location,
        'name': userName,
      });
      // Delete the document from 'job' collection
      await _deleteDocument(docId);
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Job confirmed successfully')));
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Error confirming job: $e')));
    }
  }

  // Method to show time picker and update job time
  void _selectTime(String docId) {
    showPicker(
      context: context,
      value: _jobTimes[docId] ?? Time(hour: 11, minute: 30, second: 0),
      onChange: (Time newTime) {
        setState(() {
          _jobTimes[docId] = newTime;
        });
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.containerColor7,
      appBar: AppBar(
        flexibleSpace: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [
                AppColors.btnGradient1,
                AppColors.fontColorDark
              ],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
          ),
        ),
        title: Text(
          'All Jobs',
          style: TextStyle(color: Colors.white),
        ),
      ),
      body: StreamBuilder(
        stream: FirebaseFirestore.instance.collection('job').snapshots(),
        builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
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
                        _confirmJob(docId,
                        document['category'],
                        document['description'],
                        jobTime,
                        selectedFormatDate!,
                        adminDescriptionController.text,
                          document['device'],
                          document['location'],
                          document['name'],
                        );
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
