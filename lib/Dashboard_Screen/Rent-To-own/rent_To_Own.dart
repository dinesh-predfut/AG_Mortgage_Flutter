import 'dart:convert';
import 'dart:math';

import 'package:ag_mortgage/Dashboard_Screen/Market_Place/Dashboard_Page/model.dart';
import 'package:ag_mortgage/Dashboard_Screen/Market_Place/main.dart';
import 'package:ag_mortgage/Dashboard_Screen/Mortgage/MortgageHome.dart';
import 'package:ag_mortgage/Dashboard_Screen/Mortgage/MortgagePage.dart';
import 'package:ag_mortgage/Dashboard_Screen/Mortgage/controller.dart';
import 'package:ag_mortgage/Dashboard_Screen/Rent-To-own/controller.dart';
import 'package:ag_mortgage/Dashboard_Screen/Rent-To-own/models.dart';
import 'package:ag_mortgage/Main_Dashboard/Mortgage/Withdraw/controller.dart';
import 'package:ag_mortgage/Main_Dashboard/dashboard/Dashboard/component.dart';
import 'package:ag_mortgage/const/Image.dart';
import 'package:ag_mortgage/const/colors.dart';
import 'package:ag_mortgage/const/constant.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:table_calendar/table_calendar.dart';

import '../../const/commanFunction.dart';
import '../Market_Place/Details_Page/models.dart';

// ignore: camel_case_types
class Rent_To_Own extends StatefulWidget {
  final int startIndex;
  const Rent_To_Own(
      {super.key, this.startIndex = 0, Houseview? house, bool? viewBtn});
  @override
  // ignore: library_private_types_in_public_api
  _Rent_To_OwnState createState() => _Rent_To_OwnState();
}

class _Rent_To_OwnState extends State<Rent_To_Own> {
  final RentToOwnController controller = Get.put(RentToOwnController());
  int _currentStepIndex = 0;
  @override
  void initState() {
    super.initState();
    _currentStepIndex = widget.startIndex; // Initialize with provided index
    controller.getScreeningPeriodsApi();
  }

  final List<Widget> _steps = [
    RentToOwnLanding(),
    const RentToOwnForm(),
    const CalendarPage(),
    const TermSheetPageRent(),
    const PaymentMethodPage(),
    const BankTransferPage(),
    const Success(),
    const TermsAndConditionsDialogRentown()
  ];

  void _goToNextStep() {
    setState(() {
      if (_currentStepIndex < _steps.length - 1) {
        _currentStepIndex++;
      }
    });
  }

  void _goTomRentToOwnForm() {
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

class RentToOwnLanding extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context);
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
                  Images.mortgage, // Replace with your asset path
                  fit: BoxFit.cover,
                  width: 260,
                  height: 260,
                ),
              ),
            ),
            // Title Section
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Text(
                "Rent-to-own",
                style: TextStyle(
                  fontSize: 24.0,
                  fontWeight: FontWeight.bold,
                  color: baseColor,
                ),
                textAlign: TextAlign.center,
              ),
            ),
            const SizedBox(height: 8.0),
            // Description Section
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Text(
                "An accelerated home acquisition program that transitions you from tenant to homeowner.",
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
                  Text(
                    "Requirements",
                    style: TextStyle(
                      fontSize: 18.0,
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                    ),
                  ),
                  SizedBox(height: 8.0),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Icon(Icons.check, color: Colors.indigo),
                          SizedBox(width: 8.0),
                          Text("40% Deposit"),
                        ],
                      ),
                      SizedBox(height: 8.0), // Reduced vertical spacing
                      Row(
                        children: [
                          Icon(Icons.check, color: Colors.indigo),
                          SizedBox(width: 8.0),
                          Text("Property Evaluation Report"),
                        ],
                      ),
                      SizedBox(height: 8.0),
                      Row(
                        children: [
                          Icon(Icons.check, color: Colors.indigo),
                          SizedBox(width: 8.0),
                          Text("Construction Quality Report"),
                        ],
                      ),
                      SizedBox(height: 8.0),
                      Row(
                        children: [
                          Icon(Icons.check, color: Colors.indigo),
                          SizedBox(width: 8.0),
                          Text("Execute Tenancy Agreement"),
                        ],
                      ),
                      SizedBox(height: 8.0),
                      Text(
                          "Ready to move from tenant to homeowner? These are the simple steps to get Started."),
                    ],
                  ),
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
                  Navigator.pushNamed(context, "/rent-to-own/terms_condition");
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

