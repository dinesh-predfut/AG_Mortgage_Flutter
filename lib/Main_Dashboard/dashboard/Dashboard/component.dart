import 'dart:async';

import 'package:ag_mortgage/All_Cards/Get_all_Cards/all_cards.dart';
import 'package:ag_mortgage/Dashboard_Screen/Construction/construction.dart';
import 'package:ag_mortgage/Main_Dashboard/Construction/component.dart';
import 'package:ag_mortgage/Main_Dashboard/Mortgage/Withdraw/controller.dart';
import 'package:ag_mortgage/Main_Dashboard/dashboard/Investment/compontent.dart';
import 'package:ag_mortgage/Main_Dashboard/dashboard/Refer_Page/Bonus/component.dart';
import 'package:ag_mortgage/Main_Dashboard/dashboard/Statement_Page/component.dart';
import 'package:ag_mortgage/Main_Dashboard/dashboard/Term_Sheet/component.dart';
import 'package:ag_mortgage/const/Image.dart';
import 'package:ag_mortgage/const/colors.dart';
import 'package:ag_mortgage/const/constant.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:syncfusion_flutter_gauges/gauges.dart';

class DashboardPageS extends StatefulWidget {
  final String plans;
  const DashboardPageS(this.plans, {Key? key}) : super(key: key);

  @override
  State<DashboardPageS> createState() => _DashboardPageSState();
}

class _DashboardPageSState extends State<DashboardPageS> {
  final controller = Get.put(Main_Dashboard_controller());
  @override
  void initState() {
    super.initState();
    // ignore: unrelated_type_equality_checks
    controller.amount.text = '0';

    controller.fetchPlanOptions();
    if (controller.scoreData == null) {
      controller.fetchScore();
    }
    print("controller.scoreData: ${controller.scoreData}");
  }

