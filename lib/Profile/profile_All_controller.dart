// controllers/card_controller.dart
import 'dart:async';
import 'dart:convert';
// import 'dart:html';
import 'dart:io';
import 'dart:typed_data';
import 'package:ag_mortgage/Dashboard_Screen/Mortgage/MortgageHome.dart';
import 'package:ag_mortgage/Dashboard_Screen/Mortgage/models.dart';
import 'package:ag_mortgage/Profile/Edit_Profile/models.dart';
import 'package:ag_mortgage/const/constant.dart';
import 'package:ag_mortgage/const/url.dart';
import 'package:flutter/material.dart';
import 'package:flutter_image_compress/flutter_image_compress.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:http_parser/http_parser.dart';
import 'package:intl/date_symbol_data_file.dart';
import 'package:intl/intl.dart';
import 'package:image_picker/image_picker.dart';
import 'package:open_filex/open_filex.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:file_picker/file_picker.dart';

// ignore: camel_case_types
class Profile_Controller extends ChangeNotifier {
  final TextEditingController employerController = TextEditingController();
  final TextEditingController jobTitleController = TextEditingController();
  final TextEditingController netSalaryController = TextEditingController();
  final TextEditingController netWorthController = TextEditingController();

  final TextEditingController industryController = TextEditingController();
  final TextEditingController professionController = TextEditingController();
  final TextEditingController monthlyIncomeController = TextEditingController();
  final TextEditingController selfNetWorthController = TextEditingController();
// Personal Details
  final TextEditingController gender = TextEditingController();
  final TextEditingController nin = TextEditingController();
  final TextEditingController fullName = TextEditingController();
  final TextEditingController relationShip = TextEditingController();
  final TextEditingController phoneNumber = TextEditingController();
  final TextEditingController email = TextEditingController();
  final TextEditingController address = TextEditingController();
  final TextEditingController usernameController = TextEditingController();
  // final TextEditingController passwordController = TextEditingController();
  final TextEditingController confirmPasswordController =
      TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  DateTime? dob;
  bool isDocumentUploaded = false;
  bool isDocumentUploaded2 = false;
  bool isEdited = false;
  String? nationalIdPath;
  String? passportIdPath;
  String? nextOfKinPassportPath;
  String? HelpDiskPhone;
  String? HelpDiskEmail;
  String? HelpDiskWhatapp;
  File? image;
  final ImagePicker picker = ImagePicker();

  String? selectedCity;
  bool isDocumentUploadedPd = false;
  bool isDocumentUploadedPD2 = false;
  String? nationalIdPathPd;
  String? passportIdPathPd;

  late int kinID;
  String? selectedCityHome;
  String? selectedState;
  String? selectedarea;

  Future<void> fetchCustomerDetails() async {
    try {
      var url = Uri.parse('${Urls.getEmployeeDetailsID}?id=${Params.userId}');
      var headers = {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer ${Params.userToken ?? ''}',
      };

      var response = await http.get(url, headers: headers);

      print('Response Code: ${response.statusCode}');
      print('Response Body: ${response.body}');

      if (response.statusCode == 200) {
        var jsonData = json.decode(response.body);
        CustomerDetailsModel customerDetails =
            CustomerDetailsModel.fromJson(jsonData);

        // selectedCity = jsonData.employmentType;
        employerController.text = customerDetails.employer;
        jobTitleController.text = customerDetails.jobTitle;
        netSalaryController.text = customerDetails.netSalary.toString();
        netWorthController.text = customerDetails.netWorth.toString();
        industryController.text = customerDetails.industry;
        professionController.text = customerDetails.profession;
        monthlyIncomeController.text = customerDetails.monthlyIncome.toString();
        gender.text = customerDetails.gender;
        dob = DateTime.tryParse(customerDetails.dateOfBirth);
        nin.text = customerDetails.nin;
        fullName.text = customerDetails.nextOfKinDetails!.name;
        relationShip.text = customerDetails.nextOfKinDetails!.relationship;
        phoneNumber.text = customerDetails.nextOfKinDetails!.phoneNumber;
        email.text = customerDetails.nextOfKinDetails!.email;
        address.text = customerDetails.nextOfKinDetails!.address;
        image = File(customerDetails.profileImage);
        kinID = customerDetails.nextOfKinDetails!.id;
        selectedCityHome = customerDetails.city.toString();
        selectedarea = customerDetails.area.toString();
        selectedState = customerDetails.state.toString();
      } else {
        Fluttertoast.showToast(
          msg: "Error: ${response.body}",
          toastLength: Toast.LENGTH_SHORT,
        );
      }
    } catch (error) {
      print('Error Occurred: $error');
      Fluttertoast.showToast(
        msg: "An error occurred: $error",
        toastLength: Toast.LENGTH_SHORT,
      );
    }
  }

