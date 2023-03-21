import 'dart:convert';

import 'package:assignment_project/screens/home.dart';
import 'package:assignment_project/utils/constant/api_endpoints.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

class RegisterationController extends GetxController {
  TextEditingController nameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController phoneNumberController = TextEditingController();

  final Future<SharedPreferences> _prefs = SharedPreferences.getInstance();
  final fb = FirebaseDatabase.instance;
  Future<void> registerWithEmail() async {
    try {
      UserCredential userCredential = await FirebaseAuth.instance
          .createUserWithEmailAndPassword(
              email: emailController.text.trim(),
              password: phoneNumberController.text);
      await userCredential.user?.updateDisplayName(nameController.text);
      userCredential.user?.sendEmailVerification();

      if (userCredential.user != null) {
        fb.setPersistenceEnabled(true);
        final snapshot =
            await fb.ref().child('users/${phoneNumberController.text}').get();
        if (snapshot.exists) {
          Get.back();
          showDialog(
              context: Get.context!,
              builder: (context) {
                return SimpleDialog(
                  title: Text('Error'),
                  contentPadding: EdgeInsets.all(20),
                  children: [Text('User already exist')],
                );
              });
        } else {
          final ref = fb.ref().child('users/${phoneNumberController.text}');
          ref.set({
            "email": emailController.text.trim(),
            "uid": "${userCredential.user?.uid}",
            'name': nameController.text,
            'phone_number': phoneNumberController.text
          });

          final SharedPreferences? prefs = await _prefs;
          await prefs?.setString('isLogin', "true");
          Get.off(HomeScreen());
        }
      } else {
        Get.back();
        showDialog(
            context: Get.context!,
            builder: (context) {
              return SimpleDialog(
                title: Text('Error'),
                contentPadding: EdgeInsets.all(20),
                children: [Text('User no found')],
              );
            });
      }

      final SharedPreferences? prefs = await _prefs;
      await prefs?.setString('token', "token");
      nameController.clear();
      emailController.clear();
      passwordController.clear();
      phoneNumberController.clear();
    } catch (e) {
      Get.back();
      showDialog(
          context: Get.context!,
          builder: (context) {
            return SimpleDialog(
              title: Text('Error'),
              contentPadding: EdgeInsets.all(20),
              children: [Text(e.toString())],
            );
          });
    }
  }
}
