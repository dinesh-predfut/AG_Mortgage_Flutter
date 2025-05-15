import 'dart:math';

import 'package:ag_mortgage/All_Cards/Get_all_Cards/all_cards.dart';
import 'package:ag_mortgage/Dashboard_Screen/Construction/controller.dart';
import 'package:ag_mortgage/Dashboard_Screen/Construction/models.dart';
import 'package:ag_mortgage/Dashboard_Screen/Market_Place/main.dart';
import 'package:ag_mortgage/Dashboard_Screen/Mortgage/MortgageHome.dart';
import 'package:ag_mortgage/Dashboard_Screen/dashboard_Screen.dart';
import 'package:ag_mortgage/Main_Dashboard/Mortgage/Withdraw/controller.dart';
import 'package:ag_mortgage/Main_Dashboard/dashboard/Dashboard/component.dart';
import 'package:ag_mortgage/const/Image.dart';
import 'package:ag_mortgage/const/colors.dart';
import 'package:ag_mortgage/const/constant.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:intl/intl.dart';
// ignore: depend_on_referenced_packages
import 'package:table_calendar/table_calendar.dart';

import '../../const/commanFunction.dart';
import '../Market_Place/Details_Page/models.dart';

class ConstructionPage extends StatefulWidget {
  final int startIndex;
  const ConstructionPage({super.key, this.startIndex = 0});
  @override
  // ignore: library_private_types_in_public_api
  _ConstructionPageState createState() => _ConstructionPageState();
}

class _ConstructionPageState extends State<ConstructionPage> {
  int _currentStepIndex = 0;
  @override
  void initState() {
    super.initState();
    _currentStepIndex = widget.startIndex; // Initialize with provided index
  }

  final List<Widget> _steps = [
    const Construction_Landing(),
    const ConstuctionFormPage(),
    const ConstructionFinancePage(),
    const Construction_CalendarPage(),
    const TermSheetPage(),
    const PaymentMethodPage(),
    const Sucesss(),
    const Construction_CalendarPage(),
    const TermSheetPage(),
    const BankTransferPage(),
    const TermsAndConditionsDialog(),
  ];

  void _goToNextStep() {
    setState(() {
      if (_currentStepIndex < _steps.length - 1) {
        _currentStepIndex++;
      }
    });
  }

  void _goTomConstuctionFormPage() {
    setState(() {
      if (_currentStepIndex > 0) {
        _currentStepIndex--;
      }
    });
  }

  void _goToPreviousStep() {
    setState(() {
      if (_currentStepIndex > 0) {
        _currentStepIndex--;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Expanded(
            child: _steps[_currentStepIndex],
          ),
        ],
      ),
    );
  }
}

// Chain of Components for Mortgage
// ignore: camel_case_types
class Construction_Landing extends StatelessWidget {
  const Construction_Landing({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                  builder: (context) =>
                      const DashboardPage()), // Start with MortgagePage
            );
          },
        ),
        backgroundColor: Colors.white,
        elevation: 0,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            // Image Section
            Container(
              margin: const EdgeInsets.all(16.0),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(16.0),
                child: Image.asset(
                  Images.constraction_Landing, // Replace with your asset path
                  fit: BoxFit.cover,
                  width: 260,
                  height: 260,
                ),
              ),
            ),
            // Title Section
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 16.0),
              child: Text(
                "Construction Finance",
                style: TextStyle(
                    fontSize: 24.0,
                    fontWeight: FontWeight.bold,
                    color: Color.fromARGB(255, 5, 55, 131)),
                textAlign: TextAlign.center,
              ),
            ),
            const SizedBox(height: 8.0),
            // Description Section
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Text(
                "Secure the financing you need to complete your housing project with AG Construction Bank.",
                style: TextStyle(fontSize: 16.0, color: Colors.grey[700]),
                textAlign: TextAlign.center,
              ),
            ),
            const SizedBox(height: 16.0),
            // Requirements Section

            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Align(
                    alignment: Alignment.center,
                    child: Text(
                      "Requirements",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 18.0,
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                      ),
                    ),
                  ),
                  SizedBox(height: 8.0),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Icon(Icons.check, color: Colors.indigo),
                          SizedBox(width: 6.0),
                          Expanded(
                            child: Text(
                              "Complete and verifiable registered deed of Assignment or Certificate of Occupancy",
                              style: TextStyle(fontSize: 12),
                              overflow: TextOverflow.visible,
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 8.0),
                      Row(
                        children: [
                          Icon(Icons.check, color: Colors.indigo),
                          SizedBox(width: 6.0),
                          Expanded(
                            child: Text(
                              "Building Approval Certificate",
                              style: TextStyle(fontSize: 12),
                              overflow: TextOverflow.visible,
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 8.0),
                      Row(
                        children: [
                          Icon(Icons.check, color: Colors.indigo),
                          SizedBox(width: 6.0),
                          Expanded(
                            child: Text(
                              "All Professional Approvals: Architectural, Mechanical & Electrical",
                              overflow: TextOverflow.visible,
                              style: TextStyle(fontSize: 12),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 8.0),
                      Row(
                        children: [
                          Icon(Icons.check, color: Colors.indigo),
                          SizedBox(width: 6.0),
                          Expanded(
                            child: Text(
                              "Bills and Qualities Prepared by Certified Professionals",
                              overflow: TextOverflow.visible,
                              style: TextStyle(fontSize: 12),
                            ),
                          ),
                        ],
                      ),
                    ],
                  )
                ],
              ),
            ),

            const SizedBox(height: 16.0),
            // Apply Button
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: baseColor,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30.0),
                  ),
                  padding: const EdgeInsets.symmetric(vertical: 16.0),
                ),
                onPressed: () {
                  Navigator.pushNamed(context, "/construction/term_condition");
                },
                child: const Center(
                  child: Text(
                    "Apply",
                    style: TextStyle(fontSize: 16.0, color: Colors.white),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
      backgroundColor: Colors.white,
    );
  }
}

class ConstuctionFormPage extends StatefulWidget {
  // final Houseview? house;
  final bool? viewBtn;

  const ConstuctionFormPage({
    Key? key,
    // this.house,
    this.viewBtn,
  }) : super(key: key);

  @override
  _ConstuctionFormPageState createState() => _ConstuctionFormPageState();
}

class _ConstuctionFormPageState extends State<ConstuctionFormPage> {
  final controller = Get.put(ContructionController());
  ContructionController controllerFeild = ContructionController();

  @override
  void initState() {
    super.initState();
    // calculateMonthlyRental();
    calculateEMIAmountValue();
    controller.updateEMI();
  }

  final _formKey = GlobalKey<FormState>();
// Default value for slider
  double interestRate = 18; // Annual interest rate in percentage
  String formattedEMI(double amount) {
    // Format the number with international commas (thousands separators)
    final numberFormatter = NumberFormat(
        '#,###.##', 'en_US'); // en_US for international comma formatting
    return numberFormatter.format(amount);
  }

  // void calculateMonthlyRental() {
  //   if (controller.selectedLoan.value == null) {
  //     print("No loan selected");
  //     return;
  //   }

  //   final loan = controller.selectedLoan.value;

  //   final double initialDeposit =
  //       (double.tryParse(controller.downPayment.text.replaceAll(',', '')) ?? 0);
  //   final double loanAmount = (double.tryParse(
  //               controller.propertyValueController.text.replaceAll(',', '')) ??
  //           0) -
  //       (double.tryParse(controller.downPayment.text.replaceAll(',', '')) ?? 0);
  //   print("Nosloan selected${loanAmount.toString()}");

