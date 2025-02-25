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
import 'package:ag_mortgage/Main_Dashboard/dashboard/Dashboard/component.dart';
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
  TextEditingController cityNameValue = TextEditingController();
  TextEditingController areaNameValue = TextEditingController();
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
  double sliderValue = 10;
  int? apartmentOrMarketplace;
  String cityName = "";
  String accountName = "Josh Doe";
  String accountNumber = "1234567";
  String bankName = "First Name";
  int amount = 2500000;
  String typeOfTransaction = "Monthly Contribution";
  Future<void> fetchCitiesAndAreas() async {
    try {
      allArea = await fetchAreasByCity();
      allCity = await getALLCityApi();

      int? formDataArea = selectedArea;
      int? formDataCity = selectedCity;
      // int formDataApartment = 3;

      var defaultArea = allArea.firstWhere(
        (area) => area.id == formDataArea,
        orElse: () => SeletArea(id: -1, name: "Unknown Area"),
      );

      var defaultCity = allCity.firstWhere(
        (city) => city.id == formDataCity,
        orElse: () => PostsModel(id: -1, name: "Unknown City"),
      );

      // // Find selected apartment type
      // var defaultApartment = allApartments.firstWhere(
      //   (apartment) => apartment.id == formDataApartment,
      //   orElse: () => ApartmentModel(id: -1, apartmentType: "Unknown Apartment"),
      // );
      print("areaNameValue data: ${defaultArea.name}");
      areaNameValue.text = defaultArea.name;
      cityNameValue.text = defaultCity.name;

      // areaNameValue.text = defaultArea.name;
    } catch (error) {
      print("Error fetching data: $error");
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
            msg: "No areas found for the selected city",
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

  Future<void> addMortgageForm(BuildContext context) async {
    String formattedDate = DateFormat('yyyy-MM-dd').format(selectedDay);

    try {
      print('addMortgageForm Preparing API request...');

      // Prepare the request
      var request = http.Request('POST', Uri.parse(Urls.mortagaform));
      request.body = json.encode({
        "typeOfApartment": selectedApartmentType ?? '',
        "apartmentOrMarketplace": apartmentOrMarketplace ?? "",
        "city": selectedCity ?? '',
        "area": selectedArea ?? '',
        "estimatedPropertyValue":
            double.tryParse(propertyValueController.text.replaceAll(',', '')) ??
                0.0,
        "initialDeposit": double.tryParse(
                initialDepositController.text.replaceAll(',', '').trim()) ??
            0.0,
        "loanRepaymentPeriod": sliderValue,
        "monthlyRepaymentAmount": double.tryParse(
                monthlyRepaymentController.text.replaceAll(',', '').trim()) ??
            0.0,
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
      } else {
        print('API Error: HTTP ${decodedResponse.statusCode}');
        final errorResult = jsonDecode(decodedResponse.body);
        print('Error Response: $errorResult');
      }
    } catch (error) {
      print('Error Occurred: $error');
    }
  }

  Future<void> bankTransfer(BuildContext context) async {
    String formattedDate = DateFormat('yyyy-MM-dd').format(selectedDay);

    try {
      print('addMortgageForm Preparing API request...');

      // Prepare the request
      var request = http.Request('POST', Uri.parse(Urls.bankTransfer));
      request.body = json.encode({
        "accountName": accountName,
        "accountNumber": accountNumber,
        "bankName": bankName,
        "amount": amount,
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
         // ignore: use_build_context_synchronously
         Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) => const MortgagePageHome(
                startIndex: 11), // Start with MortgagePageHome
          ),
        );
        Fluttertoast.showToast(
          msg: "Amount Send Successfully",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          backgroundColor: Colors.grey,
          textColor: Color.fromARGB(255, 15, 15, 15),
        );
        print('API Success Response: $result');
        // ignore: use_build_context_synchronously
       
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

  void clearFields() {
    propertyValueController.clear();
    initialDepositController.clear();
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

          findAndSetCity();
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
    findAndSetArea();
    print('Updated City Name: $cityName');
  }

  Future<void> findAndSetArea() async {
    List<SeletArea> allArea = await fetchAreasByCity();

    var matchArea = allArea.firstWhere(
      (item) => item.id == selectedArea,
      orElse: () => SeletArea(id: -1, name: "Unknown Area"),
    );
    areaNameValue.text = matchArea.name.toString();
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
}
