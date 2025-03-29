import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:ag_mortgage/Authentication/FinalPage/final.dart';
import 'package:ag_mortgage/Authentication/Login/login.dart';
import 'package:ag_mortgage/Authentication/Login/signin_model.dart';
import 'package:ag_mortgage/Authentication/Login_Models.dart/profile_model.dart';
import 'package:ag_mortgage/Authentication/OTP/authentication.dart';
import 'package:ag_mortgage/Authentication/PIN_Creation/pin.dart';
import 'package:ag_mortgage/Authentication/Profile/profile.dart';
import 'package:ag_mortgage/const/constant.dart';
import 'package:ag_mortgage/const/url.dart';
import 'package:ag_mortgage/main.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';

class ProfileController extends GetxController {
  RxBool showMsg = false.obs;
  RxBool isLoading = false.obs;
  RxBool isTermChecked = false.obs;
  RxBool pinMatch = false.obs;
  RxBool showTimer = false.obs;
  RxString gender = 'Female'.obs;
  String countryCode = "";
  String countryName = "TZ";
  TextEditingController firstNameController = TextEditingController();
  TextEditingController lasttNameController = TextEditingController();
  TextEditingController numberController = TextEditingController();
  TextEditingController registerPhoneNumber = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController otpController = TextEditingController();
  TextEditingController pin1Controller = TextEditingController();
  TextEditingController pin2Controller = TextEditingController();
  TextEditingController promoCode = TextEditingController();
  TextEditingController dobController = TextEditingController();
  final TextEditingController countryCodeController = TextEditingController();
  TextEditingController nin = TextEditingController();
  final TextEditingController newPasswordController = TextEditingController();
  String? selectedGender;
  File? image;
    final ImagePicker _picker = ImagePicker();
  RxInt secondsRemaining = 120.obs;
  Timer? timer;
  XFile path = XFile("null");
  Rx<SignInModel> signInModel = SignInModel().obs;
  @override
  void onInit() {
    // userProfile();
    super.onInit();
  }
Future<void> pickImage() async {
    final XFile? pickedFile =
        await _picker.pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
     
        image = File(pickedFile.path);
  
    }
  }
  nextFuncation(BuildContext context) {
    final emailRegex =
        RegExp(r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$');
    if (firstNameController.text.isEmpty) {
      Fluttertoast.showToast(msg: "enter_first_name_msg");
    } else if (lasttNameController.text.isEmpty) {
      Fluttertoast.showToast(msg: "enter_last_name_msg");
    } else if (registerPhoneNumber.text.isEmpty) {
      Fluttertoast.showToast(msg: "enter_number_msg");
    } else if (registerPhoneNumber.text.length < 9) {
      Fluttertoast.showToast(msg: "enter_valid_number_msg");
    }
    // ignore: unnecessary_null_comparison
    if (emailController.value == null || emailController.value.text.isEmpty) {
      Fluttertoast.showToast(msg: "Email cannot be empty");
    } else if (!emailRegex.hasMatch(emailController.value.text)) {
      Fluttertoast.showToast(msg: "Invalid email address");
    } else {
      Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => const PIN_Creation()
              // const Authentication(),
              ));
    }
  }

  void onBackPressed(BuildContext context) {
    // Custom logic for back navigation
    if (Navigator.of(context).canPop()) {
      print("its working");
      Navigator.pushNamed(context, "/register");
    } else {
      // Show exit confirmation dialog if needed
      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: Text("Exit App"),
          content: Text("Do you want to exit the app?"),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: Text("No"),
            ),
            TextButton(
              onPressed: () => Navigator.of(context).pop(true),
              child: Text("Yes"),
            ),
          ],
        ),
      );
    }
  }

  Future checkUser(BuildContext context) async {
    try {
      isLoading(true);

      var request = http.Request('POST', Uri.parse(Urls.signIn));
      request.body = json.encode({
        "firstName": firstNameController.text,
        "lastName": lasttNameController.text,
        "dateOfBirth": dobController.text,
        "phoneNumber":
            countryCodeController.text.trim() + registerPhoneNumber.text,
        "email": emailController.text,
        "gender": selectedGender,
        "password": newPasswordController.text,
        "nin": nin.text
      });
      request.headers.addAll({'Content-Type': 'application/json'});

      http.StreamedResponse response = await request.send();
      var decodeData = await http.Response.fromStream(response);
      // final result = jsonDecode(decodeData.body);
      print("result ==> ${decodeData.body}");
      var responseBody = jsonDecode(decodeData.body);

      String message = responseBody['message'];
      if (response.statusCode == 200) {
        Fluttertoast.showToast(
          msg: message,
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          backgroundColor: Colors.grey,
          textColor: Colors.white,
          fontSize: 16.0,
        );
        // ignore: use_build_context_synchronously
        Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => const Authentication(),
            ));
      } else {
     
        Fluttertoast.showToast(
          msg: message,
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          backgroundColor: Colors.red,
          textColor: Colors.white,
          fontSize: 16.0,
        );
        // ignore: use_build_context_synchronously
        // Navigator.push(
        //     context,
        //     MaterialPageRoute(
        //       builder: (context) => Login(),
        //     ));
        // Fluttertoast.showToast(msg: result["message"]);
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
        "email":
            countryCodeController.text.trim() + registerPhoneNumber.text.trim(),
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
        // Show success toast
        Fluttertoast.showToast(
          msg: "User Created successful!",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          backgroundColor: Colors.grey,
          textColor: Colors.white,
          fontSize: 16.0,
        );

        isLoading(false);
      } else {
        Fluttertoast.showToast(
          msg: "Already Account Created Please Login",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          backgroundColor: Colors.red,
          textColor: Colors.white,
          fontSize: 16.0,
        );
        // Fluttertoast.showToast(msg: result["message"]);
        isLoading(false);
      }
    } catch (e) {
      isLoading(false);
      rethrow;
    }
  }
 static String formatDate(DateTime date) {
    return DateFormat('dd-MM-yyyy').format(date);
  }
  Future signIn(BuildContext context) async {
    try {
      isLoading(true);
      showMsg(false);
      print("countryCodeController.text${countryCodeController.text}");
      var request = http.Request('POST', Uri.parse(Urls.signup));
      request.body = json.encode({
        "username": countryCodeController.text + numberController.text.trim(),
        "password": passwordController.text.trim(),
      });
      request.headers.addAll({'Content-Type': 'application/json'});

      http.StreamedResponse response = await request.send();
      var decodeData = jsonDecode(await response.stream.bytesToString());

      if (response.statusCode == 200) {
        signInModel.value = SignInModel.fromJson(decodeData);
        print("login response ==> ${signInModel.value.refreshToken}");

        SetSharedPref().setData(
            token: signInModel.value.token ?? "null",
            phoneNumber: signInModel.value.username ?? "null",
            userId: signInModel.value.userId ?? 0,
            refreshToken: signInModel.value.refreshToken ?? "null");

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
        Navigator.pushNamed(context, "/dashBoardPage");
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

  Future<void> selectDate(BuildContext context) async {
    DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(1900),
      lastDate: DateTime.now(),
    );

    if (pickedDate != null) {
      dobController.text =
          "${pickedDate.day.toString().padLeft(2, '0')}-${pickedDate.month.toString().padLeft(2, '0')}-${pickedDate.year}";
    }
  }
}
