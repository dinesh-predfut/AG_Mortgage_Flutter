import 'package:ag_mortgage/Authentication/Login_Controller/controller.dart';
import 'package:ag_mortgage/Authentication/Profile/profile.dart';
import 'package:ag_mortgage/const/Image.dart';
import 'package:ag_mortgage/const/colors.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

class PIN_Creation extends StatefulWidget {
  const PIN_Creation({Key? key}) : super(key: key);

  @override
  State<PIN_Creation> createState() => _PIN_CreationState();
}

class _PIN_CreationState extends State<PIN_Creation> {
  ProfileController signupController = Get.find<ProfileController>();

  final TextEditingController _confirmPasswordController =
      TextEditingController();

  bool hasMinLength = false;
  bool hasNumber = false;
  bool hasUpperCase = false;
  bool hasSpecialChar = false;
  bool _isPasswordVisible = false;
  bool _isConfirmPasswordVisible = false;
   

  @override
  void initState() {
    super.initState();
    if (signupController.newPasswordController != null) {
      signupController.newPasswordController.addListener(_validatePassword);
    }
  }

  void _validatePassword() {
    final password = signupController.newPasswordController?.text ?? '';
    setState(() {
      hasMinLength = password.length >= 8;
      hasNumber = password.contains(RegExp(r'[0-9]'));
      hasUpperCase = password.contains(RegExp(r'[A-Z]'));
      hasSpecialChar = password.contains(RegExp(r'[!@#\$&*~%^]'));
    });
  }

  @override
  void dispose() {
    // signupController.newPasswordController.dispose();
    _confirmPasswordController.dispose();
    super.dispose();
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
          // Password form
          Align(
            alignment: Alignment.bottomCenter,
            child: Container(
              decoration: const BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.vertical(
                  top: Radius.circular(30),
                ),
              ),
              padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 30),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                   Text(
                    "Setup Password",
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      color: baseColor,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 10),
                  const Text(
                    "Create Password for your account",
                    style: TextStyle(
                      fontSize: 14,
                      color: Colors.grey,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 20),
                  // New Password Field
                  TextField(
                    controller: signupController.newPasswordController,
                    obscureText: !_isPasswordVisible,
                    decoration: InputDecoration(
                      labelText: "New Password",
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                        borderSide:BorderSide(color: baseColor),
                      ),
                      suffixIcon: IconButton(
                        icon: Icon(
                          _isPasswordVisible ? Icons.visibility : Icons.visibility_off,
                        ),
                        onPressed: () {
                          setState(() {
                            _isPasswordVisible = !_isPasswordVisible;
                          });
                        },
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),

                  // Confirm Password Field
                  TextField(
                    controller: _confirmPasswordController,
                    obscureText: !_isConfirmPasswordVisible,
                    decoration: InputDecoration(
                      labelText: "Confirm Password",
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                        borderSide:BorderSide(color: baseColor),
                      ),
                      suffixIcon: IconButton(
                        icon: Icon(
                          _isConfirmPasswordVisible ? Icons.visibility : Icons.visibility_off,
                        ),
                        onPressed: () {
                          setState(() {
                            _isConfirmPasswordVisible = !_isConfirmPasswordVisible;
                          });
                        },
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),
                  // Password Requirements
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      _buildPasswordCondition(
                          "Minimum 8 Characters", hasMinLength),
                      _buildPasswordCondition(
                          "Must Contain a number", hasNumber),
                      _buildPasswordCondition(
                          "Must contain upper case letters", hasUpperCase),
                      _buildPasswordCondition(
                          "Must contain special character (e.g. @, #, %, etc.)",
                          hasSpecialChar),
                    ],
                  ),
                  const SizedBox(height: 30),
                  // Submit Button
                  ElevatedButton(
                    onPressed: () {
                      if (signupController.newPasswordController.text !=
                          _confirmPasswordController.text) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Text("Passwords do not match!"),
                            backgroundColor: Colors.red,
                          ),
                        );
                      } else if (hasMinLength &&
                          hasNumber &&
                          hasUpperCase &&
                          hasSpecialChar) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Text("Password setup successful!"),
                            backgroundColor: Colors.green,
                          ),
                        );
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => const RegistrationScreen(),
                            ));
                      } else {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content:
                                Text("Password does not meet requirements."),
                            backgroundColor: Colors.red,
                          ),
                        );
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
                      "Submit",
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

  Widget _buildPasswordCondition(String text, bool conditionMet) {
    return Row(
      children: [
        Icon(
          conditionMet ? Icons.check_circle : Icons.circle_outlined,
          color: conditionMet ? Colors.green : Colors.grey,
        ),
        const SizedBox(width: 10),
        Text(
          text,
          style: TextStyle(
            color: conditionMet ? Colors.green : Colors.grey,
            fontWeight: FontWeight.w500,
          ),
        ),
      ],
    );
  }
}
