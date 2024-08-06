import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:intl_phone_field/phone_number.dart';
import '../../common/app_button.dart';
import '../../common/app_mobile_number_field.dart';
import '../../common/app_text_field.dart';
import '../../utils/app_colors.dart';
import '../../utils/app_dimensions.dart';
import '../../utils/app_images.dart';
import '../bootom_bar/bottom_bar_view.dart';
import '../sign_in/common/login_password_field.dart';

class SignUpView extends StatefulWidget {
  const SignUpView({super.key});

  @override
  State<SignUpView> createState() => _SignUpViewState();
}

class _SignUpViewState extends State<SignUpView> {
  final nameController = TextEditingController();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final confirmPasswordController = TextEditingController();

  final mobileNumberController = TextEditingController();
  PhoneNumber? phoneNumber;
  final focusNode = FocusNode();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.containerColor7,
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 23.0),
          child: Column(
            children: [
              SizedBox(height: 40),
              Text(
                "Job Tasker",
                style: TextStyle(
                  fontWeight: FontWeight.w900,
                  color: AppColors.colorPrimary,
                  fontSize: AppDimensions.kFontSize18,
                ),
              ),
              Image.asset(AppImages.appLogo5, height: 220,),
              SizedBox(height: 22),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(height: 42),
                  Text(
                    "Welcome to the Job Tasker",
                    style: TextStyle(
                      fontWeight: FontWeight.w600,
                      color: AppColors.fontColorDark,
                      fontSize: AppDimensions.kFontSize15,
                    ),
                  ),
                  SizedBox(height: 24),
                  AppTextField(
                    hint: 'Name',
                    controller: nameController,
                    icon: Icon(Icons.person_2_outlined),
                  ),
                  SizedBox(height: 24),
                  AppTextField(
                    hint: 'E-mail',
                    controller: emailController,
                    icon: Icon(Icons.email_outlined),
                  ),
                  SizedBox(height: 24),
                  AppMobileNumberField(
                    hint: 'Mobile Number',
                    focusNode: focusNode,
                    initialCountryCode: phoneNumber != null
                        ? phoneNumber!.countryCode
                        .replaceAll('+', '')
                        : null,
                    onChange: (phone ) {
                      setState(() {
                        if (phone.number.isNotEmpty) {
                          phoneNumber = phone;
                        } else {
                          if (phoneNumber != null) {
                            phoneNumber!.number = '';
                          }
                        }
                      });
                    },
                    controller: mobileNumberController,
                    onCountryChange: (country ) {
                      focusNode.requestFocus(); },
                  ),
                  SizedBox(height: 24),
                  AppPasswordField(
                    hint: "Password",
                    controller: passwordController,
                    icon: Icon(Icons.lock_open),
                  ),
                  SizedBox(height: 24),
                  AppPasswordField(
                    hint: "Confirm Password",
                    controller: confirmPasswordController,
                    icon: Icon(Icons.lock_open),
                  ),
                  SizedBox(height: 40),
                  AppButton(
                    buttonText: "Create account",
                    onTapButton: () async {
                      if (_fieldValidation()) {
                        await _signUp();
                      }
                    },
                  ),
                  SizedBox(height: 30),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  bool _fieldValidation() {
    if (nameController.text.isEmpty) {
      _showErrorDialog('Name cannot be empty');
      return false;
    } else if (emailController.text.isEmpty) {
      _showErrorDialog('Email cannot be empty');
      return false;
    } else if (passwordController.text.isEmpty) {
      _showErrorDialog('Password cannot be empty');
      return false;
    } else if (confirmPasswordController.text.isEmpty) {
      _showErrorDialog('Confirm password cannot be empty');
      return false;
    } else if (passwordController.text != confirmPasswordController.text) {
      _showErrorDialog('Password didn’t match');
      return false;
    } else {
      return true;
    }
  }

  Future<void> _signUp() async {
    try {
      // Create user with email and password
      UserCredential userCredential = await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: emailController.text,
        password: passwordController.text,
      );

      // Fetch the current user ID and increment it atomically
      DocumentReference counterRef = FirebaseFirestore.instance.collection('user_metadata').doc('counter');
      int userId = await FirebaseFirestore.instance.runTransaction((transaction) async {
        DocumentSnapshot counterSnapshot = await transaction.get(counterRef);

        if (!counterSnapshot.exists) {
          counterRef.set({'current_user_id': 1});
          return 1;
        }

        int currentUserId = counterSnapshot['current_user_id'];
        int newUserId = currentUserId + 1;
        transaction.update(counterRef, {'current_user_id': newUserId});
        return newUserId;
      });

      // Save user information along with the new user ID
      await FirebaseFirestore.instance.collection('users').doc(userCredential.user?.uid).set({
        'user_id': userId,
        'name': nameController.text,
        'email': emailController.text,
        'mobile': mobileNumberController.text,
        'user_role': 'user',
        'createdAt': Timestamp.now(),
      });

      // Navigate to the next screen or show success message
      Navigator.push(context, MaterialPageRoute(builder: (context) => BottomBarView(),));
    } on FirebaseAuthException catch (e) {
      _showErrorDialog(e.message);
    } catch (e) {
      _showErrorDialog('An error occurred. Please try again.');
    }
  }


  void _showErrorDialog(String? message) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text('Error'),
          content: Text(message ?? 'Unknown error'),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text('OK'),
            ),
          ],
        );
      },
    );
  }
}