  void _onBackPressed(BuildContext context) {
    // Custom logic for back navigation
    if (Navigator.of(context).canPop()) {
      print("its working");
      Navigator.pushNamed(context, "/dashBoardPage");
    } else {
      // Show exit confirmation dialog if needed
      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: const Text("Exit App"),
          content: const Text("Do you want to exit the app?"),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: const Text("No"),
            ),
            TextButton(
              onPressed: () => Navigator.of(context).pop(true),
              child: const Text("Yes"),
            ),
          ],
        ),
      );
    }
  }

  late final String plans;
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
        onWillPop: () async {
          // Handle custom back navigation logic
          _onBackPressed(context);
          return false; // Prevent default back behavior
        },
        child: Scaffold(
            backgroundColor: Colors.white,
            body: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(height: 40), // For safe area padding
                    // Greeting Section
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16),
                      child: Row(
                        children: [
                          Obx(() => Container(
                                padding: const EdgeInsets.all(
                                    2), // Optional spacing between image and border
                                decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  border: Border.all(
                                    color: Colors.grey, // Border color
                                    width: 1.0, // Border width (1px)
                                  ),
                                ),
                                child: CircleAvatar(
                                  radius: 40,
                                  backgroundImage: controller
                                          .profileImageUrl.value.isNotEmpty
                                      ? NetworkImage(
                                          controller.profileImageUrl.value)
                                      : const AssetImage('assets/image.png')
                                          as ImageProvider,
                                ),
                              )),
                          const SizedBox(width: 10),
                          Text(
                            "Hello, ${"${controller.profileName} ${controller.lastName}"}👋",
                            style: const TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                              color: Colors.black,
                            ),
                          ),
                          const Spacer(),
                        ],
                      ),
                    ),
                    const SizedBox(height: 20),
                    // Gauge Meter
                    Obx(() {
                      if (controller.isLoading.value) {
                        return const Center(child: CircularProgressIndicator());
                      } else {
                        return GaugeChartWidget(
                          plans: widget.plans,
                          data: controller.scoreData!,
                        );
                      }
                    }),
                    const SizedBox(height: 20),
                    // Cash Deposits Section
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16),
                      child: Container(
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(15),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withOpacity(0.1),
                              blurRadius: 10,
                              offset: const Offset(0, 5),
                            ),
                          ],
                        ),
                        padding: const EdgeInsets.all(20),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text(
                              "Cash Deposits",
                              style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                                color: Colors.black,
                              ),
                            ),
                            const SizedBox(height: 20),
                            const Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        "Contractual Savings",
                                        style: TextStyle(
                                            fontSize: 14, color: Colors.grey),
                                      ),
                                      Text(
                                        "NGN 100,000,000",
                                        style: TextStyle(
                                          fontSize: 14,
                                          color: Colors.red,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    ],
                                  ),
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        "Voluntary Savings",
                                        style: TextStyle(
                                            fontSize: 14, color: Colors.grey),
                                      ),
                                      Text(
                                        "NGN 100,000,000",
                                        style: TextStyle(
                                          fontSize: 14,
                                          color: Colors.green,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    ],
                                  ),
                                ]),
                            const SizedBox(height: 20),
                            Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  const Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        "Bonus",
                                        style: TextStyle(
                                            fontSize: 14, color: Colors.grey),
                                      ),
                                      Text(
                                        "NGN 20,000",
                                        style: TextStyle(
                                          fontSize: 14,
                                          color: Colors.orange,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    ],
                                  ),
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      const Text(
                                        "Total Savings",
                                        style: TextStyle(
                                            fontSize: 14, color: Colors.grey),
                                      ),
                                      Text(
                                        "NGN 100,000,000",
                                        style: TextStyle(
                                          fontSize: 14,
                                          color: baseColor,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    ],
                                  ),
                                ]),
                            const SizedBox(height: 20),
                            Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  if (widget.plans == "Mortgage" ||
                                      widget.plans == "Construction Finance")
                                    ElevatedButton(
                                      onPressed: () {
                                        showSuccessPopup(context);
                                      },
                                      style: ElevatedButton.styleFrom(
                                        foregroundColor: Colors
                                            .deepPurple, // text color if needed
                                        backgroundColor: Colors
                                            .transparent, // remove background color
                                        shadowColor: Colors
                                            .transparent, // remove shadow if needed
                                        side: BorderSide(
                                            color: baseColor,
                                            width: 2), // border
                                        shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(20),
                                        ),
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: 15, vertical: 8),
                                      ),
                                      child: Text(
                                        "Withdraw",
                                        style: TextStyle(
                                            fontSize: 14, color: baseColor),
                                      ),
                                    ),
                                  if (widget.plans == "Rent-To-Own")
                                    Align(
                                      alignment: Alignment.center,
                                      child: ElevatedButton(
                                        onPressed: () {
                                          Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                builder: (context) =>
                                                    StatementOfAccount(
                                                        widget.plans),
                                              ));
                                        },
                                        style: ElevatedButton.styleFrom(
                                          backgroundColor: baseColor,
                                          shape: RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(20),
                                          ),
                                          padding: const EdgeInsets.only(
                                              left: 125,
                                              right: 125,
                                              top: 8,
                                              bottom: 8),
                                        ),
                                        child: const Text(
                                          "Pay Rent",
                                          style: TextStyle(
                                              fontSize: 14,
                                              color: Colors.white),
                                        ),
                                      ),
                                    ),
                                  if (widget.plans == "Mortgage" ||
                                      widget.plans == "Construction Finance")
                                    ElevatedButton(
                                      onPressed: () {
                                          Navigator.pushNamed(context, "/getAllcards");
                                      },
                                      style: ElevatedButton.styleFrom(
                                        backgroundColor: baseColor,
                                        shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(20),
                                        ),
                                        padding: const EdgeInsets.only(
                                            left: 15,
                                            right: 15,
                                            top: 5,
                                            bottom: 5),
                                      ),
                                      child: const Text(
                                        "Deposit",
                                        style: TextStyle(
                                            fontSize: 14, color: Colors.white),
                                      ),
                                    ),
                                ])
                          ],
                        ),
                      ),
                    ),

                    const SizedBox(height: 20),
                    // Other Features
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          FeatureCard(
                            icon: Icons.description,
                            label: "Statement of Account",
                            onPressed: () {
                              if (widget.plans != "Construction Finance") {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) =>
                                          StatementOfAccount(widget.plans),
                                    ));
                              }
                              if (widget.plans == "Construction Finance") {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) =>
                                          Constuction_StatementPage(
                                              widget.plans),
                                    ));
                              }
                            },
                          ),
                          FeatureCard(
                            icon: Icons.emoji_events,
                            label: "Referral Bonus",
                            onPressed: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => const Refer_Bonus(),
                                  ));
                            },
                          ),
                          FeatureCard(
                            icon: Icons.assessment,
                            label: "Term Sheet",
                            onPressed: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) =>
                                        Term_Sheets(widget.plans),
                                  ));
                            },
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 20),
                    // Investment Banner
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16),
                      child: GestureDetector(
                        onTap: () {
                          controller.fetchInvestmentDetails();
                          Navigator.pushNamed(context, "/investmentmore");
                        },
                        child: Container(
                          decoration: BoxDecoration(
                            color: Colors.indigo[300],
                            borderRadius: BorderRadius.circular(15),
                          ),
                          padding: const EdgeInsets.all(20),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Align(
                                alignment: Alignment.center,
                                child: Image.asset(
                                  Images.investment,
                                  width: 50,
                                  height: 50,
                                ),
                              ),
                              const Align(
                                alignment: Alignment.center,
                                child: Text(
                                  "Investment",
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white,
                                  ),
                                ),
                              ),
                              const SizedBox(height: 10),
                              const Align(
                                alignment: Alignment.center,
                                child: Text(
                                  "With as little as NGN 500,000 you can earn higher returns in real estate than in any other investments class and boost your chances of securing a mortgage faster.",
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                    fontSize: 14,
                                    color: Colors.white,
                                  ),
                                ),
                              )
                            ],
                          ),
                        ),
                      ),
                    ),

                    const SizedBox(height: 20),
                  ],
                ),
              ),
            )));
  }

  void showSuccessPopup(BuildContext context) {
    final _formKey = GlobalKey<FormState>();
    final List<String> bankList = [
      'Access Bank',
      'Citibank',
      'Ecobank Nigeria',
      'Fidelity Bank',
      'First Bank of Nigeria',
      'First City Monument Bank (FCMB)',
      'Guaranty Trust Bank (GTBank)',
      'Heritage Bank',
      'Jaiz Bank',
      'Keystone Bank',
      'Polaris Bank',
      'Providus Bank',
      'Stanbic IBTC Bank',
      'Standard Chartered Bank',
      'Sterling Bank',
      'Suntrust Bank',
      'Union Bank of Nigeria',
      'United Bank for Africa (UBA)',
      'Unity Bank',
      'Wema Bank',
      'Zenith Bank',
    ];
    final NumberFormat _formatter = NumberFormat('#,##0', 'en_US');

    showModalBottomSheet(
        context: context,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
        ),
        isScrollControlled: true,
        builder: (context) => FractionallySizedBox(
            heightFactor: 0.85,
            widthFactor: 0.98,
            child: SingleChildScrollView(
              child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Center(
                    child: Form(
                      key: _formKey,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const SizedBox(
                            height: 10,
                          ),
                          const Text(
                            'Withdraw',
                            style: TextStyle(
                                color: Colors.black,
                                fontSize: 18,
                                fontWeight: FontWeight.w800),
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                          const Text('Account Number'),
                          TextFormField(
                            controller: controller.accountNumber,
                            keyboardType: TextInputType.number,
                            maxLength: 10,
                            decoration: InputDecoration(
                              hintText: "Input Account Number",
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(100),
                              ),
                              counterText: '', // hides the character counter
                            ),
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Please enter account number';
                              } else if (value.length != 10) {
                                return 'Account number must be exactly 10 digits';
                              }
                              return null;
                            },
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          const Text('BVN'),
                          TextFormField(
                            controller: controller.bvn,
                            keyboardType: TextInputType.number,
                            maxLength: 11,
                            decoration: InputDecoration(
                              hintText: "Input BVN",
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(100),
                              ),
                              counterText:
                                  '', // hides the default character counter
                            ),
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Please enter BVN';
                              } else if (value.length != 11) {
                                return 'BVN must be exactly 11 digits';
                              }
                              return null;
                            },
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          const Text('Bank'),
                          DropdownButtonFormField<String>(
                            value: controller.bankName.text.isNotEmpty
                                ? controller.bankName.text
                                : null,
                            decoration: InputDecoration(
                              // labelText: "Select Bank",
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(100),
                              ),
                              contentPadding: const EdgeInsets.symmetric(
                                  horizontal: 16, vertical: 20),
                            ),
                            isExpanded: true,
                            hint: const Text("Select Bank"),
                            items: bankList.map((String bank) {
                              return DropdownMenuItem<String>(
                                value: bank,
                                child: Text(bank),
                              );
                            }).toList(),
                            onChanged: (value) {
                              controller.bankName.text = value ?? '';
                            },
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Please select a Bank Name';
                              }
                              return null;
                            },
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          const Text('Amount'),
                          TextFormField(
                            controller: controller.amount,
                            keyboardType: TextInputType.number,
                            decoration: InputDecoration(
                              hintText: "Input Amount",
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(100),
                              ),
                              prefix: const Padding(
                                padding: EdgeInsets.only(right: 8),
                                child: Text(
                                  'NGN',
                                  style: TextStyle(fontWeight: FontWeight.bold),
                                ),
                              ),
                            ),
                            onChanged: (value) {
                              String cleaned = value.replaceAll(',', '');
                              if (cleaned.isEmpty) {
                                controller.amount.text = '0';
                              } else {
                                final number = int.tryParse(cleaned);
                                if (number != null) {
                                  final newText = _formatter.format(number);
                                  controller.amount.value = TextEditingValue(
                                    text: newText,
                                    selection: TextSelection.collapsed(
                                        offset: newText.length),
                                  );
                                }
                              }
                            },
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Please enter an amount';
                              }
                              final number =
                                  int.tryParse(value.replaceAll(',', ''));
                              if (number == null) {
                                return 'Please enter a valid number';
                              }
                              return null;
                            },
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          const Text('Repayment Date'),
                          TextFormField(
                            controller: controller.repaymentDate,
                            readOnly: true, // Prevent manual text input
                            decoration: InputDecoration(
                              // labelText: 'NIN',
                              hintText: 'Select Date',
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(100),
                              ),
                            ),
                            onTap: () async {
                              DateTime today = DateTime.now();
                              DateTime? pickedDate = await showDatePicker(
                                context: context,
                                initialDate: today,
                                firstDate: DateTime(today.year, today.month,
                                    today.day), // disables past dates
                                lastDate: DateTime(2100),
                              );

                              if (pickedDate != null) {
                                // Convert DateTime to String and assign to TextEditingController
                                controller.repaymentDate.text =
                                    "${pickedDate.day.toString().padLeft(2, '0')}-${pickedDate.month.toString().padLeft(2, '0')}-${pickedDate.year}";
                              }
                            },

                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Please select a repayment date';
                              }
                              return null;
                            },
                          ),
                          const SizedBox(height: 30),
                          Center(
                            child: ElevatedButton(
                              onPressed: () {
                                if (_formKey.currentState!.validate()) {
                                  showWithdrawDetailsPopup(context);
                                  // Navigator.pop(context);
                                }
                              },
                              style: ElevatedButton.styleFrom(
                                backgroundColor: baseColor,
                                padding: const EdgeInsets.symmetric(
                                    vertical: 16, horizontal: 140),
                              ),
                              child: const Text(
                                'Proceed',
                                style: TextStyle(
                                    fontSize: 16, color: Colors.white),
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                  )),
            )));
  }

  void showWithdrawDetailsPopup(BuildContext context) {
    showModalBottomSheet(
        context: context,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
        ),
        isScrollControlled: true,
        builder: (context) => FractionallySizedBox(
              heightFactor: 0.6,
              child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Align(
                          alignment: Alignment.bottomLeft,
                          child: Text(
                            "Bank Details",
                            textAlign: TextAlign.right,
                            style: TextStyle(
                                color: Colors.black,
                                fontSize: 16,
                                fontWeight: FontWeight.w900),
                          ),
                        ),
                        const SizedBox(height: 10),
                        Container(
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(15),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black.withOpacity(0.1),
                                blurRadius: 10,
                                offset: const Offset(0, 5),
                              ),
                            ],
                          ),
                          padding: const EdgeInsets.all(16),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  const Text(
                                    "Account Name",
                                    style: TextStyle(
                                        color: Colors.grey, fontSize: 12),
                                  ),
                                  Obx(() => Text(
                                        ' ${controller.profileName.value} ${controller.lastName.value}',
                                        style: const TextStyle(
                                          fontSize: 14,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      )),
                                ],
                              ),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  const Text(
                                    "Account Number",
                                    style: TextStyle(
                                        color: Colors.grey, fontSize: 12),
                                  ),
                                  Text(
                                    controller.accountNumber.text,
                                    style: const TextStyle(
                                        color: Colors.black,
                                        fontSize: 14,
                                        fontWeight: FontWeight.w800),
                                  )
                                ],
                              ),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  const Text(
                                    "Bank Name",
                                    style: TextStyle(
                                        color: Colors.grey, fontSize: 12),
                                  ),
                                  Text(
                                    controller.bankName.text,
                                    style: const TextStyle(
                                        color: Colors.black,
                                        fontSize: 14,
                                        fontWeight: FontWeight.w800),
                                  )
                                ],
                              )
                            ],
                          ),
                        ),
                        const SizedBox(height: 10),
                        const Align(
                          alignment: Alignment.bottomLeft,
                          child: Text(
                            "Withdrawal",
                            textAlign: TextAlign.right,
                            style: TextStyle(
                                color: Colors.black,
                                fontSize: 16,
                                fontWeight: FontWeight.w900),
                          ),
                        ),
                        const SizedBox(height: 10),
                        Container(
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(15),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black.withOpacity(0.1),
                                blurRadius: 10,
                                offset: const Offset(0, 5),
                              ),
                            ],
                          ),
                          padding: const EdgeInsets.all(16),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  const Text(
                                    "Withdrawal Amount",
                                    style: TextStyle(
                                        color: Colors.grey, fontSize: 12),
                                  ),
                                  Text(
                                    "NGN ${controller.amount.text}",
                                    style: const TextStyle(
                                        color: Colors.black,
                                        fontSize: 14,
                                        fontWeight: FontWeight.w800),
                                  )
                                ],
                              ),
                              const Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    "Charges",
                                    style: TextStyle(
                                        color: Colors.grey, fontSize: 12),
                                  ),
                                  Text(
                                    "10%",
                                    style: TextStyle(
                                        color: Colors.black,
                                        fontSize: 14,
                                        fontWeight: FontWeight.w800),
                                  )
                                ],
                              ),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  const Text(
                                    "Disbursment Date",
                                    style: TextStyle(
                                        color: Colors.grey, fontSize: 12),
                                  ),
                                  Text(
                                    controller.repaymentDate.text,
                                    style: const TextStyle(
                                        color: Colors.black,
                                        fontSize: 14,
                                        fontWeight: FontWeight.w800),
                                  )
                                ],
                              ),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  const Text(
                                    "Repayment Date",
                                    style: TextStyle(
                                        color: Colors.grey, fontSize: 12),
                                  ),
                                  Text(
                                    controller.repaymentDate.text,
                                    style: const TextStyle(
                                        color: Colors.black,
                                        fontSize: 14,
                                        fontWeight: FontWeight.w800),
                                  ),
                                ],
                              ),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  const Text(
                                    "Disbursed Amount",
                                    style: TextStyle(
                                        color: Colors.black,
                                        fontSize: 12,
                                        fontWeight: FontWeight.w900),
                                  ),
                                  Text(
                                    'NGN ${controller.amount.text}',
                                    style: const TextStyle(
                                      color: Colors.black,
                                      fontSize: 14,
                                      fontWeight: FontWeight.w900,
                                    ),
                                  )
                                ],
                              )
                            ],
                          ),
                        ),
                        const SizedBox(height: 25),
                        ElevatedButton(
                          onPressed: () async {
                            // Navigator.pop(context);
                            final success = await controller.withdraw(context);
                            if (success) {
                              // ignore: use_build_context_synchronously
                              showwithdrawSuccessPopup(context);
                            } else {
                              // Optionally show error
                              // ignore: use_build_context_synchronously
                              ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(
                                    content: Text("Withdrawal failed")),
                              );
                            }
                          },
                          //
                          style: ElevatedButton.styleFrom(
                            backgroundColor: baseColor,
                            minimumSize: const Size.fromHeight(50),
                          ),
                          child: const Text(
                            "Proceed",
                            style: TextStyle(
                                color: Colors.white, letterSpacing: 2),
                          ),
                        ),
                      ],
                    ),
                  )),
            ));
  }

  void showwithdrawSuccessPopup(BuildContext context) {
    showModalBottomSheet(
        context: context,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
        ),
        isScrollControlled: true,
        builder: (context) => FractionallySizedBox(
              heightFactor: 0.5,
              child: Padding(
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
                          "Withdrawal Successful",
                          style: TextStyle(
                              fontSize: 20, fontWeight: FontWeight.w600),
                        ),
                        
                        const SizedBox(height: 20),
                        ElevatedButton(
                          onPressed: () {
                            Navigator.pushNamed(context, "/mainDashboard",
                                arguments: widget.plans);
                          },
                          //
                          style: ElevatedButton.styleFrom(
                            backgroundColor: baseColor,
                            minimumSize: const Size.fromHeight(50),
                          ),
                          child: const Text(
                            "Proceed",
                            style: TextStyle(
                                color: Colors.white, letterSpacing: 2),
                          ),
                        ),
                      ],
                    ),
                  )),
            ));
  }
}

