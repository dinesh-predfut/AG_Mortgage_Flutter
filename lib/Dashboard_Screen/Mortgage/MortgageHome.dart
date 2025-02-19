import 'dart:math';

import 'package:ag_mortgage/All_Cards/Get_all_Cards/controller.dart';
import 'package:ag_mortgage/All_Cards/Select_Amount/select_Amount.dart';
import 'package:ag_mortgage/Dashboard_Screen/Market_Place/Details_Page/models.dart';
import 'package:ag_mortgage/Dashboard_Screen/Market_Place/main.dart';
import 'package:ag_mortgage/Dashboard_Screen/Mortgage/controller.dart';
import 'package:ag_mortgage/Dashboard_Screen/Mortgage/models.dart';
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
// ignore: depend_on_referenced_packages
import 'package:table_calendar/table_calendar.dart';

import '../../All_Cards/Add_New_Cards/add_cards.dart';
import '../../All_Cards/Get_all_Cards/all_cards.dart';

class MortgagePageHome extends StatefulWidget {
  final int startIndex;
  const MortgagePageHome({super.key, this.startIndex = 0});
  @override
  // ignore: library_private_types_in_public_api
  _MortgagePageHomeState createState() => _MortgagePageHomeState();
}

class _MortgagePageHomeState extends State<MortgagePageHome> {
  int _currentStepIndex = 0;
  @override
  void initState() {
    super.initState();
    _currentStepIndex = widget.startIndex;
    // Initialize with provided index
  }

  final List<Widget> _steps = [
    const Landing_Mortgage(),
    const MortgageFormPage(),
    const CalendarPage(),
    const TermSheetPage(),
    const ADD_CardDetailsPage(),
    const PaymentMethodPage(),
    const Get_All_Cards(),
    const CardPaymentPage(),
    const TermSheetPage(),
    const BankTransferPage(),
    const TermsHomePage()
  ];

  void _goToNextStep() {
    setState(() {
      if (_currentStepIndex < _steps.length - 1) {
        _currentStepIndex++;
      }
    });
  }

  void _goTomMortgageFormPage() {
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
class Landing_Mortgage extends StatelessWidget {
  const Landing_Mortgage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          leading: IconButton(
        icon: const Icon(Icons.arrow_back),
        onPressed: () {
          Navigator.pop(context);
        },
      )),
      body: Stack(children: [
        Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset(Images.mortgage),
              const SizedBox(height: 10),
              const Text(
                'Mortgage',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 10),
              const Text(
                "Save Smart, Own Your Home!",
                style: TextStyle(
                  fontSize: 14,
                  color: Colors.black,
                ),
              ),
              const Text(
                "Build your down payment with interest and prove you’re mortgage ready. Start Saving today and move closer to owning your dream apartment in any Nigerian city. Your Journey to homeownership starts here.",
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 14,
                  color: Colors.grey,
                ),
              ),
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    ElevatedButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const MortgagePageHome(
                                startIndex: 1), // Start with MortgagePageHome
                          ),
                        );
                      },
                      //  onPressed: _goToPreviousStep,
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
                  ],
                ),
              ),
            ],
          ),
        ),
      ]),
    );
  }
}

class MortgageFormPage extends StatefulWidget {
  // ignore: prefer_typing_uninitialized_variables
  final Houseview? house;
  final bool? viewBtn;
  const MortgageFormPage({
    Key? key,
    this.viewBtn,
    this.house,
  }) : super(key: key);
  @override
  _MortgageFormPageState createState() => _MortgageFormPageState();
}

class _MortgageFormPageState extends State<MortgageFormPage> {
  final controller = Get.put(MortgagController());
  MortgagController controllerFeild = MortgagController();

