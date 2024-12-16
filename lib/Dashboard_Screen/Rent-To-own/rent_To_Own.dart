import 'package:ag_mortgage/Dashboard_Screen/Mortgage/MortgageHome.dart';
import 'package:ag_mortgage/const/Image.dart';
import 'package:ag_mortgage/const/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class Rent_To_Own extends StatefulWidget {
  final int startIndex;
  const Rent_To_Own({super.key, this.startIndex = 0});
  @override
  // ignore: library_private_types_in_public_api
  _Rent_To_OwnState createState() => _Rent_To_OwnState();
}

class _Rent_To_OwnState extends State<Rent_To_Own> {
  int _currentStepIndex = 0;
  @override
  void initState() {
    super.initState();
    _currentStepIndex = widget.startIndex; // Initialize with provided index
  }

  final List<Widget> _steps = [
    RentToOwnLanding(),
    RentToOwnForm(),
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
                          startIndex: 1), // Start with MortgageHome
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
  const RentToOwnForm({Key? key}) : super(key: key);

  @override
  _RentToOwnFormState createState() => _RentToOwnFormState();
}

class _RentToOwnFormState extends State<RentToOwnForm> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _monthlyRepaymentController =
      TextEditingController();
  double _sliderValue = 10;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Rent-to-Own'),
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
                  'Move in as a tenant and convert to home owner',
                  style: TextStyle(fontSize: 16, color: Colors.grey),
                ),
              ),
              const SizedBox(height: 10),
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
              const Text(
                "Tenancy Application",
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
              ),
              const SizedBox(height: 10),
              const Text('House Type'),
              DropdownButtonFormField<String>(
                items: const [
                  DropdownMenuItem(
                      value: 'Apartment', child: Text('Apartment')),
                  DropdownMenuItem(value: 'House', child: Text('House')),
                ],
                onChanged: (value) {},
                decoration: InputDecoration(
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(100),
                  ),
                ),
              ),
              const SizedBox(height: 20),
              const Text('City'),
              DropdownButtonFormField<String>(
                items: const [
                  DropdownMenuItem(value: 'City 1', child: Text('City 1')),
                  DropdownMenuItem(value: 'City 2', child: Text('City 2')),
                ],
                onChanged: (value) {},
                decoration: InputDecoration(
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(100),
                  ),
                ),
              ),
              const SizedBox(height: 10),
              const Text('Area'),
              DropdownButtonFormField<String>(
                items: const [
                  DropdownMenuItem(value: 'Area 1', child: Text('Area 1')),
                  DropdownMenuItem(value: 'Area 2', child: Text('Area 2')),
                ],
                onChanged: (value) {},
                decoration: InputDecoration(
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(100),
                  ),
                ),
              ),
              const SizedBox(height: 10),
              const Text('Estimated Property Value'),
              TextFormField(
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(100),
                  ),
                ),
              ),
              const SizedBox(height: 10),
              const Text('Deposit (< 40%)'),
              TextFormField(
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(100),
                  ),
                ),
              ),
              const SizedBox(height: 10),
              const Text('Estimated Monthly Rental Amount'),
              TextFormField(
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(100),
                  ),
                ),
              ),
              const SizedBox(height: 10),
              const SizedBox(height: 10),
              const Text(
                "Tenancy Application",
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
              ),
              const SizedBox(height: 10),
              // Loan Repayment Period Slider

              // Repayment Period
              const Text('Estimated Property Value'),
              SizedBox(
                width: double.infinity, // Ensures full width
                child: Container(
                  padding: const EdgeInsets.all(20),
                  decoration: BoxDecoration(
                    color: const Color.fromRGBO(252, 251, 255, 1), //
                    border: Border.all(color: Colors.grey),
                    borderRadius: BorderRadius.circular(100),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black
                            .withOpacity(0.1), // Shadow color with transparency
                        blurRadius: 8, // Softness of the shadow
                        offset:
                            const Offset(0, 4), // Position of the shadow (x, y)
                      ),
                    ],
                  ),
                  child: const Text(
                    'NGN 100,0000',
                    textAlign:
                        TextAlign.center, // Centers the text horizontally
                  ),
                ),
              ),
              const SizedBox(height: 10),
              const Text('Select Loan Repayment Period'),
              Slider(
                value: _sliderValue,
                min: 1,
                max: 20,
                divisions: 19,
                label: '${_sliderValue.toInt()} Years',
                onChanged: (value) {
                  setState(() {
                    _sliderValue = value; // Update slider value
                  });
                },
              ),
              const SizedBox(height: 10),
              const Text('Repayment Period'),
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
                    '${_sliderValue.toInt()} Years', // Dynamically update the text
                    textAlign: TextAlign.center,
                    style: const TextStyle(fontSize: 18),
                  ),
                ),
              ),
              const SizedBox(height: 30),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () {
                    if (_formKey.currentState!.validate()) {
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const Rent_To_Own(
                              startIndex: 2),
                        ),
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
        ),
      ),
    );
  }

  @override
  void dispose() {
    _monthlyRepaymentController.dispose();
    super.dispose();
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
                        startIndex: 3), // Example for Bank Transfer
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
                          startIndex: 4), // Start with MortgageHome
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
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const MortgageHome(), // Start with MortgageHome
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