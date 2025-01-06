import 'dart:io';
import 'package:ag_mortgage/const/colors.dart';
import 'package:flutter/material.dart';
import 'package:file_picker/file_picker.dart';
import 'package:image_picker/image_picker.dart';
import 'package:dotted_border/dotted_border.dart';

// ignore: camel_case_types
class Home_Address extends StatefulWidget {
  const Home_Address({super.key, this.initialCity});
  final String? initialCity;

  @override
  State<Home_Address> createState() => _Home_AddressState();
}

class _Home_AddressState extends State<Home_Address> {
  String? _selectedCity;
  String? _selectedState;
  String? _localgovernment;
  bool isDocumentUploaded = false;
  bool isDocumentUploaded2 = false;
  String? nationalIdPath;
  String? passportIdPath;

  @override
  void initState() {
    super.initState();
    _selectedCity = widget.initialCity; // Default value
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Employment Details"),
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
                value: _selectedState,
                hint: const Text('Select State'),
                items: const [
                  DropdownMenuItem(value: 'state-1', child: Text('State-1')),
                  DropdownMenuItem(value: 'state-2', child: Text('State-2')),
                ],
                onChanged: (value) {
                  setState(() {
                    _selectedCity = value;
                  });
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
                value: _selectedCity,
                hint: const Text('Select Employment'),
                items: const [
                  DropdownMenuItem(value: 'city-1', child: Text('City-1')),
                  DropdownMenuItem(value: 'city-2', child: Text('City-2')),
                ],
                onChanged: (value) {
                  setState(() {
                    _selectedCity = value;
                  });
                },
                decoration: InputDecoration(
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(100),
                  ),
                ),
              ),
              const SizedBox(height: 16),
              const Text('Local Government'),
              DropdownButtonFormField<String>(
                value: _localgovernment,
                hint: const Text('Select Employment'),
                items: const [
                  DropdownMenuItem(value: '0-1', child: Text('Option-1')),
                  DropdownMenuItem(value: '0-2', child: Text('Option-2')),
                ],
                onChanged: (value) {
                  setState(() {
                    _selectedCity = value;
                  });
                },
                decoration: InputDecoration(
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(100),
                  ),
                ),
              ),
              const SizedBox(height: 16),
              const Text('Local Government'),
              // Phone Number Field
              TextField(
                decoration: InputDecoration(
                  hintText: "Input Street",
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(100),
                    borderSide: const BorderSide(color: Colors.deepPurple),
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
                    //  setState(() {
                    //           isEditingPassword = false; // Enable editing mode
                    //           isEditingUsername = false;
                    //         });
                  },
                  child: const Text("Save Changes"),
                ),
              ),
            ],
          ),
        ),
      ),
    );
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
