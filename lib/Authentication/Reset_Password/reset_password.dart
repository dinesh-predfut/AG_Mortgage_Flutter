import 'package:ag_mortgage/Authentication/Login_Controller/controller.dart';
import 'package:ag_mortgage/Authentication/OTP/authentication.dart';
import 'package:ag_mortgage/Authentication/OTP_Reset/otp_reset.dart';
import 'package:ag_mortgage/const/colors.dart';
import 'package:flutter/material.dart';
import 'package:ag_mortgage/const/Image.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart'; 

class Rest_Password extends StatefulWidget {

   Rest_Password({super.key});

  @override
  State<Rest_Password> createState() => _Rest_PasswordState();
}

class _Rest_PasswordState extends State<Rest_Password> {
        ProfileController signupController = Get.find<ProfileController>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          // Background image
          Positioned.fill(
            child: Image.asset(
              Images
                  .house1, // Replace with your background image from `Images` class.
              fit: BoxFit.cover,
            ),
          ),
          // Register Form
          Align(
            alignment: Alignment.bottomCenter,
            child: Container(
              decoration: const BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.vertical(
                  top: Radius.circular(30),
                ),
              ),
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 30),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                   Text(
                    "Forgot Password",
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      color: baseColor,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 10),
                  const Text(
                    "Enter registered Phone Number to recover your password",
                    style: TextStyle(
                      fontSize: 14,
                      color: Colors.grey,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 30),
                  // Phone Number Field
                  TextField(
                    controller: signupController.forgetPassword,
                      keyboardType: TextInputType.number,
                    decoration: InputDecoration(
                      labelText: "Phone Number",
                      
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                        borderSide:BorderSide(color: baseColor),
                      ),
                    ),
                  ),
                 
                 
                  const SizedBox(height: 30),
                  // Register Button
                  ElevatedButton(
                    
                    onPressed: () { 
                      signupController.forgetPasswords(context);
                      // Navigator.push(
                      //     context,
                      //     MaterialPageRoute(
                      //       builder: (context) => const OTPAuthentication(),
                      //     ));
                    },
                    
                    style: ElevatedButton.styleFrom(
                      backgroundColor: baseColor,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30),
                      ),
                      padding: const EdgeInsets.symmetric(vertical: 15),
                    ),
                    child: const Text(
                      "Recover",
                      style: TextStyle(fontSize: 16, color: Colors.white),
                    ),
                  ),
                 
                 
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
