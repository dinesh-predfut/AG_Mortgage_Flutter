// controllers/card_controller.dart
import 'dart:async';
import 'dart:convert';
import 'dart:ffi';
// import 'dart:html';
import 'dart:io';
import 'package:ag_mortgage/Profile/profile.dart';
import 'package:ag_mortgage/const/commanFunction.dart';
import 'package:dio/dio.dart' as dio;
import 'package:get/get.dart';
import 'package:dio/dio.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
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
  final TextEditingController countryCodeController = TextEditingController();
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
  final TextEditingController userPhonenumber = TextEditingController();
  final TextEditingController useremail = TextEditingController();
  final TextEditingController email = TextEditingController();
  final TextEditingController address = TextEditingController();
  final TextEditingController usernameController = TextEditingController();
  // final TextEditingController passwordController = TextEditingController();
  final TextEditingController confirmPasswordController =
      TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  Map<String, String?> uploadedFiles = {};
  // List<Apartment> apartments = [];
  Apartment? selectedApartment;
  bool isUploading = false;
  List<dynamic> showFiles = [];
  var finalData = <dynamic>[].obs;
  List<dynamic> userDocuments = []; // Initialize an empty list
  late int fileId;
  DateTime? dob;
  bool isDocumentUploaded = false;
  bool isDocumentUploaded2 = false;
  bool isEdited = false;
  List<String> planOption = [];
  String? nationalIdPath;
  String? passportIdPath;
  String? documentFileUrl;
  String? nextOfKinPassportPath;
  String? HelpDiskPhone;
  String? HelpDiskEmail;
  String? HelpDiskWhatapp;
  File? image;
  String? showImage;
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

// Future<List<Apartment>>fetchApartments() async {
//     try {
//     final url = Uri.parse(Urls.fetchApartmentsApi);
//       var headers = {
//         'Content-Type': 'application/json',
//         'Authorization': 'Bearer ${Params.userToken ?? ''}',
//       };

//       var response = await http.get(url, headers: headers);

//       print('Response Code: ${response.statusCode}');
//       print('Response Body: ${response.body}');

//       if (response.statusCode == 200) {
//        List data = jsonDecode(response.body);
//       final List<Apartment> fetchedApartments =
//          return data.map((e) => Apartment.fromJson(e)).toList();
//       apartments.addAll(fetchedApartments);
      

