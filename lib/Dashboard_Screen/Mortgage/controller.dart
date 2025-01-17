// controllers/card_controller.dart
import 'dart:async';
import 'dart:convert';
// import 'dart:html';
import 'dart:io';
import 'package:ag_mortgage/All_Cards/Get_all_Cards/Models.dart';
import 'package:ag_mortgage/All_Cards/Get_all_Cards/all_cards.dart';
import 'package:ag_mortgage/Dashboard_Screen/Mortgage/MortgageHome.dart';
import 'package:ag_mortgage/Dashboard_Screen/Mortgage/MortgagePage.dart';
import 'package:ag_mortgage/Dashboard_Screen/Mortgage/models.dart';
import 'package:ag_mortgage/const/constant.dart';
import 'package:ag_mortgage/const/url.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:intl/date_symbol_data_file.dart';
import 'package:intl/intl.dart';

class MortgagController extends ChangeNotifier {
  TextEditingController propertyValueController = TextEditingController();
  TextEditingController initialDepositController = TextEditingController();
  TextEditingController monthlyRepaymentController = TextEditingController();
  TextEditingController cvv = TextEditingController();

  DateTime selectedDay = DateTime.now();
//  String formattedDate = DateFormat('yyyy-MM-dd').format(selectedDay);
  int? selectedApartmentType = 1 ;
  int? selectedCity;
  int? selectedArea;
  double sliderValue = 10;

  Future<List<PostsModel>> getALLCityApi() async {
    try {
      final response = await http.get(Uri.parse(Urls.allCity));
      final body = json.decode(response.body) as List;
      if (response.statusCode == 200) {
// areaName();
        return body.map((dynamic json) {
          final map = json as Map<String, dynamic>;
          return PostsModel(
            id: map['id'] as int,
            name: map['name'] as String,
          );
        }).toList();
      }
    } on SocketException {
      await Future.delayed(const Duration(milliseconds: 1800));
      throw Exception('No Internet Connection');
    } on TimeoutException {
      throw Exception('');
    }
    throw Exception('error fetching data');
  }

  Future<List<SeletArea>> fetchAreasByCity(String cityId) async {
    if (cityId == null || cityId.isEmpty) {
      return [];
    }

    try {
      var response = await http.get(
        Uri.parse('${Urls.allArea}$cityId'),
        headers: {
          'Authorization': 'Bearer ${Params.userToken}',
          'Content-Type': 'application/json',
        },
      );

      if (response.statusCode == 200) {
        List<dynamic> data = json.decode(response.body);
        if (data.isEmpty) {
          Fluttertoast.showToast(
            msg: "No areas found for the selected city",
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.BOTTOM,
            backgroundColor: Colors.grey,
            textColor: const Color.fromARGB(255, 56, 55, 55),
            fontSize: 16.0,
          );
        }

        return data.map((json) => SeletArea.fromJson(json)).toList();
      } else {
        throw Exception("Failed to fetch areas");
      }
    } catch (e) {
      throw Exception("Error: $e");
    }
  }

 Future<void> addMortgageForm(BuildContext context) async {
  String formattedDate = DateFormat('yyyy-MM-dd').format(selectedDay);

  try {
    print('Preparing API request...');
    
    // Prepare the request
    var request = http.Request('POST', Uri.parse(Urls.mortagaform));
    request.body = json.encode({
      "typeOfApartment": selectedApartmentType ?? '',
      "city": selectedCity ?? '',
      "area": selectedArea ?? '',
      "estimatedPropertyValue": propertyValueController.text.trim(),
      "initialDeposit": initialDepositController.text.trim(),
      "loanRepaymentPeriod": sliderValue,
      "monthlyRepaymentAmount": monthlyRepaymentController.text.trim(),
      "anniversary": formattedDate, // Ensure DateTime is properly formatted
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
                            msg: "Mortgage Created Successfully",
                            toastLength: Toast.LENGTH_SHORT,
                            gravity: ToastGravity.BOTTOM,
                            backgroundColor: Colors.grey,
                            textColor: const Color.fromARGB(255, 77, 73, 73),
                          );
      print('API Success Response: $result');

      // Navigate to MortgagePage
      // ignore: use_build_context_synchronously
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => const MortgagePage(startIndex: 4),
        ),
      );
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