  //   final double financeInterestPercentage = loan!.financeInterest / 100;
  //   final double depositScreeningInterestPercentage =
  //       loan.depositScreeningInterest / 100;
  //   final int screeningPeriod = loan.screeningPeriod;
  //   final double profitPercentage = loan.profit / 100;

  //   final double interestOnSecurityDeposit =
  //       (initialDeposit * depositScreeningInterestPercentage) / screeningPeriod;

  //   final double interestOnFinanceAmount =
  //       (loanAmount * financeInterestPercentage) / screeningPeriod;

  //   final double profit =
  //       (interestOnFinanceAmount + interestOnSecurityDeposit) *
  //           profitPercentage;

  //   final double monthlyRental =
  //       interestOnSecurityDeposit + interestOnFinanceAmount + profit;
  //   // Update formData with the calculated monthly rent
  //   controller.monthlyRendal.text = formattedEMI(monthlyRental);

  //   print("Interest on Security Deposit: $interestOnSecurityDeposit");
  //   print("Interest on Finance Amount: $interestOnFinanceAmount");
  //   print("Profit: $profit");
  //   print("Monthly Rent: $monthlyRental");
  // }

  void calculateEMIAmountValue() {
    double loanAmount =
        double.tryParse(controller.estimatedAmount.text.replaceAll(',', '')) ??
            0.0;
    double completion =
        double.tryParse(controller.completionAmount.text.replaceAll(',', '')) ??
            0.0;
    int emiTenureInMonth = (controller.sliderValue * 12).toInt();
    // ignore: non_constant_identifier_names
    final FinalEMi = calculateEMIAmount(loanAmount, emiTenureInMonth);
    controller.monthlyRepaymentController.text = formattedEMI(FinalEMi);
    updateControllerText(controller.completionAmount, formattedEMI(completion));
    updateControllerText(controller.estimatedAmount, formattedEMI(loanAmount));
  }

  // void handleInputChange(String name, String value) {
  //   double numericValue = double.tryParse(value.replaceAll(',', '')) ?? 0.0;

  //   if (name == 'estimatedPropertyValue') {
  //     num calculatedInitialDeposit = (0.40 * numericValue)
  //         .clamp(controller.downPayment.text as num, double.infinity);

  //     double loanAmount = numericValue - calculatedInitialDeposit;

  //     if (!numericValue.isNaN) {
  //       controller.propertyValueController.text = numericValue.toString();
  //       controller.downPayment.text = calculatedInitialDeposit.toString();
  //       controller.loanAmount.value = loanAmount as TextEditingValue;
  //     } else {
  //       controller.propertyValueController.text = 0.0.toString();
  //       controller.downPayment.text = 0.0.toString();
  //       controller.monthlyRepaymentController.text = 0.0.toString();
  //     }
  //   } else if (name == 'initialDeposit') {
  //     double estimatedValue = controller.propertyValueController.text as double;
  //     double fourtyPercent = estimatedValue * 0.40;

  //     double newLoanAmount =
  //         (numericValue > estimatedValue) ? 0.0 : estimatedValue - numericValue;

  //     controller.downPayment.text = numericValue.toString();
  //     controller.loanAmount.value = newLoanAmount as TextEditingValue;
  //   } else {
  //     controller.updateField(name, value);
  //   }
  // }

  double calculateEMIAmount(double loanAmount, int tenureMonths) {
    const double yearlyInterest = 25;
    const double monthlyRate = yearlyInterest / 12 / 100;

    if (monthlyRate == 0) {
      return loanAmount / tenureMonths;
    }

    final double emi =
        (loanAmount * monthlyRate * (pow(1 + monthlyRate, tenureMonths))) /
            (pow(1 + monthlyRate, tenureMonths) - 1);

    return double.parse(
        emi.toStringAsFixed(2)); // Round off to 2 decimal places
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Construction Finance',
          style: TextStyle(color: baseColor, fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Form(
            key: _formKey,
            child:
                Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              const Center(
                child: Text(
                  'Let us know about your Housing Project',
                  style: TextStyle(fontSize: 16, color: Colors.grey),
                ),
              ),

              const SizedBox(height: 20),

              // City Dropdown
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text('City'),
                  FutureBuilder<List<PostsModel>>(
                    future: controller.getALLCityApi(),
                    builder: (context, citySnapshot) {
                      // Ensure data is not null
                      List<PostsModel> cityData = citySnapshot.data ?? [];

                      return DropdownButtonFormField<int>(
                        value: controller.selectedCity,
                        decoration: InputDecoration(
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(100),
                          ),
                        ),
                        isExpanded: true,
                        hint: const Text("Select  City"),
                        icon: const Icon(Icons.keyboard_arrow_down),
                        items: cityData.isNotEmpty
                            ? cityData.map((item) {
                                return DropdownMenuItem<int>(
                                  value: item.id,
                                  child: Text(item.name ?? 'Unknown Name'),
                                );
                              }).toList()
                            : [], // Prevents mapping on null

                        onChanged: (value) {
                          if (value != null) {
                            setState(() {
                              controller.selectedCity = value;
                              controller.fetchAreasByCity();
                              controller.selectedArea = null;
                            });
                            controller.findAndSetCity();
                          }
                        },
                        validator: (value) {
                          if (value == null) {
                            return 'Please select  city';
                          }
                          return null;
                        },
                      );
                    },
                  ),

                  const SizedBox(height: 10),
                  const Text('Area'),
// Area Dropdown
                  FutureBuilder<List<SeletArea>>(
                    future: controller.selectedCity != null
                        ? controller.fetchAreasByCity()
                        : Future.value(
                            []), // Provide an empty list if city is not selected
                    builder: (context, areaSnapshot) {
                      // Ensure data is never null
                      List<SeletArea> areaData = areaSnapshot.data ?? [];

                      return DropdownButtonFormField<int>(
                        value: controller.selectedArea,
                        decoration: InputDecoration(
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(100),
                          ),
                        ),
                        isExpanded: true,
                        hint: const Text("Select  Area"),
                        icon: const Icon(Icons.keyboard_arrow_down),
                        items: areaData.map((item) {
                          return DropdownMenuItem<int>(
                            value: item.id,
                            child: Text(item.name ?? 'Unknown Area'),
                          );
                        }).toList(),
                        onChanged: (value) {
                          if (value != null) {
                            setState(() {
                              controller.selectedArea = value;
                            });
                            controller.findAndSetArea();
                          }
                        },
                        validator: (value) =>
                            value == null ? 'Please Select area' : null,
                      );
                    },
                  ),
                  const SizedBox(height: 10),

                  // Estimated Property Value
                  // const Text('Estimated Property Value'),
                  // TextFormField(
                  //   controller: controller.propertyValueController,
                  //   keyboardType: TextInputType.number,
                  //   decoration: InputDecoration(
                  //     border: OutlineInputBorder(
                  //       borderRadius: BorderRadius.circular(100),
                  //     ),
                  //     prefix: const Padding(
                  //       padding: EdgeInsets.only(
                  //           right: 8), // Adds spacing between NGN and input
                  //       child: Text(
                  //         'NGN',
                  //         style: TextStyle(fontWeight: FontWeight.bold),
                  //       ),
                  //     ),
                  //   ),
                  //   onChanged: (value) {
                  //     calculateEMI();
                  //   },
                  //   validator: (value) {
                  //     if (value == null || value.trim().isEmpty) {
                  //       return 'Please enter the estimated property value';
                  //     }
                  //     return null;
                  //   },
                  // ),

                  // const SizedBox(height: 10),

                  // // Initial Deposit
                  // const Text('Down Payment'),
                  // TextFormField(
                  //   controller: controller.downPayment,
                  //   onChanged: (value) {
                  //     calculateEMI();
                  //   },
                  //   keyboardType: TextInputType.number,
                  //   decoration: InputDecoration(
                  //     border: OutlineInputBorder(
                  //       borderRadius: BorderRadius.circular(100),
                  //     ),
                  //     prefix: const Padding(
                  //       padding: EdgeInsets.only(
                  //           right: 8), // Adds spacing between NGN and input
                  //       child: Text(
                  //         'NGN',
                  //         style: TextStyle(fontWeight: FontWeight.bold),
                  //       ),
                  //     ),
                  //   ),
                  // ),
                  // const SizedBox(height: 10),r
                  const Text('Type of Construction'),
                  FutureBuilder<List<LoanModel>>(
                    future: controller.getScreeningPeriodsApi(),
                    builder: (context, snapshot) {
                      List<LoanModel> loanData = snapshot.data ?? [];

                      // Reset selectedLoan to null if it is not in loanData
                      if (!loanData.contains(controller.selectedLoan.value)) {
                        controller.selectedLoan.value = null;
                      }

                      return DropdownButtonFormField<LoanModel>(
                        value: controller.selectedLoan.value,
                        decoration: InputDecoration(
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(100),
                          ),
                        ),
                        isExpanded: true,
                        hint: const Text(
                            "Select  Plan"), // Display hint when no value is selected
                        icon: const Icon(Icons.keyboard_arrow_down),
                        items: loanData.map((LoanModel loan) {
                          return DropdownMenuItem<LoanModel>(
                            value: loan,
                            child: Text(loan.typeName.toString()),
                          );
                        }).toList(),
                        onChanged: (value) {
                          if (value != null) {
                            controller.selectedLoan.value = value;
                            controller.interestRate = value.mortgageInterest;
                            controller.screenPeriod = value.profilingPeriod;
                          }
                        },
                        validator: (value) {
                          if (value == null) {
                            return 'Please Select  Construction ';
                          }
                          return null;
                        },
                      );
                    },
                  ),

