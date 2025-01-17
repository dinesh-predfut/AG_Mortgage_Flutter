import 'package:ag_mortgage/All_Cards/Get_all_Cards/all_cards.dart';
import 'package:ag_mortgage/Dashboard_Screen/dashboard_Screen.dart';
import 'package:ag_mortgage/const/Image.dart';
import 'package:ag_mortgage/const/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';
// ignore: depend_on_referenced_packages
import 'package:table_calendar/table_calendar.dart';

import '../../All_Cards/Add_New_Cards/add_cards.dart';
import '../../All_Cards/Select_Amount/select_Amount.dart';

class Investment extends StatefulWidget {
  final int startIndex;
  const Investment({super.key, this.startIndex = 0});

  @override
  State<Investment> createState() => __InvestmenStateState();
}

class __InvestmenStateState extends State<Investment> {
  int _currentStepIndex = 0;
  @override
  void initState() {
    super.initState();
    _currentStepIndex = widget.startIndex;
  }

  final List<Widget> _steps = [
    const InvestmentFormPage(),
     const CardPaymentPage(),
   const ADD_CardDetailsPage(),
     const ALL_Card(),
    const CardPaymentPage(),
    const Success(),
    const CalendarPage(),
    const TermSheetPage(),
    const BankTransferPage()
  ];
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

class InvestmentFormPage extends StatefulWidget {
  const InvestmentFormPage({super.key});

  @override
  InvestmentFormPageState createState() => InvestmentFormPageState();
}

class InvestmentFormPageState extends State<InvestmentFormPage> {
  final _formKey = GlobalKey<FormState>();
  // ignore: non_constant_identifier_names
  final TextEditingController _interest = TextEditingController();
  final TextEditingController _maturityDate = TextEditingController();
  final TextEditingController _yield = TextEditingController();

  final TextEditingController _amount = TextEditingController();

  String? _selectedApartmentType;

  DateTime? _selectedStartDate; // Holds the selected start date

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: _selectedStartDate ?? DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(2100),
    );
    if (pickedDate != null && pickedDate != _selectedStartDate) {
      setState(() {
        _selectedStartDate = pickedDate;
      });
    }
  }

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
        title: const Text(
          'Construction Finance',
          style:
              TextStyle(color: Color(0xFF633095), fontWeight: FontWeight.w800),
        ),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Center(
                child: Text(
                  'Let us know your preference',
                  style: TextStyle(fontSize: 16, color: Colors.grey),
                ),
              ),
              const SizedBox(height: 10),
              const Text('Amount (<NGN 500,000)'),
              TextFormField(
                controller: _amount,
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(100),
                  ),
                ),
              ),
              const SizedBox(height: 10),
              const Text('Duration'),
              DropdownButtonFormField<String>(
                value: _selectedApartmentType,
                items: const [
                  DropdownMenuItem(value: 'BANK-1', child: Text('BANK-1')),
                  DropdownMenuItem(value: 'BANK-2', child: Text('BANK-2')),
                ],
                onChanged: (value) {
                  setState(() {
                    _selectedApartmentType = value;
                  });
                },
                decoration: InputDecoration(
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(100),
                  ),
                ),
              ),
              const SizedBox(height: 10),
              const Text('Start Date'),
              GestureDetector(
                onTap: () => _selectDate(context),
                child: Container(
                  width: 360,
                  height: 60,
                  padding:
                      const EdgeInsets.symmetric(vertical: 20, horizontal: 30),
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.grey),
                    borderRadius: BorderRadius.circular(100),
                  ),
                  child: Text(
                    _selectedStartDate == null
                        ? ''
                        : '${_selectedStartDate!.toLocal()}'.split(' ')[0],
                    style: TextStyle(color: Colors.black54),
                  ),
                ),
              ),

              const SizedBox(height: 10),
              if (_selectedStartDate != null) ...[
                const Text('Interest (%)'),
                TextFormField(
                  controller: _interest,
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(100),
                    ),
                  ),
                ),
                const SizedBox(height: 10),
                const Text('Maturity Date'),
                TextFormField(
                  controller: _maturityDate,
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(100),
                    ),
                  ),
                ),
                const SizedBox(height: 10),
                const Text('Yield'),
                TextFormField(
                  controller: _yield,
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(100),
                    ),
                  ),
                ),
              ],
              // Add other form fields here
              const SizedBox(height: 30),
              Center(
                child: ElevatedButton(
                  onPressed: () {
                    if (_formKey.currentState!.validate()) {
                      Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const Investment(
                                startIndex: 1), // Start with MortgagePage
                          ),
                        );
                      // Perform form submission
                      ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(content: Text('Form Submitted!')));
                    }
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.deepPurple,
                    padding: const EdgeInsets.symmetric(
                        vertical: 16, horizontal: 20),
                  ),
                  child: const Text(
                    'Proceed',
                    style: TextStyle(fontSize: 16, color: Colors.white),
                  ),
                ),
              )
            ],
          ),
        ),
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
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const Investment(startIndex: 7),
                      ),
                    );
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


class PaymentPage extends StatefulWidget {
  const PaymentPage({super.key});

  @override
  _PaymentPageState createState() => _PaymentPageState();
}

class _PaymentPageState extends State<PaymentPage> {
  // Create a TextEditingController to manage the TextFormField
  final TextEditingController _amountController = TextEditingController();

  // Function to handle amount button clicks
  void _setAmount(int amount) {
    setState(() {
      _amountController.text = " $amount";
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
            Container(
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
                        icon: const Icon(Icons.more_vert, color: Colors.white),
                      ),
                    ],
                  ),
                  const SizedBox(height: 30),
                  const Text(
                    "Adeyemi Pelumi",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 10),
                  const Text(
                    "3098 9576 1876 6521",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 10),
                  const Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "CVV: 010",
                        style: TextStyle(color: Colors.white),
                      ),
                      Text(
                        "EXP: 12/29",
                        style: TextStyle(color: Colors.white),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            const SizedBox(height: 20),
            TextFormField(
              controller: _amountController,
              decoration: InputDecoration(
                prefixText: "NGN ",
                contentPadding:
                    const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                  borderSide: const BorderSide(color: Colors.deepPurple),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                  borderSide:
                      const BorderSide(color: Colors.deepPurple, width: 2),
                ),
              ),
            ),
            const SizedBox(height: 20),
            Wrap(
              spacing: 10,
              runSpacing: 10,
              children: [
                _amountButton(context, "#100,000", 100000),
                _amountButton(context, "#200,000", 200000),
                _amountButton(context, "#300,000", 300000),
                _amountButton(context, "#400,000", 400000),
                _amountButton(context, "#500,000", 500000),
                _amountButton(context, "#600,000", 600000),
              ],
            ),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: () {
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const Investment(
                        startIndex: 5), // Start with MortgagePage
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
                onPressed: () {
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                      builder: (context) =>
                          const DashboardPage(), // Start with MortgagePage
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
                      builder: (context) => const Investment(
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
