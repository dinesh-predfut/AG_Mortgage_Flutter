import 'package:ag_mortgage/Authentication/Login_Controller/controller.dart';
import 'package:ag_mortgage/Authentication/OTP/authentication.dart';
import 'package:ag_mortgage/Authentication/Reset_Password/reset_password.dart';
import 'package:ag_mortgage/Dashboard_Screen/Mortgage/MortgagePage.dart';
import 'package:ag_mortgage/Dashboard_Screen/dashboard_Screen.dart';
import 'package:ag_mortgage/main.dart';
import 'package:flutter/material.dart';
import 'package:ag_mortgage/const/Image.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart'; // Update this with the correct path to your image.dart file.
import 'package:intl_phone_field/intl_phone_field.dart';
import 'package:flutter_libphonenumber/flutter_libphonenumber.dart';

import '../../const/colors.dart';

class Login extends StatefulWidget {
  const Login({super.key});

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  ProfileController signupController = Get.find<ProfileController>();
  bool _obscureText = true;
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
        onWillPop: () async {
          // Handle custom back navigation logic
          signupController.onBackPressed(context);
          return false; // Prevent default back behavior
        },
        child: Scaffold(
            body: Form(
          key: _formKey,
          child: Stack(
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
                  padding:
                      const EdgeInsets.symmetric(horizontal: 20, vertical: 30),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      Text(
                        "Login",
                        style: TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                          color: baseColor,
                        ),
                        textAlign: TextAlign.center,
                      ),
                      const SizedBox(height: 10),
                      const Text(
                        "Welcome Back! Login with your details",
                        style: TextStyle(
                          fontSize: 14,
                          color: Colors.grey,
                        ),
                        textAlign: TextAlign.center,
                      ),
                      const SizedBox(height: 30),
                      // Phone Number Field
                      IntlPhoneField(
                        controller: signupController.numberController,
                        keyboardType: TextInputType.phone,
                        decoration: InputDecoration(
                          labelText: "Phone Number",
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                            borderSide: BorderSide(color: baseColor),
                          ),
                          counterText: "",
                        ),
                        initialCountryCode: 'NG',
                        disableLengthCheck: true, // we’ll do our own check
                        onChanged: (phone) {
                          signupController.countryCodeController.text =
                              phone.countryCode;
                        },
                        onCountryChanged: (country) {
                          signupController.countryCodeController.text =
                              "+${country.dialCode}";
                        },
                        inputFormatters: [
                          FilteringTextInputFormatter.digitsOnly,
                          LengthLimitingTextInputFormatter(10),
                        ],
                        validator: (phone) async {
                          if (phone == null || phone.number.trim().isEmpty) {
                            return 'Please enter a phone number';
                          }
                      if (phone.number.length != 10) {
                        return 'Phone number must be 10 digits';
                      }
                          // bool isValid =
                          //     await signupController.isPhoneNumberValid(
                          //   phone.completeNumber,
                          //   phone.countryISOCode ?? 'NG',
                          // );

                          // if (!isValid) {
                          //   return 'Invalid phone number for selected country';
                          // }

                          return null;
                        },
                      ),
                      const SizedBox(height: 20),
                      // Promo Code Field
                      TextField(
                        controller: signupController.passwordController,
                        obscureText: _obscureText,
                        decoration: InputDecoration(
                          labelText: "Password",
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                            borderSide: BorderSide(color: baseColor),
                          ),
                          suffixIcon: IconButton(
                            iconSize: 20,
                            icon: Icon(
                              _obscureText
                                  ? Icons.visibility_off
                                  : Icons.visibility,
                            ),
                            onPressed: () {
                              setState(() {
                                _obscureText = !_obscureText;
                              });
                            },
                          ),
                        ),
                      ),
                      const SizedBox(height: 30),
                      // Register Button
                      ElevatedButton(
                        onPressed: () {
                          if (_formKey.currentState!.validate()) {
                            signupController.signIn(context);
                          } else {
                            // Show validation error
                          }
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: baseColor,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(30),
                          ),
                          padding: const EdgeInsets.symmetric(vertical: 15),
                        ),
                        child: const Text(
                          "Login",
                          style: TextStyle(fontSize: 16, color: Colors.white),
                        ),
                      ),
                      const SizedBox(height: 20),
                      // Login Link
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Text(
                            "Forgot your Password?",
                            style: TextStyle(color: Colors.grey),
                          ),
                          TextButton(
                            onPressed: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => Rest_Password(),
                                  ));
                            },
                            child: Text(
                              "Reset Password",
                              style: TextStyle(color: baseColor),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        )));
  }
}