  Future<File?> compressImage(File image) async {
    final dir = await Directory.systemTemp.createTemp();
    final targetPath = '${dir.path}/temp.jpg';

    Uint8List? compressedData = await FlutterImageCompress.compressWithFile(
      image.path,
      minWidth: 800, 
      quality: 80, 
      format: CompressFormat.jpeg,
    );

    if (compressedData != null) {
      final compressedFile = File(targetPath)..writeAsBytesSync(compressedData);
      return compressedFile;
    } else {
      Fluttertoast.showToast(msg: "Error compressing image.");
      return null;
    }
  }

  Future<void> uploadImage(File image) async {
    try {
      if (image == null || !image.existsSync()) {
        Fluttertoast.showToast(
          msg: "No image selected",
          toastLength: Toast.LENGTH_SHORT,
        );
        return;
      }

      var request = http.MultipartRequest(
          'PUT', 
          Uri.parse('${Urls.profile}?id=${Params.userId}'));

      request.headers.addAll({
        'Authorization':
            'Bearer ${Params.userToken ?? ''}', 
      });

     
      request.files.add(
        await http.MultipartFile.fromPath(
          'profileImage', 
          image.path,
          contentType: MediaType(
              'image', 'jpeg'), 
        ),
      );

      var streamedResponse = await request.send();
      var decodedResponse = await http.Response.fromStream(streamedResponse);

      if (decodedResponse.statusCode == 200) {
        Fluttertoast.showToast(
          msg: "Profile image updated successfully",
          toastLength: Toast.LENGTH_SHORT,
        );
      } else {
        Fluttertoast.showToast(
          msg: "Failed to update profile image: ${decodedResponse.body}",
          toastLength: Toast.LENGTH_SHORT,
        );
      }
    } catch (error) {
      print('Error Occurred: $error');
      Fluttertoast.showToast(
        msg: "An error occurred: $error",
        toastLength: Toast.LENGTH_SHORT,
      );
    }
  }

  Future<bool> employementDetails(BuildContext context) async {
    print('userId: ${Params.userId}');
    try {
      var request = http.Request('PUT', Uri.parse(Urls.employeRegister));
      request.body = json.encode({
        "id": Params.userId,
        "employmentType": selectedCity,
        "employer": employerController.text,
        "jobTitle": jobTitleController.text,
        "netSalary": netSalaryController.text,
        "netWorth": netWorthController.text,
        "industry": industryController.text,
        "profession": professionController.text,
        "monthlyIncome": monthlyIncomeController.text,
        "monthlyIncome": monthlyIncomeController.text,
      });

      request.headers.addAll({
        'Content-Type': 'application/json',
        'Authorization': 'Bearer ${Params.userToken ?? ''}',
      });

      print('Request: ${request.body}');

      // Send request
      http.StreamedResponse streamedResponse = await request.send();
      var decodedResponse = await http.Response.fromStream(streamedResponse);

      print('decodedResponse Code: ${decodedResponse}');
      print('Response Body: ${decodedResponse.body}');

      if (decodedResponse.statusCode == 200) {

        Fluttertoast.showToast(
          msg: "Employment Updated Successfully",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          backgroundColor: Colors.grey,
          textColor: Colors.white,
        );
        return true;
      } else {
        print('Error: ${decodedResponse.body}');
        Fluttertoast.showToast(
          msg: "Error: ${decodedResponse.body}",
          toastLength: Toast.LENGTH_SHORT,
        );
        return false;
      }
    } catch (error) {
      print('Error Occurred: $error');
      Fluttertoast.showToast(
        msg: "An error occurred: $error",
        toastLength: Toast.LENGTH_SHORT,
      );
      return false;
    }
  }

