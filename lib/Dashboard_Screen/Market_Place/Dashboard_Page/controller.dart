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

 Future<ApiResponsemostview> fetchMostViewedHouses() async {
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
      return ApiResponsemostview.fromJson(json.decode(responseBody));
    } else {
      throw Exception('Failed to load houses');
    }
  }
   Future<ApiResponse> fetchHouses() async {
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
      return ApiResponse.fromJson(json.decode(responseBody));
    } else {
      throw Exception('Failed to load houses');
    }
  }
}