class RentToOwnForm extends StatefulWidget {
  final Houseview? house;
  final bool? viewBtn;

  const RentToOwnForm({
    Key? key,
    this.house,
    this.viewBtn,
  }) : super(key: key);

  @override
  _RentToOwnFormState createState() => _RentToOwnFormState();
}

class _RentToOwnFormState extends State<RentToOwnForm> {
  final controller = Get.put(RentToOwnController());
  RentToOwnController controllerFeild = RentToOwnController();

  @override
  void initState() {
    super.initState();
    calculateEMI();
    calculateMonthlyRental();
    calculateEMIAmountValue();
    if (widget.house != null) {
      print(widget.house);
      controller.propertyValueController.text =
          formattedEMI(widget.house!.price);
      controller.loanAmount.text = (widget.house!.price * 0.6).toString();
      controller.downPayment.text = (widget.house!.price * 0.4).toString();
      controller.selectedCity = widget.house!.city;
      controller.selectedArea = widget.house!.localGovernmentArea;
      controller.selectedApartmentType = widget.house!.typeOfApartment;
      // Calculate the initial deposit (30% of the property value)
      double propertyValue = widget.house!.price.toDouble();
      controller.monthlyRepaymentController.text = "";
      controller.apartmentOrMarketplace = widget.house!.id;
      calculateEMIAmountValue();
      calculateEMI();
    }
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

  void calculateMonthlyRental() {
    if (controller.selectedLoan.value == null) {
      print("No loan selected");
      return;
    }

    final loan = controller.selectedLoan.value;

    final double initialDeposit =
        (double.tryParse(controller.downPayment.text.replaceAll(',', '')) ?? 0);
    final downPayment = double.tryParse(
            controller.propertyValueController.text.replaceAll(',', '')) ??
        0;
    final calculatedDownPayment = downPayment * 0.4;
    controller.downPayment.text = calculatedDownPayment.toString();
    final double loanAmount = (double.tryParse(
                controller.propertyValueController.text.replaceAll(',', '')) ??
            0) -
        (double.tryParse(controller.downPayment.text.replaceAll(',', '')) ?? 0);
    print("Nosloan selected${loanAmount.toString()}");

    final double financeInterestPercentage = loan!.financeInterest / 100;
    final double depositScreeningInterestPercentage =
        loan.depositScreeningInterest / 100;
    final int screeningPeriod = loan.screeningPeriod;
    final double profitPercentage = loan.profit / 100;

    final double interestOnSecurityDeposit =
        (initialDeposit * depositScreeningInterestPercentage) / screeningPeriod;

    final double interestOnFinanceAmount =
        (loanAmount * financeInterestPercentage) / screeningPeriod;

    final double profit =
        (interestOnFinanceAmount + interestOnSecurityDeposit) *
            profitPercentage;

    final double monthlyRental =
        interestOnSecurityDeposit + interestOnFinanceAmount + profit;
    controller.monthlyRendal.text = formattedEMI(monthlyRental);

    print("Interest on Security Deposit: $interestOnSecurityDeposit");
    print("Interest on Finance Amount: $interestOnFinanceAmount");
    print("Profit: $profit");
    print("Monthly Rent: $monthlyRental");
  }

  void calculateEMIAmountValue() {
    double loanAmount =
        double.tryParse(controller.loanAmount.text.replaceAll(',', '')) ?? 0.0;
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
    calculateMonthlyRental();
    calculateEMIAmountValue();
    double propertyValue = double.tryParse(
            controller.propertyValueController.text.replaceAll(',', '')) ??
        0;
    double initialDeposit =
        double.tryParse(controller.downPayment.text.replaceAll(',', '')) ?? 0;
    // ignore: non_constant_identifier_names
    double TotalinitialDeposit = propertyValue * 0.4;
    controller.downPayment.text = formattedEMI(propertyValue * 0.4);
    // controller.downPayment.text = TotalinitialDeposit.toString();
    updateControllerText(
        controller.downPayment, formattedEMI(TotalinitialDeposit));
    // ignore: non_constant_identifier_names
    double LoanCalculationAmount = propertyValue * 0.6;

    updateControllerText(
        controller.loanAmount, formattedEMI(LoanCalculationAmount));
    if (initialDeposit > 0) {
      var calculateTotalamount = TotalinitialDeposit - initialDeposit;
      var monthlyRepayment = (calculateTotalamount) / 18;
      print('Response body: ${monthlyRepayment}');
      updateControllerText(controller.monthlyRepaymentController,
          formattedEMI(monthlyRepayment));
      updateControllerText(
          controller.downPayment, formattedEMI(initialDeposit));
      updateControllerText(
          controller.propertyValueController, formattedEMI(propertyValue));
    } else {
      var withoutuInitialAmount = (TotalinitialDeposit) / 18;
      updateControllerText(controller.monthlyRepaymentController,
          formattedEMI(withoutuInitialAmount));

      updateControllerText(
          controller.propertyValueController, formattedEMI(propertyValue));
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
        title: Text(
          'Rent-to-Own',
          style: TextStyle(color: baseColor, fontWeight: FontWeight.w800),
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
                  'Move in as a tenant and convert to home owner',
                  style: TextStyle(fontSize: 16, color: Colors.grey),
                ),
              ),
              const SizedBox(height: 10),
              if (widget.viewBtn == null)
                Align(
                  alignment: Alignment.bottomRight,
                  child: ElevatedButton(
                    onPressed: () {
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                            builder: (context) =>
                                const MarketMain() // Start with MortgagePageHome
                            ),
                      );
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: baseColor,
                      padding: const EdgeInsets.symmetric(
                          horizontal: 20.0, vertical: 10.0),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20),
                      ),
                    ),
                    child: const Text("+ House",
                        style: TextStyle(color: Colors.white, fontSize: 12)),
                  ),
                ),
              const SizedBox(height: 5),
              // const Text(
              //   'Tenancy Application',
              //   textAlign: TextAlign.left,
              //   style: TextStyle(fontWeight: FontWeight.w600),
              // ),
              const SizedBox(height: 5),
              const Text('House Type'),
              FutureBuilder<List<Apartment>>(
                future: controller.fetchApartments(),
                builder: (context, snapshot) {
                  // Ensure data is not null
                  List<Apartment> apartment = snapshot.data ?? [];

                  return DropdownButtonFormField<int>(
                    value: controller.selectedCity,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(100),
                      ),
                    ),
                    isExpanded: true,
                    hint: const Text('Select a House Type'),
                    icon: const Icon(Icons.keyboard_arrow_down),
                    items: apartment.isNotEmpty
                        ? apartment.map((item) {
                            return DropdownMenuItem<int>(
                              value: item.id,
                              child: Text(item.apartmentType ?? 'Unknown Name'),
                            );
                          }).toList()
                        : [], // Prevents mapping on null

                    onChanged: (value) {
                      if (value != null) {
                        setState(() {
                          controller.selectedApartmentType = value;
                        });
                        // controller.findAndSetCity();
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
                        hint: const Text("Selet a City"),
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
                        hint: const Text("Selet a Area"),
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
                  const Text('Estimated Property Value'),
                  TextFormField(
                    controller: controller.propertyValueController,
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
                      calculateEMI();
                    },
                    validator: (value) {
                      if (value == null ||
                          value.trim().isEmpty ||
                          value.trim() == '0') {
                        return 'Please enter a valid estimated property value';
                      }
                      return null;
                    },
                  ),

                  const SizedBox(height: 10),

                  // Initial Deposit
                  const Text('Down Payment'),
                  TextFormField(
                    controller: controller.downPayment,
                    onChanged: (value) {
                      calculateEMI();
                    },
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
                  ),
                  const SizedBox(height: 10),

                  const Text('Rental Period'),
                  FutureBuilder<List<LoanModel>>(
                    future: controller.getScreeningPeriodsApi(),
                    builder: (context, snapshot) {
                      // if (snapshot.connectionState == ConnectionState.waiting) {
                      //   return CircularProgressIndicator(); // Show loader while fetching
                      // }

                      // if (snapshot.hasError) {
                      //   return Text("Error loading data"); // Handle errors
                      // }

                      List<LoanModel> loanData = snapshot.data ?? [];

                      // Set default selected value when data loads
                      if (loanData.isNotEmpty &&
                          controller.selectedLoan.value == null) {
                        controller.selectedLoan.value = loanData.first;
                      }

                      return DropdownButtonFormField<int>(
                        value: controller.selectedLoan.value?.screeningPeriod,
                        decoration: InputDecoration(
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(100),
                          ),
                        ),
                        isExpanded: true,
                        icon: const Icon(Icons.keyboard_arrow_down),
                        items: loanData.map((loan) {
                          return DropdownMenuItem<int>(
                            value: loan.screeningPeriod,
                            child: Text(loan.screeningPeriod.toString()),
                          );
                        }).toList(),
                        onChanged: (value) {
                          if (value != null) {
                            // Find selected loan data based on screeningPeriod
                            var selectedLoanData = loanData.firstWhere(
                                (loan) => loan.screeningPeriod == value);

                            // Store full selected loan response
                            controller.selectedLoan.value = selectedLoanData;
                            calculateMonthlyRental();

                            print(controller
                                .selectedLoan.value?.typeName); // Villa Loan
                            print(
                                controller.selectedLoan.value?.financeInterest);
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
                  const Text('Monthly Rental'),
                  TextFormField(
                    controller: controller.monthlyRendal,
                    keyboardType: TextInputType.number,
                    enabled: false,
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
                      // calculateEMI();
                    },
                  ),

                  const SizedBox(height: 10),
                  const Text('Loan Amount'),
                  TextFormField(
                    controller: controller.loanAmount,
                    enabled: false,
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
                        return 'Please enter the estimated property value';
                      }
                      return null;
                    },
                  ),

                  const SizedBox(height: 5),

                  // Initial Deposit
                  // const Text(
                  //   'Mortgage Application',
                  //   textAlign: TextAlign.left,
                  //   style: TextStyle(fontWeight: FontWeight.w600),
                  // ),
                  const SizedBox(height: 5),

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
                        calculateEMIAmountValue();
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
                    'Monthly Repayment',
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

                          Navigator.pushNamed(context, "/rent-to-own/calendar");
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

class CalendarPage extends StatefulWidget {
  const CalendarPage({super.key});

  @override
  _CalendarPageState createState() => _CalendarPageState();
}

class _CalendarPageState extends State<CalendarPage> {
  final controller = Get.put(RentToOwnController());
  DateTime? _selectedDay;
  DateTime _initialFocusedDay = DateTime.now();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Repayment',
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
                    ? DateFormat('dd-MM-yyyy').format(controller.selectedDay!)
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
                  if (!selectedDay.isBefore(DateTime.now())) {
                    setState(() {
                      controller.selectedDay = selectedDay;
                    });
                  }
                },
                enabledDayPredicate: (day) {
                  // Disable past dates
                  final now = DateTime.now();
                  return !day.isBefore(DateTime(now.year, now.month, now.day));
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
                  disabledTextStyle: TextStyle(color: Colors.grey), // Optional
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
                    if (controller.selectedDay == null) {
                      Fluttertoast.showToast(
                        msg: "Please select a repayment date",
                        toastLength: Toast.LENGTH_SHORT,
                        gravity: ToastGravity.BOTTOM,
                        backgroundColor: Colors.red,
                        textColor: Colors.white,
                      );
                    } else {
                      Navigator.pushNamed(
                          context, "/rent-to-own/term_sheet_Details");
                      controller.getData(Params.userId as String);
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
    );
  }
}

class PaymentMethodPage extends StatefulWidget {
  const PaymentMethodPage({super.key});

  @override
  _PaymentMethodPageState createState() => _PaymentMethodPageState();
}

class _PaymentMethodPageState extends State<PaymentMethodPage> {
  String selectedPaymentMethod = "";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Payment",
          style: TextStyle(color: baseColor),
        ),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Center(
              child: Text(
                "Make Your First Deposit",
                style: TextStyle(fontSize: 16),
              ),
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
                // Navigate to a page for Bank Transfer
                Navigator.pushNamed(context, "/rent-to-own/paymentPage/bank");
                // Navigator.pushReplacement(
                //   context,
                //   MaterialPageRoute(
                //     builder: (context) => const Rent_To_Own(
                //         startIndex: 5), // Example for Bank Transfer
                //   ),
                // );
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

class BankTransferPage extends StatelessWidget {
  const BankTransferPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Bank Transfer',
          style: TextStyle(color: baseColor, fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
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
                            const SizedBox(width: 8.0),
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
            const Center(
              child: Text(
                "Use this account number for this transaction only",
                textAlign: TextAlign.center,
                style: TextStyle(color: Colors.black),
              ),
            ),
            const Spacer(),
            Center(
              child: ElevatedButton(
                onPressed: () {
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const Rent_To_Own(
                          startIndex: 6), // Start with MortgagePage
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

class Success extends StatefulWidget {
  const Success({super.key});

  @override
  State<Success> createState() => _SuccessState();
}

class _SuccessState extends State<Success> {
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
                    "Congratulations ${controller.profileName} You have made your first deposit",
                    style: TextStyle(fontSize: 10)),
                const SizedBox(height: 20),
                ElevatedButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) => const DashboardPageS("Rent-To-Own"),
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

class TermSheetPageRent extends StatefulWidget {
  const TermSheetPageRent({super.key});

  @override
  State<TermSheetPageRent> createState() => _TermSheetPageRentState();
}

class _TermSheetPageRentState extends State<TermSheetPageRent>
    with SingleTickerProviderStateMixin {
  final controller = Get.put(RentToOwnController());

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

  double cleanNumbers(String input) {
    String cleaned = input.replaceAll(",", "").trim();
    return double.tryParse(cleaned) ?? 0.0;
  }

  @override
  void initState() {
    super.initState();
    // fetchData();
    controller.findApartments();
    controller.findAndSetArea();
    controller.findAndSetCity();
  }

//   Future<void> _fetchCityName() async {
// var cityName = await controller.findAndSetCity(data["city"] ?? 0);

//   }

  @override
  Widget build(BuildContext context) {
    double initialDeposit = double.tryParse(
          controller.propertyValueController.text.replaceAll(',', ''),
        ) ??
        0;

    print("44411${initialDeposit}");
    String todayDate = DateFormat('dd-MM-yyyy').format(DateTime.now());
    String anniversary =
        DateFormat('dd-MM-yyyy').format(controller.selectedDay!);
    String anniversaryDate = controller.selectedDay?.toString() ?? '';
    String estimatedProfileDate =
        controller.calculateProfileDate(anniversaryDate, 16);

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
              const SizedBox(
                height: 5,
              ),
              Align(
                alignment: Alignment.bottomRight,
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.pushNamed(context, "login/propertyView",
                        arguments: controller.apartmentOrMarketplace);
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: baseColor,
                    padding: const EdgeInsets.symmetric(
                        horizontal: 20.0, vertical: 10.0),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20),
                    ),
                  ),
                  child: const Text("View House",
                      style: TextStyle(color: Colors.white, fontSize: 12)),
                ),
              ),
              const SizedBox(height: 0.0),
              _buildSection(
                "House Details",
                [
                  _buildRow("Apartment Type", controller.apartmentName.text),
                  _buildRow("City", controller.cityNameValue.text),
                  _buildRow("Area", controller.areaNameValue.text),
                  _buildRow("Selling Price",
                      "NGN ${controller.propertyValueController.text} "),
                ],
                buttonAction: () {},
              ),
              const SizedBox(height: 16.0),
              _buildSection(
                "Loan Details",
                [
                  _buildRow(
                      "Down Payment", "NGN ${(controller.downPayment.text)} "),
                  _buildRow("Loan", "NGN ${(controller.loanAmount.text)} "),
                  _buildRow("Repayment Period",
                      "${controller.sliderValue.toInt()} Years"),
                  _buildRow("Screening Monthly Rental",
                      "NGN ${(controller.monthlyRendal.text)}"),
                  _buildRow("Monthly Repayment",
                      "NGN ${(controller.monthlyRepaymentController.text.toString())}"),
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
                  _buildRow("Screening Period",
                      "${controller.selectedLoan.value?.screeningPeriod.toString()}Months "),
                  _buildRow(
                    "Estimated Profile Date",
                    controller.formatProfileDate(estimatedProfileDate),
                  ),
                  _buildRow("Total Monthly Rental",
                      "NGN ${formattedEMI((cleanNumbers(controller.propertyValueController.text) * 0.8 - cleanNumbers(controller.downPayment.text)) / 25)}"),
                  _buildRow(
                    "Down Payment",
                    controller.downPayment.text.isNotEmpty
                        ? "NGN ${controller.downPayment.text}"
                        : "-",
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 4.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text("Total Expected Deposit",
                            style: TextStyle(
                                color: Color.fromARGB(255, 44, 44, 44),
                                fontWeight: FontWeight.bold)),
                        Text(
                            "NGN ${formattedEMI((cleanNumbers(controller.downPayment.text) + cleanNumbers(controller.monthlyRendal.text)))}",
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
                    const Text(
                      "Amount to Deposit",
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    Text(controller.downPayment.text.isNotEmpty
                        ? "NGN ${controller.downPayment.text}"
                        : "-")
                  ],
                ),
              ),
              Center(
                child: TextButton(
                  onPressed: () {
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const MortgagePageHome(
                          startIndex: 1,
                        ), // Start with MortgagePageHome
                      ),
                    );
                  },
                  child: Text("Recalculate"),
                ),
              ),
              const SizedBox(height: 24.0),
              Center(
                child: ElevatedButton(
                  onPressed: () => {
                    controller.addRentoOwn(context),
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: baseColor,
                    padding: const EdgeInsets.symmetric(
                        horizontal: 24.0, vertical: 12.0),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20),
                    ),
                  ),
                  child: const Text("Proceed to Payment",
                      style: TextStyle(color: Colors.white)),
                ),
              ),
            ],
          ),
        ));
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

