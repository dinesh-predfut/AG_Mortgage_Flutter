import 'dart:io';
import 'package:ag_mortgage/Profile/profile.dart';
import 'package:ag_mortgage/const/colors.dart';
import 'package:flutter/material.dart';
import 'package:file_picker/file_picker.dart';
import 'package:image_picker/image_picker.dart';
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
  bool isDocumentUploaded = false;
  bool isDocumentUploaded2 = false;
  bool isEdited = false;
  String? nationalIdPath;
  String? passportIdPath;
  String? nextOfKinPassportPath;
  File? _image;
  final ImagePicker _picker = ImagePicker();

  Future<void> _pickImage() async {
    final XFile? pickedFile =
        await _picker.pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      setState(() {
        _image = File(pickedFile.path);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Personal Details'),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              // Profile Picture Section
              Center(
                child: Column(
                  children: [
                    CircleAvatar(
                      radius: 60,
                      backgroundImage:
                          _image != null ? FileImage(_image!) : null,
                      child: _image == null
                          ? IconButton(
                              icon: const Icon(Icons.camera_alt, size: 30),
                              onPressed: _pickImage,
                            )
                          : null,
                    ),
                    const SizedBox(height: 8),
                    const Text('Change Profile Picture'),
                  ],
                ),
              ),
              const SizedBox(height: 16),
              // Form Section
              isEdited ? _buildUploadedForm() : _buildInitialForm(),
              const SizedBox(height: 16),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
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
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) =>
                            const ProfilePagewidget(startIndex: 3),
                      ));
                  setState(() {
                    isEdited = true;
                  });
                },
                child: const Text('Save Changes'),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildUploadedForm() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildEditableField('Date of Birth', value: '14/06/1980'),
        _buildEditableField('Sex', value: 'Male'),
        _buildEditableField('NIN', value: '41382913428'),
        _buildDocumentViewSection('National ID', nationalIdPath),
        const SizedBox(height: 16),
        const Text('Next of Kin Details',
            style: TextStyle(fontWeight: FontWeight.bold)),
        _buildEditableField('Full Name', value: 'Adeyemi Feranmi'),
        _buildEditableField('Relationship', value: 'Brother'),
        _buildEditableField('Phone Number', value: '09145912290'),
        _buildEditableField('Email (Optional)', value: 'Aferanmi123@gmail.com'),
        _buildEditableField('Address',
            value: 'NO 3, Coker Estate, Lagos, Lagos State'),
        _buildDocumentViewSection('Possport ID', passportIdPath),
      ],
    );
  }

  Widget _buildEditableField(String label, {required String value}) {
    return Padding(
        padding: const EdgeInsets.symmetric(vertical: 8.0),
        child: TextField(
          controller: TextEditingController(text: value),
          decoration: InputDecoration(
            labelText: label,
            suffixIcon: const Icon(Icons.edit),
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
        _buildTextField('Date of Birth', hintText: 'DD/MM/YYYY'),
        _buildDropdown('Sex'),
        _buildTextField('NIN'),
        isDocumentUploaded
            ? _buildDocumentViewSection('National ID', nationalIdPath)
            : _buildUploadBox(
                'Upload Picture of your National ID',
                onUpload: (filePath) {
                  setState(() {
                    nationalIdPath = filePath;
                    isDocumentUploaded = true;
                  });
                },
              ),
        const SizedBox(height: 16),
        const Text('Next of Kin Details',
            style: TextStyle(fontWeight: FontWeight.bold)),
        _buildTextField('Full Name'),
        _buildTextField('Relationship'),
        _buildTextField('Phone Number'),
        _buildTextField('Email (Optional)'),
        _buildTextField('Address'),
        isDocumentUploaded2
            ? _buildDocumentViewSection('Passport ID', passportIdPath)
            : _buildUploadBox(
                'Upload Picture of your National ID',
                onUpload: (filePath) {
                  setState(() {
                    passportIdPath = filePath;
                    isDocumentUploaded2 = true;
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
          DropdownMenuItem(child: Text('Male'), value: 'Male'),
          DropdownMenuItem(child: Text('Female'), value: 'Female'),
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
                            ? isDocumentUploaded = false
                            : isDocumentUploaded2 = false;
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
