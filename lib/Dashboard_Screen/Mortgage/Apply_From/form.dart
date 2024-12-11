import 'package:flutter/material.dart';

void main() {
  runApp(const Form_mortgage());
  
}

class Form_mortgage extends StatelessWidget {
  const Form_mortgage({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Global Navigation',
      theme: ThemeData(primarySwatch: Colors.blue),
      home: const GlobalNavigationBar(),
    );
  }
}

class GlobalNavigationBar extends StatefulWidget {
  const GlobalNavigationBar({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _GlobalNavigationBarState createState() => _GlobalNavigationBarState();
}

class _GlobalNavigationBarState extends State<GlobalNavigationBar> {
  int _currentIndex = 0;

  final List<Widget> _pages = [
    const HomePage(),
    const MarketplacePage(),
    const NotificationsPage(),
    const AccountPage(),
  ];

  void _onTabTapped(int index) {
    setState(() {
      _currentIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: IndexedStack(
        index: _currentIndex,
        children: _pages,
      ),
      // bottomNavigationBar: BottomNavigationBar(
      //   currentIndex: _currentIndex,
      //   onTap: _onTabTapped,
      //   items: const [
      //     BottomNavigationBarItem(
      //       icon: Icon(Icons.home),
      //       label: 'Home',
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

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: ElevatedButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => const MortgagePage(),
            ),
          );
        },
        child: const Text('Go to Mortgage Page'),
      ),
    );
  }
}

class MortgagePage extends StatefulWidget {
  const MortgagePage({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _MortgagePageState createState() => _MortgagePageState();
}

class _MortgagePageState extends State<MortgagePage> {
  int _currentStepIndex = 0;

  final List<Widget> _steps = [
    const MortgageStep1(),
    const MortgageStep2(),
    const MortgageStep3(),
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
      appBar: AppBar(
        title: const Text('Mortgage Page'),
      ),
      body: Column(
        children: [
          Expanded(
            child: _steps[_currentStepIndex],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              if (_currentStepIndex > 0)
                ElevatedButton(
                  onPressed: _goToPreviousStep,
                  child: const Text('Back'),
                ),
              if (_currentStepIndex < _steps.length - 1)
                ElevatedButton(
                  onPressed: _goToNextStep,
                  child: const Text('Next'),
                ),
            ],
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
class MortgageStep1 extends StatelessWidget {
  const MortgageStep1({super.key});

  @override
  Widget build(BuildContext context) {
    return const Center(child: Text('Mortgage Step 1'));
  }
}

class MortgageStep2 extends StatelessWidget {
  const MortgageStep2({super.key});

  @override
  Widget build(BuildContext context) {
    return const Center(child: Text('Mortgage Step 2'));
  }
}

class MortgageStep3 extends StatelessWidget {
  const MortgageStep3({super.key});

  @override
  Widget build(BuildContext context) {
    return const Center(child: Text('Mortgage Step 3'));
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

// Placeholder Screens
class MarketplacePage extends StatelessWidget {
  const MarketplacePage({super.key});

  @override
  Widget build(BuildContext context) {
    return const Center(child: Text('Marketplace Page'));
  }
}

class NotificationsPage extends StatelessWidget {
  const NotificationsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return const Center(child: Text('Notifications Page'));
  }
}

class AccountPage extends StatelessWidget {
  const AccountPage({super.key});

  @override
  Widget build(BuildContext context) {
    return const Center(child: Text('Account Page'));
  }
}
