// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';
// import 'package:google_fonts/google_fonts.dart';
// import 'package:shared_preferences/shared_preferences.dart';
// import '../utils/app_colors.dart';
// import '../utils/app_constants.dart';
// import '../utils/navigation_routes.dart';
//
// class HomeWork extends StatefulWidget {
//   @override
//   State<HomeWork> createState() => _HomeWorkState();
// }
//
// class _HomeWorkState extends State<HomeWork> {
//   final prefs = await SharedPreferences.getInstance();
//   final FirebaseAuth _auth = FirebaseAuth.instance;
//   final User? user = _auth.currentUser;
//
//   final SharedPreferences prefs;
//   final User? user;
//
//   @override
//   Widget build(BuildContext context) {
//     return ScreenUtilInit(
//         designSize: const Size(390, 844),
//         minTextAdapt: true,
//         builder: (context, child) {
//           return MaterialApp(
//             debugShowCheckedModeBanner: false,
//             title: AppConstants.appName,
//             initialRoute: Routes.kSplashView,
//             onGenerateRoute: Routes.generateRoute,
//             theme: ThemeData(
//                 primaryColor: AppColors.colorReviewing,
//                 textTheme: GoogleFonts.interTextTheme().copyWith(
//                   bodyMedium: GoogleFonts.interTextTheme().bodyMedium?.copyWith(
//                     letterSpacing: -0.5,
//                   ),
//                 ),
//                 scaffoldBackgroundColor: AppColors.fontColorWhite),
//           );
//         });
//   }
// }
