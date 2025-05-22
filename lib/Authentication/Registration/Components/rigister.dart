import 'package:ag_mortgage/Authentication/Login/login.dart';
import 'package:ag_mortgage/Authentication/Login_Controller/controller.dart';
import 'package:ag_mortgage/Authentication/OTP/authentication.dart';
import 'package:flutter/material.dart';
import 'package:ag_mortgage/const/Image.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:intl_phone_field/intl_phone_field.dart';

import '../../../const/colors.dart'; // Update this with the correct path to your image.dart file.

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  ProfileController signupController = Get.find<ProfileController>();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(vsync: this);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SingleChildScrollView(
            child: Form(
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
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 30),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Text(
                    "Register",
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      color: baseColor,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 10),
                  const Text(
                    "Enter the Phone Number you registered with NIN",
                    style: TextStyle(
                      fontSize: 14,
                      color: Colors.grey,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 30),
                  // Phone Number Field
                  TextFormField(
                    controller: signupController.firstNameController,
                    decoration: InputDecoration(
                      labelText: "First Name",
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                        borderSide: BorderSide(color: baseColor),
                      ),
                    ),
                    validator: (value) {
                      if (value == null || value.trim().isEmpty) {
                        return 'Please enter your first name';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 20),

                  // Last Name Field
                  TextFormField(
                    controller: signupController.lasttNameController,
                    decoration: InputDecoration(
                      labelText: "Last Name",
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                        borderSide: BorderSide(color: baseColor),
                      ),
                    ),
                    validator: (value) {
                      if (value == null || value.trim().isEmpty) {
                        return 'Please enter your last name';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 20),

                  // IntlPhoneField(
                  //   controller: signupController.registerPhoneNumber,
                  //   keyboardType: TextInputType.phone,
                  //   // validator: false,
                  //   decoration: InputDecoration(
                  //     labelText: "Phone Number",
                  //     border: OutlineInputBorder(
                  //       borderRadius: BorderRadius.circular(10),
                  //       borderSide: BorderSide(color: baseColor),
                  //     ),
                  //     counterText: "",
                  //   ),
                  //   initialCountryCode: 'NG', // Nigeria as default
                  //   disableLengthCheck: true,
                  //   onChanged: (phone) {
                  //     signupController.registerPhoneNumber.text =
                  //         phone.completeNumber;
                  //     print(phone
                  //         .completeNumber); // Prints full number with country code
                  //   },
                  // ),

                  IntlPhoneField(
                    controller: signupController.registerPhoneNumber,
                    keyboardType: TextInputType.phone,
                    invalidNumberMessage: "Please select a valid number",
                    decoration: InputDecoration(
                      labelText: "Phone Number",
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                        borderSide: BorderSide(color: baseColor),
                      ),
                      counterText: "",
                    ),
                    initialCountryCode: 'NG',
                    disableLengthCheck: true,
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
                    validator: (phone) {
                      if (phone == null || phone.number.trim().isEmpty) {
                        return 'Please enter a phone number';
                      }

                      String phoneNumber = phone.number.trim();

                      // Simple rules (Nigeria as example: 10 digits)
                      if (phoneNumber.length != 10) {
                        return 'Phone number must be 10 digits';
                      }

                      // Optional: more basic rule - ensure all characters are digits
                      if (!RegExp(r'^\d{10}$').hasMatch(phoneNumber)) {
                        return 'Only digits are allowed';
                      }

                      return null;
                    },
                  ),

                  const SizedBox(height: 20),

                  // Phone Number Field
                  TextFormField(
                    controller: signupController.emailController,
                    keyboardType: TextInputType.emailAddress,
                    decoration: InputDecoration(
                      labelText: "Email",
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                        borderSide: BorderSide(color: baseColor),
                      ),
                    ),
                    validator: (value) {
                      if (value == null || value.trim().isEmpty) {
                        return 'Please enter your email';
                      }

                      // Simple email pattern check
                      bool isValidEmail =
                          RegExp(r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+/=?^_`{|}~-]+@"
                                  r"[a-zA-Z0-9]+\.[a-zA-Z]+")
                              .hasMatch(value.trim());

                      if (!isValidEmail) {
                        return 'Enter a valid email address';
                      }

                      return null;
                    },
                  ),
                  const SizedBox(height: 20),
                  // Promo Code Field
                  TextField(
                    controller: signupController.promoCode,
                    decoration: InputDecoration(
                      labelText: "Promo Code (Optional)",
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                        borderSide: BorderSide(color: baseColor),
                      ),
                    ),
                  ),
                  const SizedBox(height: 30),
                  // Register Button
                  ElevatedButton(
                    onPressed: () {
                      if (_formKey.currentState!.validate()) {
                        // Valid input → Proceed with login

                        signupController.nextFuncation(context);
                      } else {
                        // Invalid input → Errors will show
                        print("Phone is invalid");
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
                      "Register",
                      style: TextStyle(fontSize: 16, color: Colors.white),
                    ),
                  ),
                  const SizedBox(height: 20),
                  // Login Link
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text(
                        "Already have an account?",
                        style: TextStyle(color: Colors.grey),
                      ),
                      TextButton(
                        onPressed: () {
                          // Navigator.push(
                          //     context,
                          //     MaterialPageRoute(
                          //       builder: (context) =>
                          //           const Login(navigation: true),
                          //     ));
                          //  Navigator.of(context).pushNamed('/login');
                          Navigator.pushNamed(context, "/login");
                        },
                        child: Text(
                          "Login",
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
