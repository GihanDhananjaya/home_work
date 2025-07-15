import 'dart:io';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../utils/app_colors.dart';
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
          title: Text("No Internet Connection"),
          content: Text("Please check your connection and try again."),
          actions: [
            TextButton(
              child: Text("Retry"),
              onPressed: () {
                Navigator.of(context).pop();
                checkConnection();
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
