// ignore: file_names
import 'package:ag_mortgage/Dashboard_Screen/Mortgage/MortgageHome.dart';
import 'package:ag_mortgage/Dashboard_Screen/Mortgage/MortgagePage.dart';
import 'package:ag_mortgage/const/colors.dart';
import 'package:flutter/material.dart';

import '../../Dashboard_Screen/Investment/investment.dart';

// ignore: camel_case_types
class CardPaymentPage extends StatefulWidget {
  const CardPaymentPage({super.key});

  @override
  _CardPaymentPageState createState() => _CardPaymentPageState();
}
class _CardPaymentPageState extends State<CardPaymentPage> {
  // Create a TextEditingController to manage the TextFormField
  final TextEditingController _amountController = TextEditingController();

  // Function to handle amount button clicks
  void _setAmount(int amount) {
    setState(() {
      _amountController.text = " $amount";
    });
  }

  Widget _amountButton(BuildContext context, String displayText, int amount) {
    // ignore: unrelated_type_equality_checks

    return ElevatedButton(
      onPressed: () => _setAmount(amount),
      style: ElevatedButton.styleFrom(
        backgroundColor: Colors.white,

        // Set the button's background color
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),

          side: const BorderSide(
            color:
                Colors.orange, // Set the border color to match the button color
            width: 1, // Adjust border width if needed
          ),
          // Rounded corners
        ),
        padding: const EdgeInsets.symmetric(
            horizontal: 20, vertical: 10), // Button padding
      ),
      child: Text(
        displayText,
        style: const TextStyle(color: Colors.black), // Text color
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Card"),
        centerTitle: true,
         leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Center(
                child: Text(
              'Select Card and Proceed to make payment',
              style: TextStyle(fontSize: 12, color: Colors.grey),
            )),
            const SizedBox(height: 10),
            // Card Section
            Container(
              decoration: BoxDecoration(
                gradient: const LinearGradient(
                  colors: [
                    Color.fromARGB(255, 51, 170, 55),
                    Color.fromARGB(209, 45, 245, 51)
                  ],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
                borderRadius: BorderRadius.circular(12),
              ),
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      const CircleAvatar(
                        radius: 20,
                        backgroundColor: Colors.white,
                        child: Icon(Icons.circle, color: Colors.green),
                      ),
                      const Spacer(),
                      IconButton(
                        onPressed: () {},
                        icon: const Icon(Icons.more_vert, color: Colors.white),
                      ),
                    ],
                  ),
                  const SizedBox(height: 30),
                  const Text(
                    "Adeyemi Pelumi",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 10),
                  const Text(
                    "3098 9576 1876 6521",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 10),
                  const Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "CVV: 010",
                        style: TextStyle(color: Colors.white),
                      ),
                      Text(
                        "EXP: 12/29",
                        style: TextStyle(color: Colors.white),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            const SizedBox(height: 20),
            TextFormField(
              controller: _amountController,
              decoration: InputDecoration(
                prefixText: "NGN ",
                contentPadding:
                    const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                  borderSide: const BorderSide(color: Colors.deepPurple),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                  borderSide:
                      const BorderSide(color: Colors.deepPurple, width: 2),
                ),
              ),
            ),
            const SizedBox(height: 20),
            Wrap(
              spacing: 10,
              runSpacing: 10,
              children: [
                _amountButton(context, "#100,000", 100000),
                _amountButton(context, "#200,000", 200000),
                _amountButton(context, "#300,000", 300000),
                _amountButton(context, "#400,000", 400000),
                _amountButton(context, "#500,000", 500000),
                _amountButton(context, "#600,000", 600000),
              ],
            ),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: () {
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const MortgagePage(
                        startIndex: 7), // Start with MortgagePage
                  ),
                );
              },
              //
              style: ElevatedButton.styleFrom(
                backgroundColor: baseColor,
                minimumSize: const Size.fromHeight(50),
              ),
              child: const Text(
                "Processd",
                style: TextStyle(color: Colors.white, letterSpacing: 2),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