                  // const Text('Type of Construction'),
                  // FutureBuilder<List<LoanModel>>(
                  //   future: controller.getScreeningPeriodsApi(),
                  //   builder: (context, snapshot) {
                  //     List<LoanModel> loanData = snapshot.data ?? [];

                  //     return DropdownButtonFormField<LoanModel>(
                  //       value: loanData.firstWhere(
                  //         (loan) =>
                  //             loan.id == controller.selectedLoan.value?.id,
                  //         orElse: () =>
                  //             loanData.first, // Ensure valid selection
                  //       ),
                  //       decoration: InputDecoration(
                  //         border: OutlineInputBorder(
                  //           borderRadius: BorderRadius.circular(100),
                  //         ),
                  //       ),
                  //       isExpanded: true,
                  //       icon: const Icon(Icons.keyboard_arrow_down),
                  //       items: loanData.map((LoanModel loan) {
                  //         return DropdownMenuItem<LoanModel>(
                  //           value: loan,
                  //           child: Text(loan.typeName),
                  //         );
                  //       }).toList(),
                  //       onChanged: (LoanModel? value) {
                  //         if (value != null) {
                  //           controller.selectedLoan.value = value;
                  //           controller.interestRate = value.mortgageInterest;
                  //           controller.screenPeriod = value.profilingPeriod;

                  //           // calculateMonthlyRental();
                  //           print("Selected Loan: ${controller.interestRate}");
                  //         }
                  //       },
                  //       validator: (value) {
                  //         if (value == null) {
                  //           return 'Please Select  screening period';
                  //         }
                  //         return null;
                  //       },
                  //     );
                  //   },
                  // ),

                  const SizedBox(height: 10),
                  const Text('Stage of Development'),
                  DropdownButtonFormField<int>(
                    value: controller.selectedStage, // Selected value
                    decoration: InputDecoration(
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(
                            50), // Rounded-full equivalent
                      ),
                    ),
                    hint: const Text("Select  Stage"),
                    isExpanded: true,
                    items: const [
                      DropdownMenuItem<int>(
                        value: 1,
                        child: Text("Foundation"),
                      ),
                      DropdownMenuItem<int>(
                        value: 2,
                        child: Text("Lockup"),
                      ),
                      DropdownMenuItem<int>(
                        value: 3,
                        child: Text("Framing"),
                      ),
                      DropdownMenuItem<int>(
                        value: 4,
                        child: Text("Exterior Finishes"),
                      ),
                      DropdownMenuItem<int>(
                        value: 5,
                        child: Text("Electrical and Plumbing"),
                      ),
                    ],
                    onChanged: (int? newValue) {
                      if (newValue != null) {
                        setState(() {
                          controller.selectedStage = newValue;
                        });
                      }
                    },
                    validator: (value) =>
                        value == null ? "Please Select  stage" : null,
                  ),

                  const SizedBox(height: 10),
                  const Text('Estimated Amount Spent So Far'),
                  TextFormField(
                    controller: controller.estimatedAmount,
                    keyboardType: TextInputType.number,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(100),
                      ),
                      prefix: const Padding(
                        padding: EdgeInsets.only(
                            right: 8), // Adds spacing between NGN and input
                        child: Text(
                          'NGN',
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                      ),
                    ),
                    onChanged: (value) {
                      calculateEMIAmountValue();
                    },
                    validator: (value) {
                      if (value == null || value.trim().isEmpty) {
                        return 'Please enter the estimated Amount value';
                      }
                      return null;
                    },
                  ),
                  const Text('Estimated Completion Amount'),
                  TextFormField(
                    controller: controller.completionAmount,
                    keyboardType: TextInputType.number,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(100),
                      ),
                      prefix: const Padding(
                        padding: EdgeInsets.only(
                            right: 8), // Adds spacing between NGN and input
                        child: Text(
                          'NGN',
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                      ),
                    ),
                    onChanged: (value) {
                      calculateEMIAmountValue();
                    },
                    validator: (value) {
                      if (value == null || value.trim().isEmpty) {
                        return 'Please Estimated Completion Amount value';
                      }
                      return null;
                    },
                  ),

                  const SizedBox(height: 10),

                  // Initial Deposit

                  const Text('Select Loan Repayment Period'),
                  Slider(
                    value: controller.sliderValue,
                    min: 1,
                    max: 20,
                    divisions: 19,
                    label: '${controller.sliderValue.toInt()} Years',
                    onChanged: (value) {
                      setState(() {
                        controller.sliderValue = value; // Update slider value
                        // calculateEMIAmountValue();
                        controller.updateEMI();
                      });
                    },
                  ),
                  const Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        '0',
                        style: TextStyle(
                            fontSize: 16, fontWeight: FontWeight.bold),
                      ),
                      Text(
                        '10',
                        style: TextStyle(
                            fontSize: 16, fontWeight: FontWeight.bold),
                      ),
                      Text(
                        '20',
                        style: TextStyle(
                            fontSize: 16, fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                  const SizedBox(height: 10),

                  // Repayment Period
                  const Text(
                    'Repayment Period',
                    style: TextStyle(fontSize: 16),
                  ),
                  SizedBox(
                    width: double.infinity,
                    child: Container(
                      padding: const EdgeInsets.all(20),
                      decoration: BoxDecoration(
                        color: const Color.fromRGBO(252, 251, 255, 1),
                        border: Border.all(color: Colors.grey),
                        borderRadius: BorderRadius.circular(100),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.1),
                            blurRadius: 8,
                            offset: const Offset(0, 4),
                          ),
                        ],
                      ),
                      child: Text(
                        '${controller.sliderValue.toInt()} Years', // Dynamically update the text
                        textAlign: TextAlign.center,
                        style: const TextStyle(fontSize: 18),
                      ),
                    ),
                  ),
                  const SizedBox(height: 10),

                  // Monthly Repayment
                  const Text('Monthly Repayment'),
                  TextFormField(
                    controller: controller.monthlyRepaymentController,
                    keyboardType: TextInputType.number,
                    readOnly: true,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(100),
                      ),
                      prefix: const Padding(
                        padding: EdgeInsets.only(
                            right: 8), // Adds spacing between NGN and input
                        child: Text(
                          'NGN',
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                      ),
                    ),
                    inputFormatters: [
                      FilteringTextInputFormatter.digitsOnly,
                      // Add comma formatting
                      TextInputFormatter.withFunction((oldValue, newValue) {
                        final newText = newValue.text.replaceAll(
                            RegExp(r'\D'), ''); // remove non-digit characters
                        final formattedText = controller.formatNumber(newText);
                        return newValue.copyWith(text: formattedText);
                      }),
                    ],
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter the monthly repayment amount';
                      }

                      final int enteredAmount =
                          int.tryParse(value.replaceAll(',', '')) ?? 0;

                      return null;
                    },
                  ),
                  const SizedBox(height: 30),

                  // Proceed Button
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed: () {
                        if (_formKey.currentState!.validate()) {
                          // Form is valid, proceed with the submission

                          Navigator.pushNamed(context,
                              "/construction/termsheet/permissionPage");
                        } else {
                          Fluttertoast.showToast(
                            msg: "Please fill in all mandatory fields",
                            toastLength: Toast.LENGTH_SHORT,
                            gravity: ToastGravity.BOTTOM,
                            backgroundColor: Colors.red,
                            textColor: Colors.white,
                          );
                        }
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: baseColor,
                        padding: const EdgeInsets.symmetric(vertical: 16),
                      ),
                      child: const Text(
                        'Proceed',
                        style: TextStyle(fontSize: 16, color: Colors.white),
                      ),
                    ),
                  ),
                ],
              ),
            ])),
      ),
    );
  }
}

