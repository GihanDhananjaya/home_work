import 'package:email_validator/email_validator.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../common/app_button.dart';
import '../../common/app_text_field.dart';
import '../../utils/app_colors.dart';
import '../../utils/app_dimensions.dart';
import '../../utils/app_images.dart';
import '../bootom_bar/bottom_bar_view.dart';
import '../home/home_view.dart';
import 'common/login_password_field.dart';

class SignInView extends StatefulWidget {
  final SharedPreferences? prefs;

  SignInView({  this.prefs});
  @override
  State<SignInView> createState() => _SignInViewState();
}

class _SignInViewState extends State<SignInView> {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  bool _isLogging = false;
  final FirebaseAuth _auth = FirebaseAuth.instance;


  Future<void> loginUser() async {
    setState(() {
      _isLogging = true;
    });
    try {
      final UserCredential userCredential = await
      _auth.signInWithEmailAndPassword(email: emailController.text,
          password: passwordController.text);
      final User? user = userCredential.user;
      //String userRole = widget.prefs!.getString('userRole') ?? 'User';

      if (user != null) {
        setState(() {});

        widget.prefs!.setBool('userLoggedIn', true);

        Navigator.of(context).pushReplacement(
          MaterialPageRoute(builder: (context) => BottomBarView(user:user)),
        );
      }
    } catch (e) {
      String errorMessage = 'An error occurred. Please try again.';

      if (e is FirebaseAuthException) {
        if (e.code == 'user-not-found') {
          errorMessage = 'No user found with this email address.';
        } else if (e.code == 'wrong-password') {
          errorMessage = 'Wrong password. Please try again.';
        }
      }
      _showErrorDialog(errorMessage);
    }finally {
      setState(() {
        _isLogging = false;
      });
    }
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.containerColor7,
      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(height: 40),
            Text("Job Tasker",
                style: TextStyle(
                    fontWeight: FontWeight.w900,
                    color: AppColors.fontColorDark,
                    fontSize: AppDimensions.kFontSize18)),
            SizedBox(height: 42),
            Image.asset(AppImages.appLogo5, height: 220,),
            SizedBox(height: 42),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 23),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text("Log in to continue",
                      style: TextStyle(
                          fontWeight: FontWeight.w600,
                          color: AppColors.fontColorDark,
                          fontSize: AppDimensions.kFontSize15)),
                  SizedBox(height: 24),
                  AppTextField(
                    hint: "E-mail",
                    icon: Icon(Icons.email_outlined),
                    controller: emailController,
                  ),
                  SizedBox(height: 32),
                  AppPasswordField(
                    hint: "Password",
                    controller: passwordController,
                    icon: Icon(Icons.lock_open),
                  ),
                  SizedBox(height: 24),
                  InkWell(
                    onTap: () {
                      // Navigator.pushNamed(context, Routes.kResetPasswordView);
                    },
                    child: Text("Forget password?",
                        style: TextStyle(
                            decoration: TextDecoration.underline,
                            fontWeight: FontWeight.w600,
                            color: AppColors.colorIconOuter,
                            fontSize: AppDimensions.kFontSize14)),
                  ),
                  SizedBox(height: 12),
                  RichText(
                    text: TextSpan(
                        text: "Don't have an account? ",
                        style: TextStyle(
                          fontSize: AppDimensions.kFontSize16,
                          color: AppColors.colorIconOuter,
                          fontWeight: FontWeight.w600,
                        ),
                        children: [
                          TextSpan(
                            text: 'Register',
                            style: TextStyle(
                              color: AppColors.colorIconOuter,
                              fontWeight: FontWeight.w600,
                              fontSize: AppDimensions.kFontSize16,
                              decoration: TextDecoration.underline,
                              decorationColor: AppColors.fontColorDark,
                            ),
                            recognizer: TapGestureRecognizer()
                              ..onTap = () {
                                Navigator.pushNamed(context, '/signup');
                              },
                          )
                        ]),
                  ),
                  SizedBox(height: 100),
                  AppButton(
                    buttonText: "Login",
                    onTapButton: () async {
                      if (_fieldValidation()) {
                        await loginUser();
                      }
                    },
                  ),
                  SizedBox(height: 30),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  bool _fieldValidation() {
    if (emailController.text.isEmpty) {
      _showErrorDialog('Email cannot be empty');
      return false;
    } else if (passwordController.text.isEmpty) {
      _showErrorDialog('Password cannot be empty');
      return false;
    } else if (!EmailValidator.validate(emailController.text)) {
      _showErrorDialog('Please enter a valid email');
      return false;
    } else {
      return true;
    }
  }

  Future<void> _signIn() async {
    try {
      UserCredential userCredential = await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: emailController.text,
        password: passwordController.text,
      );

      // Check if user exists in Firestore
      DocumentSnapshot userDoc = await FirebaseFirestore.instance.collection('users').
      doc(userCredential.user?.uid).get();
      if (userDoc.exists) {
        Navigator.pushReplacementNamed(context, '/home');
      } else {
        _showErrorDialog('No user found for this email.');
      }
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
