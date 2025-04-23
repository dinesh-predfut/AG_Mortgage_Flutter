// controllers/card_controller.dart
import 'dart:async';
import 'dart:convert';
// import 'dart:html';
import 'dart:io';
import 'package:ag_mortgage/Dashboard_Screen/Mortgage/MortgageHome.dart';
import 'package:ag_mortgage/Dashboard_Screen/Mortgage/models.dart';
import 'package:ag_mortgage/const/constant.dart';
import 'package:ag_mortgage/const/url.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:intl/date_symbol_data_file.dart';
import 'package:intl/intl.dart';

import '../../dashboard/Dashboard/component.dart';

class Main_Dashboard_controller extends ChangeNotifier {
  TextEditingController accountNumber = TextEditingController();
  TextEditingController bvn = TextEditingController();
  TextEditingController bankName = TextEditingController();
  TextEditingController account = TextEditingController();
  TextEditingController amount = TextEditingController();
  final TextEditingController repaymentDate = TextEditingController();
  var planOptions = <int>[].obs; // Observable list to store plan options
  var isLoading = false.obs;
  var profileName = "";
  var phoneNumber = "";
  String? profileImageUrl;
  Future<InvestmentModels?> fetchInvestmentDetails() async {
    try {
      var url = Uri.parse(Urls.investment);

      var response = await http.get(
        url,
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer ${Params.userToken ?? ''}',
        },
      );

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);

        return InvestmentModels.fromJson(data);
      } else {
        print("Failed to fetch investment details: ${response.body}");
        return null;
      }
    } catch (error) {
      print("Error fetching investment: $error");
      return null;
    }
  }

  static Future<bool> updateInvestment(InvestmentModels investment) async {
    try {
      var url = Uri.parse(Urls.investment);

      var response = await http.put(
        url,
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer ${Params.userToken ?? ''}',
        },
      );

      print('Response Code: ${response.statusCode}');
      print('Response Body: ${response.body}');

      if (response.statusCode == 200) {
        Fluttertoast.showToast(
          msg: "Investment Updated Successfully",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          backgroundColor: Colors.green,
          textColor: Colors.white,
        );
        return true;
      } else {
        print('Error: ${response.body}');
        Fluttertoast.showToast(
          msg: "Error: ${response.body}",
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

  String formatCurrency(dynamic value) {
    try {
      if (value == null || value.toString().isEmpty) return "";
      double numericValue;

      if (value is String) {
        value = value.replaceAll(',', ''); // Remove commas from string
        numericValue = double.tryParse(value) ?? 0.0; // Convert to double
      } else if (value is num) {
        numericValue = value.toDouble();
      } else {
        return "";
      }

      final formatter = NumberFormat("#,##0.##", "en_US");
      return formatter.format(numericValue);
    } catch (error) {
      print("Error formatting currency: $error");
      return "";
    }
  }

  Future<void> onLogout(BuildContext context) async {
    await SetSharedPref().clearData();
    // ignore: use_build_context_synchronously
    Navigator.of(context, rootNavigator: true).pushNamed("/login");
  }

  Future<void> fetchPlanOptions() async {
    try {
      print('Response Code: ${Params.userId}');
      isLoading.value = true;
      var url = Uri.parse('${Urls.getEmployeeDetailsID}?id=${Params.userId}');
      var headers = {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer ${Params.userToken}',
      };

      var response = await http.get(url, headers: headers);

      print('Response Code: ${response.statusCode}');
      print('Responsesss Body: ${response.body}');

      if (response.statusCode == 200) {
        var data = json.decode(response.body);

        if (data['firstName'] != null) {
          profileName = data['firstName'];
        }
        if (data['phoneNumber'] != null) {
          phoneNumber = data['phoneNumber'];
        }
        // Adjust this to match your API response
        var profileImage = data['profileImage']; // Get profileImage URL

        // print("WWWWWWWW$profileName");

        if (data['planOption'] != null) {
          planOptions.value = List<int>.from(data['planOption']);
        }
        if (planOptions.contains(26)) {
          print("Passhere");
        }
        print("WWWWWWWW$planOptions");
        // Assuming you want to store the image URL for use in your UI
        profileImageUrl = profileImage; // Store the image URL
      } else {
        print("Error: ${response.body}");
      }
    } catch (e) {
      print("API Call Error: $e");
    } finally {
      isLoading.value = false;
    }
  }

  Future<bool> withdraw(BuildContext context) async {
    try {
      var request = http.Request('POST', Uri.parse(Urls.withdraw));
      request.body = json.encode({
        "bankName": bankName.text.trim(),
        "amount": amount.text.trim(),
        "accountNumber": accountNumber.text.trim(),
        "bvn": bvn.text.trim(),
        "anniversary": repaymentDate.text.trim(),
      });

      request.headers.addAll({
        'Content-Type': 'application/json',
        'Authorization': 'Bearer ${Params.userToken ?? ''}',
      });

      print('Request: ${request.body}');

      // Send request
      http.StreamedResponse streamedResponse = await request.send();
      var decodedResponse = await http.Response.fromStream(streamedResponse);

      print('Response Code: ${decodedResponse.statusCode}');
      print('Response Body: ${decodedResponse.body}');

      if (decodedResponse.statusCode == 200) {
        // ignore: use_build_context_synchronously

        Fluttertoast.showToast(
          msg: "Withdrawal Successful",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          backgroundColor: Colors.grey,
          textColor: Colors.white,
        );
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
