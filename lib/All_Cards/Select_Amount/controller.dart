import 'dart:convert';
import 'package:ag_mortgage/All_Cards/Get_all_Cards/Models.dart';
import 'package:ag_mortgage/Main_Dashboard/dashboard/Dashboard/component.dart';
import 'package:ag_mortgage/Main_Dashboard/dashboard/Term_Sheet/model.dart';
import 'package:ag_mortgage/const/constant.dart';
import 'package:ag_mortgage/const/url.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as http;
// Import the model you created earlier

class CardControllerSelectAmount {
  final TextEditingController amountController = TextEditingController();
  late double monthlyRepaymentAmount;

  Future<void> calculation(context,int id) async {
    double monthlyRepayment = double.tryParse(
          amountController.text.replaceAll(',', ''),
        ) ??
        0;
    if (monthlyRepayment > monthlyRepaymentAmount.toDouble()) {
      var voluntaryAmount = monthlyRepayment - monthlyRepaymentAmount;
      monthlyContribution(context,monthlyRepaymentAmount, id);
      voluntoryPayment(voluntaryAmount, id);
    }
    monthlyContribution(context,monthlyRepaymentAmount, id);
    print('check City Name: ');
  }

  Future<List<CustomerModel>> fetchMortgageDetails() async {
    try {
      print('userId: ${Params.userId}');

      final url = Uri.parse('${Urls.getMortgageDetails}?id=${Params.userId}');

      final headers = {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer ${Params.userToken ?? ''}',
      };

      final response = await http.get(url, headers: headers);

      if (response.statusCode == 200) {
        List<dynamic> data = json.decode(response.body);
        if (data.isNotEmpty) {
          CustomerModel customer = CustomerModel.fromJson(data[0]);

          monthlyRepaymentAmount = customer.monthlyRepaymentAmount!;
          amountController.text = customer.monthlyRepaymentAmount!.toString();
        }
        print("amountController${amountController.value}");
        return data.map((json) => CustomerModel.fromJson(json)).toList();
      } else {
        throw Exception('Failed to load data: ${response.statusCode}');
      }
    } catch (e) {
      print('Error: $e');
      throw Exception('Failed to fetch mortgage details');
    }
  }

  Future<CardModel?> fetchCardDetails(int cardId) async {
    final response = await http.get(
      Uri.parse('${Urls.amountPay}?id=$cardId'),
      headers: {
        'Content-Type': 'application/json',
        'Authorization':
            'Bearer ${Params.userToken}', // Ensure userToken is correct
      },
    );

    print('Response status: ${response.statusCode}');
    print('Response body: ${response.body}'); // Log the body for more details

    if (response.statusCode == 200) {
      final cardJson = json.decode(response.body);
      return CardModel.fromJson(cardJson);
    } else {
      print('Error: ${response.statusCode}');
      return null;
    }
  }

  Future<void> monthlyContribution(context,double monthlyRepayment, int id) async {
    try {
      print('Preparing API request...');

      // Prepare the request
      var request = http.Request('POST', Uri.parse(Urls.depositAmont));
      request.body = json.encode({
        "cardId": id,
        "amount": monthlyRepayment,
        "typeOfTransaction": "Monthly Contributions"
      });
      request.headers.addAll({
        'Content-Type': 'application/json ',
        'Authorization': 'Bearer ${Params.userToken}',
      });

      print('Request Headers: ${request.headers}');
      print('Request Body: ${request.body}');

      // Send the request
      http.StreamedResponse streamedResponse = await request.send();
      var decodedResponse = await http.Response.fromStream(streamedResponse);

      // Log response
      print('Response Status Code: ${decodedResponse.statusCode}');
      print('Response Body: ${decodedResponse.body}');

      if (decodedResponse.statusCode == 200) {
        final result = jsonDecode(decodedResponse.body);
         Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) =>
                const DashboardPageS("Mortgage"), // Start with MortgagePage
          ),
        );
        Fluttertoast.showToast(
          msg: "Payment Successfully",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          backgroundColor: Colors.grey,
          textColor: Color.fromARGB(255, 15, 15, 15),
        );
        print('API Success Response: $result');

        // Navigate to MortgagePage
        // ignore: use_build_context_synchronously
      } else {
        print('API Error: HTTP ${decodedResponse.statusCode}');
        final errorResult = jsonDecode(decodedResponse.body);
        print('Error Response: $errorResult');
      }
    } catch (error) {
      print('Error Occurred: $error');
    }
  }

  Future<void> voluntoryPayment(double monthlyRepayment, int id) async {
    try {
      print('Preparing API request...');

      // Prepare the request
      var request = http.Request('POST', Uri.parse(Urls.depositAmont));
      request.body = json.encode({
        "cardId": id,
        "amount": monthlyRepayment,
        "typeOfTransaction": "Voluntary Contributions"
      });
      request.headers.addAll({
        'Content-Type': 'application/json ',
        'Authorization': 'Bearer ${Params.userToken}',
      });

      print('Request Headers: ${request.headers}');
      print('Request Body: ${request.body}');

      // Send the request
      http.StreamedResponse streamedResponse = await request.send();
      var decodedResponse = await http.Response.fromStream(streamedResponse);

      // Log response
      print('Response Status Code: ${decodedResponse.statusCode}');
      print('Response Body: ${decodedResponse.body}');

      if (decodedResponse.statusCode == 200) {
        final result = jsonDecode(decodedResponse.body);
        Fluttertoast.showToast(
          msg: "Payment Successfully",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          backgroundColor: Colors.grey,
          textColor: Color.fromARGB(255, 15, 15, 15),
        );
        print('API Success Response: $result');

        // Navigate to MortgagePage
        // ignore: use_build_context_synchronously
      } else {
        print('API Error: HTTP ${decodedResponse.statusCode}');
        final errorResult = jsonDecode(decodedResponse.body);
        print('Error Response: $errorResult');
      }
    } catch (error) {
      print('Error Occurred: $error');
    }
  }
}
