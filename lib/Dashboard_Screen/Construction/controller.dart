// controllers/card_controller.dart
import 'dart:async';
import 'dart:convert';
// import 'dart:html';
import 'dart:io';
import 'dart:math';
import 'package:ag_mortgage/All_Cards/Get_all_Cards/Models.dart';
import 'package:ag_mortgage/All_Cards/Get_all_Cards/all_cards.dart';
import 'package:ag_mortgage/Dashboard_Screen/Construction/models.dart';
import 'package:ag_mortgage/Dashboard_Screen/Mortgage/MortgageHome.dart';
import 'package:ag_mortgage/Dashboard_Screen/Mortgage/MortgagePage.dart';

import 'package:ag_mortgage/Main_Dashboard/dashboard/Dashboard/component.dart';
import 'package:ag_mortgage/const/constant.dart';
import 'package:ag_mortgage/const/url.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:intl/date_symbol_data_file.dart';
import 'package:intl/intl.dart';

class ContructionController extends GetxController {
  TextEditingController propertyValueController = TextEditingController();
  TextEditingController downPayment = TextEditingController();
  TextEditingController monthlyRepaymentController = TextEditingController();
  TextEditingController cityNameValue = TextEditingController();
  TextEditingController areaNameValue = TextEditingController();
  TextEditingController monthlyRendal = TextEditingController();
  TextEditingController completionAmount = TextEditingController();
  TextEditingController estimatedAmount = TextEditingController();
  TextEditingController cvv = TextEditingController();
  Map<String, dynamic> data = {};
  List allApartments = [];
  List allCity = [];
  List allArea = [];
  List allMsetting = [];
  DateTime selectedDay = DateTime.now();
//  String formattedDate = DateFormat('yyyy-MM-dd').format(selectedDay);
  int? selectedApartmentType = 1;
  int? selectedCity;
  int? selectedArea;
  int? selectedStage;
  double sliderValue = 1;
  int? apartmentOrMarketplace;
  String cityName = "";
  var screeningPeriod = <int>[].obs; // Observable list
  var selectedPeriod = Rxn<String>();
  var selectedLoan = Rxn<LoanModel>(); // Store the selected loan object

  double calculateEMI(double loanAmount, int tenureMonths) {
    double yearlyInterest = 25.0;
    double monthlyRate = yearlyInterest / 12 / 100;

    print('$monthlyRate - emiTenureInMonth');
    double emi =
        (loanAmount * monthlyRate * pow(1 + monthlyRate, tenureMonths)) /
            (pow(1 + monthlyRate, tenureMonths) - 1);

    return double.parse(emi.toStringAsFixed(2));
  }

  void updateEMI() {
    double loanAmount = double.tryParse(completionAmount.text) ?? 0;

    if (loanAmount > 0 && sliderValue > 0) {
      int emiTenureInMonths = (sliderValue * 12).toInt();
      double emi = calculateEMI(loanAmount, emiTenureInMonths);

      monthlyRepaymentController.text = emi.toStringAsFixed(2);

      print("emi$emi");
      print("emi$emiTenureInMonths");
      print("emi$loanAmount");
      print("emi$sliderValue");

    }
  }

  Future<List<PostsModel>> getALLCityApi() async {
    try {
      final response = await http.get(Uri.parse(Urls.allCity));
      final body = json.decode(response.body) as List;
      if (response.statusCode == 200) {
        return body.map((dynamic json) {
          final map = json as Map<String, dynamic>;
          return PostsModel(
            id: map['id'] as int,
            name: map['name'] as String,
          );
        }).toList();
      }
    } catch (error) {}
    throw Exception('error fetching data');
  }

  Future<List<SeletArea>> fetchAreasByCity() async {
    try {
      var response = await http.get(
        Uri.parse('${Urls.allArea}$selectedCity'),
        headers: {
          'Authorization': 'Bearer ${Params.userToken}',
          'Content-Type': 'application/json',
        },
      );

      if (response.statusCode == 200) {
        List<dynamic> data = json.decode(response.body);
        if (data.isEmpty) {
          Fluttertoast.showToast(
            msg: "No areas found for the selected cityss",
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.BOTTOM,
            backgroundColor: Colors.grey,
            textColor: const Color.fromARGB(255, 56, 55, 55),
            fontSize: 16.0,
          );
        }
        print("datass1${data}");
        return data.map((json) => SeletArea.fromJson(json)).toList();
      } else {
        throw Exception("Failed to fetch areas");
      }
    } catch (e) {
      throw Exception("Error: $e");
    }
  }

  String formatNumber(String number) {
    if (number.isEmpty) return number;
    final formatter = NumberFormat('#,###');
    final intNumber = int.tryParse(number);
    if (intNumber == null) return number;
    return formatter.format(intNumber);
  }

  int cleanNumbers(dynamic amount) {
    if (amount == null) return 0;

    // Convert the amount to a string and remove commas
    String amountString = amount.toString().replaceAll(',', '');

    return int.tryParse(amountString) ?? 0;
  }

