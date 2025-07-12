import 'package:flutter/material.dart';
import 'package:home_work/views/all_job/all_job_view.dart';
import 'package:home_work/views/confirm_job/confirm_job_view.dart';
import 'package:home_work/views/home/home_view.dart';
import 'package:home_work/views/new_job/new_job_view.dart';
import 'package:home_work/views/reject_job/reject_job_view.dart';
import 'package:home_work/views/sign_in/sign_in_view.dart';
import 'package:home_work/views/sign_up/sign_up_view.dart';
import '../views/user_profile/edit_profile_details_view.dart';

class AppRoutes {
  static const String signIn = '/sign_in';
  static const String signUp = '/signup';
  static const String home = '/home';
  static const String newJob = '/new_job';
  static const String allJob = '/all_job_view';
  static const String confirmJob = '/confirm_job_view';
  static const String rejectJob = '/reject_job_view';
  static const String editProfile = '/edit_profile_details_view';

  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case signIn:
        return MaterialPageRoute(builder: (_) => SignInView());

      case signUp:
        return MaterialPageRoute(builder: (_) => SignUpView());

      case home:
        return MaterialPageRoute(builder: (_) => HomeView());

      case newJob:
        return MaterialPageRoute(builder: (_) => NewJobView());

      case allJob:
        return MaterialPageRoute(builder: (_) => AllJobView());

      case confirmJob:
        return MaterialPageRoute(builder: (_) => ConfirmJobView());

      case rejectJob:
        return MaterialPageRoute(builder: (_) => RejectJobView());

      case editProfile:
        final args = settings.arguments as String? ?? '';
        return MaterialPageRoute(
          builder: (_) => EditProfileDetails(userName: args),
        );

      default:
        return MaterialPageRoute(
          builder: (_) => const Scaffold(
            body: Center(child: Text("Invalid route")),
          ),
        );
    }
  }
}
