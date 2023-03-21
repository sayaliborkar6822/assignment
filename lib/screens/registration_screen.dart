import 'package:assignment_project/controllers/home_controller.dart';
import 'package:assignment_project/controllers/registeration_controller.dart';
import 'package:assignment_project/models/assigenment_model.dart';
import 'package:assignment_project/screens/login.dart';
import 'package:assignment_project/utils/widgets/input_fields.dart';
import 'package:assignment_project/utils/widgets/submit_button.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

class RegistrationScreen extends StatefulWidget {
  const RegistrationScreen({Key? key}) : super(key: key);

  @override
  State<RegistrationScreen> createState() => _RegistrationScreenState();
}

class _RegistrationScreenState extends State<RegistrationScreen> {
  final Future<SharedPreferences> _prefs = SharedPreferences.getInstance();

  RegisterationController registerationController =
      Get.put(RegisterationController());
  late AssigenmentModel jsonData;
  Widget registerWidget() {
    return Column(
      children: [
        InputTextFieldWidget(registerationController.nameController, 'Name'),
        const SizedBox(
          height: 20,
        ),
        InputTextFieldWidget(
            registerationController.emailController, 'Email address'),
        const SizedBox(
          height: 20,
        ),
        InputTextFieldWidget(
            registerationController.passwordController, 'Password'),
        const SizedBox(
          height: 20,
        ),
        InputTextFieldWidget(
            registerationController.phoneNumberController, 'Phone number'),
        const SizedBox(
          height: 20,
        ),
        SubmitButton(
          onPressed: () => registerationController.registerWithEmail(),
          title: 'Register',
        )
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Container(
          margin: EdgeInsets.only(top: 100, left: 20, right: 20),
          child: registerWidget(),
        ),
      ),
    );
  }
}
