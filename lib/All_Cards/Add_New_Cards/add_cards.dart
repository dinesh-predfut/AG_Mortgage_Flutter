import 'package:ag_mortgage/All_Cards/Add_New_Cards/controller.dart';
import 'package:ag_mortgage/All_Cards/Get_all_Cards/all_cards.dart';
import 'package:ag_mortgage/Dashboard_Screen/Investment/investment.dart';
import 'package:ag_mortgage/const/Image.dart';
import 'package:ag_mortgage/const/colors.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

class ADD_CardDetailsPage extends StatefulWidget {
  const ADD_CardDetailsPage({super.key});

  @override
  State<ADD_CardDetailsPage> createState() => _ADD_CardDetailsPageState();
}

class _ADD_CardDetailsPageState extends State<ADD_CardDetailsPage> {
  final cardControllers = Get.put(ADDCardController());
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
          children: [
            const Center(
                child: Text(
              'Enter Card Details',
              style: TextStyle(fontSize: 16, color: Colors.grey),
            )),
            Card(
              color: Colors.red,
              elevation: 4.0,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
              child: const Padding(
                padding: EdgeInsets.all(20.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "iPay",
                      style: TextStyle(
                          color: Colors.white, fontSize: 28, height: 3),
                    ),
                    SizedBox(height: 20),
                    Text(
                      "0000 0000 0000 0000",
                      style: TextStyle(color: Colors.white, fontSize: 20),
                    ),
                    SizedBox(height: 10),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "CVV: 000",
                          style: TextStyle(color: Colors.white),
                        ),
                        Text(
                          "EXP: 00/00",
                          style: TextStyle(color: Colors.white),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 20),
            TextField(
              controller: cardControllers.nameController,
              
              onChanged: (value) {
                // Dynamically update state
                setState(() {
                  cardControllers.nameController.text = value;
                });
              },
              decoration: const InputDecoration(labelText: "Card Name"),
            ),
            const SizedBox(height: 16),
            TextField(
              controller: cardControllers.cardNumber,
              keyboardType: TextInputType.number,
              onChanged: (value) {
                // Dynamically update state
                setState(() {
                  cardControllers.cardNumber.text = value;
                });
              },
              decoration: const InputDecoration(labelText: "Card Number"),
            ),
            const SizedBox(height: 16),
            Row(
              children: [
                Expanded(
                  child: TextField(
                    // keyboardType: TextInputType.number,
                    controller: cardControllers.expDateController,
                    onChanged: (value) {
                      // Dynamically update state
                      setState(() {
                        cardControllers.expDateController.text = value;
                      });
                    },
                    decoration: const InputDecoration(labelText: "Exp. Date"),
                  ),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: TextField(
                    controller: cardControllers.cvv,
                    keyboardType: TextInputType.number,
                    onChanged: (value) {
                      // Dynamically update state
                      setState(() {
                        cardControllers.cvv.text = value;
                      });
                    },
                    decoration: const InputDecoration(labelText: "CVV"),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),
            Row(
              children: [
                Checkbox(value: false, onChanged: (value) {}),
                const Text("Save Card"),
              ],
            ),
            const Spacer(),
            ElevatedButton(
              onPressed: () {
                if (cardControllers.nameController.text.isEmpty) {
                  Fluttertoast.showToast(msg: "Enter Card Name");
                } else if (cardControllers.cardNumber.text.trim().length < 9) {
                  Fluttertoast.showToast(msg: "Enter Valid Card Number".tr);
                  return;
                } else if (cardControllers.expDateController.text.isEmpty) {
                  Fluttertoast.showToast(msg: "Enter the Vaild Date");
                } else if (cardControllers.cvv.text.isEmpty) {
                  Fluttertoast.showToast(msg: "Enter Vaild CVV");
                } else {
                  cardControllers.add_card(context);
                }
              },
              //
              style: ElevatedButton.styleFrom(
                minimumSize: const Size.fromHeight(50),
                backgroundColor: Colors.deepPurple,
              ),
              child: const Text("Save Card",
                  style: TextStyle(color: Colors.white)),
            ),
          ],
        ),
      ),
    );
  }
  // ignore: non_constant_identifier_names
}

class Success extends StatelessWidget {
  const Success({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(""),
        centerTitle: true,
      ),
      body: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image.asset(
                  Images.success, width: 150, // Adjust size as needed
                  height: 150,
                ),
                const SizedBox(height: 20),
                const Text(
                  "Deposite Successful",
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.w600),
                ),
                const Text(
                    "Congratulations Pelumi! You have made your first deposit",
                    style: TextStyle(fontSize: 10)),
                const SizedBox(height: 20),
                ElevatedButton(
                  onPressed: () {
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                        builder: (context) =>
                            const Get_All_Cards(), // Start with MortgagePage
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
          )),
    );
  }
}
