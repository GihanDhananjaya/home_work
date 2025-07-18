import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:home_work/utils/navigation_routes.dart';
import 'package:home_work/views/splash/splash_view.dart';
import 'package:shared_preferences/shared_preferences.dart';


Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp();

  final prefs = await SharedPreferences.getInstance();
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final User? user = _auth.currentUser;

  runApp(MyApp(prefs: prefs, user: user));
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
      home: SplashView(prefs: widget.prefs, user: widget.user),
      onGenerateRoute: AppRoutes.generateRoute,
    );
  }
}
