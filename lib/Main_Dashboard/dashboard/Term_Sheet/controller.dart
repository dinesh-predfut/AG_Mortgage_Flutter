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
import 'package:ag_mortgage/Main_Dashboard/dashboard/Term_Sheet/model.dart';
import 'package:ag_mortgage/const/constant.dart';
import 'package:ag_mortgage/const/url.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:intl/date_symbol_data_file.dart';
import 'package:intl/intl.dart';

class MortgagControllerDashboard extends ChangeNotifier {
  TextEditingController cityNameValue = TextEditingController();
  TextEditingController areaNameValue = TextEditingController();
  TextEditingController constructionName = TextEditingController();

  TextEditingController cvv = TextEditingController();
  Map<String, dynamic> data = {};
  var isLoading = true.obs;
  List allApartments = [];
  List allCity = [];
  List allArea = [];
  List typeConstruction = [];
  List allMsetting = [];
  DateTime selectedDay = DateTime.now();
//  String formattedDate = DateFormat('yyyy-MM-dd').format(selectedDay);
  int? selectedApartmentType = 1;
  int? propertyValueController;
  int? selectedCity;

  int? monthlyRepaymentController;
  int? selectedArea;
  int? seletedconstruction;
  int? initialDepositController;
  double sliderValue = 10;
  int? apartmentOrMarketplace;
  String cityName = "";
  int? loanRepaymentPeriod;
  String? startDate = "";
  String anniversary = "";

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
      print("Decoded Data Length: ${data.toString()}");

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

  Future<List<PostsModel>> getALLCityApi() async {
    isLoading.value = true;
    try {
      final response = await http.get(Uri.parse(Urls.allCity));
      final body = json.decode(response.body) as List;
      if (response.statusCode == 200) {
        isLoading.value = false;
        fetchAreasByCity();
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
          isLoading.value = false;
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

  Future<void> fetchCitiesAndAreas() async {
    try {
      allArea = await fetchAreasByCity();
      allCity = await getALLCityApi();
      typeConstruction = await getScreeningPeriodsApi();
      int? formDataArea = selectedArea;
      int? formDataCity = selectedCity;
      int? formdataConstruction = seletedconstruction;
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
      var typeOfConstruction = typeConstruction.firstWhere(
        (apartment) => apartment.id == formdataConstruction,
        orElse: () => LoanModel(
            id: -1,
            constructionType: "Unknown Apartment",
            typeName: '',
            profilingPeriod: 0,
            minPaymentPeriod: 0,
            maxPaymentPeriod: 0,
            constructionLocation: '',
            depositInterest: 0,
            mortgageInterest: 0),
      );
      print("ypeOfConstruction.typeName data: ${typeOfConstruction.typeName}");
      areaNameValue.text = defaultArea.name;
      cityNameValue.text = defaultCity.name;
      constructionName.text = typeOfConstruction.typeName;
      // areaNameValue.text = defaultArea.name;
    } catch (error) {
      print("Error fetching data: $error");
    }
  }

  Future<void> findAndSetCity() async {
    List<PostsModel> allCity = await getALLCityApi();

    var matchCity = allCity.firstWhere(
      (item) => item.id == selectedCity,
      orElse: () => PostsModel(id: -1, name: "Unknown"),
    );

    cityNameValue.text = matchCity.name.toString();

    print('Updated City Name City Name: ${cityNameValue.value}');
  }

  Future<void> findAndSetconstruction() async {
      typeConstruction = await getScreeningPeriodsApi();
 int? formdataConstruction = seletedconstruction;

    var typeOfConstruction = typeConstruction.firstWhere(
      (apartment) => apartment.id == formdataConstruction,
      orElse: () => LoanModel(
          id: -1,
          constructionType: "Unknown Apartment",
          typeName: '',
          profilingPeriod: 0,
          minPaymentPeriod: 0,
          maxPaymentPeriod: 0,
          constructionLocation: '',
          depositInterest: 0,
          mortgageInterest: 0),
    );
 print(
        'findAndSetconstruction City Name City Name: ${typeOfConstruction.typeName}');
    constructionName.text = typeOfConstruction.typeName;
   
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

  String formatNumber(String number) {
    if (number.isEmpty) return number;
    final formatter = NumberFormat('#,###');
    final intNumber = int.tryParse(number);
    if (intNumber == null) return number;
    return formatter.format(intNumber);
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
        isLoading.value = false;
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
    return DateFormat('MMM yyyy').format(dateTime).toUpperCase();
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
        isLoading.value = false;
        List<dynamic> data = json.decode(response.body);
        List<CustomerModel> customers =
            data.map((json) => CustomerModel.fromJson(json)).toList();
        final customer = customers[0];
        selectedCity = customer.city;
        selectedArea = customer.area;
        print("selectedCity$selectedCity");
        if (customers.isNotEmpty) {
          fetchAreasByCity();
        }
        return customers;
      } else {
        throw Exception('Failed to load data: ${response.statusCode}');
      }
    } catch (e) {
      print('Error: $e');
      throw Exception('Failed to fetch mortgage details');
    }
  }

  Future<List<CustomerModel>> fetchRentToOwnDetails() async {
    try {
      print('userId: ${Params.userId}');

      final url = Uri.parse('${Urls.getRentToOwnDetails}?id=${Params.userId}');

      final headers = {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer ${Params.userToken ?? ''}',
      };

      final response = await http.get(url, headers: headers);

      if (response.statusCode == 200) {
        List<dynamic> data = json.decode(response.body);
        List<CustomerModel> customers =
            data.map((json) => CustomerModel.fromJson(json)).toList();
        final customer = customers[0];
        selectedCity = customer.city;
        selectedArea = customer.area;
        print("selectedCity$selectedCity");
        if (customers.isNotEmpty) {
          fetchAreasByCity();
        }
        return customers;
      } else {
        throw Exception('Failed to load data: ${response.statusCode}');
      }
    } catch (e) {
      print('Error: $e');
      throw Exception('Failed to fetch mortgage details');
    }
  }

  Future<List<ConstructionProject>> fetchConstructionFinance() async {
    try {
      print('userId: ${Params.userId}');

      final url = Uri.parse(
          '${Urls.getAllConstructionFinanceDetailsByCustomer}?id=${Params.userId}');

      final headers = {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer ${Params.userToken ?? ''}',
      };

      final response = await http.get(url, headers: headers);

      if (response.statusCode == 200) {
        List<dynamic> data = json.decode(response.body);
        List<ConstructionProject> customers =
            data.map((json) => ConstructionProject.fromJson(json)).toList();

        if (customers.isNotEmpty) {
          final customer = customers[0];
          selectedCity = customer.city;
          selectedArea = customer.area;
          seletedconstruction = customer.typeOfConstruction;

          print("selectedCity$seletedconstruction");
          fetchAreasByCity();
        }
        return customers;
      } else {
        throw Exception('Failed to load data: ${response.statusCode}');
      }
    } catch (e) {
      print('Error: $e');
      throw Exception('Failed to fetch mortgage details');
    }
  }
}
