import 'dart:convert';

import 'package:ag_mortgage/const/constant.dart';
import 'package:ag_mortgage/const/url.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:image_picker/image_picker.dart';

class DashboardController extends GetxController {
  var planOptions = <String>[].obs; // Observable list to store plan options
  var isLoading = true.obs;
  var profileName = "";
  String? profileImageUrl;
  String? totalPeople;
  String? totalnotClick;
  String? totalClick;
  String? totalJoin;

  Future<bool> ALLinvite(BuildContext context) async {
    print('userId: ${Params.userId}');
    try {
      var request = http.Request(
          'GET', Uri.parse('${Urls.referalOverAll}?id=${Params.userId}'));

      request.headers.addAll({
        'Content-Type': 'application/json',
        'Authorization': 'Bearer ${Params.userToken ?? ''}',
      });

      print('Request: ${request.body}');

      // Send request
      http.StreamedResponse streamedResponse = await request.send();
      var decodedResponse = await http.Response.fromStream(streamedResponse);

      print('decodedResponse Code: ${decodedResponse}');
      print('Response Body: ${decodedResponse.body}');

      if (decodedResponse.statusCode == 200) {
         isLoading.value = false;
        // ignore: use_build_context_synchronously
        var responseJson = jsonDecode(decodedResponse.body);
        totalPeople = responseJson['peopleInvited'] ?? '';
        totalClick = responseJson['timesClicked'] ?? '';
        totalJoin = responseJson['peopleJoined'] ?? '';
        totalnotClick = responseJson['peopleLeftAfterJoining'] ?? '';
        print('responseJson Body: $responseJson');
        return true;
      } else {
        print('Error: ${decodedResponse.body}');
        Fluttertoast.showToast(
          msg: "Error: ${decodedResponse.body}",
          toastLength: Toast.LENGTH_SHORT,
        );
        return false;
      }
    } catch (error) {
      print('Error Occurred: $error');
      Fluttertoast.showToast(
        msg: "An error occurred: $error",
        toastLength: Toast.LENGTH_SHORT,
      );
      return false;
    }
  }
}
