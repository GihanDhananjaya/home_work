import 'dart:io';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../utils/app_colors.dart';
import '../../utils/app_images.dart';
import '../bootom_bar/bottom_bar_view.dart';
import '../sign_in/sign_in_view.dart';

class SplashView extends StatefulWidget {
  final SharedPreferences prefs;
  final User? user;

  const SplashView({super.key, required this.prefs, required this.user});

  @override
  State<SplashView> createState() => _SplashViewState();
}

class _SplashViewState extends State<SplashView> {
  @override
  void initState() {
    super.initState();
    checkConnection();
  }

  Future<void> checkConnection() async {

    final connectivityResult = await Connectivity().checkConnectivity();

    bool hasInternet = false;

    if (connectivityResult == ConnectivityResult.mobile ||
        connectivityResult == ConnectivityResult.wifi) {
      try {
        final result = await InternetAddress.lookup('google.com');
        if (result.isNotEmpty && result[0].rawAddress.isNotEmpty) {
          hasInternet = true;
        }
      } on SocketException catch (_) {
        hasInternet = false;
      }
    }

    if (hasInternet) {
      _navigate();
    } else {
      await showDialog(
        context: context,
        builder: (_) => AlertDialog(
          title: Column(
            children: [
              Text("No Internet Connection",style: TextStyle(
                  fontSize: 24,fontWeight: FontWeight.w500
              ),),
              SizedBox(height: 10,),
              Text("Please check your connection and try again.",style: TextStyle(
                  fontSize: 14,fontWeight: FontWeight.w400
              ),),
            ],
          ),
          content: Container(
            padding: EdgeInsets.all(8),
            decoration: BoxDecoration(
              gradient: LinearGradient(colors: [
                AppColors.btnGradient1.withOpacity(0.3),
                AppColors.fontColorDark.withOpacity(0.3)
              ]),
              shape: BoxShape.circle,
              border: Border.all(color: Colors.black54),
            ),
            child: ClipOval(
              child: Image.asset(
                AppImages.appInternetErrorImg,
                height: 230,
                width: 230,
                fit: BoxFit.cover,
              ),
            ),
          ),
          actions: [
            TextButton(
              child: Text("Retry"),
              onPressed: () {
                Navigator.of(context).pop();

              },
            ),
          ],
        ),
      );
    }
  }

  Future<void> _navigate() async {
    await Future.delayed(const Duration(seconds: 2));

    bool isLoggedIn = widget.prefs.getBool('userLoggedIn') ?? false;
    User? firebaseUser = FirebaseAuth.instance.currentUser;

    if (isLoggedIn && firebaseUser != null) {
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(builder: (_) => BottomBarView(user: firebaseUser)),
      );
    } else {
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(builder: (_) => SignInView(prefs: widget.prefs)),
      );
    }
  }

  @override
  Widget build(BuildContext context) {

    return const Scaffold(
      backgroundColor: AppColors.btnGradient1,
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Center(
            child: Text(
              "Job Tasker",
              style: TextStyle(
                color: AppColors.fontColorWhite,
                fontWeight: FontWeight.w700,
                fontSize: 26,
              ),
            ),
          ),
          SizedBox(height: 44),
          Text(
            'Version 0.0.2',
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w500,
              color: AppColors.fontColorWhite,
            ),
          ),
        ],
      ),
    );
  }
}
