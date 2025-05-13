import 'dart:io';
import 'package:ag_mortgage/Profile/profile_All_controller.dart';
import 'package:ag_mortgage/const/colors.dart';
import 'package:flutter/material.dart';
import 'package:file_picker/file_picker.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:dotted_border/dotted_border.dart';

class EmploymentDetails extends StatefulWidget {
  const EmploymentDetails({super.key, this.initialCity});
  final String? initialCity;

  @override
  State<EmploymentDetails> createState() => _EmploymentDetailsState();
}

class _EmploymentDetailsState extends State<EmploymentDetails> {
  final controller = Get.put(Profile_Controller());

  @override
  void initState() {
    super.initState();
    controller.selectedCity = widget.initialCity; // Default value
    controller.fetchCustomerDetails();  
    controller.selectedCity= controller.selectedCity ="Employed";
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
    child: Scaffold(
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
                  value: controller.selectedCity,
                  hint: const Text('Select Employment'),
                  selectedItemBuilder: (context) => [
                    Text('Employed'),
                    Text('Self Employed'),
                  ],
                  items: const [
                    DropdownMenuItem(value: 'Employed', child: Text('Employed')),
                    DropdownMenuItem(
                        value: 'Self Employed', child: Text('Self Employed')),
                  ],
                  onChanged: (value) {
                    setState(() {
                      controller.selectedCity =
                          value ?? 'Employed'; 
                    });
                  },
                  decoration: InputDecoration(
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(100),
                    ),
                  ),
                ),
              const SizedBox(height: 16),
              if (controller.selectedCity == "Employed")
                _buildEmployedForm(context),
              if (controller.selectedCity == "Self Employed")
                _buildSelfEmployedForm(context),
            ],
          ),
        ),
      ),
    ));
  }

  Widget _buildEmployedForm(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildEditableField('Employer', controller.employerController,
              'Input Employer', context),
          _buildEditableField('Job Title', controller.jobTitleController,
              'Input Job Title', context),
          _buildEditableField(
              'Net Salary', controller.netSalaryController, 'NGN', context),
          _buildEditableField('Net Worth (Optional)',
              controller.netWorthController, 'NGN', context),
          // controller.isDocumentUploaded2
          //     ? _buildDocumentViewSection('Business Registration Document',
          //         controller.passportIdPath, context)
          //     : _buildUploadBox(
          //         'Upload Business Registration Document',
          //         onUpload: (filePath) {
          //           setState(() {
          //             controller.passportIdPath = filePath;
          //             controller.isDocumentUploaded2 = true;
          //           });
          //         },
          //       ),
          const SizedBox(height: 16),
          Align(
            alignment: Alignment.center,
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: baseColor, // Transparent background
                elevation: 0, // Remove shadow
                foregroundColor: Colors.white, // Text and icon color
                padding:
                    const EdgeInsets.symmetric(horizontal: 109, vertical: 18),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(30), // Rounded corners
                ),
              ),
              onPressed: () {
                controller.employementDetails(context);
              },
              child: const Text("Save Changes"),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSelfEmployedForm(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildEditableField('Industry', controller.industryController,
            'Input Industry', context),
        _buildEditableField('Profession', controller.professionController,
            'Input Profession', context),
        _buildEditableField('Monthly Income',
            controller.monthlyIncomeController, 'NGN', context),
        _buildEditableField('Net Worth (Optional)',
            controller.selfNetWorthController, 'NGN', context),
        // controller.isDocumentUploaded
        //     ? _buildDocumentViewSection('Business Registration Document',
        //         controller.passportIdPath, context)
        //     : _buildUploadBox(
        //         'Upload Business Registration Document',
        //         onUpload: (filePath) {
        //           setState(() {
        //             controller.passportIdPath = filePath;
        //             controller.isDocumentUploaded = true;
        //           });
        //         },
        //       ),
               Align(
            alignment: Alignment.center,
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: baseColor, // Transparent background
                elevation: 0, // Remove shadow
                foregroundColor: Colors.white, // Text and icon color
                padding:
                    const EdgeInsets.symmetric(horizontal: 109, vertical: 18),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(30), // Rounded corners
                ),
              ),
              onPressed: () {
                controller.employementDetails(context);
              },
              child: const Text("Save Changes"),
            ),
          ),
      ],
    );
  }

  Widget _buildEditableField(String label, TextEditingController controller,
      String hintText, BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: TextField(
        controller: controller,
        decoration: InputDecoration(
          labelText: label,
          hintText: hintText,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
          ),
        ),
      ),
    );
  }
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

Widget _buildDocumentViewSection(
    String label, String? filePath, BuildContext context) {
  return filePath != null
      ? Container(
          decoration: BoxDecoration(color: Colors.orange[300]),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              ElevatedButton.icon(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.transparent, // Transparent background
                  elevation: 0, // Remove shadow
                  foregroundColor: Colors.white,
                ),
                onPressed: () {
                  _showDocumentPopup(filePath, label, context);
                },
                icon: const Icon(Icons.check_circle),
                label: Text(label),
              ),
              TextButton(
                onPressed: () {
                  _showDocumentPopup(filePath, label, context);
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

void _showDocumentPopup(String filePath, String label, context) {
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
