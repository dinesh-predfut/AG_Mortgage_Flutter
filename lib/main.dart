import 'package:ag_mortgage/Authentication/Login/login.dart';
import 'package:ag_mortgage/Botam_Tab/bottam_tap.dart';
import 'package:ag_mortgage/Dashboard_Screen/Market_Place/main.dart';

import 'package:ag_mortgage/Dashboard_Screen/Mortgage/MortgageHome.dart';
import 'package:ag_mortgage/NotificationScreen/notification.dart';
import 'package:ag_mortgage/Profile/profile.dart';


import 'package:ag_mortgage/Dashboard_Screen/dashboard_Screen.dart';
import 'package:flutter/material.dart';
import 'package:ag_mortgage/onboarding_pages/first_page.dart';
import 'package:ag_mortgage/onboarding_pages/second_page.dart';
// Import the BottomNavBar

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
     initialRoute: '/landing',
      routes: {
        '/landing': (context) => const LandingPage(),
        // '/second': (context) =>  MortgageHome (),
        '/login': (context) => const Login(navigation: true,),
        // '/main_page':(context) => const MortgageHome(),
        
      },
    );  
  }
}

class LandingPage extends StatefulWidget {

   final int startIndex;
  const LandingPage({super.key, this.startIndex = 0});
  @override
  _LandingPageState createState() => _LandingPageState();
}

class _LandingPageState extends State<LandingPage> {
  int _currentIndex = 1;

 @override
  void initState() {
    super.initState();
    _currentIndex = widget.startIndex; // Initialize with provided index
  }
  // List of pages to show based on the index
  final List<Widget> _pages = [
    const Logo_Screen(),
    const DashboardPage(),
     const MarketMain(),
    const NotificationsPage(),
    const ProfilePage(),
    
  ];  
  void _onItemTapped(int index) {
    setState(() {
      _currentIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    final bool showBottomNavBar = _currentIndex != 0; // H
    return Scaffold(
      
      body: _pages[_currentIndex],
      bottomNavigationBar: showBottomNavBar
          ? BottomNavBar(
              currentIndex: _currentIndex - 1,
              onTap: (index) =>
                  _onItemTapped(index + 1), items: const [], // Adjust for LandingPage
            )
          : null,
    );
  }
}
