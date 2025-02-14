import 'dart:math';

import 'package:ag_mortgage/Dashboard_Screen/Market_Place/main.dart';
import 'package:ag_mortgage/Dashboard_Screen/Mortgage/MortgageHome.dart';
import 'package:ag_mortgage/Dashboard_Screen/Mortgage/MortgagePage.dart';
import 'package:ag_mortgage/Dashboard_Screen/Mortgage/controller.dart';
import 'package:ag_mortgage/Dashboard_Screen/Rent-To-own/controller.dart';
import 'package:ag_mortgage/Dashboard_Screen/Rent-To-own/models.dart';
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
    const Success()
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
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 16.0),
              child: Text(
                "Rent to Own",
                style: TextStyle(
                  fontSize: 24.0,
                  fontWeight: FontWeight.bold,
                  color: Colors.indigo,
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
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const Rent_To_Own(
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
    // Update formData with the calculated monthly rent
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
    controller.downPayment.text = formattedEMI(TotalinitialDeposit);
    // ignore: non_constant_identifier_names
    double LoanCalculationAmount = propertyValue * 0.6;
    controller.loanAmount.text = formattedEMI(LoanCalculationAmount);
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
                    child: const Text("View House",
                        style: TextStyle(color: Colors.white, fontSize: 12)),
                  ),
                ),
              const SizedBox(height: 10),
              // Apartment Type Dropdown
              const Text('House Type'),
              DropdownButtonFormField<int>(
                value: controller.selectedApartmentType,
                items: const [
                  DropdownMenuItem(value: 1, child: Text('Studio')),
                  DropdownMenuItem(
                      value: 2, child: Text('1 Bedroom Apartment')),
                  DropdownMenuItem(
                      value: 3, child: Text('2 Bedroom Apartment')),
                  DropdownMenuItem(
                      value: 4, child: Text('3 Bedroom Apartment')),
                ],
                onChanged: (value) {
                  setState(() {
                    controller.selectedApartmentType = value;
                  });
                },
                // validator: (value) {
                //   if (value == null || value.isEmpty) {
                //     return 'Please select an apartment type';
                //   }
                //   return null;
                // },
                decoration: InputDecoration(
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(100),
                  ),
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
                      if (value == null || value.trim().isEmpty) {
                        return 'Please enter the estimated property value';
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
                  const Text('Monthly Rendal'),
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
                    validator: (value) {
                      if (value == null || value.trim().isEmpty) {
                        return 'Please enter the estimated property value';
                      }
                      return null;
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
                                    const Rent_To_Own(startIndex: 2)),
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
                        backgroundColor: Colors.deepPurple,
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
  DateTime _selectedDay = DateTime.now();
  DateTime _focusedDay = DateTime.now();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Anniversaryss'),
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
                ' ${DateFormat('dd-MM-yyyy').format(controller.selectedDay)}',
                style: const TextStyle(fontSize: 25, color: Colors.black),
              ),
              TableCalendar(
                focusedDay: _focusedDay,
                firstDay: DateTime(2000),
                lastDay: DateTime(2100),
                selectedDayPredicate: (day) {
                  return isSameDay(controller.selectedDay, day);
                },
                onDaySelected: (selectedDay, focusedDay) {
                  setState(() {
                    controller.selectedDay = selectedDay;
                    _focusedDay = focusedDay; // Update focusedDay
                  });
                },
                calendarStyle: const CalendarStyle(
                  selectedDecoration: BoxDecoration(
                    color: Colors.deepPurple,
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
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const Rent_To_Own(startIndex: 3),
                      ),
                    );

                    controller.getData(Params.userId as String);
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.deepPurple,
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
                // Navigate to a page for Bank Transfer
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const Rent_To_Own(
                        startIndex: 5), // Example for Bank Transfer
                  ),
                );
              },
              //
              style: ElevatedButton.styleFrom(
                minimumSize: const Size.fromHeight(50),
                backgroundColor: Colors.deepPurple,
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
                      builder: (context) => const Rent_To_Own(
                          startIndex: 6), // Start with MortgagePage
                    ),
                  );
                },
                style: ElevatedButton.styleFrom(
                  padding: const EdgeInsets.symmetric(
                      horizontal: 24.0, vertical: 12.0),
                  backgroundColor: Colors.deepPurple,
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

  int cleanNumbers(dynamic amount) {
    if (amount == null) return 0;

    // Convert the amount to a string and remove commas
    String amountString = amount.toString().replaceAll(',', '');

    return int.tryParse(amountString) ?? 0;
  }

  @override
  void initState() {
    super.initState();
    fetchData();

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
                  onPressed: () {},
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
                  _buildRow("Apartment Type",
                      controller.selectedApartmentType.toString()),
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
                  _buildRow(
                      "Down Payment", "NGN ${(controller.loanAmount.text)} "),
                  _buildRow("Repayment Period",
                      "${controller.sliderValue.toInt()} Years"),
                  _buildRow("Screening Monthly Rental",
                      "NGN ${(controller.monthlyRendal.text)}"),
                  _buildRow("Monthly Repayment",
                      "NGN ${(controller.monthlyRepaymentController.text.toString())}"),
                  _buildRow("Starting Date", todayDate),
                  _buildRow("Next Anniversary Date", anniversary),
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
                      "NGN ${(cleanNumbers(controller.propertyValueController.text) * 0.8 - cleanNumbers(controller.downPayment.text)) / 25}"),
                  _buildRow(
                    "Down Payment",
                    controller.downPayment.text.isNotEmpty ? "NGN ${controller.downPayment.text}"
                        : "-",
                  ),
                     _buildRow(
                    "Total Expected Deposit",
                    "NGN ${(cleanNumbers(controller.downPayment.text) + cleanNumbers(controller.monthlyRendal.text))}"),
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
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          "Estimated Mortgage Month",
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                        Text(
                          controller
                              .formatProfileDateName(estimatedProfileDate),
                        )
                      ],
                    ),
                    TextButton(
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
                      child: const Text("Recalculate"),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 24.0),
              Center(
                child: ElevatedButton(
                  onPressed: () => {
                    controller.addRentoOwn(context),
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const Rent_To_Own(
                          startIndex: 4,
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
