
import 'package:ag_mortgage/Dashboard_Screen/Construction/construction.dart';
import 'package:ag_mortgage/Dashboard_Screen/Mortgage/MortgageHome.dart';
import 'package:ag_mortgage/Dashboard_Screen/Rent-To-own/rent_To_Own.dart';
import 'package:ag_mortgage/const/Image.dart';
import 'package:ag_mortgage/const/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';
// ignore: depend_on_referenced_packages
import 'package:table_calendar/table_calendar.dart';



class DashboardPage extends StatelessWidget {
  const DashboardPage({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'AG Mortgage',
      home: HomePage(),
    );
  }
}

class HomePage extends StatelessWidget {
  const HomePage({super.key});

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
                          builder: (_) => const MortgageHome(),
                        ),
                      );
                    },
                  ),
                  MenuButton(
                    title: 'Rent to Own',
                    icon: Icons.key,
                    onTap: () {Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (_) => const Rent_To_Own(),
                        )
                  );
                  },
                  ),
                  MenuButton(
                    title: 'Construction Finance',
                    icon: Icons.construction,
                     onTap: () {Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (_) => const ConstructionPage(),
                        )
                  );
                     }
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
                          builder: (_) => const MortgageHome(),
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