class Construction_CalendarPage extends StatefulWidget {
  const Construction_CalendarPage({super.key});

  @override
  _Construction_CalendarPageState createState() =>
      _Construction_CalendarPageState();
}

class _Construction_CalendarPageState extends State<Construction_CalendarPage> {
  final controller = Get.put(ContructionController());

  DateTime _initialFocusedDay = DateTime.now();
  void _onBackPressed(BuildContext context) {
    // Custom logic for back navigation
    if (Navigator.of(context).canPop()) {
      Navigator.pushReplacementNamed(
        context,
        '/mortgageForm',
      );
    } else {
      // Show exit confirmation dialog if needed
      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: Text("Exit App"),
          content: Text("Do you want to exit the app?"),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: Text("No"),
            ),
            TextButton(
              onPressed: () => Navigator.of(context).pop(true),
              child: Text("Yes"),
            ),
          ],
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
        onWillPop: () async {
          // Handle custom back navigation logic
          _onBackPressed(context);
          return false; // Prevent default back behavior
        },
        child: Scaffold(
          appBar: AppBar(
            title: Text(
              'Repayment',
              style: TextStyle(color: baseColor, fontWeight: FontWeight.bold),
            ),
            centerTitle: true,
            leading: IconButton(
              icon: const Icon(Icons.arrow_back),
              onPressed: () {
                Navigator.pushReplacementNamed(
                  context,
                  '/mortgageForm',
                );
              },
            ),
          ),
          body: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                children: [
                  const Center(
                    child: Text(
                      'Set your repayment date',
                      style: TextStyle(fontSize: 14, color: Colors.grey),
                    ),
                  ),
                  const Center(
                    child: Text(
                      '(An anniversary date is your last day to receive your payment every month)',
                      style: TextStyle(fontSize: 8, color: Colors.grey),
                    ),
                  ),
                  const Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      "Your next repayment date is:",
                      style: TextStyle(fontSize: 15, height: 5),
                    ),
                  ),
                  Text(
                    controller.selectedDay != null
                        ? DateFormat('dd-MM-yyyy')
                            .format(controller.selectedDay!)
                        : '',
                    style: const TextStyle(fontSize: 25, color: Colors.black),
                  ),
                  TableCalendar(
                    focusedDay: controller.selectedDay ?? _initialFocusedDay,
                    firstDay: DateTime(2000),
                    lastDay: DateTime(2100),
                    selectedDayPredicate: (day) =>
                        controller.selectedDay != null &&
                        isSameDay(controller.selectedDay, day),
                    onDaySelected: (selectedDay, focusedDay) {
                      setState(() {
                        controller.selectedDay = selectedDay;
                      });
                    },
                    calendarStyle: CalendarStyle(
                      selectedDecoration: BoxDecoration(
                        color: Colors.amber[800],
                        shape: BoxShape.circle,
                      ),
                      todayDecoration: const BoxDecoration(
                        color: Colors.blue,
                        shape: BoxShape.circle,
                      ),
                      markerDecoration: const BoxDecoration(
                        color: Colors.orange,
                        shape: BoxShape.circle,
                      ),
                    ),
                    headerStyle: const HeaderStyle(
                      formatButtonVisible: false,
                      titleCentered: true,
                    ),
                  ),
                  const SizedBox(height: 16),
                  Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 20, vertical: 20),
                    child: ElevatedButton(
                      onPressed: () {
                        if (controller.selectedDay == null) {
                          Fluttertoast.showToast(
                            msg: "Please Select repayment date",
                            toastLength: Toast.LENGTH_SHORT,
                            gravity: ToastGravity.BOTTOM,
                            backgroundColor: Colors.red,
                            textColor: Colors.white,
                          );
                        } else {
                          Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                              builder: (context) =>
                                  const ConstructionPage(startIndex: 4),
                            ),
                          );
                        }
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: baseColor,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(30),
                        ),
                        minimumSize: const Size(200, 50),
                      ),
                      child: const Text(
                        "Proceed",
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ));
  }
}

class PaymentMethodPage extends StatefulWidget {
  const PaymentMethodPage({super.key});

  @override
  _PaymentMethodPageState createState() => _PaymentMethodPageState();
}

