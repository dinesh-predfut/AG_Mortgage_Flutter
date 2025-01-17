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

class Main_Dashboard_controller extends ChangeNotifier {
  TextEditingController accountNumber = TextEditingController();
  TextEditingController bvn = TextEditingController();
  TextEditingController bankName = TextEditingController();
  TextEditingController account = TextEditingController();
  TextEditingController amount = TextEditingController();
  final TextEditingController repaymentDate = TextEditingController();
  // DateTime repaymentDate = DateTime.now();
//  String formattedDate = DateFormat('yyyy-MM-dd').format(selectedDay);

  Future<bool> getwithdrawDetails(BuildContext context) async {
    try {
      var request = http.Request('GET', Uri.parse(Urls.withdraw));
      

      request.headers.addAll({
        'Content-Type': 'application/json',
        'Authorization': 'Bearer ${Params.userToken ?? ''}',
      });

      print('Request: ${request.body}');

      // Send request
      http.StreamedResponse streamedResponse = await request.send();
      var decodedResponse = await http.Response.fromStream(streamedResponse);

      print('Response Code: ${decodedResponse.statusCode}');
      print('Response Bodyyyyyy: ${decodedResponse.body}');

      if (decodedResponse.statusCode == 200) {
        // Fluttertoast.showToast(
        //   msg: "Withdrawal Successful",
        //   toastLength: Toast.LENGTH_SHORT,
        //   gravity: ToastGravity.BOTTOM,
        //   backgroundColor: Colors.grey,
        //   textColor: Colors.white,
        // );
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
        getwithdrawDetails(context);
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
