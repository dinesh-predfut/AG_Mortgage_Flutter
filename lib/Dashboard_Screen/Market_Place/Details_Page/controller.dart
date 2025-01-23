import 'dart:convert';
import 'package:ag_mortgage/Dashboard_Screen/Market_Place/Details_Page/models.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

import '../../../const/constant.dart';
import '../../../const/url.dart';
import '../Dashboard_Page/model.dart';

// ignore: camel_case_types
class House_view_controller extends ChangeNotifier {

  // Fetch all items
  Future<Houseview> fetchMostviewList(int? id) async {
    final uri = Uri.parse('${Urls.houseView}?id=$id');
   final request = http.Request('GET', uri)
      ..headers.addAll({
        'Content-Type': 'application/json',
        'Authorization': 'Bearer ${Params.userToken ?? ''}',
      });
       final response = await request.send();

    // Read the response body and decode it
    final responseBody = await response.stream.bytesToString();

    if (response.statusCode == 200) {
       return Houseview.fromJson(json.decode(responseBody));
      
    } else {
      throw Exception('Failed to load Mostview data');
    }
  }

}