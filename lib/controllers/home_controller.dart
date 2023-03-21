import 'dart:convert';
import 'package:assignment_project/utils/constant/api_endpoints.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

import '../models/assigenment_model.dart';

class HomeController extends GetxController {
  var jsonData;

  var enableMaster = false;
  Future<void> getDashboard() async {
    try {
      var headers = {'Content-Type': 'application/json'};
      var url = Uri.parse(
          ApiEndPoints.baseUrl + ApiEndPoints.authEndpoints.dashboardDetails);
      http.Response response = await http.get(url, headers: headers);
      if (response.statusCode == 200) {
        jsonData = AssigenmentModel.fromJson(jsonDecode(response.body));
      } else {
        throw jsonDecode(response.body)["Message"] ?? "Unknown Error Occured";
      }
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
