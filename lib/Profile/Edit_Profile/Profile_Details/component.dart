// ignore_for_file: unnecessary_cast

import 'dart:io';
import 'package:ag_mortgage/Profile/profile.dart';
import 'package:ag_mortgage/Profile/profile_All_controller.dart';
import 'package:ag_mortgage/const/colors.dart';
import 'package:flutter/material.dart';
import 'package:file_picker/file_picker.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:flutter_image_compress/flutter_image_compress.dart';
import 'package:intl/intl.dart';
import 'package:open_filex/open_filex.dart';
import 'package:dotted_border/dotted_border.dart';

void _openFile(String filePath) {
  OpenFilex.open(filePath);
}

class PersonalDetailsPage extends StatefulWidget {
  const PersonalDetailsPage({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _PersonalDetailsPageState createState() => _PersonalDetailsPageState();
}

class _PersonalDetailsPageState extends State<PersonalDetailsPage> {
  final controller = Get.put(Profile_Controller());
  final _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    controller.fetchCustomerDetails();
  }

  Future<void> _pickImage() async {
    final XFile? pickedFile =
        await controller.picker.pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      setState(() {
        controller.image = File(pickedFile.path);
      });
    }
    File? compressedImage = await controller.compressImage(controller.image!);
    if (compressedImage != null) {
      // Upload the compressed image
      controller.uploadImage(compressedImage);
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
    return WillPopScope(
        onWillPop: () async {
          // Handle custom back navigation logic
          _onBackPressed(context);
          return false; // Prevent default back behavior
        },
        child: Scaffold(
          appBar: AppBar(
            title: const Text('Personal Details'),
            centerTitle: true,
          ),
          body: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                children: [
                  // Profile e Section
                  Center(
                    child: Column(children: [
                      Stack(
                        alignment: Alignment
                            .bottomRight, // Align the camera icon at the bottom-right
                        children: [
                          CircleAvatar(
                            radius: 60,
                            backgroundImage: controller.image != null
                                ? FileImage(controller.image!) as ImageProvider<
                                    Object> // Show local file if available
                                : NetworkImage(controller.showImage!)
                                    as ImageProvider,
                            child: (controller.image == null &&
                                    (controller.showImage == null ||
                                        controller.showImage!.isEmpty))
                                ? const Icon(Icons.person,
                                    size: 60, color: Colors.grey)
                                : null,
                          ),
                          IconButton(
                            icon: const Icon(Icons.camera_alt, size: 30),
                            onPressed: _pickImage,
                            color: Colors.blue,
                          ),
                        ],
                      ),
                      const SizedBox(height: 8),
                      const Text('Change Profile Picture'),
                    ]),
                  ),

                  const SizedBox(height: 16),
                  // Form Section
                  // controller.isEdited ? _buildUploadedForm() : _buildInitialForm(),
                  _buildUploadedForm(),
                  const SizedBox(height: 16),
                ],
              ),
            ),
          ),
        ));
  }

  Widget _buildUploadedForm() {
    return Form(
        key: _formKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TextFormField(
              controller: TextEditingController(
                text: controller.dob != null
                    ? DateFormat('yyyy-MM-dd').format(controller.dob!)
                    : '',
              ), // Display selected date
              readOnly: true, // Prevent manual text editing
              decoration: InputDecoration(
                labelText: 'Date of Birth',
                suffixIcon: const Icon(Icons.calendar_today), // Calendar icon
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(30),
                ),
              ),
              onTap: () async {
                DateTime? pickedDate = await showDatePicker(
                  context: context,
                  initialDate: controller.dob ?? DateTime.now(),
                  firstDate: DateTime(1900),
                  lastDate: DateTime.now(),
                );

                if (pickedDate != null) {
                  setState(() {
                    controller.dob = pickedDate;
                  });
                }
              },
            ),
            _buildEditableField('Sex', value: controller.gender),
            _buildEditableField(
              "NIN",
              value: controller.nin,
              validator: (val) {
                if (val == null || val.isEmpty) {
                  return 'This field cannot be empty';
                }
                if (val.length <= 11) {
                  return 'Value must be more than 11 characters';
                }
                return null;
              },
            ),
            // _buildEditableField('NINs', value: controller.nin),
            controller.isDocumentUploadedPd
                ? _buildDocumentViewSection(
                    'National ID', controller.nationalIdPath)
                : _buildUploadBox(
                    'Upload Picture of your National ID',
                    onUpload: (filePath) {
                      setState(() {
                        controller.nationalIdPath = filePath;
                        controller.isDocumentUploadedPd = true;
                      });
                    },
                  ),
            const SizedBox(height: 16),
            const Text('Next of Kin Details',
                style: TextStyle(fontWeight: FontWeight.bold)),
            _buildEditableField('Full Name', value: controller.fullName),
            _buildEditableField('Relationship', value: controller.relationShip),
            _buildEditableField('Phone Number', value: controller.phoneNumber),
            _buildEditableField('Email (Optional)', value: controller.email),
            _buildEditableField('Address', value: controller.address),
            controller.isDocumentUploadedPd
                ? _buildDocumentViewSection(
                    'Passport ID', controller.nationalIdPath)
                : _buildUploadBox(
                    'Upload Picture of your Passport ID',
                    onUpload: (filePath) {
                      setState(() {
                        controller.passportIdPath = filePath;
                        controller.isDocumentUploadedPd = true;
                      });
                    },
                  ),
            const SizedBox(height: 16),
            SizedBox(
                    width: double.infinity,
                    child:ElevatedButton(
              style: ElevatedButton.styleFrom(
                alignment: Alignment.center,
                backgroundColor: baseColor, // Transparent background
                elevation: 0, // Remove shadow
                foregroundColor:
                    Colors.white, // Text and icon color// Text and icon color
                padding:
                    const EdgeInsets.symmetric(horizontal: 109, vertical: 18),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(30), // Rounded corners
                ),
              ),
              onPressed: () {
                if (_formKey.currentState!.validate()) {
                  controller.kinDetails(context);
                  Navigator.pushReplacementNamed(context, '/editProfile');

                  setState(() {
                    controller.isEdited = true;
                  });
                }
                else {
                          Fluttertoast.showToast(
                            msg: "Please fill in all mandatory fields",
                            toastLength: Toast.LENGTH_SHORT,
                            gravity: ToastGravity.BOTTOM,
                            backgroundColor: Colors.red,
                            textColor: Colors.white,
                          );
                        }
              },
              child: const Text('Save Changes'),
            ),
        )],
          
        ));
  }

  Widget _buildEditableField(String label,
      {required value, String? Function(String?)? validator}) {
    return Padding(
        padding: const EdgeInsets.symmetric(vertical: 8.0),
        child: TextFormField(
          controller: value,
          validator: validator,
          decoration: InputDecoration(
            labelText: label,
            // suffixIcon: const Icon(Icons.edit),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(100),
            ),
          ),
        ));
  }

  Widget _buildInitialForm() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        TextFormField(
          controller: TextEditingController(
            text: controller.dob != null
                ? DateFormat('dd-MM-yyyy').format(controller.dob!)
                : '',
          ), // Display selected date
          readOnly: true, // Prevent manual text editing
          decoration: InputDecoration(
            labelText: 'Date of Birth',
            suffixIcon: Icon(Icons.calendar_today), // Calendar icon
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(30),
            ),
          ),
          onTap: () async {
            DateTime? pickedDate = await showDatePicker(
              context: context,
              initialDate: controller.dob ?? DateTime.now(),
              firstDate: DateTime(1900),
              lastDate: DateTime.now(),
            );

            if (pickedDate != null) {
              setState(() {
                controller.dob = pickedDate;
              });
            }
          },
        ),
        const SizedBox(height: 10),
        _buildDropdown('Sex'),
        _buildTextField('NIN'),
        controller.isDocumentUploadedPd
            ? _buildDocumentViewSection(
                'National ID', controller.nationalIdPath)
            : _buildUploadBox(
                'Upload Picture of your National ID',
                onUpload: (filePath) {
                  setState(() {
                    controller.nationalIdPath = filePath;
                    controller.isDocumentUploadedPd = true;
                  });
                },
              ),
        const SizedBox(height: 16),
        const Text('Next of Kin Details',
            style: TextStyle(fontWeight: FontWeight.bold)),
        _buildEditableField('Full Name', value: controller.fullName),
        _buildEditableField('Relationship', value: controller.relationShip),
        _buildEditableField('Phone Number', value: controller.phoneNumber),
        _buildEditableField('Email (Optional)', value: controller.email),
        _buildEditableField('Address', value: controller.address),
        controller.isDocumentUploadedPD2
            ? _buildDocumentViewSection(
                'Passport ID', controller.passportIdPathPd)
            : _buildUploadBox(
                'Upload Picture of your National ID',
                onUpload: (filePath) {
                  setState(() {
                    controller.passportIdPathPd = filePath;
                    controller.isDocumentUploadedPD2 = true;
                  });
                },
              ),
      ],
    );
  }

  Widget _buildTextField(String label, {String? hintText}) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 14.0),
      child: TextField(
        decoration: InputDecoration(
          labelText: label,
          hintText: hintText,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(100),
          ),
        ),
      ),
    );
  }

  Widget _buildDropdown(String label) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: DropdownButtonFormField<String>(
        decoration: InputDecoration(
          labelText: label,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(100),
          ),
        ),
        items: const [
          DropdownMenuItem(value: 'Male', child: Text('Male')),
          DropdownMenuItem(value: 'Female', child: Text('Female')),
        ],
        onChanged: (value) {},
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
                    foregroundColor: Colors
                        .white, // Text and icon color// Text and icon color
                    padding:
                        const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8), // Rounded corners
                    ),
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
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Icon(
                    Icons.delete_forever_outlined,
                    color: Colors.red,
                  ),
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor:
                          Colors.orange[200], // Transparent background
                      elevation: 0, // Remove shadow
                      foregroundColor: Colors
                          .white, // Text and icon color// Text and icon color
                      padding: const EdgeInsets.symmetric(
                          horizontal: 10, vertical: 6),
                      shape: RoundedRectangleBorder(
                        borderRadius:
                            BorderRadius.circular(30), // Rounded corners
                      ),
                    ),
                    onPressed: () {
                      Navigator.of(context).pop();
                      setState(() {
                        label == "National ID"
                            ? controller.isDocumentUploadedPd = false
                            : controller.isDocumentUploadedPD2 = false;
                      });
                    },
                    child: const Text('Re-Attach'),
                  ),
                ],
              ),
              Image.file(File(filePath), fit: BoxFit.contain),
              const SizedBox(height: 16),
            ],
          ),
        );
      },
    );
  }
}
