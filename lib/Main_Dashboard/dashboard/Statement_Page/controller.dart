// controllers/card_controller.dart
import 'dart:convert';
import 'package:ag_mortgage/All_Cards/Get_all_Cards/Models.dart';
import 'package:ag_mortgage/All_Cards/Get_all_Cards/all_cards.dart';
import 'package:ag_mortgage/const/constant.dart';
import 'package:ag_mortgage/const/url.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

// ignore: camel_case_types
class StatementPage extends ChangeNotifier {
  TextEditingController accountNumber = TextEditingController();
  TextEditingController bvn = TextEditingController();
  TextEditingController bankName = TextEditingController();
  TextEditingController account = TextEditingController();
  TextEditingController amount = TextEditingController();
  final TextEditingController repaymentDate = TextEditingController();
  final List<Map<String, dynamic>> transactions = [];

  // DateTime repaymentDate = DateTime.now();
//  String formattedDate = DateFormat('yyyy-MM-dd').format(selectedDay);

  Future<bool> getAllTransactions(BuildContext context) async {
  try {
    var request = http.Request(
        'GET', Uri.parse('${Urls.getAllTransactions}?page=0&size=10'));

    request.headers.addAll({
      'Content-Type': 'application/json',
      'Authorization': 'Bearer ${Params.userToken ?? ''}',
    });

    print('Sending request to: ${request.url}');

    // Send request
    http.StreamedResponse streamedResponse = await request.send();
    var decodedResponse = await http.Response.fromStream(streamedResponse);

    print('Response Code: ${decodedResponse.statusCode}');
    print('Response Body: ${decodedResponse.body}');

    if (decodedResponse.statusCode == 200) {
      final responseData = json.decode(decodedResponse.body);

      // Debugging: Check the structure of responseData
      print('Decoded Response Data: $responseData');

      if (responseData.containsKey('items')) {
        if (responseData['items'] is List) {
          if (responseData['items'].isNotEmpty) {
            transactions.addAll(List<Map<String, dynamic>>.from(responseData['items']));
            print('Updated Transactions List: $transactions');
          } else {
            print('Response "items" is an empty list.');
          }
        } else {
          print('Error: "items" is not a list. It is ${responseData['items'].runtimeType}');
        }
      } else {
        print('Error: Response does not contain "items" key.');
      }

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
