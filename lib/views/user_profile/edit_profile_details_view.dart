import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:home_work/common/app_button.dart';
import 'package:home_work/common/app_text_field.dart';
import 'package:home_work/views/user_profile/user_profile_view.dart';
import 'package:intl_phone_field/phone_number.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../common/app_mobile_number_field.dart';
import '../../common/app_rectangel_shimmer.dart';
import '../../utils/app_colors.dart';
import '../../utils/app_dimensions.dart';
import '../sign_in/common/login_password_field.dart';
import 'common/profile_component.dart';

class EditProfileDetails extends StatefulWidget {
  UserData userdata;

  EditProfileDetails({required this.userdata});

  @override
  State<EditProfileDetails> createState() => _EditProfileDetailsState();
}

class _EditProfileDetailsState extends State<EditProfileDetails> {
  String? userName;
  String? userEmail;
  final nameController = TextEditingController();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final confirmPasswordController = TextEditingController();
  final currentPasswordController = TextEditingController();

  final mobileNumberController = TextEditingController();
  PhoneNumber? phoneNumber;
  final focusNode = FocusNode();

  @override
  void initState() {
    setState(() {
      nameController.text = widget.userdata.userName;
      emailController.text = widget.userdata.email;
      mobileNumberController.text = widget.userdata.mobileNumber!;
      super.initState();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.containerColor7,
      appBar: AppBar(
        flexibleSpace: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [AppColors.btnGradient1, AppColors.fontColorDark],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
          ),
        ),
        title: Text(
          'Edit Profile Detals',
          style: TextStyle(
              color: Colors.white, fontWeight: FontWeight.w500, fontSize: 18),
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 20.0, vertical: 20),
          child: Column(
            children: [
              SizedBox(height: 20),
              AppTextField(hint: 'Name',controller: nameController,),
              const SizedBox(height: 10),
              AppTextField(hint: 'Email',controller: emailController,),
              const SizedBox(height: 10),
              //
              // AppMobileNumberField(
              //   appMobileNumberController: null,
              //   title: 'Mobile Number',
              //   focusNode: focusNode,
              //   initialCountryCode: phoneNumber != null
              //       ? phoneNumber!.countryCode
              //       .replaceAll('+', '')
              //       : null,
              //   onChange: (phone ) {
              //     setState(() {
              //       if (phone.number.isNotEmpty) {
              //         phoneNumber = phone;
              //       } else {
              //         if (phoneNumber != null) {
              //           phoneNumber!.number = '';
              //         }
              //       }
              //     });
              //   },
              //   controller: mobileNumberController,
              //   onCountryChange: (country ) {
              //     focusNode.requestFocus(); },
              // ),
              SizedBox(height: 40,),

              AppButton(
                buttonText: "Save",
                  onTapButton: () async {
                    try {
                      final user = FirebaseAuth.instance.currentUser;
                      if (user == null) return;

                      final updatedName = nameController.text.trim();
                      final updatedEmail = emailController.text.trim();
                      final updatedMobile = mobileNumberController.text.trim();

                      // Validate passwords
                      if (passwordController.text.isNotEmpty &&
                          passwordController.text != confirmPasswordController.text) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(content: Text("Passwords do not match")),
                        );
                        return;
                      }

                      // Update Firestore
                      await FirebaseFirestore.instance.collection('users').doc(user.uid).update({
                        'name': updatedName,
                        'email': updatedEmail,
                        'mobile': updatedMobile,
                      });

                      // Update SharedPreferences
                      final prefs = await SharedPreferences.getInstance();
                      await prefs.setString('userName', updatedName);
                      await prefs.setString('userEmail', updatedEmail);
                      await prefs.setString('mobile', updatedMobile);

                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(content: Text("Profile updated successfully")),
                      );

                      Navigator.pop(context);
                    } catch (e) {
                      print("Error updating profile: $e");
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(content: Text("Failed to update profile")),
                      );
                    }
                  }

              )

            ],
          ),
        ),
      ),
    );
  }
}
