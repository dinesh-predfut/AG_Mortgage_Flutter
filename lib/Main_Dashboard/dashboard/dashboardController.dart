
import 'dart:convert';

import 'package:ag_mortgage/const/constant.dart';
import 'package:ag_mortgage/const/url.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:image_picker/image_picker.dart';

class DashboardController extends GetxController {
    var planOptions = <String>[].obs; // Observable list to store plan options
  var isLoading = false.obs;
  var profileName = "";
  String? profileImageUrl;


}