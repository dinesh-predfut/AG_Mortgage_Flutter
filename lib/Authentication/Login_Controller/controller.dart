import 'dart:async';
import 'dart:convert';

import 'package:ag_mortgage/Authentication/Login/signin_model.dart';
import 'package:ag_mortgage/Authentication/Login_Models.dart/profile_model.dart';
import 'package:ag_mortgage/const/constant.dart';
import 'package:ag_mortgage/const/url.dart';
import 'package:ag_mortgage/main.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:image_picker/image_picker.dart';
class ProfileController extends GetxController {
    RxBool showMsg = false.obs;
   RxBool isLoading = false.obs;
  RxBool isTermChecked = false.obs;
  RxBool pinMatch = false.obs;
  RxBool showTimer = false.obs;
  RxString gender = 'Female'.obs;
  String countryCode = "234";
  String countryName = "TZ";
  TextEditingController firstNameController = TextEditingController();
  TextEditingController lasttNameController = TextEditingController();
  TextEditingController numberController = TextEditingController();
   TextEditingController passwordController = TextEditingController();
  TextEditingController otpController = TextEditingController();
  TextEditingController pin1Controller = TextEditingController();
  TextEditingController pin2Controller = TextEditingController();
   TextEditingController promoCode = TextEditingController();
  RxInt secondsRemaining = 120.obs;
  Timer? timer;
  XFile path = XFile("null");
  Rx<SignInModel> signInModel = SignInModel().obs;
  @override
  void onInit() {
    // userProfile();
    super.onInit();
  }
    nextFuncation() {
    if (firstNameController.text.isEmpty) {
      Fluttertoast.showToast(msg: "enter_first_name_msg".tr);
    } else if (lasttNameController.text.isEmpty) {
      Fluttertoast.showToast(msg: "enter_last_name_msg".tr);
    } else if (numberController.text.isEmpty) {
      Fluttertoast.showToast(msg: "enter_number_msg".tr);
    } else if (numberController.text.length < 9) {
      Fluttertoast.showToast(msg: "enter_valid_number_msg".tr);
    } else if (isTermChecked.value == false) {
      Fluttertoast.showToast(msg: "read_condition_msg".tr);
    } else {
      checkUser();
    }
  }
   Future checkUser() async {
    try {
      isLoading(true);
      var request = http.Request(
          'GET',
          Uri.parse(
              "${Urls.signIn}/${countryCode + numberController.text.trim()}"));

      http.StreamedResponse response = await request.send();
      var decodeData = await http.Response.fromStream(response);
      final result = jsonDecode(decodeData.body);
      print("check user ==> ${result["exists"]}");

      if (result["exists"] == true) {
        Fluttertoast.showToast(msg: "already_use".tr);

        isLoading(false);
      } else {
        // sendOTP();
        isLoading(false);
      }
    } catch (e) {
      isLoading(false);
      rethrow;
    }
  }
  
  Future sendOTP() async {
    try {
      isLoading(true);

      var request = http.Request('POST', Uri.parse(Urls.sendOTP));
      request.body = json.encode({
        "email": countryCode + numberController.text.trim(),
        "userType": "customer",
        "resendType": "emailVerification"

      });
      request.headers.addAll({'Content-Type': 'application/json'});

      http.StreamedResponse response = await request.send();
      var decodeData = await http.Response.fromStream(response);
      // final result = jsonDecode(decodeData.body);
      print("result ==> ${decodeData.body}");

      if (response.statusCode == 200) {
        // Get.to(() => Authentication(isReset: false), binding: InitialBinding());
        Fluttertoast.showToast(
            msg:
                "${"otp_sent".tr} ${countryCode + numberController.text.trim()}",
            toastLength: Toast.LENGTH_LONG);
        isLoading(false);
      } else {
        // Fluttertoast.showToast(msg: result["message"]);
        isLoading(false);
      }
    } catch (e) {
      isLoading(false);
      rethrow;
    }
  }
  Future signIn(BuildContext context) async {
  try {
    isLoading(true);
    showMsg(false);

    var request = http.Request('POST', Uri.parse(Urls.signIn));
    request.body = json.encode({
      "username": countryCode + numberController.text.trim(),
      "password": passwordController.text.trim(),
    });
    request.headers.addAll({'Content-Type': 'application/json'});

    http.StreamedResponse response = await request.send();
    var decodeData = jsonDecode(await response.stream.bytesToString());

    if (response.statusCode == 200) {
      signInModel.value = SignInModel.fromJson(decodeData);
      print("login response ==> $signInModel");

      SetSharedPref().setData(
        token: signInModel.value.token ?? "null",
        phoneNumber: signInModel.value.username ?? "null",
        userId: signInModel.value.id ?? "null",
      );

      isLoading(false);
      showMsg(false);

      // Show success toast
      Fluttertoast.showToast(
        msg: "Login successful!",
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        backgroundColor: Colors.green,
        textColor: Colors.white,
        fontSize: 16.0,
      );

      // Navigate to LandingPage
      // ignore: use_build_context_synchronously
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (_) => const LandingPage(startIndex: 1),
        ),
      );
    } else {
      showMsg(true);
      isLoading(false);

      // Show error toast
      Fluttertoast.showToast(
        msg: decodeData["message"] ?? "Login failed. Please try again.",
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        backgroundColor: Colors.red,
        textColor: Colors.white,
        fontSize: 16.0,
      );
    }
  } catch (e) {
    showMsg(true);
    isLoading(false);

    // Show exception toast
    Fluttertoast.showToast(
      msg: "An error occurred: $e",
      toastLength: Toast.LENGTH_SHORT,
      gravity: ToastGravity.BOTTOM,
      backgroundColor: Colors.red,
      textColor: Colors.white,
      fontSize: 16.0,
    );

    rethrow;
  }
}

}