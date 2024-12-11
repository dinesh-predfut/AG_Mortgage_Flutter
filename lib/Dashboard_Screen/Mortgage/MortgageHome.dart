import 'package:ag_mortgage/Dashboard_Screen/Mortgage/Apply_From/form.dart';
import 'package:ag_mortgage/const/Image.dart';
import 'package:ag_mortgage/const/colors.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
// ignore: depend_on_referenced_packages
import 'package:table_calendar/table_calendar.dart';
void main() {
  runApp(MortgageHome());
}

class MortgageHome extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'AG Mortgage',
      home: HomePage(),
    );
  }
}

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('AG Mortgage'),
        backgroundColor: Colors.deepPurple,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            const Text(
              'Hello, Pelumi 👋',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            const Text(
              'What brings you to AG Mortgage Bank Plc today?',
              style: TextStyle(fontSize: 16),
            ),
            const SizedBox(height: 16),
            Expanded(
              child: ListView(
                children: [
                  MenuButton(
                    title: 'Mortgage',
                    icon: Icons.home,
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (_) => const MortgagePage(),
                        ),
                      );
                    },
                  ),
                  MenuButton(
                    title: 'Rent to Own',
                    icon: Icons.key,
                    onTap: () {},
                  ),
                  MenuButton(
                    title: 'Construction Finance',
                    icon: Icons.construction,
                    onTap: () {},
                  ),
                  MenuButton(
                    title: 'Investment',
                    icon: Icons.trending_up,
                    onTap: () {},
                  ),
                  MenuButton(
                    title: 'Marketplace',
                    icon: Icons.shopping_cart,
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (_) => const MortgagePage(),
                        ),
                      );
                    },
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class MenuButton extends StatelessWidget {
  final String title;
  final IconData icon;
  final VoidCallback onTap;

  const MenuButton({
    Key? key,
    required this.title,
    required this.icon,
    required this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        margin: const EdgeInsets.symmetric(vertical: 8),
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: Colors.deepPurple,
          borderRadius: BorderRadius.circular(8),
        ),
        child: Row(
          children: [
            Icon(icon, color: Colors.white),
            const SizedBox(width: 16),
            Text(
              title,
              style: const TextStyle(color: Colors.white, fontSize: 16),
            ),
          ],
        ),
      ),
    );
  }
}

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
    MortgageFormPage(),
    CalendarPage(),
    const MortgageStep4(),
    const MortgageStep5(),
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
      // bottomNavigationBar: BottomNavigationBar(
      //   currentIndex: 0, // Keep global sync if needed
      //   onTap: (index) {
      //     // Prevent bottom bar interaction in chained pages
      //     Navigator.pop(context); // Go back to global bottom nav
      //   },
      //   items: const [
      //     BottomNavigationBarItem(
      //       icon: Icon(Icons.home),
      //       label: 'Homess',
      //     ),
      //     BottomNavigationBarItem(
      //       icon: Icon(Icons.shopping_cart),
      //       label: 'Marketplace',
      //     ),
      //     BottomNavigationBarItem(
      //       icon: Icon(Icons.notifications),
      //       label: 'Notifications',
      //     ),
      //     BottomNavigationBarItem(
      //       icon: Icon(Icons.person),
      //       label: 'Account',
      //     ),
      //   ],
      // ),
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
                                startIndex: 1), // Start with MortgageHome
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

class MortgageFormPage extends StatelessWidget {
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Mortgage'),
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

              // Apartment Type Dropdown
              const Text('Apartment Type'),
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

              // City Dropdown
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

              // Area Dropdown
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

              // Estimated Property Value
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

              // Initial Deposit
              const Text('Initial Deposit (Optional)'),
              TextFormField(
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
                value: 10,
                min: 1,
                max: 20,
                divisions: 19,
                label: '10 Years',
                onChanged: (value) {},
              ),
              const SizedBox(height: 10),

              // Repayment Period
              const Text('Repayment Period'),
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
                        offset: const Offset(0, 4), // Position of the shadow (x, y)
                      ),
                    ],
                  ),
                  child: const Text(
                    '10 Years',
                    textAlign:
                        TextAlign.center, // Centers the text horizontally
                  ),
                ),
              ),
              const SizedBox(height: 10),

              // Monthly Repayment
              const Text('Monthly Repayment'),
              TextFormField(
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(100),
                  ),
                ),
              ),
              const SizedBox(height: 30),

              // Proceed Button
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () {
                    if (_formKey.currentState!.validate()) {
                      // Perform form submission
                       Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const MortgagePage(
                                startIndex: 2), // Start with MortgageHome
                          ),
                        );
                    } 
                    
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.deepPurple,
                    padding: const EdgeInsets.symmetric(vertical: 16),
                  ),
                  child: const Text(
                    'Proceed'
                    ,
                    style: TextStyle(fontSize: 16,color: Colors.white),
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


class CalendarPage extends StatefulWidget {
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
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
             const Center(
              
                child: Text(
                  'Set your anniversary for payment..',
                  style: TextStyle(fontSize: 16, color: Colors.grey),
                ),
              ),
              const Center(
                child: Text(
                  '(An anniversary date is your last day to receive your payment every month)',
                  style: TextStyle(fontSize: 10, color: Colors.grey),
                ),
              ),
              const Align(
                alignment: Alignment.centerLeft,
                child:Text("Your next anniversary date is:",style: TextStyle(fontSize: 15,height: 5))),
             Text(
              ' ${DateFormat('dd-MM-yyyy').format(_selectedDay)}' ,
              style: const TextStyle(fontSize: 25,color: Colors.black),
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
                  _focusedDay = focusedDay; // Update focusedDay to maintain current view
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
            // Show Selected Date
          
          ],
        ),
      ),
    );
  }
}
class MortgageStep4 extends StatelessWidget {
  const MortgageStep4({super.key});

  @override
  Widget build(BuildContext context) {
    return const Center(child: Text('Mortgage Step 4'));
  }
}

class MortgageStep5 extends StatelessWidget {
  const MortgageStep5({super.key});

  @override
  Widget build(BuildContext context) {
    return const Center(child: Text('Mortgage Step 5'));
  }
}