class _PaymentMethodPageState extends State<PaymentMethodPage> {
  String selectedPaymentMethod = "Card";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Payment",
          style: TextStyle(color: baseColor, fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              "How would you like to make your first deposit?",
              style: TextStyle(fontSize: 16),
            ),
            const SizedBox(height: 20),
            ListTile(
              leading: const Icon(Icons.account_balance),
              title: const Text("Bank Transfer"),
              trailing: Radio<String>(
                value: "Bank Transfer",
                groupValue: selectedPaymentMethod,
                onChanged: (value) {
                  setState(() {
                    selectedPaymentMethod = value!;
                  });
                },
              ),
            ),
            const Spacer(),
            ElevatedButton(
              onPressed: () {
                if (selectedPaymentMethod == "Bank Transfer") {
                  // Navigate to a page for Bank Transfer
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const ConstructionPage(
                          startIndex: 6), // Example for Bank Transfer
                    ),
                  );
                }
              },
              //
              style: ElevatedButton.styleFrom(
                minimumSize: const Size.fromHeight(50),
                backgroundColor: baseColor,
              ),
              child: const Text("Make Payment",
                  style: TextStyle(color: Colors.white)),
            ),
          ],
        ),
      ),
    );
  }
}

class Sucesss extends StatefulWidget {
  const Sucesss({super.key});

  @override
  State<Sucesss> createState() => _SucesssState();
}

class _SucesssState extends State<Sucesss> {
  final controller = Get.put(Main_Dashboard_controller());

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
                  "Deposit Successful",
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.w600),
                ),
                Text(
                    "Congratulations  ${controller.profileName} You have made your first deposit",
                    style: const TextStyle(fontSize: 10)),
                const SizedBox(height: 20),
                ElevatedButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) => const DashboardPageS("Mortgage"),
                      ),
                    );
                  },
                  //
                  style: ElevatedButton.styleFrom(
                    backgroundColor: baseColor,
                    minimumSize: const Size.fromHeight(50),
                  ),
                  child: const Text(
                    "Proceed to Home",
                    style: TextStyle(color: Colors.white, letterSpacing: 2),
                  ),
                ),
              ],
            ),
          )),
    );
  }
}

class TermSheetPage extends StatefulWidget {
  const TermSheetPage({super.key});

  @override
  State<TermSheetPage> createState() => _TermSheetPageState();
}

class _TermSheetPageState extends State<TermSheetPage>
    with SingleTickerProviderStateMixin {
  final controller = Get.put(ContructionController());

  Map<String, dynamic> data = {};
  Future<void> fetchData() async {
    try {
      final responseData =
          await controller.getData("userId"); // Pass the actual userId
      setState(() {
        data = responseData;
      });
    } catch (error) {
      print("Error fetching data in UI: $error");
    }
  }

  @override
  void initState() {
    super.initState();
    fetchData();
    _fetchCityName();

    _fetchAreaName();
    // controller.fetchCitiesAndAreas();
  }

  Future<void> _fetchCityName() async {
    var cityName = await controller.findAndSetCity();
    setState(() {}); // Rebuild to display the city name
  }

  Future<void> _fetchAreaName() async {
    var areaName = await controller.findAndSetArea();
    setState(() {}); // Rebuild to display the city name
  }

  @override
  Widget build(BuildContext context) {
    double initialDeposit = double.tryParse(
          controller.propertyValueController.text.replaceAll(',', ''),
        ) ??
        0;
    print("44411${initialDeposit}");
    String todayDate = DateFormat('dd-MM-yyyy').format(DateTime.now());
    String anniversary =
        DateFormat('dd-MM-yyyy').format(controller.selectedDay);
    String anniversaryDate = controller.selectedDay?.toString() ?? '';
    String estimatedProfileDate =
        controller.calculateProfileDate(anniversaryDate, 16);
    int emiTenureInMonth = (controller.sliderValue * 12).toInt();
    print("cleanAmount fetching data in UI: $emiTenureInMonth");
    String cleanAmount = controller.completionAmount.text.replaceAll(',', '');

    double completionAmount = double.tryParse(cleanAmount) ?? 0.0;
    var emi = controller.calculateEMI(completionAmount, emiTenureInMonth);
    var expectedSave = (emi ?? 0) * (controller.screenPeriod ?? 0);
    controller.totalMonthlySaving = emi.toInt();
    controller.totalExpectedSaving = expectedSave.toInt();

    print("expectedSave fetching data in UI: $expectedSave");

    return Scaffold(
        appBar: AppBar(
          title: Text(
            'Term Sheet',
            style: TextStyle(color: baseColor, fontWeight: FontWeight.bold),
          ),
          centerTitle: true,
          leading: IconButton(
            icon: const Icon(Icons.arrow_back),
            onPressed: () => Navigator.pop(context),
          ),
        ),
        body: SingleChildScrollView(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                "Est pellentesque fermentum cursus curabitur pharetra, vene",
                textAlign: TextAlign.center,
                style: TextStyle(color: Colors.grey, fontSize: 13),
              ),
              const SizedBox(height: 0.0),
              _buildSection(
                "House Details",
                [
                  _buildRow("City", controller.cityNameValue.text),
                  _buildRow("Area", controller.areaNameValue.text),
                  _buildRow(
                    "Construction Type",
                    " ${controller.getConstructionStageName(controller.selectedStage)}",
                  ),
                  _buildRow(
                    "Estimated Budget",
                    "NGN ${controller.formatNumber(controller.completionAmount.text)} ",
                  ),
                ],
                buttonAction: () {},
              ),
              const SizedBox(height: 16.0),
              _buildSection(
                "Loan Details",
                [
                  _buildRow("Loan",
                      "NGN ${controller.formatNumber(controller.completionAmount.text)} "),
                  _buildRow("Repayment Period",
                      "${controller.sliderValue.toInt()} Years"),
                  _buildRow("Monthly Repayment",
                      "NGN ${controller.formatNumber(controller.monthlyRepaymentController.text)}"),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 4.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text("Starting Date",
                            style: TextStyle(color: Colors.grey)),
                        Text(todayDate,
                            style: TextStyle(
                                color: baseColor,
                                fontWeight: FontWeight.bold,
                                decoration: TextDecoration.underline)),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 4.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text("Next Anniversary Date",
                            style: TextStyle(color: Colors.grey)),
                        Text(anniversary,
                            style: TextStyle(
                                color: baseColor,
                                fontWeight: FontWeight.bold,
                                decoration: TextDecoration.underline)),
                      ],
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 16.0),
              _buildSection(
                "Saving & Profiling",
                [
                  _buildRow(
                      "Screening Period", "${controller.screenPeriod} Months"),
                  _buildRow(
                    "Estimated Profile Date",
                    controller.formatProfileDate(estimatedProfileDate),
                  ),
                  _buildRow("Total Monthly Savings",
                      "NGN ${controller.formatNumber(emi.toString())}"),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 4.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text("Total Monthly Savings",
                            style: TextStyle(
                                color: Color.fromARGB(255, 44, 44, 44),
                                fontWeight: FontWeight.bold)),
                        Text("NGN ${formattedEMI(expectedSave)} ",
                            style: const TextStyle(
                                color: Colors.black,
                                fontWeight: FontWeight.bold,
                                decoration: TextDecoration.underline)),
                      ],
                    ),
                  ),
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
                          "Total Expected Saving",
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                      ],
                    ),
                    TextButton(
                        onPressed: () {
                          // controller.addMortgageForm(context);
                          Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                              builder: (context) => const ConstructionPage(
                                startIndex: 5,
                              ), // Start with MortgagePageHome
                            ),
                          );
                        },
                        child: Text(
                          'NGN ${formattedEMI(expectedSave)}',
                        )),
                  ],
                ),
              ),
              const SizedBox(height: 24.0),
              Center(
                child: ElevatedButton(
                  onPressed: () => {
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const ConstructionPage(
                          startIndex: 5,
                        ), // Start with MortgagePageHome
                      ),
                    )
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: baseColor,
                    padding: const EdgeInsets.symmetric(
                        horizontal: 24.0, vertical: 12.0),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20),
                    ),
                  ),
                  child: const Text("Proceed to Pay",
                      style: TextStyle(color: Colors.white)),
                ),
              ),
            ],
          ),
        ));
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
}

