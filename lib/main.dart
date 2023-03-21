import 'package:assignment_project/screens/registration_screen.dart';
import 'package:assignment_project/screens/home.dart';
import 'package:assignment_project/screens/login.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';
import 'package:shared_preferences/shared_preferences.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  FirebaseApp app;
  final Future<SharedPreferences> _prefs = SharedPreferences.getInstance();

  final SharedPreferences? prefs = await _prefs;
  var isLogin = await prefs?.getString('isLogin');

  try {
    app = await Firebase.initializeApp();
  } on FirebaseException catch (e) {
    print(e.code);
  }
  runApp(GetMaterialApp(
    debugShowCheckedModeBanner: false,
    home: isLogin == "true" ? HomeScreen() : LoginPage(),
    // home: RegistrationScreen(),
  ));
}