class FeatureCard extends StatelessWidget {
  final IconData icon;
  final String label;
  final VoidCallback onPressed; // Callback for tap action

  const FeatureCard({
    Key? key,
    required this.icon,
    required this.label,
    required this.onPressed, // Require onPressed in constructor
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPressed, // Trigger the callback when the card is tapped
      child: Container(
        width: 100,
        height: 100,
        decoration: BoxDecoration(
          color: Colors.indigo[100],
          borderRadius: BorderRadius.circular(15),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.1),
              blurRadius: 10,
              offset: const Offset(0, 5),
            ),
          ],
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(icon, size: 30, color: baseColor),
            const SizedBox(height: 10),
            Text(
              label,
              style: const TextStyle(fontSize: 12, color: Colors.black),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
}

class GaugeChartWidget extends StatelessWidget {
  final Map<String, dynamic> data;

  final String plans;

  const GaugeChartWidget({Key? key, required this.data, required this.plans})
      : super(key: key);

  Color hexToColor(String code) {
    return Color(int.parse(code.substring(1, 7), radix: 16) + 0xFF000000);
  }

  @override
  Widget build(BuildContext context) {
    List<dynamic> colors = data["creditScoreColor"];

    return Container(
      padding: const EdgeInsets.all(10),
      width: 400,
      height: 250,
      decoration: BoxDecoration(
        color: baseColor,
        borderRadius: BorderRadius.circular(1),
      ),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    "Current Plan:",
                    textAlign: TextAlign.left,
                    style: TextStyle(
                      fontSize: 14,
                      color: Colors.white,
                      fontWeight: FontWeight.w900,
                      letterSpacing: 1,
                    ),
                  ),
                  Text(
                    "KWIK $plans",
                    textAlign: TextAlign.left,
                    style: const TextStyle(
                      fontSize: 18,
                      color: Colors.white,
                      fontWeight: FontWeight.w900,
                    ),
                  ),
                ],
              ),
              Row(
                children: [
                  const Icon(
                    Icons.timer, // Timer icon
                    size: 16,
                    color: Colors.white,
                  ),
                  const SizedBox(width: 4), // Spacing between icon and text
                  Text(
                    "${data["currentPlanDuration"] ?? ''}",
                    style: const TextStyle(
                      fontSize: 14,
                      color: Colors.white,
                      fontWeight: FontWeight.w900,
                    ),
                  ),
                ],
              )
            ],
          ),
          const SizedBox(height: 20),
          SizedBox(
            width: MediaQuery.of(context).size.width * 0.9,
            height: 150,
            child: SfRadialGauge(
              axes: <RadialAxis>[
                RadialAxis(
                  startAngle: 180,
                  endAngle: 0,
                  minimum: 0,
                  maximum: 100,
                  showLabels: false,
                  showTicks: false,
                  ranges: [
                    for (int i = 0; i < colors.length; i++)
                      GaugeRange(
                        startValue:
                            i == 0 ? 0 : colors[i - 1]['percentage'].toDouble(),
                        endValue: colors[i]['percentage'].toDouble(),
                        color: hexToColor(colors[i]['color']),
                        startWidth: 10,
                        endWidth: 10,
                      )
                  ],
                  pointers: <GaugePointer>[
                    NeedlePointer(
                      enableAnimation: true,
                      value: double.tryParse(data["creditScore"] ?? "0") ?? 0,
                      needleColor: Colors.white,
                      needleLength: 0.5,
                      needleStartWidth: 1,
                      needleEndWidth: 5,
                      knobStyle: const KnobStyle(
                        color: Colors.black,
                        borderColor: Colors.white,
                        borderWidth: 0.06,
                      ),
                    ),
                  ],
                  annotations: <GaugeAnnotation>[
                    GaugeAnnotation(
                      widget: Container(
                          padding: const EdgeInsets.symmetric(
                              vertical: 5, horizontal: 10),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(15),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.symmetric(
                                vertical: 5, horizontal: 10),
                            child: Text(
                              data["creditScore"] ?? '',
                              style: TextStyle(
                                fontSize: 16,
                                color: Colors.blue[900],
                                fontWeight: FontWeight.w900,
                              ),
                            ),
                          )),
                      angle: 90,
                      positionFactor: 0.8,
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

void showSuccessPopup(BuildContext context) {
  showModalBottomSheet(
      context: context,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
      ),
      isScrollControlled: true,
      builder: (context) => FractionallySizedBox(
            heightFactor: 0.5,
            child: Padding(
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
                        style: TextStyle(
                            fontSize: 20, fontWeight: FontWeight.w600),
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
                              builder: (context) => const DashboardPageS(
                                  ''), // Start with MortgagePage
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
                          style:
                              TextStyle(color: Colors.white, letterSpacing: 2),
                        ),
                      ),
                    ],
                  ),
                )),
          ));
}