Widget _buildRow(String label, value) {
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

class TermsAndConditionsDialogRentown extends StatelessWidget {
  final Houseview? house;
  final bool? viewBtn;
  const TermsAndConditionsDialogRentown({
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
            // const Center(
            //   child: Text(
            //     'Terms And Conditions',
            //     style: TextStyle(
            //       fontSize: 24,
            //       fontWeight: FontWeight.bold,
            //     ),
            //   ),
            // ),
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
              'KWIK by AGMB is a digital platform for the KWIK Rent-to-Own program. This program helps users gradually save for a 30% down payment over 18 months, instilling a strong savings culture and enabling them to meet Rent-to-Own requirements to purchase verified properties.\n\nPlease note that the KWIK platform is not a regular savings or current account. It has specific terms and is for people on a mission to own a home. Applicants are encouraged to read these Terms carefully and fully understand them before signing up.',
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
                'Enhance the user’s financial profile and improve their chances of Rent-to-Own approval.'),
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
                'Use the platform to monitor your savings, build Rent-to-Own credibility, choose properties, and manage your Rent-to-Own application.'),
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
                    Navigator.pushNamed(context, "/dashBoardPage");
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
                    Navigator.pushNamed(context, "/rent-to-own/term_sheet",
                        arguments: house);
                    // Navigator.pushReplacement(
                    //   context,
                    //   MaterialPageRoute(
                    //     builder: (context) => RentToOwnForm(
                    //       viewBtn: viewBtn, // Pass viewBtn
                    //       house: house, // Pass house
                    //     ),
                    //   ),
                    // );
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
