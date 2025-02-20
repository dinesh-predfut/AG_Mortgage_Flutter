import 'package:ag_mortgage/Dashboard_Screen/Market_Place/Details_Page/component.dart';
import 'package:ag_mortgage/Dashboard_Screen/Mortgage/MortgageHome.dart';
import 'package:ag_mortgage/Main_Dashboard/dashboard/Term_Sheet/controller.dart';
import 'package:ag_mortgage/Main_Dashboard/dashboard/Term_Sheet/model.dart';
import 'package:ag_mortgage/const/colors.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:intl/intl.dart';

// ignore: must_be_immutable
class Term_Sheets extends StatefulWidget {
  String plans;
  Term_Sheets(this.plans, {super.key});

  @override
  State<Term_Sheets> createState() => _Term_SheetsState();
}

class _Term_SheetsState extends State<Term_Sheets>
    with SingleTickerProviderStateMixin {
  final controller = Get.put(MortgagControllerDashboard());
  String testPlan = "Rent-To-Own";
  Map<String, dynamic> data = {};
  // Future<void> fetchData() async {
  //   try {
  //     final responseData =
  //         await controller.getData("userId"); // Pass the actual userId
  //     setState(() {
  //       data = responseData;
  //     });
  //   } catch (error) {
  //     print("Error fetching data in UI: $error");
  //   }
  // }

  @override
  void initState() {
    super.initState();
    print("check${widget.plans.toLowerCase()}");
    //  controller.findAndSetArea(controller.selectedArea!.toInt());
    //  controller.findAndSetCity(controller.selectedCity!.toInt());
  }

  int cleanNumbers(dynamic amount) {
    if (amount == null) return 0;

    // Convert the amount to a string and remove commas
    String amountString = amount.toString().replaceAll(',', '');

    return int.tryParse(amountString) ?? 0;
  }

  @override
  Widget build(BuildContext context) {
    // double initialDeposit = double.tryParse(
    //       controller.propertyValueController?.replaceAll(',', ''),
    //     ) ??
    //     0;
    String todayDate = DateFormat('dd-MM-yyyy').format(DateTime.now());
    String anniversary =
        DateFormat('dd-MM-yyyy').format(controller.selectedDay);
    String anniversaryDate = controller.selectedDay?.toString() ?? '';
    String estimatedProfileDate =
        controller.calculateProfileDate(anniversaryDate, 16);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Term Sheet'),
        centerTitle: true,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: () {
        if (widget.plans.toLowerCase() == "mortgage") {
          return FutureBuilder<List<CustomerModel>>(
            future: controller.fetchMortgageDetails(),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const Center(child: CircularProgressIndicator());
              } else if (snapshot.hasError) {
                return Center(child: Text('Error: ${snapshot.error}'));
              } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                return const Center(child: Text('No data available.'));
              } else {
                final customer = snapshot
                    .data![0]; // Assuming we're displaying the first customer
                String anniversaryDate = customer.anniversary?.toString() ?? '';
                String estimatedProfileDate =
                    controller.calculateProfileDate(anniversaryDate, 16);

                return SingleChildScrollView(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        "Est pellentesque fermentum cursus curabitur pharetra, vene",
                        textAlign: TextAlign.center,
                        style: TextStyle(color: Colors.grey, fontSize: 13),
                      ),
                      const SizedBox(height: 5),
                      Align(
                        alignment: Alignment.bottomRight,
                        child: ElevatedButton(
                          onPressed: () {
                            Navigator.pushNamed(context, "login/propertyView",
                                arguments: customer.apartmentOrMarketplace);
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.blue, // baseColor
                            padding: const EdgeInsets.symmetric(
                                horizontal: 20.0, vertical: 10.0),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(20),
                            ),
                          ),
                          child: const Text("View House",
                              style:
                                  TextStyle(color: Colors.white, fontSize: 12)),
                        ),
                      ),
                      const SizedBox(height: 0.0),
                      _buildSection(
                        "House Details",
                        [
                          _buildRow(
                              "City",
                              customer.city != null
                                  ? customer.city.toString()
                                  : "N/A"),
                          _buildRow(
                              "Area",
                              customer.area != null
                                  ? customer.area.toString()
                                  : "N/A"),
                          _buildRow("Selling Price",
                              "NGN ${customer.estimatedPropertyValue != null ? customer.estimatedPropertyValue.toString() : 'N/A'}"),
                        ],
                        buttonAction: () {},
                      ),
                      const SizedBox(height: 16.0),
                      _buildSection(
                        "Loan Details",
                        [
                          _buildRow(
                              "Initial Deposit",
                              customer.initialDeposit != null
                                  ? "NGN ${customer.initialDeposit.toString()}"
                                  : 'N/A'),
                          _buildRow("Loan",
                              "NGN ${(customer.estimatedPropertyValue! * 0.7)}"),
                          _buildRow(
                              "Repayment Period",
                              customer.loanRepaymentPeriod != null
                                  ? "${customer.loanRepaymentPeriod} Years"
                                  : "N/A"),
                          _buildRow(
                              "Monthly Repayment",
                              customer.monthlyRepaymentAmount != null
                                  ? "NGN ${customer.monthlyRepaymentAmount.toString()}"
                                  : "N/A"),
                          _buildRow(
                              "Starting Date",
                              controller.formatProfileDate(
                                  customer.startDate ?? 'N/A')),
                          _buildRow(
                              "Next Anniversary Date",
                              controller.formatProfileDate(
                                  customer.startDate ?? 'N/A')),
                        ],
                      ),
                      const SizedBox(height: 16.0),
                      _buildSection(
                        "Saving & Profiling",
                        [
                          _buildRow("Screening Period", "18 Months"),
                          _buildRow(
                            "Estimated Profile Date",
                            controller.formatProfileDate(estimatedProfileDate),
                          ),
                          _buildRow("Estimated\nTotal Monthly Savings",
                              "NGN ${customer.monthlyRepaymentAmount != null ? customer.monthlyRepaymentAmount.toString() : "N/A"}"),
                          _buildRow("Initial Deposit",
                              "NGN ${customer.initialDeposit != null ? " ${customer.initialDeposit.toString()}" : "N/A"}"),
                          _buildRow("Minimum Total Expected Saving",
                              "NGN ${(customer.estimatedPropertyValue! * 0.3)}"),
                        ],
                      ),
                      Container(
                        padding: const EdgeInsets.all(16.0),
                        decoration: BoxDecoration(
                          color: Colors.amber[100],
                          borderRadius: BorderRadius.circular(8.0),
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            const Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "Estimated Mortgage Month",
                                  style: TextStyle(fontWeight: FontWeight.bold),
                                ),
                              ],
                            ),
                            TextButton(
                              onPressed: () {
                                Navigator.pushReplacement(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) =>
                                        const MortgagePageHome(
                                      startIndex: 1,
                                    ),
                                  ),
                                );
                              },
                              child: Text(
                                controller.formatProfileDateName(
                                    estimatedProfileDate),
                              ),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 24.0),
                    ],
                  ),
                );
              }
            },
          );
        } else if (widget.plans.toLowerCase() == "rent-to-own") {
          return FutureBuilder<List<CustomerModel>>(
            future: controller.fetchRentToOwnDetails(),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const Center(child: CircularProgressIndicator());
              } else if (snapshot.hasError) {
                return Center(child: Text('Error: ${snapshot.error}'));
              } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                return const Center(child: Text('No data available.'));
              } else {
                final customer = snapshot
                    .data![0]; // Assuming we're displaying the first customer
                String anniversaryDate = customer.anniversary?.toString() ?? '';
                String estimatedProfileDate =
                    controller.calculateProfileDate(anniversaryDate, 16);

                return SingleChildScrollView(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        "Est pellentesque fermentum cursus curabitur pharetra, vene",
                        textAlign: TextAlign.center,
                        style: TextStyle(color: Colors.grey, fontSize: 13),
                      ),
                      const SizedBox(height: 5),
                      Align(
                        alignment: Alignment.bottomRight,
                        child: ElevatedButton(
                          onPressed: () {
                            Navigator.pushNamed(context, "login/propertyView",
                                arguments: customer.apartmentOrMarketplace);
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.blue, // baseColor
                            padding: const EdgeInsets.symmetric(
                                horizontal: 20.0, vertical: 10.0),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(20),
                            ),
                          ),
                          child: const Text("View House",
                              style:
                                  TextStyle(color: Colors.white, fontSize: 12)),
                        ),
                      ),
                      const SizedBox(height: 0.0),
                      _buildSection(
                        "House Details",
                        [
                          _buildRow(
                              "City",
                              customer.city != null
                                  ? customer.city.toString()
                                  : "N/A"),
                          _buildRow(
                              "Area",
                              customer.area != null
                                  ? customer.area.toString()
                                  : "N/A"),
                          _buildRow("Selling Price",
                              "NGN ${customer.estimatedPropertyValue != null ? customer.estimatedPropertyValue.toString() : 'N/A'}"),
                        ],
                        buttonAction: () {},
                      ),
                      const SizedBox(height: 16.0),
                      _buildSection(
                        "Loan Details",
                        [
                          _buildRow(
                              "Down Payment",
                              customer.initialDeposit != null
                                  ? "NGN ${customer.initialDeposit.toString()}"
                                  : 'N/A'),
                          _buildRow("Loan",
                              "NGN ${(customer.estimatedPropertyValue! * 0.6)}"),
                          _buildRow(
                              "Repayment Period",
                              customer.rentalRepaymentPeriod != null
                                  ? "${customer.rentalRepaymentPeriod} Years"
                                  : "N/A"),
                          _buildRow(
                              "Screening Monthly Rental",
                              customer.monthlyLoanAmount != null
                                  ? "NGN ${customer.monthlyLoanAmount.toString()}"
                                  : "N/A"),
                          _buildRow(
                              "Monthly Repayment",
                              customer.monthlyRentalAmount != null
                                  ? "NGN ${customer.monthlyRentalAmount.toString()}"
                                  : "N/A"),
                          _buildRow(
                              "Starting Date",
                              controller.formatProfileDate(
                                  customer.startDate ?? 'N/A')),
                          _buildRow(
                              "Next Anniversary Date",
                              controller.formatProfileDate(
                                  customer.anniversary ?? 'N/A')),
                        ],
                      ),
                      const SizedBox(height: 16.0),
                      _buildSection(
                        "Saving & Profiling",
                        [
                          _buildRow("Screening Period",
                              "${customer.loanRepaymentPeriod} Months"),
                          _buildRow(
                            "Estimated Profile Date",
                            controller.formatProfileDate(
                                customer.anniversary ?? 'N/A'),
                          ),
                          _buildRow("Total Monthly Rental",
                              "NGN ${(((customer.estimatedPropertyValue ?? 0) * 0.8) - (customer.initialDeposit ?? 0)) / 25}"),
                          _buildRow("Down Payment",
                              "NGN ${customer.initialDeposit != null ? " ${customer.initialDeposit.toString()}" : "N/A"}"),
                          _buildRow("Total Expected Deposit",
                              "NGN ${(customer.initialDeposit ?? 0) + (customer.monthlyLoanAmount ?? 0)}"),
                        ],
                      ),
                      Container(
                        padding: const EdgeInsets.all(16.0),
                        decoration: BoxDecoration(
                          color: Colors.amber[100],
                          borderRadius: BorderRadius.circular(8.0),
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            const Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "Amount to Deposit",
                                  style: TextStyle(fontWeight: FontWeight.bold),
                                ),
                              ],
                            ),
                            TextButton(
                              onPressed: () {},
                              child: Text(
                                controller.formatProfileDateName(
                                    customer.anniversary.toString()),
                              ),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 24.0),
                    ],
                  ),
                );
              }
            },
          );
        } else if (widget.plans == "Construction Finance") {
          return FutureBuilder<List<ConstructionProject>>(
            future: controller.fetchConstructionFinance(),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const Center(child: CircularProgressIndicator());
              } else if (snapshot.hasError) {
                return Center(child: Text('Error: ${snapshot.error}'));
              } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                return const Center(child: Text('No data available.'));
              } else {
                final customer = snapshot
                    .data![0]; // Assuming we're displaying the first customer
                String anniversaryDate = customer.anniversary?.toString() ?? '';
                String estimatedProfileDate =
                    controller.calculateProfileDate(anniversaryDate, 16);

                return SingleChildScrollView(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        "Est pellentesque fermentum cursus curabitur pharetra, vene",
                        textAlign: TextAlign.center,
                        style: TextStyle(color: Colors.grey, fontSize: 13),
                      ),
                      const SizedBox(height: 5),
                      Align(
                        alignment: Alignment.bottomRight,
                        child: ElevatedButton(
                          onPressed: () {
                            Navigator.pushNamed(context, "login/propertyView",
                                arguments: customer.typeOfConstruction);
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.blue, // baseColor
                            padding: const EdgeInsets.symmetric(
                                horizontal: 20.0, vertical: 10.0),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(20),
                            ),
                          ),
                          child: const Text("View House",
                              style:
                                  TextStyle(color: Colors.white, fontSize: 12)),
                        ),
                      ),
                      const SizedBox(height: 0.0),
                      _buildSection(
                        "House Details",
                        [
                          _buildRow(
                              "City",
                              customer.city != null
                                  ? customer.city.toString()
                                  : "N/A"),
                          _buildRow(
                              "Area",
                              customer.area != null
                                  ? customer.area.toString()
                                  : "N/A"),
                          _buildRow(
                              "Type of Construction",
                              // ignore: unnecessary_null_comparison
                              "NGN ${customer.typeOfConstruction != null ? customer.typeOfConstruction.toString() : 'N/A'}"),
                          _buildRow(
                              "Estimated Budget",
                              // ignore: unnecessary_null_comparison
                              "NGN ${ controller.formatNumber(customer.estimatedAmountSpent.toStringAsFixed(2))}"),
                        ],
                        buttonAction: () {},
                      ),
                      const SizedBox(height: 16.0),
                      _buildSection(
                        "Loan Details",
                        [
                          _buildRow(
                              "Loan",
                              customer.estimatedAmountSpent != null
                                  ? "NGN ${customer.estimatedAmountSpent.toString()}"
                                  : 'N/A'),
                         
                          _buildRow(
                              "Repayment Period",
                              customer.repaymentPeriod != null
                                  ? "${customer.repaymentPeriod} Years"
                                  : "N/A"),
                          _buildRow(
                              "Monthly Repayment",
                              // ignore: unnecessary_null_comparison
                              customer.totalMonthlySaving != null
                                  ? "NGN ${controller.formatNumber(customer.totalExpectedSaving.toString())}"
                                  : "N/A"),
                        
                          _buildRow(
                              "Starting Date",
                              controller.formatProfileDate(
                                  customer.startDate ?? 'N/A')),
                          _buildRow(
                              "Next Anniversary Date",
                              controller.formatProfileDate(
                                  customer.anniversary ?? 'N/A')),
                        ],
                      ),
                      const SizedBox(height: 16.0),
                      _buildSection(
                        "Deposit & Profiling",
                        [
                          _buildRow("Screening Period",
                              "${customer.screeningPeriod} Months"),
                          _buildRow(
                            "Estimated Profile Date",
                            controller.formatProfileDate(
                                customer.anniversary ?? 'N/A'),
                          ),
                          _buildRow("Total Monthly Rental",
                              "NGN ${controller.formatNumber(customer.totalMonthlySaving.toString())}"),
                         
                          _buildRow("Total Expected Deposit",
                              "NGN ${controller.formatNumber(customer.totalExpectedSaving.toString())}"),
                        ],
                      ),
                       const SizedBox(height: 16.0),
                      Container(
                        padding: const EdgeInsets.all(16.0),
                        decoration: BoxDecoration(
                          color: Colors.amber[100],
                          borderRadius: BorderRadius.circular(8.0),
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            const Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "Amount to Deposit",
                                  style: TextStyle(fontWeight: FontWeight.bold),
                                ),
                              ],
                            ),
                            TextButton(
                              onPressed: () {},
                              child: Text(
                                controller.formatProfileDateName(
                                    customer.anniversary.toString()),
                              ),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 24.0),
                    ],
                  ),
                );
              }
            },
          );
        } else {
          return const Center(child: Text('Invalid Plan'));
        }
      }(),
    );
  }
}

Widget _buildSection(String title, List<Widget> rows,
    {String? buttonText, VoidCallback? buttonAction}) {
  return Card(
    margin: const EdgeInsets.only(top: 8.0),
    child: Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                title,
                style: const TextStyle(
                    fontWeight: FontWeight.bold, fontSize: 16.0),
              ),
              if (buttonText != null && buttonAction != null)
                TextButton(
                  onPressed: buttonAction,
                  child: Text(buttonText),
                ),
            ],
          ),
          const SizedBox(height: 8.0),
          Column(children: rows),
        ],
      ),
    ),
  );
}

Widget _buildRow(String label, String value) {
  return Padding(
    padding: const EdgeInsets.symmetric(vertical: 4.0),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(label, style: const TextStyle(color: Colors.grey)),
        Text(value, style: const TextStyle(fontWeight: FontWeight.bold)),
      ],
    ),
  );
}
