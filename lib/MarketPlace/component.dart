import 'package:ag_mortgage/Dashboard_Screen/Market_Place/main.dart';
import 'package:flutter/material.dart';

// ignore: camel_case_types
class Market_PlaceRedirectPage extends StatefulWidget {
  const Market_PlaceRedirectPage({Key? key}) : super(key: key);

  @override
  // ignore: library_private_types_in_public_api
  _Market_PlaceRedirectPageState createState() => _Market_PlaceRedirectPageState();
}

class _Market_PlaceRedirectPageState extends State<Market_PlaceRedirectPage> {
  @override
  void initState() {
    super.initState();

    // Redirect to the desired page after a short delay
    Future.delayed(const Duration(seconds: 0), () {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (_) => const MarketMain(),
        ),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            CircularProgressIndicator(), // Show a loader during redirection
            SizedBox(height: 16),
            Text(
              'Loading...',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
          ],
        ),
      ),
    );
  }
}

// Example destination page
class Market_PlaceRedirectPage_connection extends StatelessWidget {
  const Market_PlaceRedirectPage_connection({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Marketplace")),
      body: const Center(
        child: Text(
          "Welcome to the Marketplace!",
          style: TextStyle(fontSize: 24),
        ),
      ),
    );
  }
}

