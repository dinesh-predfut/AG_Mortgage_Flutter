// controllers/card_controller.dart
import 'dart:convert';
import 'package:ag_mortgage/All_Cards/Get_all_Cards/Models.dart';
import 'package:ag_mortgage/All_Cards/Get_all_Cards/all_cards.dart';
import 'package:ag_mortgage/Dashboard_Screen/Market_Place/Dashboard_Page/model.dart';
import 'package:ag_mortgage/const/constant.dart';
import 'package:ag_mortgage/const/url.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

// ignore: camel_case_types
class Market_Place_controller extends ChangeNotifier {
  String? selectedLocation;
  String? selectedHouseType;
  int? selectedBedrooms;
  double? budget;
  late TabController _tabController;
  
 Future<ApinewHoseview> fetchnewtViewedHouses() async {
    final uri = Uri.parse('${Urls.marketPlace}?page=0&size=10&newHouses=true');

    // Create a GET request with headers   
    final request = http.Request('GET', uri)
      ..headers.addAll({
        'Content-Type': 'application/json',
        'Authorization': 'Bearer ${Params.userToken ?? ''}',
      });

    // Send the request
    final response = await request.send();

    // Read the response body and decode it
    final responseBody = await response.stream.bytesToString();

    if (response.statusCode == 200) {
      return ApinewHoseview.fromJson(json.decode(responseBody));
    } else {
      throw Exception('Failed to load houses');
    }
  }  
  Future<ApiResponsemostview> fetchmostViewedHouses() async {
    final uri = Uri.parse('${Urls.marketPlace}?page=0&size=10&mostViewed=true');

    // Create a GET request with headers   
    final request = http.Request('GET', uri)
      ..headers.addAll({
        'Content-Type': 'application/json',
        'Authorization': 'Bearer ${Params.userToken ?? ''}',
      });

    // Send the request
    final response = await request.send();

    // Read the response body and decode it
    final responseBody = await response.stream.bytesToString();

    if (response.statusCode == 200) {
      return ApiResponsemostview.fromJson(json.decode(responseBody));
    } else {
      throw Exception('Failed to load houses');
    }
  }
   Future<ApiResponse> fetchHouses() async {
    final uri = Uri.parse('${Urls.marketPlace}?page=0&size=10&sponsored=true');

    // Create a GET request with headers
    final request = http.Request('GET', uri)
      ..headers.addAll({
        'Content-Type': 'application/json',
        'Authorization': 'Bearer ${Params.userToken ?? ''}',
      });

    // Send the request
    final response = await request.send();

    // Read the response body and decode it
    final responseBody = await response.stream.bytesToString();

    if (response.statusCode == 200) {
      return ApiResponse.fromJson(json.decode(responseBody));
    } else {
      throw Exception('Failed to load houses');
    }
  }
  Future<ApiTodayDeals> fetchTodayDeals() async {
    final uri = Uri.parse('${Urls.marketPlace}?page=0&size=10');

    // Create a GET request with headers   
    final request = http.Request('GET', uri)
      ..headers.addAll({
        'Content-Type': 'application/json',
        'Authorization': 'Bearer ${Params.userToken ?? ''}',
      });

    // Send the request
    final response = await request.send();

    // Read the response body and decode it
    final responseBody = await response.stream.bytesToString();

    if (response.statusCode == 200) {
      return ApiTodayDeals.fromJson(json.decode(responseBody));
    } else {
      throw Exception('Failed to load houses');
    }
  }
  Future<List<String>> tabFetch() async {
    final uri = Uri.parse(Urls.allCity);

    // Create a GET request with headers
    final request = http.Request('GET', uri)
      ..headers.addAll({
        'Content-Type': 'application/json',
        'Authorization': 'Bearer ${Params.userToken ?? ''}',
      });

    // Send the request
    final response = await request.send();

    // Read the response body and decode it
    final responseBody = await response.stream.bytesToString();

    if (response.statusCode == 200) {
      // return ApiResponse.fromJson(json.decode(responseBody));
      List<dynamic> data = json.decode(responseBody);
       return data.map<String>((item) => item['name'].toString()).toList();
    } else {
      throw Exception('Failed to load houses');
    }
  }
}