  Future<void> addRentoOwn(BuildContext context) async {
    String formattedDate = DateFormat('yyyy-MM-dd').format(selectedDay);

    try {
      print('Preparing API request...');
      final monthlyRendalCalculation = {
        (cleanNumbers(propertyValueController.text) * 0.8 -
                cleanNumbers(downPayment.text)) /
            25
      };
      // Prepare the request
      var request = http.Request('POST', Uri.parse(Urls.rentToOwn));
      request.body = json.encode({
        "typeOfApartment": selectedApartmentType ?? '',
        "apartmentOrMarketplace": apartmentOrMarketplace ?? "",
        "city": selectedCity ?? '',
        "area": selectedArea ?? '',
        // "loanRepaymentPeriod": selectedLoan.value?.screeningPeriod,
        "estimatedPropertyValue":
            double.tryParse(propertyValueController.text.replaceAll(',', '')) ??
                0.0,
        "initialDeposit":
            double.tryParse(downPayment.text.replaceAll(',', '').trim()) ?? 0.0,
        "rentalRepaymentPeriod": sliderValue,
        "monthlyRepaymentAmount": double.tryParse(
                monthlyRepaymentController.text.replaceAll(',', '').trim()) ??
            0.0,
        "monthlyLoanAmount":
            double.tryParse(estimatedAmount.text.replaceAll(",", "").trim()) ??
                0.0,
        "anniversary": formattedDate,
        "monthlyRentalAmount": monthlyRendalCalculation,
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
        clearFields();
        final result = jsonDecode(decodedResponse.body);
        Fluttertoast.showToast(
          msg: "Mortgage Created Successfully",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          backgroundColor: Colors.grey,
          textColor: Color.fromARGB(255, 15, 15, 15),
        );
        print('API Success Response: $result');

        // Navigate to MortgagePage
        // ignore: use_build_context_synchronously
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) =>
                const DashboardPageS("Mortgage"), // Start with MortgagePage
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

  Future<List<LoanModel>> getScreeningPeriodsApi() async {
    var response = await http.get(
      Uri.parse(Urls.constructionFinance),
      headers: {
        'Authorization': 'Bearer ${Params.userToken}',
        'Content-Type': 'application/json',
      },
    );

    print("API Response Status Code: ${response.statusCode}");
    print("API Response Body: ${response.body}");

    if (response.statusCode == 200) {
      List<dynamic> data = jsonDecode(response.body);
      print("Decoded Data Length: ${data.length}");

      // Print each loan object to check typeName
      for (var item in data) {
        print("Loan Data: ${item["id"]} - ${item["typeName"]}");
      }

      return data.map((e) => LoanModel.fromJson(e)).toList();
    } else {
      print("Error Fetching Data: ${response.reasonPhrase}");
      throw Exception('Failed to load screening periods');
    }
  }

  void clearFields() {
    propertyValueController.clear();
    downPayment.clear();
    monthlyRepaymentController.clear();

    selectedApartmentType = null;
    apartmentOrMarketplace = null;
    selectedCity = null;
    selectedArea = null;

    selectedDay = DateTime.now();
  }

  Future<Map<String, dynamic>> getData(String userId) async {
    Map<String, dynamic> data = {};

    try {
      final url = Uri.parse(Urls.upDateTermsheet); // Your API URL

      final response = await http.get(
        url,
        headers: {
          'Content-Type': 'application/json',
          'Authorization':
              'Bearer ${Params.userToken}', // Token for Authorization
        },
      );

      if (response.statusCode == 200) {
        final responseData = json.decode(response.body);
        if (responseData is List && responseData.isNotEmpty) {
          data = responseData[0];
          // Store the first item of the response
        } else {
          throw Exception("No data found.");
        }
      } else {
        throw Exception(
            "Failed to fetch data. Status Code: ${response.statusCode}");
      }
    } catch (error) {
      print("Error fetching data: $error");
      rethrow; // Re-throw error so UI can handle it
    }

    return data;
  }

  int convertToNumber(dynamic value) {
    if (value is int) {
      return value;
    } else if (value is String) {
      return int.tryParse(value) ?? 0;
    } else {
      return 0;
    }
  }

  Future<void> findAndSetCity() async {
    List<PostsModel> allCity = await getALLCityApi();

    var matchCity = allCity.firstWhere(
      (item) => item.id == selectedCity,
      orElse: () => PostsModel(id: -1, name: "Unknown"),
    );

    cityNameValue.text = matchCity.name.toString();

    print('Updated City Name: $cityName');
  }

  Future<void> findAndSetArea() async {
    List<SeletArea> allArea = await fetchAreasByCity();

    if (allArea.isEmpty) {
      areaNameValue.text = "No areas found";
      return;
    }
    var matchArea = allArea.firstWhere(
      (item) => item.id == selectedArea,
      orElse: () => SeletArea(id: -1, name: "Unknown Area"),
    );

    areaNameValue.text = matchArea.name.toString();
    print("22222${areaNameValue.text}");
  }

  String calculateProfileDate(String anniversaryDate, int remainingMonths) {
    DateTime startDate = DateTime.parse(anniversaryDate);

    if (startDate == null) {
      throw Exception('Invalid date');
    }

    DateTime newDate = DateTime(
      startDate.year,
      startDate.month + remainingMonths,
      startDate.day,
    );

    return '${newDate.year}-${newDate.month.toString().padLeft(2, '0')}-${newDate.day.toString().padLeft(2, '0')}';
  }

  String formatProfileDate(String profileDate) {
    DateTime dateTime = DateTime.parse(profileDate);

    String formattedDate = DateFormat('dd-MM-yyyy').format(dateTime);

    return formattedDate;
  }

  String formatProfileDateName(String profileDate) {
    DateTime dateTime = DateTime.parse(profileDate);
    return DateFormat('MMM dd').format(dateTime).toUpperCase();
  }

  void updateField(String name, String value) {}
}