class BankTransferPage extends StatefulWidget {
  const BankTransferPage({super.key});

  @override
  State<BankTransferPage> createState() => _BankTransferPageState();
}

class _BankTransferPageState extends State<BankTransferPage> {
  final controller = Get.put(ContructionController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Bank Transfer'),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Card(
              elevation: 2,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8.0),
              ),
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _buildRow("Bank Name", "AG Mortgage Bank Plc"),
                    const SizedBox(height: 8.0),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text(
                          "Account Number",
                          style: TextStyle(color: Colors.grey),
                        ),
                        Row(
                          children: [
                            const Text(
                              "1234567890",
                              style: TextStyle(fontWeight: FontWeight.bold),
                            ),
                            const SizedBox(width: 6.0),
                            IconButton(
                              icon: const Icon(Icons.copy, size: 20.0),
                              onPressed: () {
                                Clipboard.setData(
                                  const ClipboardData(text: "1234567890"),
                                );
                                ScaffoldMessenger.of(context).showSnackBar(
                                  const SnackBar(
                                      content: Text("Account number copied")),
                                );
                              },
                            ),
                          ],
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 8.0),
            const Text(
              "Use this account number for this transaction only",
              textAlign: TextAlign.center,
              style: TextStyle(color: Colors.black),
            ),
            const Spacer(),
            Center(
              child: ElevatedButton(
                onPressed: () {
                  controller.constructionFinance(context);

                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const ConstructionPage(
                          startIndex: 5), // Start with ConstructionPage
                    ),
                  );
                },
                style: ElevatedButton.styleFrom(
                  padding: const EdgeInsets.symmetric(
                      horizontal: 24.0, vertical: 12.0),
                  backgroundColor: baseColor,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                ),
                child: const Text("I’ve sent the money",
                    style: TextStyle(color: Colors.white)),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildRow(String label, String value) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(label, style: const TextStyle(color: Colors.grey)),
        Text(value, style: const TextStyle(fontWeight: FontWeight.bold)),
      ],
    );
  }
}

// construction page 2

class ConstructionFinancePage extends StatefulWidget {
  const ConstructionFinancePage({super.key});

  @override
  _ConstructionFinancePageState createState() =>
      _ConstructionFinancePageState();
}

class _ConstructionFinancePageState extends State<ConstructionFinancePage> {
  // State variables
  final controller = Get.put(ContructionController());
  @override
  void initState() {
    super.initState();
    controller.voluntaryAmount.text = '0'; // Set default value on page load
  }

  final _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    final isMobile = MediaQuery.of(context).size.width < 600;

    return Scaffold(
        appBar: AppBar(
          title: Text(
            'Construction Finance',
            style: TextStyle(color: baseColor, fontWeight: FontWeight.bold),
          ),
          leading: IconButton(
            icon: const Icon(Icons.arrow_back),
            onPressed: () => Navigator.pop(context),
          ),
        ),
        body: SingleChildScrollView(
          padding: const EdgeInsets.all(16.0),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Align(
                    alignment: Alignment.center,
                    child: Text(
                      "Let's know about your housing project",
                      style: TextStyle(
                          fontSize: 16.0, fontWeight: FontWeight.w400),
                    )),
                const SizedBox(height: 20.0),
                _buildSwitchTile('Have you started Construction?',
                    controller.hasRegisteredDeed, (value) {
                  setState(() {
                    controller.hasRegisteredDeed = value;
                  });
                }),
                _buildSwitchTile('Do you have title deed on the plot?',
                    controller.hasLandTitleCertificate, (value) {
                  setState(() {
                    controller.hasLandTitleCertificate = value;
                  });
                }),
                _buildSwitchTile(
                    'Do you have current valuation report of the asset?',
                    controller.hasValuationReport, (value) {
                  setState(() {
                    controller.hasValuationReport = value;
                  });
                }),
                const SizedBox(height: 16.0),
                const Text('Valuation Amount'),
                TextFormField(
                  controller: controller.voluntaryAmount,
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(100),
                    ),
                    prefix: const Padding(
                      padding: EdgeInsets.only(
                          right: 8), // Adds spacing between NGN and input
                      child: Text(
                        'NGN',
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                    ),
                  ),
                  inputFormatters: [
                    FilteringTextInputFormatter.digitsOnly,
                    TextInputFormatter.withFunction((oldValue, newValue) {
                      final newText = newValue.text.replaceAll(
                          RegExp(r'\D'), ''); // Remove non-digit characters
                      final formattedText = controller
                          .formatNumber(newText.isEmpty ? '0' : newText);
                      return newValue.copyWith(text: formattedText);
                    }),
                  ],
                  validator: (value) {
                    if (value == null ||
                        value.trim().isEmpty ||
                        value.trim() == '0') {
                      return 'Please enter a valuation amount';
                    }
                    final int enteredAmount =
                        int.tryParse(value.replaceAll(',', '')) ?? 0;
                    final int estimatedAmount =
                        controller.estimatedAmount as int;

                    if (enteredAmount < estimatedAmount) {
                      return 'Valuation amount must be greater than or equal to estimated completion amount.';
                    }
                    return null; // No error message when valid
                  },
                  onChanged: (value) {
                    // Set default value to '0' if empty
                    if (value.isEmpty) {
                      controller.voluntaryAmount.text = '0';
                      controller.voluntaryAmount.selection =
                          TextSelection.fromPosition(
                        TextPosition(
                            offset: controller.voluntaryAmount.text.length),
                      );
                    }

                    // Hide validation message dynamically
                    controller.formKey.currentState?.validate();
                  },
                ),
                _buildSwitchTile(
                    'Do you have approved architectural & structural drawing?',
                    controller.hasArchitecturalDrawing, (value) {
                  setState(() {
                    controller.hasArchitecturalDrawing = value;
                  });
                }),
                _buildSwitchTile(
                    'Do you have approved electrical and mechanical drawing?',
                    controller.hasElectricalAndMechanicalDrawings, (value) {
                  setState(() {
                    controller.hasElectricalAndMechanicalDrawings = value;
                  });
                }),
                _buildSwitchTile(
                    'Do you have current bill of Qualities and material by certified quantity surveyor?',
                    controller.hasBillOfQuantities, (value) {
                  setState(() {
                    controller.hasBillOfQuantities = value;
                  });
                }),
                const SizedBox(height: 20.0),
                const Text(
                  'Details of Project Professionals',
                  style: TextStyle(fontSize: 16.0, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 16.0),
                _buildProfessionalDetails('Architect', controller.architechName,
                    controller.architechNumner),
                engineer('Engineer', controller.engineerName,
                    controller.engineerNumner),
                quantity('Quantity Surveyor', controller.surveyorName,
                    controller.surveyorNumner),
                const SizedBox(height: 16.0),
                Container(
                  padding: const EdgeInsets.all(12.0),
                  decoration: BoxDecoration(
                    color: const Color.fromARGB(255, 214, 160, 32),
                    borderRadius: BorderRadius.circular(8.0),
                  ),
                  child: const Text(
                    'Note: No worries if you don’t have the required documents. AG Mortgage can help you obtain them as we move forward.',
                    style: TextStyle(fontSize: 14.0, color: Colors.white),
                  ),
                ),
                const SizedBox(height: 20.0),
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: () {
                      if (_formKey.currentState!.validate()) {
                        Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const ConstructionPage(
                                startIndex: 3), // Start with MortgagePage
                          ),
                        );
                      }
                    },
                    style: ElevatedButton.styleFrom(
                        padding: const EdgeInsets.symmetric(vertical: 16.0),
                        backgroundColor: baseColor),
                    child: const Text(
                      'Proceed to Open Account',
                      style: TextStyle(
                          color: Colors.white, fontWeight: FontWeight.w600),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ));
  }

  Widget _buildSwitchTile(String title, bool value, Function(bool) onChanged) {
    return Container(
      padding: const EdgeInsets.all(12.0),
      margin: const EdgeInsets.all(5),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8.0),
        boxShadow: const [
          BoxShadow(
            color: Colors.black26,
            blurRadius: 4.0,
            offset: Offset(0, 2),
          ),
        ],
      ),
      child: SwitchListTile(
        activeColor: Colors.white,
        activeTrackColor: Colors.orange,
        inactiveTrackColor: baseColor,
        inactiveThumbColor: Colors.white,
        title: Text(
          title,
          style: const TextStyle(fontSize: 15),
        ),
        value: value,
        onChanged: onChanged,
      ),
    );
  }

  Widget _buildTextInputField(
      String label, String placeholder, TextEditingController controller) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: TextField(
        controller: controller,
        decoration: InputDecoration(
          labelText: label,
          hintText: placeholder,
          hintStyle: const TextStyle(fontSize: 10.0),
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(30)),
        ),
      ),
    );
  }

  Widget _buildProfessionalDetails(
      String role,
      TextEditingController architechName,
      TextEditingController architechNumner) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('$role',
            style:
                const TextStyle(fontSize: 16.0, fontWeight: FontWeight.w500)),
        const SizedBox(height: 8.0),
        _buildTextInputField('Input Name', '', architechName),
        _buildTextInputField(
            'Input Professional Registration Number', '', architechNumner),
      ],
    );
  }

  Widget engineer(String role, TextEditingController engineerName,
      TextEditingController engineerNumner) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('$role',
            style:
                const TextStyle(fontSize: 16.0, fontWeight: FontWeight.w500)),
        const SizedBox(height: 8.0),
        _buildTextInputField('Input Name', '', engineerName),
        _buildTextInputField(
            'Input Professional Registration Number', '', engineerNumner),
      ],
    );
  }

  Widget quantity(String role, TextEditingController surveyorName,
      TextEditingController surveyorNumner) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('$role',
            style:
                const TextStyle(fontSize: 16.0, fontWeight: FontWeight.w500)),
        const SizedBox(height: 8.0),
        _buildTextInputField('Input Name', '', surveyorName),
        _buildTextInputField(
            'Input Professional Registration Number', '', surveyorNumner),
      ],
    );
  }
}

