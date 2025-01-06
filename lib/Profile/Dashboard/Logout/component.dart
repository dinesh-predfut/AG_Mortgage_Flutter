import 'package:ag_mortgage/Authentication/Login/login.dart';
import 'package:ag_mortgage/main.dart';
import 'package:flutter/material.dart';

// ignore: camel_case_types
class LogoutScreen_main extends StatelessWidget {
  const LogoutScreen_main({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'AG Mortgage',
      home: LogoutScreen(),
    );
  }
}

class LogoutScreen extends StatelessWidget {
  const LogoutScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // Set a delay of 0.5 seconds before navigating to the login screen
    Future.delayed(const Duration(milliseconds: 500), () {
      Navigator.pushNamedAndRemoveUntil(
        context,
        '/login',
        (route) => false,
      );
    });

    return const Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            CircularProgressIndicator(),
            SizedBox(height: 20),
            Text(
              "Logging out...",
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
            ),
          ],
        ),
      ),
    );
  }
}
