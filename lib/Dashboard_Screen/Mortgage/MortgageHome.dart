import 'package:ag_mortgage/All_Cards/Get_all_Cards/controller.dart';
import 'package:ag_mortgage/All_Cards/Select_Amount/select_Amount.dart';
import 'package:ag_mortgage/Dashboard_Screen/Mortgage/controller.dart';
import 'package:ag_mortgage/Dashboard_Screen/Mortgage/models.dart';
import 'package:ag_mortgage/Main_Dashboard/dashboard/Dashboard/component.dart';
import 'package:ag_mortgage/const/Image.dart';
import 'package:ag_mortgage/const/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
// ignore: depend_on_referenced_packages
import 'package:table_calendar/table_calendar.dart';

import '../../All_Cards/Add_New_Cards/add_cards.dart';
import '../../All_Cards/Get_all_Cards/all_cards.dart';

// void main() {
//   runApp(const MortgagePage());
// }

// class MortgagePage extends StatelessWidget {
//   const MortgagePage({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return const MaterialApp(
//       debugShowCheckedModeBanner: false,
//       title: 'AG Mortgage',
//       home: MortgagePage(),
//     );
//   }
// }

class MortgagePage extends StatefulWidget {
  final int startIndex;
  const MortgagePage({super.key, this.startIndex = 0});
  @override
  // ignore: library_private_types_in_public_api
  _MortgagePageState createState() => _MortgagePageState();
}

class _MortgagePageState extends State<MortgagePage> {
  int _currentStepIndex = 0;
  @override
  void initState() {
    super.initState();
    _currentStepIndex = widget.startIndex; // Initialize with provided index
  }

  final List<Widget> _steps = [
    const Landing_Mortgage(),
    const MortgageFormPage(),
    const CalendarPage(),
    const ADD_CardDetailsPage(),
    const PaymentMethodPage(),
    const Get_All_Cards(),
    const CardPaymentPage(),
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
        )
      ),
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
                        Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const MortgagePage(
                                startIndex: 1), // Start with MortgagePage
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
  const MortgageFormPage({super.key});

  @override
  _MortgageFormPageState createState() => _MortgageFormPageState();
}

class _MortgageFormPageState extends State<MortgageFormPage> {
  final controller = Get.put(MortgagController());
  MortgagController controllerFeild = MortgagController();
  final _formKey = GlobalKey<FormState>();
// Default value for slider

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
                      return Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          // City Dropdown
                          DropdownButtonFormField<int>(
                            value: controller.selectedCity,
                            decoration: InputDecoration(
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(100),
                              ),
                            ),
                            isExpanded: true,
                            icon: const Icon(Icons.keyboard_arrow_down),
                            items: citySnapshot.data!.map((item) {
                              return DropdownMenuItem<int>(
                                value:
                                    item.id, // Use directly since it's an int
                                child: Text(item.name ?? 'Unknown Name'),
                              );
                            }).toList(),
                            onChanged: (value) {
                              setState(() {
                                controller.selectedCity = value;
                                controller.fetchAreasByCity(value.toString());
                                controller.selectedArea = null;
                              });
                            },
                            validator: (value) {
                              if (value == null) {
                                return 'Please select a city';
                              }
                              return null;
                            },
                          ),

                          const SizedBox(height: 10),
                          const Text('Area'),
                          // Area Dropdown
                          FutureBuilder<List<SeletArea>>(
                            future: controller.selectedCity == null
                                ? Future.value([])
                                : controller.fetchAreasByCity(
                                    controller.selectedCity.toString()),
                            builder: (context, areaSnapshot) {
                              if (!areaSnapshot.hasData ||
                                  areaSnapshot.data!.isEmpty) {
                                return const Text('No areas found.');
                              }

                              return DropdownButtonFormField<int>(
                                value: controller.selectedArea,
                                decoration: InputDecoration(
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(100),
                                  ),
                                ),
                                isExpanded: true,
                                icon: const Icon(Icons.keyboard_arrow_down),
                                items: areaSnapshot.data!.map((item) {
                                  return DropdownMenuItem<int>(
                                    value: item
                                        .id, // Use directly since it's an int
                                    child: Text(item.name ?? 'Unknown Area'),
                                  );
                                }).toList(),
                                onChanged: (value) {
                                  setState(() {
                                    controller.selectedArea = value;
                                  });
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
                        ],
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
                    ),
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
                    keyboardType: TextInputType.number,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(100),
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
                      });
                    },
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
                    ),
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
                                  const MortgagePage(startIndex: 2),
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
                    controller.addMortgageForm(context);
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
                      builder: (context) => const MortgagePage(
                          startIndex: 9), // Example for Bank Transfer
                    ),
                  );
                } else if (selectedPaymentMethod == "Card") {
                  // Navigate to a page for Card payment
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const MortgagePage(
                          startIndex: 5), // Example for Card payment
                    ),
                  );
                } else {
                  // Default case: navigate to MortgagePage with startIndex as 3 (fallback case)
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                      builder: (context) =>
                          const MortgagePage(startIndex: 9), // Default case
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


class TermSheetPage extends StatelessWidget {
  const TermSheetPage({super.key});

  @override
  Widget build(BuildContext context) {
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
                _buildRow("Apartment Type", "Studio"),
                _buildRow("City", "Lagos"),
                _buildRow("Area", "Ogunlana Area"),
                _buildRow("Selling Price", "NGN 40,000,000"),
              ],
              buttonAction: () {},
            ),
            const SizedBox(height: 16.0),
            _buildSection(
              "Loan Details",
              [
                _buildRow("Initial Deposit", "NGN 500,000"),
                _buildRow("Loan", "NGN 33,200,000"),
                _buildRow("Repayment Period", "10 Years"),
                _buildRow("Monthly Repayment", "NGN 350,000"),
                _buildRow("Starting Date", "1 August, 2024"),
                _buildRow("Next Anniversary Date", "30 September, 2024"),
              ],
            ),
            const SizedBox(height: 16.0),
            _buildSection(
              "Saving & Profiling",
              [
                _buildRow("Screening Period", "18 Months"),
                _buildRow("Estimated Profile Date", "30 January, 2026"),
                _buildRow("Estimated Total Monthly Savings", "NGN 6,300,000"),
                _buildRow("Initial Deposit", "NGN 500,000"),
                _buildRow("Minimum Total Expected Saving", "NGN 6,800,000"),
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
                        "Estimated Mortgage Month",
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                      Text("February 2026"),
                    ],
                  ),
                  TextButton(
                    onPressed: () {},
                    child: const Text("Recalculate"),
                  ),
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
                      builder: (context) => const DashboardPageS("Mortgage"), // Start with MortgagePage
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
                child: const Text("Proceed to Home",
                    style: TextStyle(color: Colors.white)),
              ),
            ),
          ],
        ),
      ),
    );
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
                      builder: (context) => const MortgagePage(
                          startIndex: 7), // Start with MortgagePage
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
