import 'dart:ffi';

import 'package:ag_mortgage/Dashboard_Screen/Investment/controller.dart';
import 'package:ag_mortgage/Main_Dashboard/Mortgage/Withdraw/controller.dart';
import 'package:ag_mortgage/Main_Dashboard/dashboard/Dashboard/component.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

import '../../../const/colors.dart';

class Investment_Forms extends StatefulWidget {
  const Investment_Forms({super.key});

  @override
  State<Investment_Forms> createState() => _Investment_FormsState();
}

class _Investment_FormsState extends State<Investment_Forms> {
  InvestmentModels? investmentData;
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    loadInvestmentData();
  }

  Future<void> loadInvestmentData() async {
    final controller = Get.put(Main_Dashboard_controller());
    InvestmentModels? data = await controller.fetchInvestmentDetails();

    setState(() {
      investmentData = data;
      isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Investments")),
      body: isLoading
    ? const Center(child: CircularProgressIndicator())
    : investmentData == null || investmentData!.items.isEmpty
        ? const Center(child: Text("No investments found"))
        : Column(
            children: [
              Expanded(
                child: ListView.builder(
                  itemCount: investmentData!.items.length,
                  itemBuilder: (context, index) {
                    InvestmentPlan investment = investmentData!.items[index];

                    return InvestmentCard(investment: investment, index: index);
                  },
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Center(
                  child: ElevatedButton(
                    onPressed: () {
                      Navigator.pushNamed(context, "/investment");
                    },
                    style: ElevatedButton.styleFrom(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 24.0, vertical: 12.0),
                      backgroundColor: baseColor,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20),
                      ),
                    ),
                    child: const Text("Invest More",
                        style: TextStyle(color: Colors.white)),
                  ),
                ),
              ),
            ],
          ),
 
    );
  }
}

class InvestmentCard extends StatelessWidget {
  final InvestmentPlan investment;
  final int index;

  const InvestmentCard(
      {super.key, required this.investment, required this.index});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Column(children: [
        Align(
          alignment: Alignment.centerLeft,
          child: Text(
            "Investment $index",
            style: const TextStyle(
                color: Colors.black, fontSize: 18, fontWeight: FontWeight.bold),
          ),
        ),
        Container(
          margin: const EdgeInsets.all(12),
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(10),
            boxShadow: [
              BoxShadow(color: Colors.grey.withOpacity(0.2), blurRadius: 5),
            ],
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text("Customer: ${investment.customerName}",
                  style: const TextStyle(
                      fontSize: 16, fontWeight: FontWeight.bold)),
              const SizedBox(height: 8),
              buildRow("Amount Invested", "NGN ${investment.amountInvested}"),
              buildRow("Duration", investment.duration),
              buildRow("Start Date", investment.startDate),
              buildRow("Interest", "${investment.interestPercentage}%"),
              buildRow("Maturity Date", investment.maturityDate),
              buildRow("Maturity Amount", "NGN ${investment.maturityAmount}"),
              buildRow("Status", investment.status),
            ],
          ),
        ),
        Container(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: Colors.yellow[800],
            borderRadius: BorderRadius.circular(10),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.1),
                blurRadius: 10,
                offset: const Offset(0, 5),
              ),
            ],
          ),
          child: const Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [Text("Expected Yield"), Text("NGN 660,000")],
          ),
        ),
    
        const SizedBox(
          height: 20,
        ),
      ]),
    );
  }

  Widget buildRow(String title, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(title, style: const TextStyle(color: Colors.grey)),
          Text(value, style: const TextStyle(fontWeight: FontWeight.w600)),
        ],
      ),
    );
  }
}
