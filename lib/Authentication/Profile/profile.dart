import 'dart:io';
import 'package:ag_mortgage/Authentication/FinalPage/final.dart';
import 'package:ag_mortgage/Authentication/Login_Controller/controller.dart';
import 'package:ag_mortgage/const/Image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:image_picker/image_picker.dart';



class RegistrationScreen extends StatefulWidget {
  const RegistrationScreen({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _RegistrationScreenState createState() => _RegistrationScreenState();
}

class _RegistrationScreenState extends State<RegistrationScreen> {
  File? _image;
  final ImagePicker _picker = ImagePicker();
  ProfileController signupController = Get.find<ProfileController>();

  Future<void> _pickImage() async {
    final XFile? pickedFile =
        await _picker.pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      setState(() {
        _image = File(pickedFile.path);
      });
    }
  }

  Future<void> _submitData() async {
    if (_image == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please select a picture')),
      );
      return;
    } else {
      signupController.checkUser(context);
    }

    // Mock API call to demonstrate backend sending
    print("Send image to backend: ${_image?.path}");
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Image uploaded successfully!')),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          // Background image
          Positioned.fill(
            child: Image.asset(
              Images.house1, // Replace with your image path
              fit: BoxFit.cover,
            ),
          ),
          // Registration form
          Align(
            alignment: Alignment.bottomCenter,
            child: Container(
              decoration: const BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.vertical(
                  top: Radius.circular(30),
                ),
              ),
              padding: const EdgeInsets.all(16.0),
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
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
                    const SizedBox(height: 20),
                    TextField(
                      controller: signupController.dobController,
                      readOnly: true, // Prevent manual input
                      decoration: InputDecoration(
                        labelText: 'Date of Birth',
                        hintText: 'DD/MM/YYYY',
                        border: OutlineInputBorder(),
                        suffixIcon: IconButton(
                          icon: Icon(Icons.calendar_today),
                          onPressed: () => signupController.selectDate(context),
                        ),
                      ),
                      onTap: () => signupController
                          .selectDate(context), // Open date picker on tap
                    ),
                    const SizedBox(height: 20),
                    DropdownButtonFormField<String>(
                      value: signupController.selectedGender,
                      items: ['Male', 'Female']
                          .map((gender) => DropdownMenuItem<String>(
                                value: gender,
                                child: Text(gender),
                              ))
                          .toList(),
                      onChanged: (value) {},
                      decoration: const InputDecoration(
                        labelText: 'Sex',
                        border: OutlineInputBorder(),
                      ),
                    ),
                    const SizedBox(height: 20),
                    TextField(
                      controller: signupController.nin,
                      decoration: const InputDecoration(
                        labelText: 'NIN',
                        hintText: 'Input NIN',
                        border: OutlineInputBorder(),
                      ),
                    ),
                    const SizedBox(height: 30),
                    ElevatedButton(
                      onPressed: () {
                        signupController.checkUser(context);
                      },
                      child: const Text('Register'),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
