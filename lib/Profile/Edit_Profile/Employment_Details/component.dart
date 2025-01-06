import 'dart:io';
import 'package:flutter/material.dart';
import 'package:file_picker/file_picker.dart';
import 'package:image_picker/image_picker.dart';
import 'package:dotted_border/dotted_border.dart';

class EmploymentDetails extends StatefulWidget {
  const EmploymentDetails({super.key, this.initialCity});
  final String? initialCity;

  @override
  State<EmploymentDetails> createState() => _EmploymentDetailsState();
}

class _EmploymentDetailsState extends State<EmploymentDetails> {
  String? _selectedCity;
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
          padding: const EdgeInsets.all(6.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text('Employment Type'),
              DropdownButtonFormField<String>(
                value: _selectedCity,
                hint: const Text('Select Employment'),
                items: const [
                  DropdownMenuItem(value: 'employed', child: Text('Employed')),
                  DropdownMenuItem(
                      value: 'self_employed', child: Text('Self Employed')),
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
              if (_selectedCity == "employed") _buildEmployedForm(),
              if (_selectedCity == "self_employed") _buildSelfEmployedForm(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildEmployedForm() {
    return SingleChildScrollView(
        child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildEditableField('Employer', value: '', hintText: 'Input Employer'),
        _buildEditableField('Job Title',
            value: '', hintText: 'Input Job Title'),
        _buildEditableField('Net Salary', value: '', hintText: 'NGN'),
        _buildEditableField('Net Worth(Option)', value: '', hintText: 'NGN'),
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
      ],
    ));
  }

  Widget _buildSelfEmployedForm() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
       _buildEditableField('Industry', value: '', hintText: 'Input Industry'),
        _buildEditableField('Profession',
            value: '', hintText: 'Input Profession'),
        _buildEditableField('Monthly Income', value: '', hintText: 'NGN'),
        _buildEditableField('Net Worth(Option)', value: '', hintText: 'NGN'),
        isDocumentUploaded
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
      ],
    );
  }

  Widget _buildEditableField(String label,
      {required String value, required String hintText}) {
    return SingleChildScrollView(
        child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 8.0),
            child: TextField(
              controller: TextEditingController(text: value),
              decoration: InputDecoration(
                labelText: label,
                hintText: hintText,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(100),
                ),
              ),
            )));
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
