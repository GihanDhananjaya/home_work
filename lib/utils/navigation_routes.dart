import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';
import 'package:home_work/views/sign_in/sign_in_view.dart';
import 'package:home_work/views/sign_up/sign_up_view.dart';
import 'package:home_work/views/home/home_view.dart';
import 'package:home_work/views/new_job/new_job_view.dart';
import 'package:home_work/views/all_job/all_job_view.dart';
import 'package:home_work/views/confirm_job/confirm_job_view.dart';
import 'package:home_work/views/reject_job/reject_job_view.dart';
import 'package:home_work/views/user_profile/edit_profile_details_view.dart';
import 'package:home_work/views/bootom_bar/bottom_bar_view.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Routes {
  static const String signIn = '/';
  static const String signUp = '/signup';
  static const String home = '/home';
  static const String newJob = '/new_job';
  static const String allJobs = '/all_job_view';
  static const String confirmJobs = '/confirm_job_view';
  static const String rejectJobs = '/reject_job_view';
  static const String editProfile = '/edit_profile_details_view';
  static const String bottomBar = '/bottom_bar';

  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case signIn:
        final prefs = settings.arguments as SharedPreferences;
        final user = settings.arguments as User?;
        return PageTransition(
            child: isUserLoggedIn(prefs, user)
                ? BottomBarView(user: user)
                : SignInView(prefs: prefs),
            type: PageTransitionType.fade);

      case signUp:
        return PageTransition(
            child: SignUpView(), type: PageTransitionType.rightToLeft);

      case home:
        return PageTransition(
            child: HomeView(), type: PageTransitionType.fade);

      case newJob:
        return PageTransition(
            child: NewJobView(), type: PageTransitionType.rightToLeft);

      case allJobs:
        return PageTransition(
            child: AllJobView(), type: PageTransitionType.rightToLeft);

      case confirmJobs:
        return PageTransition(
            child: ConfirmJobView(), type: PageTransitionType.rightToLeft);

      case rejectJobs:
        return PageTransition(
            child: RejectJobView(), type: PageTransitionType.rightToLeft);

      case editProfile:
        return PageTransition(
            child: EditProfileDetails(userName: ''),
            type: PageTransitionType.rightToLeft);

      default:
        return MaterialPageRoute(
          builder: (_) => const Scaffold(
            body: Center(child: Text("Invalid Route")),
          ),
        );
    }
  }

  static bool isUserLoggedIn(SharedPreferences prefs, User? user) {
    return user != null && prefs.getBool('userLoggedIn') == true;
  }
}