  @override
  void initState() {
    super.initState();
    calculateEMI();
    final initialAmount = controller.monthlyRepaymentController.text;
    controller.initialDepositController.text = '0';
    if (widget.house != null) {
      controller.propertyValueController.text =
          formattedEMI(widget.house!.price);
      controller.selectedCity = widget.house!.city;
      controller.selectedArea = widget.house!.localGovernmentArea;
      controller.selectedApartmentType = widget.house!.typeOfApartment;
      // Calculate the initial deposit (30% of the property value)
      double propertyValue = widget.house!.price.toDouble();
      controller.monthlyRepaymentController.text = "";
      controller.apartmentOrMarketplace = widget.house!.id;
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

  void calculateEMI() {
    double propertyValue = double.tryParse(
            controller.propertyValueController.text.replaceAll(',', '')) ??
        0;
    double initialDeposit = double.tryParse(
            controller.initialDepositController.text.replaceAll(',', '')) ??
        0;
    // Calculate initial deposit and loan amount
    // ignore: non_constant_identifier_names
    double TotalinitialDeposit = propertyValue * 0.3; // 30% of property value

    if (initialDeposit > 0) {
      var calculateTotalamount = TotalinitialDeposit - initialDeposit;
      // Calculate monthly repayment
      var monthlyRepayment =
          (calculateTotalamount) / 18; // 18 months repayment period
      print('Response body: ${monthlyRepayment}');
      controller.monthlyRepaymentController.text =
          formattedEMI(monthlyRepayment);
      controller.initialDepositController.text = formattedEMI(initialDeposit);
      controller.propertyValueController.text = formattedEMI(propertyValue);
    } else {
      var withoutuInitialAmount = (TotalinitialDeposit) / 18;
      controller.monthlyRepaymentController.text =
          formattedEMI(withoutuInitialAmount);
      controller.propertyValueController.text = formattedEMI(propertyValue);
    }

    // Update UI
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Mortgage'),
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
              const Text('Apartment Type'),
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
                            []), // If selectedCity is null, return an empty list
                    builder: (context, areaSnapshot) {
                      List<SeletArea> areaData =
                          areaSnapshot.data ?? []; // Prevent null errors

                      return DropdownButtonFormField<int>(
                        value: controller.selectedArea,
                        decoration: InputDecoration(
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(100),
                          ),
                        ),
                        isExpanded: true,
                        icon: const Icon(Icons.keyboard_arrow_down),
                        items: areaData.isNotEmpty
                            ? areaData.map((item) {
                                return DropdownMenuItem<int>(
                                  value: item.id,
                                  child: Text(item.name ?? 'Unknown Area'),
                                );
                              }).toList()
                            : [], // Prevents mapping on null

                        onChanged: (value) {
                          if (value != null) {
                            setState(() {
                              controller.selectedArea = value;
                            });
                            // controller.findAndSetArea();
                          }
                        },
                        validator: (value) {
                          if (value == null) {
                            return 'Please select an area';
                          }
                          return null;
                        },
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
                  const Text('Initial Deposit (Optional)'),
                  TextFormField(
                    controller: controller.initialDepositController,
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

                  // Loan Repayment Period Slider
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
                        calculateEMI();
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
                                  const MortgagePageHome(startIndex: 2),
                            ),
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
  final controller = Get.put(MortgagController());
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
                        builder: (context) => ChangeNotifierProvider.value(
                          value: Provider.of<MortgagController>(context,
                              listen: false),
                          child: const MortgagePageHome(startIndex: 3),
                        ),
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
              leading: const Icon(Icons.credit_card),
              title: const Text("Card"),
              trailing: Radio<String>(
                value: "Card",
                groupValue: selectedPaymentMethod,
                onChanged: (value) {
                  setState(() {
                    selectedPaymentMethod = value!;
                  });
                },
              ),
            ),
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
                      builder: (context) => const MortgagePageHome(
                          startIndex: 9), // Example for Bank Transfer
                    ),
                  );
                } else if (selectedPaymentMethod == "Card") {
                  // Navigate to a page for Card payment
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const MortgagePageHome(
                          startIndex: 6), // Example for Card payment
                    ),
                  );
                } else {
                  // Default case: navigate to MortgagePageHome with startIndex as 3 (fallback case)
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                      builder: (context) =>
                          const MortgagePageHome(startIndex: 9), // Default case
                    ),
                  );
                }
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

