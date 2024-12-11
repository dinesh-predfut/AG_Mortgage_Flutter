import 'package:ag_mortgage/Dashboard_Screen/Mortgage/Landing/landing.dart';
import 'package:ag_mortgage/const/colors.dart';
import 'package:ag_mortgage/const/colors.dart';
import 'package:ag_mortgage/const/colors.dart';
import 'package:ag_mortgage/onboarding_pages/second_page.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const Dashboard_Screen());
}

// ignore: camel_case_types
class Dashboard_Screen extends StatelessWidget {
  const Dashboard_Screen({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Dashboard with Bottom Nav Bar',
      theme: ThemeData(primarySwatch: Colors.blue),
      home: const DashboardPage(),
    );
  }
}

class DashboardPage extends StatefulWidget {
  const DashboardPage({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _DashboardPageState createState() => _DashboardPageState();
}

class _DashboardPageState extends State<DashboardPage> {
  int _selectedIndex = 0;

  final List<Widget> _pages = [
    const Landing_Mortgage(),
    const MarketplaceScreen(),
    const NotificationsScreen(),
    const AccountScreen(),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('AG Mortgage Bank Plc'),
        centerTitle: true,
      ),
      body: _pages[_selectedIndex],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
        items:  [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
             backgroundColor:baseColor,
          ),
          BottomNavigationBarItem(
            icon: const Icon(Icons.shopping_cart),
            label: 'Marketplace',
            backgroundColor:baseColor,
          ),
          BottomNavigationBarItem(
            icon: const Icon(Icons.notifications),
            label: 'Notifications',
            backgroundColor:baseColor,
          ),
          BottomNavigationBarItem(
            icon: const Icon(Icons.person),
            label: 'Account',
            backgroundColor:baseColor,
          ),
        ],
      ),
    );
  }
}

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Text('Welcome to Home Screen'),
          const SizedBox(height: 20),
          ElevatedButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const MortgageScreen(),
                ),
              );
            },
            child: const Text('Mortgage'),
          ),
        ],
      ),
    );
  }
}

class MortgageScreen extends StatelessWidget {
  const MortgageScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Mortgage Options'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text('Mortgage Page 1'),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const MortgagePage2(),
                  ),
                );
              },
              child: const Text('Next Page'),
            ),
          ],
        ),
      ),
      // bottomNavigationBar: BottomNavigationBar(
      //   currentIndex: 0, // Use this to sync across all pages if needed.
      //   onTap: (index) {},
      //   items: const [
      //     BottomNavigationBarItem(
      //       icon: Icon(Icons.home),
      //       label: 'Home',
      //       backgroundColor: Colors.blue
      //     ),
      //     BottomNavigationBarItem(
      //       icon: Icon(Icons.shopping_cart),
      //       label: 'Marketplace',
      //        backgroundColor: Colors.blue
      //     ),
      //     BottomNavigationBarItem(
      //       icon: Icon(Icons.notifications),
      //       label: 'Notifications',
      //        backgroundColor: Colors.blue
      //     ),
      //     BottomNavigationBarItem(
      //       icon: Icon(Icons.person),
      //       label: 'Account',
      //        backgroundColor: Colors.blue
      //     ),
      //   ],
      // ),
    );
  }
}

class MortgagePage2 extends StatelessWidget {
  const MortgagePage2({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Mortgage Options - Page 2'),
      ),
      body: const Center(
        child: Text('Mortgage Page 2'),
      ),
    );
  }
}

// Placeholder Screens
class MarketplaceScreen extends StatelessWidget {
  const MarketplaceScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const Center(child: Text('Marketplace Screen'));
  }
}

class NotificationsScreen extends StatelessWidget {
  const NotificationsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const Center(child: Text('Notifications Screen'));
  }
}

class AccountScreen extends StatelessWidget {
  const AccountScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const Center(child: Text('Account Screen'));
  }
}
