import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:home_work/views/all_job/all_job_view.dart';
import 'package:home_work/views/bootom_bar/bottom_bar_view.dart';
import 'package:home_work/views/confirm_job/confirm_job_view.dart';
import 'package:home_work/views/new_job/new_job_view.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:home_work/views/home/home_view.dart';
import 'package:home_work/views/sign_in/sign_in_view.dart';
import 'package:home_work/views/sign_up/sign_up_view.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: FirebaseOptions(
      storageBucket: "fir-prpject-af778.appspot.com",
      apiKey: "AIzaSyAOgaaiFYJKdfKGzwglGgnzeGlBNcxdaic",
      appId: "1:199375982331:android:869afe435b462932f2aa5e",
      messagingSenderId: "199375982331",
      projectId: 'fir-prpject-af778',
    ),
  );
  final prefs = await SharedPreferences.getInstance();
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final User? user = _auth.currentUser;
  runApp( MyApp(prefs: prefs,user: user));
}

class MyApp extends StatefulWidget {
  final SharedPreferences prefs;
  final User? user;


  MyApp({required this.prefs,required this.user});

  @override
  State<MyApp> createState() => _MyAppState();
}

bool isUserLoggedIn(SharedPreferences prefs, User? user) {
  return user != null && prefs.getBool('userLoggedIn') == true;
}

class _MyAppState extends State<MyApp> {
  bool _isLoggedIn = false;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      routes: {
        '/': (context) =>isUserLoggedIn(widget.prefs, widget.user) ?
        BottomBarView(user: widget.user): SignInView(prefs: widget.prefs),
        '/details': (context) => SignInView(),
        '/signup': (context) => SignUpView(),
        '/home': (context) => HomeView(),
        '/new_job': (context) => NewJobView(),
        '/all_job_view': (context) => AllJobView(),
        '/confirm_job_view': (context) => ConfirmJobView(),
      },
    );
  }
}