class InvestmentItem {
  final int id;
  final int customerId;
  final String customerName;
  final double amountInvested;
  final String duration;
  final String startDate;
  final double interestPercentage;
  final String maturityDate;
  final double maturityAmount;
  final String status;

  InvestmentItem({
    required this.id,
    required this.customerId,
    required this.customerName,
    required this.amountInvested,
    required this.duration,
    required this.startDate,
    required this.interestPercentage,
    required this.maturityDate,
    required this.maturityAmount,
    required this.status,
  });

  factory InvestmentItem.fromJson(Map<String, dynamic> json) {
    return InvestmentItem(
      id: json['id'],
      customerId: json['customerId'],
      customerName: json['customerName'],
      amountInvested: json['amountInvested'].toDouble(),
      duration: json['duration'],
      startDate: json['startDate'],
      interestPercentage: json['interestPercentage'].toDouble(),
      maturityDate: json['maturityDate'],
      maturityAmount: json['maturityAmount'].toDouble(),
      status: json['status'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'customerId': customerId,
      'customerName': customerName,
      'amountInvested': amountInvested,
      'duration': duration,
      'startDate': startDate,
      'interestPercentage': interestPercentage,
      'maturityDate': maturityDate,
      'maturityAmount': maturityAmount,
      'status': status,
    };
  }
}
