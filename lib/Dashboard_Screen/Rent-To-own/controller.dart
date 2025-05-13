// controllers/card_controller.dart
import 'dart:async';
import 'dart:convert';
// import 'dart:html';
import 'dart:io';
import 'package:ag_mortgage/All_Cards/Get_all_Cards/Models.dart';
import 'package:ag_mortgage/All_Cards/Get_all_Cards/all_cards.dart';
import 'package:ag_mortgage/Dashboard_Screen/Market_Place/Dashboard_Page/model.dart';
import 'package:ag_mortgage/Dashboard_Screen/Mortgage/MortgageHome.dart';
import 'package:ag_mortgage/Dashboard_Screen/Mortgage/MortgagePage.dart';
import 'package:ag_mortgage/Dashboard_Screen/Rent-To-own/models.dart';

import 'package:ag_mortgage/Main_Dashboard/dashboard/Dashboard/component.dart';
import 'package:ag_mortgage/const/constant.dart';
import 'package:ag_mortgage/const/url.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:intl/date_symbol_data_file.dart';
import 'package:intl/intl.dart';

class RentToOwnController extends GetxController {
  TextEditingController propertyValueController = TextEditingController();
  TextEditingController downPayment = TextEditingController();
  TextEditingController monthlyRepaymentController = TextEditingController();
  TextEditingController cityNameValue = TextEditingController();
    TextEditingController apartmentName = TextEditingController();

  TextEditingController areaNameValue = TextEditingController();
  TextEditingController monthlyRendal = TextEditingController();
  TextEditingController loanAmount = TextEditingController();
  TextEditingController cvv = TextEditingController();
  Map<String, dynamic> data = {};
  List allApartments = [];
  List allCity = [];
  List allArea = [];
  List allMsetting = [];
  DateTime? selectedDay;
//  String formattedDate = DateFormat('yyyy-MM-dd').format(selectedDay);
  int? selectedApartmentType = 1;
  int? selectedCity;
  int? selectedArea;
  double sliderValue = 1;
  int? apartmentOrMarketplace;
  String cityName = "";
  var screeningPeriods = <int>[].obs; // Observable list
  var selectedPeriod = Rxn<int>();
  var selectedLoan = Rxn<LoanModel>(); // Store the selected loan object

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

    String amountString = amount.toString().replaceAll(',', '');

    return int.tryParse(amountString) ?? 0;
  }
 Future<void> addRentoOwn(BuildContext context) async {
  String formattedDate = DateFormat('yyyy-MM-dd').format(selectedDay!);

  try {
    print('Preparing API request...');
    final double monthlyRendalCalculation = 
      (cleanNumbers(propertyValueController.text) * 0.8 - cleanNumbers(downPayment.text)) / 25;

    var request = http.Request('POST', Uri.parse(Urls.rentToOwn));
    request.body = json.encode({
      "id":Params.userId,
      "typeOfApartment": selectedApartmentType ?? '',
      "apartmentOrMarketplace": apartmentOrMarketplace ?? "",
      "city": selectedCity ?? '',
      "area": selectedArea ?? '',
      "loanRepaymentPeriod": selectedLoan.value?.screeningPeriod,
      "estimatedPropertyValue": double.tryParse(propertyValueController.text.replaceAll(',', '')) ?? 0.0,
      "initialDeposit": double.tryParse(downPayment.text.replaceAll(',', '').trim()) ?? 0.0,
      "rentalRepaymentPeriod": sliderValue,
      "monthlyRepaymentAmount": double.tryParse(monthlyRepaymentController.text.replaceAll(',', '').trim()) ?? 0.0,
      "monthlyLoanAmount": double.tryParse(loanAmount.text.replaceAll(",", "").trim()) ?? 0.0,
      "anniversary": formattedDate,
      "monthlyRentalAmount": monthlyRendalCalculation, // ✅ Fix: Correct data type
    });

    request.headers.addAll({
      'Content-Type': 'application/json',
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
        msg: "Rent-to-Own Created Successfully",
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        backgroundColor: Colors.grey,
        textColor: const Color.fromARGB(255, 15, 15, 15),
      );
      print('API Success Response: $result');

      // Navigate to MortgagePage
      // ignore: use_build_context_synchronously
                          Navigator.pushNamed(context, "/rent-to-own/paymentPage");

    } else {
      print('API Error: HTTP ${decodedResponse.statusCode}');
      final errorResult = jsonDecode(decodedResponse.body);
      print('Error Response: $errorResult');
    }
  } catch (error) {
    print('Error Occurred: $error');
  }
}
 Future<List<Apartment>> fetchApartments() async {
    try {
      var response = await http.get(
        Uri.parse(Urls.fetchApartmentsApi),
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
        print("datass1${data}");
        return data.map((json) => Apartment.fromJson(json)).toList();
      } else {
        throw Exception("Failed to fetch areas");
      }
    } catch (e) {
      throw Exception("Error: $e");
    }
  }

  Future<List<LoanModel>> getScreeningPeriodsApi() async {
    var response = await http.get(
      Uri.parse(Urls.getsettingsData),
      headers: {
        'Authorization': 'Bearer ${Params.userToken}',
        'Content-Type': 'application/json',
      },
    );

    if (response.statusCode == 200) {
      List<dynamic> data = jsonDecode(response.body);
      return data.map((e) => LoanModel.fromJson(e)).toList();
    } else {
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
 Future<void> findApartments() async {
    List<Apartment> apartment = await fetchApartments();

    var matchCity = apartment.firstWhere(
      (item) => item.id == selectedApartmentType,
      orElse: () => Apartment(id: -1, apartmentType: "Unknown", description: ''),
    );

    apartmentName.text = matchCity.apartmentType.toString();

    print('Updated apartmentName Name: $apartmentName');
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
