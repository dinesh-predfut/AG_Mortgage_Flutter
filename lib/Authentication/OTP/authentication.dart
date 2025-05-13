import 'package:ag_mortgage/Authentication/Login_Controller/controller.dart';
import 'package:ag_mortgage/Authentication/PIN_Creation/pin.dart';
import 'package:ag_mortgage/const/Image.dart'; // Update this with the correct path to your image.dart file.
import 'package:ag_mortgage/const/colors.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';


class Authentication extends StatefulWidget {
  const Authentication({Key? key}) : super(key: key);

  @override
  State<Authentication> createState() => _AuthenticationState();
}

class _AuthenticationState extends State<Authentication> {
  final List<TextEditingController> _controllers = List.generate(
    6,
    (_) => TextEditingController(),
  ); // Create a controller for each OTP field.

  int _countdown = 50;
  ProfileController signupController = Get.find<ProfileController>();

  @override
  void initState() {
    super.initState();
    _startCountdown();
  }

  void _startCountdown() {
    if (_countdown > 0) {
      Future.delayed(const Duration(seconds: 1), () {
        setState(() {
          _countdown--;
        });
        _startCountdown();
      });
    }
  }

  // Collect the OTP from all controllers.
  String getOtp() {
    return _controllers.map((controller) => controller.text).join();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          // Background image
          Positioned.fill(
            child: Image.asset(
              Images
                  .house1, // Replace with your image path
              fit: BoxFit.cover,
            ),
          ),
          // Authentication form
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
                    "Authentication",
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      color: baseColor,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 10),
                  const Text(
                    "Enter the 6 digits code sent to your Phone Number to verify your request",
                    style: TextStyle(
                      fontSize: 14,
                      color: Colors.grey,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 30),
                  // OTP Input Row
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: List.generate(
                      6,
                      (index) => SizedBox(
                        width: 40,
                        child: TextField(
                          controller: _controllers[index],
                          textAlign: TextAlign.center,
                          maxLength: 1,
                          keyboardType: TextInputType.number,
                          decoration: InputDecoration(
                            counterText: '',
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10),
                              borderSide:
                                 BorderSide(color: baseColor),
                            ),
                          ),
                          onChanged: (value) {
                            if (value.isNotEmpty) {
                              if (index < 5) {
                                FocusScope.of(context)
                                    .nextFocus(); // Move to the next field
                              }
                            } else if (index > 0) {
                              FocusScope.of(context)
                                  .previousFocus(); // Move to the previous field
                            }
                          },
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 30),
                  // Verify Button
                  ElevatedButton(
                    onPressed: () {
                      // Collect the OTP and handle the verification logic.
                      String otp = getOtp();
                      print("Entered OTP: $otp");
                      // signupController.sendOTP();
                      Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => const PIN_Creation(),
                              ));
                      // Add your API call or verification logic here.
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: baseColor,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30),
                      ),
                      padding: const EdgeInsets.symmetric(vertical: 15),
                    ),
                    child: const Text(
                      "Verify",
                      style: TextStyle(fontSize: 16, color: Colors.white),
                    ),
                  ),
                  const SizedBox(height: 20),
                  // Resend OTP and Timer
                  Column(
                    children: [
                      const Text(
                        "I didn’t receive a code",
                        style: TextStyle(color: Colors.grey),
                      ),
                      const SizedBox(height: 5),
                      _countdown > 0
                          ? Text(
                              "Ends in 00:${_countdown.toString().padLeft(2, '0')}",
                              style: const TextStyle(color: Colors.grey),
                            )
                          : GestureDetector(
                              onTap: () {
                                setState(() {
                                  _countdown = 50; // Reset the timer.
                                });
                                _startCountdown();
                                // Add your resend OTP logic here.
                              },
                              child:  Text(
                                "Resend OTP",
                                style: TextStyle(
                                  color: baseColor,
                                  fontWeight: FontWeight.bold,
                                ),
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
    );
  }
}
