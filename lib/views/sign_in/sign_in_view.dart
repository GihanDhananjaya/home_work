import 'package:email_validator/email_validator.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:google_sign_in/google_sign_in.dart';
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

  @override
  void initState() {

    super.initState();
  }

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


  Future<void> _signInWithGoogle() async {
    try {
      final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();
      if (googleUser == null) return; // Cancelled

      final GoogleSignInAuthentication googleAuth = await googleUser.authentication;

      final credential = GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );

      final UserCredential userCredential =
      await FirebaseAuth.instance.signInWithCredential(credential);

      final user = userCredential.user;

      await FirebaseFirestore.instance.collection('users').doc(user!.uid).set({
        'name': user.displayName,
        'email': user.email,
        'photoUrl': user.photoURL,
        'user_id': user.uid,
        'mobile': user.phoneNumber,
        'user_role': 'user',
      });


      if (user != null) {
        // Save login to SharedPreferences
        await widget.prefs?.setBool('userLoggedIn', true);

        // Navigate to BottomBarView
        Navigator.of(context).pushReplacement(
          MaterialPageRoute(builder: (context) => BottomBarView(user: user)),
        );
      }
    } catch (e) {
      _showErrorDialog('Google Sign-In failed. Please try again.');
      print('Google Sign-In Error: $e');
    }
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.containerColor7,
      body: SingleChildScrollView(
        child: Column(
          children: [
            Center(
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    SizedBox(height: 40),
                    Text("Job Tasker",
                        style: TextStyle(
                            fontWeight: FontWeight.w900,
                            color: AppColors.fontColorDark,
                            fontSize: AppDimensions.kFontSize18)),
                    SizedBox(height: 42),
                    Image.asset(AppImages.appLoginImg, height: 220,),
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
                          SizedBox(height: 50),
                          AppButton(
                            buttonText: "Login",
                            onTapButton: () async {
                              if (_fieldValidation()) {
                                await loginUser();
                              }
                            },
                          ),

                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
            GestureDetector(
              onTap: (){
                Navigator.pushNamed(context, '/signup');
              },
              child: Padding(
                padding: EdgeInsets.symmetric(vertical: 20.0),
                child: Align(
                  alignment: Alignment.bottomCenter,
                  child: Text(
                    'Already have an account? SignUp',
                    textAlign: TextAlign.end,
                    style: TextStyle(
                      fontSize: AppDimensions.kFontSize12,
                      fontWeight: FontWeight.w400,
                      color: AppColors.fontColorGray,
                      decoration:
                      TextDecoration.underline,
                      decorationColor:
                      AppColors.colorReviewing,
                    ),
                  ),
                ),
              ),
            ),
            Text('Or'),
            SizedBox(height: 12),
            ElevatedButton.icon(
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.white,
                foregroundColor: Colors.black,
                minimumSize: Size(12, 18),
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
              ),
              icon: ClipRRect(
                  borderRadius: BorderRadius.circular(60),
                  child: Image.asset(AppImages.appGoogleImg, height: 25)), // Add google icon to assets
              label: Text('Sign in with Google'),
              onPressed: _signInWithGoogle,
            ),
            SizedBox(height: 12),
        
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