class TermsAndConditionsDialog extends StatelessWidget {
  final Houseview? house;
  final bool? viewBtn;
  const TermsAndConditionsDialog({
    Key? key,
    this.house,
    this.viewBtn,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Terms and Conditions'),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 20),
            const Text(
              'Effective Date: January 2025',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 10),
            const Text(
              'Welcome to KWIK by AGMB! These Terms and Conditions (“Terms”) explain how the KWIK platform works and the rules for using it. By signing up or using the platform, you agree to these Terms, so please read them carefully.',
              style: TextStyle(fontSize: 14),
            ),
            const SizedBox(height: 20),
            const Text(
              'Key Highlights of KWIK by AGMB',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 10),
            _buildBulletPoint(
                'Save for a 30% down payment over 18 months and earn competitive interest.'),
            _buildBulletPoint(
                'Referral credits are added to your savings balance (not withdrawable as cash).'),
            _buildBulletPoint(
                'Missed payments result in program extensions and delayed loan eligibility.'),
            _buildBulletPoint(
                'Only properties in approved locations qualify for funding.'),
            _buildBulletPoint(
              'Diaspora Nigerians can participate but must consider remittance timelines, exchange rates, and refunds in Naira only.',
            ),
            const SizedBox(height: 20),
            const Text(
              '1. What is KWIK by AGMB?',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 10),
            const Text(
              'KWIK by AGMB is a digital platform for the KWIK Construction program. This program helps users gradually save for a 30% down payment over 18 months, instilling a strong savings culture and enabling them to meet Construction requirements to purchase verified properties.\n\nPlease note that the KWIK platform is not a regular savings or current account. It has specific terms and is for people on a mission to own a home. Applicants are encouraged to read these Terms carefully and fully understand them before signing up.',
              style: TextStyle(fontSize: 14),
            ),
            const SizedBox(height: 20),
            const Text(
              '2. Who Can Use KWIK by AGMB?',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 10),
            _buildBulletPoint('Age: You must be at least 18 years old.'),
            _buildBulletPoint(
                'Residency: You can join if you live in Nigeria or are a Nigerian living abroad (diaspora Nigerians).'),
            _buildBulletPoint(
                'Verification: You need to provide valid ID, proof of address, and other documents during registration.'),
            const SizedBox(height: 10),
            const Text(
              'Special Terms for Diaspora Nigerians\n\nDiaspora Nigerians may face processing delays due to international remittance timelines or exchange rate fluctuations.\n\nAll deposits and refunds for diaspora users will be processed in Naira, and any exchange rate losses or remittance charges will be borne by the user.',
              style: TextStyle(fontSize: 14),
            ),
            const SizedBox(height: 20),
            const Text(
              '3. How Does the KWIK Savings Plan Work?',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 10),
            const Text(
              '3.1 Contractual and Voluntary Savings',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 10),
            _buildBulletPoint(
                'Contractual Savings: Mandatory monthly savings contributions made on each monthly anniversary date. These form the primary basis for building the 30% down payment.'),
            _buildBulletPoint(
                'Voluntary Savings: Optional savings made beyond the required contractual savings. Voluntary savings:'),
            _buildSubBulletPoint(
                'Are tracked separately from contractual savings.'),
            _buildSubBulletPoint(
                'Enhance the user’s financial profile and improve their chances of Construction approval.'),
            const SizedBox(height: 20),
            const Text(
              '3.2 Monthly Deposits',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 10),
            _buildBulletPoint(
                'You’ll deposit money monthly toward your 30% down payment.'),
            _buildBulletPoint(
                'The first deposit is required when you sign up.'),
            const SizedBox(height: 20),
            const Text(
              '3.3 Interest Rates',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 10),
            _buildBulletPoint(
                'Months 1–5: You’ll earn 4% monthly interest on your savings.'),
            _buildBulletPoint(
                'After 6 Months: You’ll earn 6% monthly interest.'),
            const SizedBox(height: 20),
            const Text(
              '3.4 Withdrawal Rules',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 10),
            _buildBulletPoint(
                'First 6 Months: You can withdraw once, but there’s a 3% penalty, and it takes 48 hours to process.'),
            _buildBulletPoint(
                'After 6 Months: Withdrawals require 30 days’ notice and may incur penalties if they affect your program eligibility.'),
            const SizedBox(height: 20),
            const Text(
              '3.5 Missed Payments',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 10),
            _buildBulletPoint(
                'Users have a 7-day grace period to make up missed payments without penalties.'),
            _buildBulletPoint(
                'After the grace period, missing a payment will:'),
            _buildSubBulletPoint('Extend your savings plan by 3 months.'),
            _buildSubBulletPoint('Delay your loan eligibility by 1 month.'),
            const SizedBox(height: 20),
            const Text(
              '3.6 Exiting the Program',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 10),
            const Text(
              'If you leave the program early:',
              style: TextStyle(fontSize: 14),
            ),
            _buildBulletPoint('You will lose all earned interest.'),
            _buildBulletPoint(
                'Submit a written request via the platform or email. The remaining balance, minus applicable penalties, will be processed and returned within 14 business days.'),
            const SizedBox(height: 20),
            const Text(
              '4. Property Selection Rules',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 10),
            const Text(
              '4.1 AGMB’s Marketplace',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 10),
            _buildBulletPoint(
                'You can choose from verified properties in AGMB’s Marketplace. These properties are high-quality, structurally sound, and have clear ownership records.'),
            const SizedBox(height: 20),
            const Text(
              '4.2 External Properties',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 10),
            const Text(
              'If you want to buy a property outside AGMB’s Marketplace:',
              style: TextStyle(fontSize: 14),
            ),
            _buildBulletPoint(
                'The property must go through a verification process.'),
            _buildBulletPoint(
                'A non-refundable verification fee will be charged upfront before the process begins.'),
            _buildBulletPoint(
                'The fee amount will depend on the property’s location and complexity of verification.'),
            const SizedBox(height: 20),
            const Text(
              '4.3 Exceptional Locations Policy',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 10),
            const Text(
              'To protect the bank, AGMB may restrict funding for properties in areas with low property values or high risks. Only properties in approved locations will be eligible for funding under the KWIK program.',
              style: TextStyle(fontSize: 14),
            ),
            const SizedBox(height: 20),
            const Text(
              '5. Referral Program',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 10),
            const Text(
              '5.1 Who Can Refer?',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 10),
            const Text(
              'Both users in Nigeria and Nigerians in the diaspora can refer others to the program.',
              style: TextStyle(fontSize: 14),
            ),
            const SizedBox(height: 20),
            const Text(
              '5.2 How the Program Works',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 10),
            _buildBulletPoint(
                'There’s no limit to how many people you can refer, as long as you follow the referral rules.'),
            _buildBulletPoint(
                'A referral is successful when the referred person:'),
            _buildSubBulletPoint('Signs up for the KWIK program.'),
            _buildSubBulletPoint(
                'Maintains six consecutive monthly savings and locks down their deposit for homeownership.'),
            const SizedBox(height: 20),
            const Text(
              '5.3 Definition of Lockdown',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 10),
            const Text(
              'Lockdown occurs when a referred person, after completing six consecutive monthly savings, formally signs to lock their savings for homeownership and continues with the KWIK program.',
              style: TextStyle(fontSize: 14),
            ),
            const SizedBox(height: 20),
            const Text(
              '5.4 Referral Rewards',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 10),
            _buildBulletPoint(
                'Accumulation: Referral credits will be held in a referral wallet.'),
            _buildBulletPoint(
                'True Value: Referral credits are added to the beneficiary’s savings balance only after the referred person locks down their deposit.'),
            _buildBulletPoint(
                'Non-Withdrawal: Referral credits cannot be withdrawn as cash.'),
            _buildBulletPoint(
                'Ownership: Referral credits are tied to the beneficiary’s account and cannot be transferred.'),
            const SizedBox(height: 20),
            const Text(
              '6. Fees and Penalties',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 10),
            const Text(
              '6.1 Verification Fees for External Properties',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 10),
            _buildBulletPoint(
                'Charged upfront before the verification process begins.'),
            _buildBulletPoint('Non-refundable.'),
            const SizedBox(height: 20),
            const Text(
              '6.2 Penalties for Withdrawals and Missed Payments',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 10),
            _buildBulletPoint(
                'Early Withdrawals: During the first 6 months, withdrawals incur a 3% penalty.'),
            _buildBulletPoint('Missed Payments: Missing a payment will:'),
            _buildSubBulletPoint('Extend your savings plan by 3 months.'),
            _buildSubBulletPoint('Delay your loan eligibility by 1 month.'),
            const SizedBox(height: 20),
            const Text(
              '7. How to Use the KWIK Platform',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 10),
            _buildBulletPoint(
                'Use the platform to monitor your savings, build Construction credibility, choose properties, and manage your Construction application.'),
            _buildBulletPoint(
                'The platform will be updated regularly. Install updates to enjoy all features.'),
            _buildBulletPoint(
                'AGMB will communicate via SMS and email. Keep your contact details accurate.'),
            const SizedBox(height: 20),
            const Text(
              '8. Consequences for Non-Compliance with Lockdown Rules',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 10),
            _buildBulletPoint(
                'Failure to lock down savings after six consecutive monthly deposits may result in AGMB reclassifying the savings as voluntary savings.'),
            const SizedBox(height: 20),
            const Text(
              '9. Data Privacy',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 10),
            _buildBulletPoint(
                'AGMB may share user data with trusted third parties for property verification, credit checks, or regulatory compliance.'),
            _buildBulletPoint(
                'Third parties comply with strict data protection standards.'),
            const SizedBox(height: 20),
            const Text(
              '10. Dispute Resolution',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 10),
            const Text(
              'Disputes will first be addressed by AGMB’s customer service. Unresolved disputes will proceed to arbitration under Nigerian law.',
              style: TextStyle(fontSize: 14),
            ),
            const SizedBox(height: 20),
            const Text(
              '11. Force Majeure',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 10),
            const Text(
              'AGMB is not liable for delays caused by natural disasters, strikes, wars, pandemics, regulatory changes, or financial system disruptions.',
              style: TextStyle(fontSize: 14),
            ),
            const SizedBox(height: 20),
            const Text(
              '12. Contact Us',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 10),
            const Text(
              'Email: support@agmbplc.com',
              style: TextStyle(fontSize: 14),
            ),
            const SizedBox(height: 10),
            const Text(
              'Phone: +234 (0) 800 AGMB KWIK',
              style: TextStyle(fontSize: 14),
            ),
            const SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.white,
                    padding: const EdgeInsets.symmetric(
                        horizontal: 32, vertical: 16),
                    textStyle: const TextStyle(fontSize: 18),
                  ),
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: const Text(
                    'Decline',
                    style: TextStyle(
                        color: Colors.black, fontWeight: FontWeight.w600),
                  ),
                ),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: baseColor,
                    padding: const EdgeInsets.symmetric(
                        horizontal: 32, vertical: 16),
                    textStyle: const TextStyle(fontSize: 18),
                  ),
                  onPressed: () {
                    Navigator.pushNamed(context, "/construction/termsheet");
                  },
                  child: const Text(
                    'Accept',
                    style: TextStyle(
                        color: Colors.white, fontWeight: FontWeight.w600),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildBulletPoint(String text) {
    return Row(
      children: [
        const Icon(Icons.circle, size: 6, color: Colors.black),
        const SizedBox(width: 8),
        Expanded(child: Text(text)),
      ],
    );
  }

  Widget _buildSubBulletPoint(String text) {
    return Padding(
      padding: const EdgeInsets.only(left: 20.0, top: 4.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text('• '),
          Expanded(
            child: Text(
              text,
              style: const TextStyle(fontSize: 14),
            ),
          ),
        ],
      ),
    );
  }
}
