import 'dart:async';

import 'package:assignment_project/screens/home.dart';
import 'package:assignment_project/screens/registration_screen.dart';
import 'package:assignment_project/screens/verification.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

class VerificationController extends GetxController
    with GetSingleTickerProviderStateMixin {
  var showPrefix = false.obs;
  var isLogin = true;
  var phoneNo = "".obs;
  var otp = "".obs;
  var isOtpSent = false.obs;
  var resendAfter = 30.obs;
  var resendOTP = false.obs;
  var firebaseVerificationId = "";
  var statusMessage = "".obs;
  var statusMessageColor = Colors.black.obs;
  FirebaseAuth auth = FirebaseAuth.instance;
  final fb = FirebaseDatabase.instance;
  var timer;
  final Future<SharedPreferences> _prefs = SharedPreferences.getInstance();
  VerificationController() {}

  @override
  onInit() async {
    super.onInit();
  }

  getOtp() async {
    final snapshot = await fb.ref().child('users/${phoneNo.value}').get();
    if (snapshot.exists) {
      auth.verifyPhoneNumber(
          phoneNumber: '+91' + phoneNo.value,
          verificationCompleted: (phonesAuthCredentials) async {},
          verificationFailed: (verificationFailed) async {},
          codeSent: (verificationId, reseningToken) async {
            firebaseVerificationId = verificationId;
            isOtpSent.value = true;
            statusMessage.value = "OTP sent to +91" + phoneNo.value;
            startResendOtpTimer();
          },
          codeAutoRetrievalTimeout: (verificationId) async {});
    } else {
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
    }
  }

  navigateToRegister() {
    Get.off(RegistrationScreen());
    // Get.to(() => RegistrationScreen());
    // Get.create(() => RegistrationScreen());

    // Get.put(RegistrationScreen());

    // Get.back();
    // Get.off(RegistrationScreen());
  }

  resendOtp() async {
    resendOTP.value = false;
    FirebaseAuth.instance.verifyPhoneNumber(
      phoneNumber: '+91' + phoneNo.value,
      verificationCompleted: (PhoneAuthCredential credential) {},
      verificationFailed: (FirebaseAuthException e) {},
      codeSent: (String verificationId, int? resendToken) {
        firebaseVerificationId = verificationId;
        isOtpSent.value = true;
        statusMessage.value = "OTP re-sent to +91" + phoneNo.value;
        startResendOtpTimer();
      },
      codeAutoRetrievalTimeout: (String verificationId) {},
    );
  }

  verifyOTP() async {
    FirebaseAuth auth = FirebaseAuth.instance;
    try {
      statusMessage.value = "Verifying... " + otp.value;
      // Create a PhoneAuthCredential with the code
      PhoneAuthCredential credential = PhoneAuthProvider.credential(
          verificationId: firebaseVerificationId, smsCode: otp.value);
      // Sign the user in (or link) with the credential
      await auth.signInWithCredential(credential);
      final SharedPreferences? prefs = await _prefs;
      await prefs?.setString('isLogin', "true");
      Get.off(HomeScreen());
    } catch (e) {
      statusMessage.value = "Invalid  OTP";
      statusMessageColor = Colors.red.obs;
    }
  }

  startResendOtpTimer() {
    timer = Timer.periodic(Duration(seconds: 1), (timer) {
      if (resendAfter.value != 0) {
        resendAfter.value--;
      } else {
        resendAfter.value = 30;
        resendOTP.value = true;
        timer.cancel();
      }
      update();
    });
  }

  @override
  void dispose() {
    super.dispose();
  }
}
