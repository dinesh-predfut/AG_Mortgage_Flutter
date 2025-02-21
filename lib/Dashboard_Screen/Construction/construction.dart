import 'dart:math';

import 'package:ag_mortgage/All_Cards/Get_all_Cards/all_cards.dart';
import 'package:ag_mortgage/Dashboard_Screen/Construction/controller.dart';
import 'package:ag_mortgage/Dashboard_Screen/Construction/models.dart';
import 'package:ag_mortgage/Dashboard_Screen/Market_Place/main.dart';
import 'package:ag_mortgage/Dashboard_Screen/Mortgage/MortgageHome.dart';
import 'package:ag_mortgage/Dashboard_Screen/dashboard_Screen.dart';
import 'package:ag_mortgage/Main_Dashboard/dashboard/Dashboard/component.dart';
import 'package:ag_mortgage/const/Image.dart';
import 'package:ag_mortgage/const/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:intl/intl.dart';
// ignore: depend_on_referenced_packages
import 'package:table_calendar/table_calendar.dart';

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
    const Success(),
    const Construction_CalendarPage(),
    const TermSheetPage(),
    const BankTransferPage()
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
                "Secure the financing you need to complete your housing project with AG Mortgage Bank.",
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
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const ConstructionPage(
                          startIndex: 1), // Start with MortgagePage
                    ),
                  );
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
    calculateEMI();
    // calculateMonthlyRental();
    calculateEMIAmountValue();
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
    int emiTenureInMonth = (controller.sliderValue * 12).toInt();
    // ignore: non_constant_identifier_names
    final FinalEMi = calculateEMIAmount(loanAmount, emiTenureInMonth);
    controller.monthlyRepaymentController.text = formattedEMI(FinalEMi);
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

  void calculateEMI() {
    // calculateMonthlyRental();
    calculateEMIAmountValue();
    double propertyValue = double.tryParse(
            controller.propertyValueController.text.replaceAll(',', '')) ??
        0;
    double initialDeposit =
        double.tryParse(controller.downPayment.text.replaceAll(',', '')) ?? 0;
    // ignore: non_constant_identifier_names
    double TotalinitialDeposit = propertyValue * 0.4;
    controller.downPayment.text = formattedEMI(TotalinitialDeposit);
    // ignore: non_constant_identifier_names
    double LoanCalculationAmount = propertyValue * 0.6;
    controller.estimatedAmount.text = formattedEMI(LoanCalculationAmount);
    if (initialDeposit > 0) {
      var calculateTotalamount = TotalinitialDeposit - initialDeposit;
      var monthlyRepayment = (calculateTotalamount) / 18;
      print('Response body: ${monthlyRepayment}');
      controller.monthlyRepaymentController.text =
          formattedEMI(monthlyRepayment);
      controller.downPayment.text = formattedEMI(initialDeposit);
      controller.propertyValueController.text = formattedEMI(propertyValue);
    } else {
      var withoutuInitialAmount = (TotalinitialDeposit) / 18;
      controller.monthlyRepaymentController.text =
          formattedEMI(withoutuInitialAmount);
      controller.propertyValueController.text = formattedEMI(propertyValue);
      ;
    }
  }

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
        title: const Text('Rent-to-Own'),
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
                  'Let us know your preference',
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
                            return 'Please select a city';
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
                            value == null ? 'Please select an area' : null,
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

                      // if (controller.selectedLoan.value == null &&
                      //     loanData.isNotEmpty) {
                      //   controller.selectedLoan.value = loanData.first;
                      // }

                      return DropdownButtonFormField<LoanModel>(
                        value: 
                        loanData.firstWhere(
                          (loan) =>
                              loan.id == controller.selectedLoan.value?.id,
                          orElse: () =>
                              loanData.first, // Ensure valid selection
                        ),
                        decoration: InputDecoration(
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(100),
                          ),
                        ),
                        isExpanded: true,
                        icon: const Icon(Icons.keyboard_arrow_down),
                        items: loanData.map((LoanModel loan) {
                          return DropdownMenuItem<LoanModel>(
                            value: loan,
                            child: Text(loan.typeName),
                          );
                        }).toList(),
                        onChanged: (LoanModel? value) {
                          if (value != null) {
                            controller.selectedLoan.value = value;
                            controller.interestRate = value.mortgageInterest;
                            controller.screenPeriod = value.profilingPeriod;
                            
                            // calculateMonthlyRental();
                            print("Selected Loan: ${controller.interestRate}");
                          }
                        },
                        validator: (value) {
                          if (value == null) {
                            return 'Please select a screening period';
                          }
                          return null;
                        },
                      );
                    },
                  ),

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
                        value == null ? "Please select a stage" : null,
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
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
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
                      if (value == null || value.trim().isEmpty) {
                        return 'Please enter the monthly repayment amount';
                      }
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
                          Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                                builder: (context) =>
                                    const ConstructionPage(startIndex: 2)),
                          );
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
  DateTime _selectedDay = DateTime.now();
  DateTime _focusedDay = DateTime.now();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Anniversary'),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              const Center(
                child: Text(
                  'Set your anniversary for payment..',
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
                  "Your next anniversary date is:",
                  style: TextStyle(fontSize: 15, height: 5),
                ),
              ),
              Text(
                ' ${DateFormat('dd-MM-yyyy').format(_selectedDay)}',
                style: const TextStyle(fontSize: 25, color: Colors.black),
              ),
              TableCalendar(
                focusedDay: _focusedDay,
                firstDay: DateTime(2000),
                lastDay: DateTime(2100),
                selectedDayPredicate: (day) {
                  return isSameDay(_selectedDay, day);
                },
                onDaySelected: (selectedDay, focusedDay) {
                  setState(() {
                    _selectedDay = selectedDay;
                    _focusedDay = focusedDay; // Update focusedDay
                  });
                },
                calendarStyle:  CalendarStyle(
                  selectedDecoration: BoxDecoration(
                    color: baseColor,
                    shape: BoxShape.circle,
                  ),
                  todayDecoration: BoxDecoration(
                    color: Colors.orange,
                    shape: BoxShape.circle,
                  ),
                  markerDecoration: BoxDecoration(
                    color: Colors.blue,
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
                padding:
                    const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                        builder: (context) =>
                            const ConstructionPage(startIndex: 4),
                      ),
                    );
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
    );
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
        title: const Text("Payment"),
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
                   Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (_) => const DashboardPageS("Construction"),
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
          title: const Text('Term Sheet'),
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
                  _buildRow("Starting Date", todayDate),
                  _buildRow("Next Anniversary Date", anniversary),
                ],
              ),
              const SizedBox(height: 16.0),
              _buildSection(
                "Saving & Profiling",
                [
                  _buildRow("Screening Period", "${controller.screenPeriod} Months"),
                  _buildRow(
                    "Estimated Profile Date",
                    controller.formatProfileDate(estimatedProfileDate),
                  ),
                  _buildRow("Total Monthly Savings",
                      "NGN ${controller.formatNumber(emi.toString())}"),
                  _buildRow("Minimum Total Expected Saving",
                      "NGN ${controller.formatNumber(expectedSave.toString())} "),
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
                      child:  Text(controller.formatNumber(expectedSave.toString())),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 24.0),
              Center(
                child: ElevatedButton(
                  onPressed: () => {
                    controller.constructionFinance(context),
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

class BankTransferPage extends StatelessWidget {
  const BankTransferPage({super.key});

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
  Widget build(BuildContext context) {
    final isMobile = MediaQuery.of(context).size.width < 600;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Construction Finance'),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pushNamed(context, "/construction");
          },
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Align(
                alignment: Alignment.center,
                child: Text(
                  "Let's know about your housing project",
                  style: TextStyle(fontSize: 16.0, fontWeight: FontWeight.w400),
                )),
            const SizedBox(height: 20.0),
            _buildSwitchTile(
                'Have you started Construction?', controller.hasRegisteredDeed,
                (value) {
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
                  final formattedText = controller.formatNumber(newText);
                  return newValue.copyWith(text: formattedText);
                }),
              ],
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please enter a valuation amount';
                }
                final int enteredAmount =
                    int.tryParse(value.replaceAll(',', '')) ?? 0;
                final int estimatedAmount = controller.estimatedAmount as int;

                if (enteredAmount < estimatedAmount) {
                  return 'Valuation amount must be greater than or equal to estimated completion amount.';
                }
                return null; // No error message when valid
              },
              onChanged: (value) {
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
                'Do you have current bill of quantities and material by certified quantity surveyor?',
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
            engineer(
                'Engineer', controller.engineerName, controller.engineerNumner),
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
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const ConstructionPage(
                          startIndex: 3), // Start with MortgagePage
                    ),
                  );
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
    );
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
