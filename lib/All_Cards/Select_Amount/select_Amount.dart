// ignore: file_names
import 'package:ag_mortgage/All_Cards/Get_all_Cards/Models.dart';
import 'package:ag_mortgage/All_Cards/Get_all_Cards/controller.dart';
import 'package:ag_mortgage/All_Cards/Select_Amount/controller.dart';
import 'package:ag_mortgage/Dashboard_Screen/Mortgage/MortgageHome.dart';
import 'package:ag_mortgage/Dashboard_Screen/Mortgage/MortgagePage.dart';
import 'package:ag_mortgage/Dashboard_Screen/Mortgage/controller.dart';
import 'package:ag_mortgage/const/colors.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:intl/intl.dart';

import '../../Dashboard_Screen/Investment/investment.dart';

// ignore: camel_case_types
class CardPaymentPage extends StatefulWidget {
  final int? selectedID;
  final String? planType;
  const CardPaymentPage({super.key, this.selectedID, this.planType});

  @override
  _CardPaymentPageState createState() => _CardPaymentPageState();
}

class _CardPaymentPageState extends State<CardPaymentPage> {
  // final TextEditingController _amountController = TextEditingController();

  late Future<CardModel?> cardDetails;
  final controller = Get.put(CardControllerSelectAmount());
  final mortgagecontroller = Get.put(MortgagController());

  @override
  void initState() {
    super.initState();
    String amount = controller.amountController.text.trim();
    if (amount.isEmpty) {
      controller.amountController.text = '0';
    }

    // Ensure mortgagecontroller is initialized before accessing its controllers
    if (mortgagecontroller.initialDepositController.text.isNotEmpty &&
        mortgagecontroller.monthlyRepaymentController.text.isNotEmpty) {
      double initialDeposit = double.tryParse(
            mortgagecontroller.initialDepositController.text.replaceAll(',', ''),
          ) ??
          0;

      double monthlyRepayment = double.tryParse(
            mortgagecontroller.monthlyRepaymentController.text
                .replaceAll(',', ''),
          ) ??
          0;

      // Only update amountController if values are valid
      if (initialDeposit > 0 || monthlyRepayment > 0) {
        controller.amountController.text =
            formattedEMI((initialDeposit + monthlyRepayment)).toString();
      }
      controller.fetchMortgageDetails();
      print("Valid Initial Deposit: $initialDeposit");
    }

    // Fetch mortgage details regardless
  }

  String formattedEMI(double amount) {
    // Format the number with international commas (thousands separators)
    final numberFormatter = NumberFormat(
        '#,###.##', 'en_US'); // en_US for international comma formatting
    return numberFormatter.format(amount);
  }

  void _setAmount(int amount) {
    setState(() {
      controller.amountController.text = " $amount";
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
            FutureBuilder<CardModel?>(
              future: controller.fetchCardDetails(widget.selectedID!),
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  final card = snapshot.data;
                  return SingleChildScrollView(
                    child: Container(
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
                                icon: const Icon(Icons.more_vert,
                                    color: Colors.white),
                              ),
                            ],
                          ),
                          const SizedBox(height: 30),
                          Text(
                            card!.cardName,
                            style: const TextStyle(
                              color: Colors.white,
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const SizedBox(height: 10),
                          Text(
                            card.cardNumber,
                            style: const TextStyle(
                              color: Colors.white,
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const SizedBox(height: 10),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                "CVV: ${card.cvv}",
                                style: const TextStyle(color: Colors.white),
                              ),
                              Text(
                                "EXP: ${card.expDate}",
                                style: const TextStyle(color: Colors.white),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  );
                } else {
                  return const Center(child: Text('No card data available.'));
                }
              },
            ),
            const SizedBox(height: 20),
            TextFormField(
              controller: controller.amountController,
              keyboardType: TextInputType.number,
              onTap: () {
                if (controller.amountController.text.trim() == '0') {
                  controller.amountController.clear();
                }
              },
              decoration: InputDecoration(
                prefixText: "NGN ",
                contentPadding:
                    const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                  borderSide: BorderSide(color: baseColor),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                  borderSide: BorderSide(color: baseColor, width: 2),
                ),
              ),
            ),

            const SizedBox(height: 20),
            // Wrap(
            //   spacing: 10,
            //   runSpacing: 10,
            //   children: [
            //     _amountButton(context, "#100,000", 100000),
            //     _amountButton(context, "#200,000", 200000),
            //     _amountButton(context, "#300,000", 300000),
            //     _amountButton(context, "#400,000", 400000),
            //     _amountButton(context, "#500,000", 500000),
            //     _amountButton(context, "#600,000", 600000),
            //   ],
            // ),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: () {
                double monthlyRepayment = double.tryParse(
                      mortgagecontroller.monthlyRepaymentController.text
                          .replaceAll(',', ''),
                    ) ??
                    0;
                double initialDeposit = double.tryParse(
                      mortgagecontroller.initialDepositController.text
                          .replaceAll(',', ''),
                    ) ??
                    0;
                double amountPay = double.tryParse(
                      controller.amountController.text.replaceAll(',', ''),
                    ) ??
                    0;
                if (monthlyRepayment != 0) {
                  if(widget.planType == "Mortgage"){
                    mortgagecontroller.addMortgageForm(context);
                  
                  controller.monthlyContribution(
                      context, monthlyRepayment, widget.selectedID!);
                  controller.voluntoryPayment(
                      initialDeposit, widget.selectedID!);
                } else if (monthlyRepayment == 0) {
                  controller.voluntoryPayment(amountPay, widget.selectedID!);

                  Fluttertoast.showToast(
                    msg: "Created Successfully",
                    toastLength: Toast.LENGTH_SHORT,
                    gravity: ToastGravity.BOTTOM,
                    backgroundColor: Colors.grey,
                    textColor: Color.fromARGB(255, 15, 15, 15),
                  );
                } else {
                  print("amountController");
                  controller.calculation(context, widget.selectedID!);
                }
              }
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: baseColor,
                minimumSize: const Size.fromHeight(50),
              ),
              child: const Text(
                "Proceed",
                style: TextStyle(color: Colors.white, letterSpacing: 2),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
