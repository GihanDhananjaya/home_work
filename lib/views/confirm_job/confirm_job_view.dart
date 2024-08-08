import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:home_work/views/confirm_job/widget/confirm_job_component.dart';
import 'package:day_night_time_picker/lib/state/time.dart';

import '../../utils/app_colors.dart';

class ConfirmJobView extends StatefulWidget {
  const ConfirmJobView({super.key});

  @override
  State<ConfirmJobView> createState() => _ConfirmJobViewState();
}

class _ConfirmJobViewState extends State<ConfirmJobView> {
  String userRole = '';

  @override
  void initState() {
    super.initState();
    _checkUserRole();
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
          'Confirm Jobs',
          style: TextStyle(color: Colors.white),
        ),
      ),
      body: StreamBuilder<QuerySnapshot>(
        stream: userRole == 'admin'
            ? FirebaseFirestore.instance.collection('confirm_job').snapshots()
            : FirebaseFirestore.instance.collection('confirm_job').where('user_id', isEqualTo: currentUser!.uid).snapshots(),
        builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
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
                child: ConfirmJobComponent(
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