class TermSheetPage extends StatefulWidget {
  const TermSheetPage({super.key});

  @override
  State<TermSheetPage> createState() => _TermSheetPageState();
}

class _TermSheetPageState extends State<TermSheetPage>
    with SingleTickerProviderStateMixin {
  final controller = Get.put(MortgagController());

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
    controller.fetchCitiesAndAreas();
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
                  // _buildRow("City", controller.findAndSetArea(controller.selectedArea)),
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
                  _buildRow("Initial Deposit",
                      "NGN ${controller.initialDepositController.text.toString()} "),
                  _buildRow("Loan", "NGN ${(initialDeposit * 0.3)} "),
                  _buildRow("Repayment Period",
                      "${controller.sliderValue.toInt()} Years"),
                  _buildRow("Monthly Repayment",
                      controller.monthlyRepaymentController.text.toString()),
                  _buildRow("Starting Date", todayDate),
                  _buildRow("Next Anniversary Date", anniversary),
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
                      "NGN ${controller.monthlyRepaymentController.text}"),
                  _buildRow("Initial Deposit",
                      "NGN ${controller.initialDepositController.text}"),
                  _buildRow("Minimum Total Expected Saving",
                      "NGN ${(initialDeposit * 0.7)} "),
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
                  onPressed: () {
                     controller.addMortgageForm(context);
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const MortgagePageHome(
                          startIndex: 5,
                        ), // Start with MortgagePageHome
                      ),
                    );
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
                      builder: (context) => const MortgagePageHome(
                          startIndex: 7), // Start with MortgagePageHome
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

class TermsHomePage extends StatefulWidget {
  const TermsHomePage({super.key});

  @override
  _TermsHomePageState createState() => _TermsHomePageState();
}

class _TermsHomePageState extends State<TermsHomePage> {
  // Function to show the Terms and Conditions dialog
  void _showTermsAndConditionsDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => TermsAndConditionsDialog(
        onAccept: () {
          Navigator.pop(context); // Close dialog and proceed
          // Handle the accept logic (e.g., navigate to the next screen)
        },
        onDecline: () {
          Navigator.pop(context); // Close dialog
          // Handle the decline logic (e.g., show a message or exit)
        },
      ),
    );
  }

  @override
  void initState() {
    super.initState();
    // Show the Terms and Conditions dialog as soon as the app starts
    Future.delayed(Duration.zero, () {
      _showTermsAndConditionsDialog(context);
    });
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold();
  }
}

class TermsAndConditionsDialog extends StatelessWidget {
  final VoidCallback onAccept;
  final VoidCallback onDecline;

  const TermsAndConditionsDialog({
    Key? key,
    required this.onAccept,
    required this.onDecline,
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
            const Center(
              child: Text(
                'Terms And Conditions',
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
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
              'KWIK by AGMB is a digital platform for the KWIK Mortgage program. This program helps users gradually save for a 30% down payment over 18 months, instilling a strong savings culture and enabling them to meet mortgage requirements to purchase verified properties.\n\nPlease note that the KWIK platform is not a regular savings or current account. It has specific terms and is for people on a mission to own a home. Applicants are encouraged to read these Terms carefully and fully understand them before signing up.',
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
                'Enhance the user’s financial profile and improve their chances of mortgage approval.'),
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
                'Use the platform to monitor your savings, build mortgage credibility, choose properties, and manage your mortgage application.'),
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
                  onPressed: () {
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const MortgagePageHome(
                            startIndex: 1), // Start with MortgagePageHome
                      ),
                    );
                  },
                  child: const Text('Accept'),
                ),
                ElevatedButton(
                  onPressed: () {
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const MortgagePageHome(
                            startIndex: 0), // Start with MortgagePageHome
                      ),
                    );
                  },
                  child: const Text('Decline'),
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