  Future<bool> logInDetails(BuildContext context) async {
    print('userId: ${Params.userId}');
    try {
      var request = http.Request('PUT', Uri.parse(Urls.logInDetails));
      request.body = json.encode({
        "id": Params.userId,
        "phoneNumber": phoneNumber.text,
        "email": email.text,
        "password": passwordController.text,
      });

      request.headers.addAll({
        'Content-Type': 'application/json',
        'Authorization': 'Bearer ${Params.userToken ?? ''}',
      });

      print('Request: ${request.body}');

      // Send request
      http.StreamedResponse streamedResponse = await request.send();
      var decodedResponse = await http.Response.fromStream(streamedResponse);

      print('decodedResponse Code: ${decodedResponse}');
      print('Response Body: ${decodedResponse.body}');

      if (decodedResponse.statusCode == 200) {
        // ignore: use_build_context_synchronously

        Fluttertoast.showToast(
          msg: "LoginDetails Updated Successfully",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          backgroundColor: Colors.grey,
          textColor: Colors.white,
        );
        return true;
      } else {
        print('Error: ${decodedResponse.body}');
        Fluttertoast.showToast(
          msg: "Error: ${decodedResponse.body}",
          toastLength: Toast.LENGTH_SHORT,
        );
        return false;
      }
    } catch (error) {
      print('Error Occurred: $error');
      Fluttertoast.showToast(
        msg: "An error occurred: $error",
        toastLength: Toast.LENGTH_SHORT,
      );
      return false;
    }
  }

  Future<bool> helpDisk(BuildContext context) async {
    print('userId: ${Params.userId}');
    try {
      var request = http.Request('GET', Uri.parse(Urls.helpDisk));

      request.headers.addAll({
        'Content-Type': 'application/json',
        'Authorization': 'Bearer ${Params.userToken ?? ''}',
      });

      print('Request: ${request.body}');

      // Send request
      http.StreamedResponse streamedResponse = await request.send();
      var decodedResponse = await http.Response.fromStream(streamedResponse);

      print('decodedResponse Code: ${decodedResponse}');
      print('Response Body: ${decodedResponse.body}');

      if (decodedResponse.statusCode == 200) {
        // ignore: use_build_context_synchronously
        var responseJson = jsonDecode(decodedResponse.body);
        HelpDiskEmail = responseJson['email'] ?? '';
        HelpDiskPhone = responseJson['phoneNumber'] ?? '';
        HelpDiskWhatapp = responseJson['whatsApp'] ?? '';
        Fluttertoast.showToast(
          msg: "LoginDetails Updated Successfully",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          backgroundColor: Colors.grey,
          textColor: Colors.white,
        );
        return true;
      } else {
        print('Error: ${decodedResponse.body}');
        Fluttertoast.showToast(
          msg: "Error: ${decodedResponse.body}",
          toastLength: Toast.LENGTH_SHORT,
        );
        return false;
      }
    } catch (error) {
      print('Error Occurred: $error');
      Fluttertoast.showToast(
        msg: "An error occurred: $error",
        toastLength: Toast.LENGTH_SHORT,
      );
      return false;
    }
  }

  Future<bool> kinDetails(BuildContext context) async {
    print('userId: ${Params.userId}');
    try {
      var request = http.Request('PUT', Uri.parse(Urls.kinDetails));
      request.body = json.encode({
        "customerId": Params.userId,
        "id": kinID,
        "name": fullName.text,
        "relationship": relationShip.text,
        "phoneNumber": phoneNumber.text,
        "email": email.text,
        "address": address.text
      });

      request.headers.addAll({
        'Content-Type': 'application/json',
        'Authorization': 'Bearer ${Params.userToken ?? ''}',
      });

      print('Request: ${request.body}');

      // Send request
      http.StreamedResponse streamedResponse = await request.send();
      var decodedResponse = await http.Response.fromStream(streamedResponse);

      print('decodedResponse Code: ${decodedResponse}');
      print('Response Body: ${decodedResponse.body}');

      if (decodedResponse.statusCode == 200) {
        // ignore: use_build_context_synchronously

        Fluttertoast.showToast(
          msg: "Employment Updated Successfully",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          backgroundColor: Colors.grey,
          textColor: Colors.white,
        );
        return true;
      } else {
        print('Error: ${decodedResponse.body}');
        Fluttertoast.showToast(
          msg: "Error: ${decodedResponse.body}",
          toastLength: Toast.LENGTH_SHORT,
        );
        return false;
      }
    } catch (error) {
      print('Error Occurred: $error');
      Fluttertoast.showToast(
        msg: "An error occurred: $error",
        toastLength: Toast.LENGTH_SHORT,
      );
      return false;
    }
  }
}
