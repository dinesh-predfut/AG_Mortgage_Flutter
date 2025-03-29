import 'dart:convert';
import 'dart:io';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:flutter_image_compress/flutter_image_compress.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:image_picker/image_picker.dart';
import 'package:percent_indicator/percent_indicator.dart';

import '../../profile_All_controller.dart';

class DocumentsPage extends StatefulWidget {
  @override
  _DocumentsPageState createState() => _DocumentsPageState();
}

class _DocumentsPageState extends State<DocumentsPage> {
  final controller = Get.put(Profile_Controller());

  void initState() {
    super.initState();
    controller.getAllDocuments(context);
    print("List${controller.uploadedFiles}");
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
          height: 80,
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
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildDocumentViewSection(String label, String? filePath) {
    return filePath != null
        ? Container(
            decoration: BoxDecoration(color: Colors.orange[300]),
            padding: const EdgeInsets.all(8.0),
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
            ),
          )
        : const SizedBox.shrink();
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
            title: const Text("Documents"),
            centerTitle: true,
            leading: IconButton(
              icon: const Icon(Icons.arrow_back),
              onPressed: () => Navigator.pop(context),
            ),
          ),
          body: SingleChildScrollView(
            child: Column(
              children: [
                // Fixed Percentage Circle
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: CircularPercentIndicator(
                    radius: 100.0,
                    animation: true,
                    lineWidth: 10.0,
                    percent: controller.showFiles.isNotEmpty
                        ? controller.showFiles
                                .where((file) => file.isNotEmpty)
                                .length /
                            controller.showFiles.length
                        : 0.0, // Avoid division by zero
                    center: Text(
                      "${controller.showFiles.where((file) => file.isNotEmpty).length}/${controller.showFiles.length}",
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    progressColor: Colors.green,
                    backgroundColor: Colors.grey[300]!,
                    circularStrokeCap: CircularStrokeCap.round,
                  ),
                ),
                // Document Upload and View Sections
                ListView.builder(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: controller.uploadedFiles.keys.length,
                  itemBuilder: (context, index) {
                    String documentType =
                        controller.uploadedFiles.keys.elementAt(index);
                    String? filePath = controller.uploadedFiles[documentType];
                    print("Document Type: $index, File Path: $filePath");
                    try {
                      Map<String, dynamic> fileData =
                          jsonDecode(filePath!); // Decode JSON
                      controller.fileId = fileData['id'];
                      controller.documentFileUrl = fileData['documentFile'];
                      print(
                          "Document Type: ${controller.fileId}, File ID: ${controller.documentFileUrl}");
                    } catch (e) {
                      print("Error decoding JSON: $e");
                    }
                    // List<String> documentFileUrls = controller.showFiles
                    //     .map((file) => file.documentFile)
                    //     .toList();
                    // int fileId = fileData['id'];
                    return Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: controller.showFiles
                                .contains(controller.fileId.toString())
                            ? _buildUploadBox(
                                "Upload $documentType",
                                onUpload: (path) {
                                  controller.pickAndUploadFile(
                                      documentType, 13);
                                  setState(() {
                                    controller.uploadedFiles[documentType] =
                                        path;
                                  });
                                },
                              )
                            : _buildDocumentViewSection(
                                documentType, controller.documentFileUrl));
                  },
                ),
              ],
            ),
          ),
        ));
  }
}
