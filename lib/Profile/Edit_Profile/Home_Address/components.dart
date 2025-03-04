import 'dart:convert';
import 'dart:io';
import 'package:ag_mortgage/Profile/profile_All_controller.dart';
import 'package:ag_mortgage/const/colors.dart';
import 'package:ag_mortgage/const/constant.dart';
import 'package:flutter/material.dart';
import 'package:file_picker/file_picker.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:image_picker/image_picker.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:http/http.dart' as http;

import '../../../const/url.dart';

// ignore: camel_case_types
class Home_Address extends StatefulWidget {
  const Home_Address({super.key, this.initialCity});
  final String? initialCity;

  @override
  State<Home_Address> createState() => _Home_AddressState();
}

class _Home_AddressState extends State<Home_Address> {
  final controller = Get.put(Profile_Controller());
  bool isDocumentUploaded = false;
  bool isDocumentUploaded2 = false;
  String? nationalIdPath;
  String? passportIdPath;
  List<DropdownMenuItem<String>> _states = [];
  List<DropdownMenuItem<String>> _city = [];
  List<DropdownMenuItem<String>> _area = [];

  @override
  void initState() {
    super.initState();
    // controller.selectedCityHome = widget.initialCity; // Default value
    fetchStates();

    fetchCity(controller.selectedState);

    fetcharea(controller.selectedCityHome);

    print("&&&&&${controller.selectedCity}");
  }

  Future<void> fetchStates() async {
    try {
      var url = Uri.parse('${Urls.stateList}?countryId=1');
      var headers = {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer ${Params.userToken ?? ''}',
      };

      var response = await http.get(url, headers: headers);
      if (response.statusCode == 200) {
        List<dynamic> data = json.decode(response.body);

        setState(() {
          _states = data.map((state) {
            return DropdownMenuItem(
              value: state['id'].toString(), // Use state ID as value
              child: Text(state['name']), // Use state name as display text
            );
          }).toList();
        });
      } else {
        throw Exception('Failed to load states');
      }
    } catch (error) {
      print('Error fetching states: $error');
    }
  }

  Future<void> fetchCity(String? value) async {
    try {
      var url = Uri.parse('${Urls.cityList}?stateId=$value');
      var headers = {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer ${Params.userToken ?? ''}',
      };

      var response = await http.get(url, headers: headers);
      if (response.statusCode == 200) {
        List<dynamic> data = json.decode(response.body);

        setState(() {
          _city = data.map((state) {
            return DropdownMenuItem(
              value: state['id'].toString(), // Use state ID as value
              child: Text(state['name']), // Use state name as display text
            );
          }).toList();
        });
      } else {
        throw Exception('Failed to load states');
      }
    } catch (error) {
      print('Error fetching states: $error');
    }
  }

  Future<void> fetcharea(String? value) async {
    try {
      var url = Uri.parse('${Urls.areaList}?cityId=$value');
      var headers = {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer ${Params.userToken ?? ''}',
      };

      var response = await http.get(url, headers: headers);
      if (response.statusCode == 200) {
        List<dynamic> data = json.decode(response.body);

        setState(() {
          _area = data.map((state) {
            return DropdownMenuItem(
              value: state['id'].toString(), // Use state ID as value
              child: Text(state['name']), // Use state name as display text
            );
          }).toList();
        });
      } else {
        throw Exception('Failed to load states');
      }
    } catch (error) {
      print('Error fetching states: $error');
    }
  }

