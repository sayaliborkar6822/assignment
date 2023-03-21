import 'package:assignment_project/controllers/home_controller.dart';
import 'package:assignment_project/models/assigenment_model.dart';
import 'package:assignment_project/screens/login.dart';
import 'package:assignment_project/utils/widgets/submit_button.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final Future<SharedPreferences> _prefs = SharedPreferences.getInstance();

  HomeController homeController = Get.put(HomeController());
  late AssigenmentModel jsonData;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(actions: [
        TextButton(
            onPressed: () async {
              final SharedPreferences? prefs = await _prefs;
              prefs?.remove("isLogin");
              prefs?.clear();
              Get.offAll(LoginPage());
            },
            child: const Text(
              'logout',
              style: TextStyle(color: Colors.white),
            ))
      ]),
      body: Center(
        child: Column(
          children: [
            const SizedBox(
              height: 30,
            ),
            Container(
              margin: EdgeInsets.only(left: 20, right: 20),
              child: Text(homeController.jsonData == null
                  ? ""
                  : "Brightness_10 : ${jsonData.brightness10}"),
            ),
            const SizedBox(
              height: 20,
            ),
            Container(
              margin: EdgeInsets.only(left: 20, right: 20),
              child: Text(homeController.jsonData == null
                  ? ""
                  : "Brightness_20 : ${jsonData.brightness20}"),
            ),
            const SizedBox(
              height: 20,
            ),
            Container(
              margin: EdgeInsets.only(left: 20, right: 20),
              child: Text(homeController.jsonData == null
                  ? ""
                  : "Brightness_30 : ${jsonData.brightness30}"),
            ),
            const SizedBox(
              height: 20,
            ),
            Container(
              margin: EdgeInsets.only(left: 20, right: 20),
              child: Text(homeController.jsonData == null
                  ? ""
                  : "Light_OFF : ${jsonData.lightOFF}"),
            ),
            const SizedBox(
              height: 20,
            ),
            Container(
              margin: EdgeInsets.only(left: 20, right: 20),
              child: Text(homeController.jsonData == null
                  ? ""
                  : "Light_ON : ${jsonData.lightON}"),
            ),
            const SizedBox(
              height: 20,
            ),
            SubmitButton(
              onPressed: () => {
                homeController.getDashboard().then(
                      (value) => setState(() {
                        jsonData = homeController.jsonData;
                      }),
                    ),
              },
              title: 'Master Switch',
            )
          ],
        ),
      ),
    );
  }
}