//         print('showFiles Filtered Documents: $showFiles');
//         print('showFiles Filtered Documentss: $showFiles');
//       } else {
//         Fluttertoast.showToast(
//           msg: "Error: ${response.body}",
//           toastLength: Toast.LENGTH_SHORT,
//         );
//       }
//     } catch (error) {
//       print('Error Occurred11: $error');
//       Fluttertoast.showToast(
//         msg: "An error occurred: $error",
//         toastLength: Toast.LENGTH_SHORT,
//       );
//     }
//   }
    Future<List<Apartment>?> fetchApartments() async {
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
  Future<CustomerDetailsModel?> fetchCustomerDetails() async {
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
        // final Map<String, dynamic> parsedData = jsonDecode(jsonData);
        showFiles = jsonData['Document'] ?? [];
        ;

        planOption = customerDetails.planOption ?? [];
        planOption = planOption.toSet().toList(); // Remove duplicates

        print('Updated Plan Options: $jsonData');
        employerController.text = customerDetails?.employer ?? '';
        jobTitleController.text = customerDetails?.jobTitle ?? '';
        netSalaryController.text =
            customerDetails?.netSalary?.toString() ?? '0';
        netWorthController.text = customerDetails?.netWorth?.toString() ?? '0';
        industryController.text = customerDetails?.industry ?? '';
        professionController.text = customerDetails?.profession ?? '';
        monthlyIncomeController.text =
            customerDetails?.monthlyIncome?.toString() ?? '0';
        gender.text = customerDetails?.gender ?? '';
        dob = DateTime.tryParse(customerDetails?.dateOfBirth ?? '');
        nin.text = customerDetails?.nin ?? '';

// Handle nextOfKinDetails safely
        fullName.text = customerDetails.nextOfKinDetails?.name ?? '';
        relationShip.text =
            customerDetails.nextOfKinDetails?.relationship ?? '';
        phoneNumber.text = customerDetails.nextOfKinDetails?.phoneNumber ?? '';
        userPhonenumber.text = customerDetails.phoneNumber ?? '';
        email.text = customerDetails.nextOfKinDetails?.email ?? '';
        useremail.text = customerDetails?.email ?? '';

        address.text = customerDetails.nextOfKinDetails?.address ?? '';
        kinID = customerDetails.nextOfKinDetails?.id ?? 0;

        showImage = customerDetails.profileImage ?? '';
        selectedCityHome = customerDetails.city.toString() ?? '';
        selectedarea = customerDetails.area.toString();
        selectedState = customerDetails.state.toString() ?? '';
        // showFiles = customerDetails.documents;

        // showFiles = documents.toSet().cast<String>().toList();

        print('showFiles Filtered Documents: $showFiles');
        print('showFiles Filtered Documentss: $showFiles');
      } else {
        Fluttertoast.showToast(
          msg: "Error: ${response.body}",
          toastLength: Toast.LENGTH_SHORT,
        );
      }
    } catch (error) {
      print('Error Occurred11: $error');
      Fluttertoast.showToast(
        msg: "An error occurred: $error",
        toastLength: Toast.LENGTH_SHORT,
      );
    }
    return null;
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
          'PUT', Uri.parse('${Urls.profile}?id=${Params.userId}'));

      request.headers.addAll({
        'Authorization': 'Bearer ${Params.userToken ?? ''}',
      });

      request.files.add(
        await http.MultipartFile.fromPath(
          'profileImage',
          image.path,
          contentType: MediaType('image', 'jpeg'),
        ),
      );

      var streamedResponse = await request.send();
      var decodedResponse = await http.Response.fromStream(streamedResponse);

      if (decodedResponse.statusCode == 200) {
        fetchCustomerDetails();
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
        Navigator.pushReplacementNamed(context, '/editProfile');
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
        "phoneNumber": countryCodeController.text + userPhonenumber.text,
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

  // Declare this list at the class level
  List<Map<String, dynamic>> documents = [];

  List<DocumentModel> documentsModels = [];

  Future<bool> getAllDocuments(BuildContext context) async {
    debugPrint('Fetching documents for userId: ${Params.userId}');
    try {
      final uri = Uri.parse(Urls.getAllDocuments);
      final request = http.Request('GET', uri)
        ..headers.addAll({
          'Content-Type': 'application/json',
          'Authorization': 'Bearer ${Params.userToken ?? ''}',
        });

      final streamedResponse = await request.send();
      final decodedResponse = await http.Response.fromStream(streamedResponse);

      debugPrint('Response Code: ${decodedResponse.statusCode}');
      debugPrint('Response Bodyaaa: ${decodedResponse.body}');

      if (decodedResponse.statusCode == 200) {
        final List<dynamic> responseJson = jsonDecode(decodedResponse.body);

        if (responseJson.isEmpty) {
          Fluttertoast.showToast(
            msg: "No documents available. Try again later.",
            toastLength: Toast.LENGTH_SHORT,
          );
          return false;
        }

        // Filter documents based on `planOption`
        final filteredDocuments = responseJson.where((item) {
          final planType =
              item['planId']?.toString().replaceFirst('KWIK ', '') ?? '';
          debugPrint('Filtered planType: $planType');

          return planOption.contains(planType);
        }).toList();

        debugPrint('Filtered Documentsds: $filteredDocuments');
        List<dynamic> decodedList = responseJson;
        //  List<dynamic> Item = showFiles;
        List<String> showFiless =
            decodedList.map((doc) => doc['id'].toString()).toList();

        List<dynamic> view = responseJson.where((item) {
          return showFiles.any((doc) => doc['documentMasterId'] == item['id']);
        }).toList();

        final resultData = filteredDocuments.map((items) {
          final documentId = items['id'];
          final matchedVerification = showFiles.firstWhere(
            (item) {
              debugPrint(
                  'Comparing ${item['documentMasterId']} with $documentId');
              return item['documentMasterId'].toString() ==
                  documentId.toString();
            },
            orElse: () => null,
          );

          debugPrint('matchedVerification for $documentId: $showFiles');

          return {
            ...items,
            'matchedVerification': matchedVerification,
            'verificationStatus':
                matchedVerification?['verificationStatus'] ?? 'Manual',
            'status': matchedVerification?['documentFile'] == null,
          };
        }).toList();

        finalData.assignAll(resultData);

        debugPrint('resultData Files List: $finalData');
        final completedCount =
            documents.where((item) => item['status'] == true).length;
        debugPrint('Completed view: $uploadedFiles');
        debugPrint('Uploaded Files List: $documents');

        Fluttertoast.showToast(
          msg: "Documents fetched successfully",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          backgroundColor: Colors.green,
          textColor: Colors.white,
        );

        return true;
      } else {
        debugPrint('Error: ${decodedResponse.body}');
        Fluttertoast.showToast(
          msg: "Error: ${decodedResponse.body}",
          toastLength: Toast.LENGTH_SHORT,
        );
        return false;
      }
    } catch (error) {
      debugPrint('Error Occurred: $error');
      Fluttertoast.showToast(
        msg: "An error occurred: $error",
        toastLength: Toast.LENGTH_SHORT,
      );
      return false;
    }
  }

  Future<dynamic> fetchDataBasedOnAccountId(
      String url, dynamic accountId) async {
    print('url: $url');
    print('accountId: $accountId');

    try {
      final String fullUrl = 'http://3.253.82.115/api/$url$accountId';
      print('Requesting: $fullUrl');

      var request = http.Request('GET', Uri.parse(fullUrl));

      request.headers.addAll({
        'Content-Type': 'application/json',
        'Authorization': 'Bearer ${Params.userToken ?? ''}',
      });

      http.StreamedResponse streamedResponse = await request.send();
      var decodedResponse = await http.Response.fromStream(streamedResponse);

      if (decodedResponse.statusCode == 200) {
        final responseData = json.decode(decodedResponse.body);
        print('Response: $responseData');
        return responseData;
      } else {
        print('Error: ${decodedResponse.statusCode}');
        return null;
      }
    } catch (e) {
      print('Exception occurred: $e');
      return null;
    }
  }

  Future<String?> uploadFile(PlatformFile file, int docId, int dueMonth,
      String planType, bool dataNeeded, String dataType, context) async {
    print("file.path: ${file.path}");
    print("docId: $docId");
    print("Uploading file: ${file.name}");
    print("Plan Type: $planType, Data Type: $dataType");

    try {
      final updatedPlanType = removeKwikPrefix(planType);
      final String url = await getURLbasedPlanType(updatedPlanType);

      // Use actual customerId not stringified userId
      var result = await fetchDataBasedOnAccountId(url, Params.userId);

      if (result == null || result.isEmpty) {
        throw Exception("No data returned for accountId");
      }

      String startDate = result[0]['startDate'];
      String calculatedDate = addMonthsToDate(startDate, dueMonth);
      String isPastDates = isPastDate(calculatedDate) ? 'Delayed' : 'OnTime';

      dio.FormData formData = dio.FormData();

      formData.files.add(MapEntry(
        'documentFile',
        await dio.MultipartFile.fromFile(
          file.path!,
          filename: file.name,
        ),
      ));

      formData.fields
        ..add(MapEntry('documentMasterId', docId.toString()))
        ..add(MapEntry('submissionStatus', isPastDates))
        ..add(MapEntry('dataNeeded', dataNeeded.toString()))
        ..add(MapEntry('dataType', dataType))
        ..add(const MapEntry('verificationStatus', 'Applied'));

      dio.Dio dioInstance = dio.Dio();
      print('--- FormData Fields ---');
      for (var field in formData.fields) {
        print('${field.key}: ${field.value}');
      }

      print('--- FormData Files ---');
      for (var file in formData.files) {
        final f = file.value;
        print(
            '${file.key}: filename=${f.filename}, contentType=${f.contentType}');
      }
      dio.Response response = await dioInstance.put(
        "http://3.253.82.115/api/customer/documentUpload",
        data: formData,
        options: dio.Options(
          headers: {
            'Content-Type': 'multipart/form-data',
            'Authorization': 'Bearer ${Params.userToken ?? ''}',
          },
        ),
      );

      if (response.statusCode == 200) {
        Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => const ProfilePagewidget(startIndex: 8),
            ));
        Fluttertoast.showToast(
          msg: "Documents Upload successfully",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          backgroundColor: Colors.green,
          textColor: Colors.white,
        );
        return response.data['filePath'];
      } else {
        Fluttertoast.showToast(
          msg: "File size exceeds the limit of 3MB.",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
        );
        throw Exception('Failed to upload');
      }
    } catch (e) {
      Fluttertoast.showToast(
        msg: "File size exceeds the limit of 3MB.",
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
      );
      debugPrint("Upload failed: $e");
      return null;
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
        // Fluttertoast.showToast(
        //   msg: "LoginDetails Updated Successfully",
        //   toastLength: Toast.LENGTH_SHORT,
        //   gravity: ToastGravity.BOTTOM,
        //   backgroundColor: Colors.grey,
        //   textColor: Colors.white,
        // );
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
      var request = http.Request('POST', Uri.parse(Urls.kinDetails));
      request.body = json.encode({
        "customerId": Params.userId,
        "id": kinID,
        "name": fullName.text,
        "relationship": relationShip.text,
        "phoneNumber": countryCodeController.text + phoneNumber.text,
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

  void handleFileChange(
      docId, dueMonth, planType, dataNeeded, dataType, context) async {
    if (isUploading) return; // prevent double upload
    isUploading = true;
    FilePickerResult? result = await FilePicker.platform.pickFiles();

    if (result != null && result.files.isNotEmpty) {
      final file = result.files.first;

      final fileSizeInBytes = file.size;
      final fileSizeInMB = fileSizeInBytes / (1024 * 1024);
      print(
          "Doc ID: $file, Plan Type: $fileSizeInBytes, Data Type: $fileSizeInMB");

      if (fileSizeInMB <= 3) {
        uploadFile(
            file, docId, dueMonth, planType, dataNeeded, dataType, context);
      } else {
        Fluttertoast.showToast(
          msg: "File size exceeds the limit of 3MB.",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
        );
      }
    }
  }
}