  Future<bool> homeAddres(BuildContext context) async {
    print('userId: ${Params.userId}');
    try {
      var request = http.Request('PUT', Uri.parse(Urls.homeAddress));
      request.body = json.encode({
        "id": Params.userId,
        "city": controller.selectedCityHome,
        "area": controller.selectedarea,
        "state": controller.selectedState,
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
 void _onBackPressed(BuildContext context) {
    // Custom logic for back navigation
    if (Navigator.of(context).canPop()) {
      print("its working");
         Navigator.pushNamed(context, "/editProfile");
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
  @override
  Widget build(BuildContext context) {
    return 
    WillPopScope(
      onWillPop: () async {
        // Handle custom back navigation logic
        _onBackPressed(context);
        return false; // Prevent default back behavior
      },
    child:  Scaffold(
      appBar: AppBar(
        title: const Text("Home Address Details"),
        centerTitle: true,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 16),
              const Text('State'),
              DropdownButtonFormField<String>(
                value: controller.selectedState,
                hint: const Text('Select State'),
                items: _states, // Use API-fetched values
                onChanged: (value) {
                  setState(() {
                    controller.selectedState = value;
                  });
                  fetchCity(value);
                },
                decoration: InputDecoration(
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(100),
                  ),
                ),
              ),
              const SizedBox(
                height: 16,
              ),
              const Text('City'),
              DropdownButtonFormField<String>(
                value: controller.selectedCityHome,
                hint: const Text('Select State'),
                items: _city, // Use API-fetched values
                onChanged: (value) {
                  setState(() {
                    controller.selectedCityHome = value;
                  });
                  fetcharea(value);
                },
                decoration: InputDecoration(
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(100),
                  ),
                ),
              ),
              const SizedBox(
                height: 16,
              ),
              const SizedBox(height: 16),
              const Text('Local Government'),
              DropdownButtonFormField<String>(
                value: controller.selectedarea,
                hint: const Text('Select State'),
                items: _area, // Use API-fetched values
                onChanged: (value) {
                  setState(() {
                    controller.selectedarea = value;
                  });
                  fetcharea(value);
                },
                decoration: InputDecoration(
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(100),
                  ),
                ),
              ),
              const SizedBox(height: 16),
              isDocumentUploaded2
                  ? _buildDocumentViewSection(
                      'Business Registration Document', passportIdPath)
                  : _buildUploadBox(
                      'Upload Business Registration Document',
                      onUpload: (filePath) {
                        setState(() {
                          passportIdPath = filePath;
                          isDocumentUploaded2 = true;
                        });
                      },
                    ),
              const SizedBox(height: 16),
              Align(
                alignment: Alignment.center,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: baseColor, // Transparent background
                    elevation: 0, // Remove shadow
                    foregroundColor: Colors.white, // Text and icon color
                    padding: const EdgeInsets.symmetric(
                        horizontal: 109, vertical: 18),
                    shape: RoundedRectangleBorder(
                      borderRadius:
                          BorderRadius.circular(30), // Rounded corners
                    ),
                  ),
                  onPressed: () {
                    homeAddres(context);
                  },
                  child: const Text("Save Changes"),
                ),
              ),
            ],
          ),
        ),
      ),
    ));
  }

  Widget _buildUploadBox(String text, {required Function(String) onUpload}) {
    return GestureDetector(
        onTap: () async {
          FilePickerResult? result = await FilePicker.platform.pickFiles();

          if (result != null) {
            String filePath = result.files.single.path!;
            onUpload(filePath);
          }
        },
        child: DottedBorder(
          color: Colors.orange, // Border color
          strokeWidth: 1, // Thickness of the dotted line
          dashPattern: [4, 4], // Length and spacing of dashes
          child: Container(
              height: 100,
              width: double.infinity,
              color: Colors.orange[100],
              child: Center(
                  child: Column(
                children: [
                  const SizedBox(height: 18),
                  const Center(
                    child: Icon(
                      Icons.cloud_download,
                      color: Colors.orange,
                    ),
                  ),
                  Center(
                    child: Text(
                      text,
                      textAlign: TextAlign.center,
                    ),
                  ),
                ],
              ))),
        ));
  }

  Widget _buildDocumentViewSection(String label, String? filePath) {
    return filePath != null
        ? Container(
            decoration: BoxDecoration(color: Colors.orange[300]),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                ElevatedButton.icon(
                  style: ElevatedButton.styleFrom(
                    backgroundColor:
                        Colors.transparent, // Transparent background
                    elevation: 0, // Remove shadow
                    foregroundColor: Colors.white,
                  ),
                  onPressed: () {
                    _showDocumentPopup(filePath, label);
                  },
                  icon: const Icon(Icons.check_circle),
                  label: Text(label),
                ),
                TextButton(
                  onPressed: () {
                    _showDocumentPopup(filePath, label);
                  },
                  child: const Text(
                    'View',
                    style: TextStyle(color: Colors.white),
                  ),
                ),
              ],
            ))
        : Container();
  }

  void _showDocumentPopup(String filePath, String label) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(label),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(); // Close the dialog
              },
              child: const Text('Close'),
            ),
          ],
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Image.file(File(filePath), fit: BoxFit.contain),
            ],
          ),
        );
      },
    );
  }
}
