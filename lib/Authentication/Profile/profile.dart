import 'dart:io';
import 'package:ag_mortgage/Authentication/FinalPage/final.dart';
import 'package:ag_mortgage/Authentication/Login_Controller/controller.dart';
import 'package:ag_mortgage/const/Image.dart';
import 'package:ag_mortgage/const/colors.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';

class RegistrationScreen extends StatefulWidget {
  const RegistrationScreen({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _RegistrationScreenState createState() => _RegistrationScreenState();
}

class _RegistrationScreenState extends State<RegistrationScreen> {
  ProfileController signupController = Get.find<ProfileController>();
 static String formatDate(DateTime date) {
    return DateFormat('dd-MM-yyyy').format(date);
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
                      backgroundImage: signupController.image != null
                          ? FileImage(signupController.image!)
                          : null,
                      child: signupController.image == null
                          ? IconButton(
                              icon: const Icon(Icons.camera_alt, size: 30),
                              onPressed: signupController.pickImage,
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
                        border: const OutlineInputBorder(),
                        suffixIcon: IconButton(
                          icon: const Icon(Icons.calendar_today),
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
                      onChanged: (value) {
                        signupController.selectedGender = value;
                      },
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
                      style: ElevatedButton.styleFrom(
                        backgroundColor: baseColor,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(30),
                        ),
                        padding: const EdgeInsets.symmetric(vertical: 15,horizontal: 65
                        ),
                      ),
                      onPressed: () {
                        signupController.checkUser(context);
                      },
                      child: const Text('Register',
                          style: TextStyle(fontSize: 16, color: Colors.white)),
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
