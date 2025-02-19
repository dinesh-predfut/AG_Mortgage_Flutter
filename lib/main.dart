import 'package:ag_mortgage/Authentication/Login/login.dart';
import 'package:ag_mortgage/Authentication/Registration/Components/rigister.dart';
import 'package:ag_mortgage/Botam_Tab/bottam_tap.dart';
import 'package:ag_mortgage/Dashboard_Screen/Construction/construction.dart';
import 'package:ag_mortgage/Dashboard_Screen/Market_Place/Details_Page/component.dart';
import 'package:ag_mortgage/Dashboard_Screen/Market_Place/main.dart';
import 'package:ag_mortgage/Dashboard_Screen/Mortgage/MortgageHome.dart';

import 'package:ag_mortgage/Dashboard_Screen/Mortgage/MortgagePage.dart';
import 'package:ag_mortgage/Dashboard_Screen/Mortgage/controller.dart';
import 'package:ag_mortgage/Dashboard_Screen/Rent-To-own/rent_To_Own.dart';
import 'package:ag_mortgage/NotificationScreen/notification.dart';
import 'package:ag_mortgage/Profile/profile.dart';

import 'package:ag_mortgage/Dashboard_Screen/dashboard_Screen.dart';
import 'package:flutter/material.dart';
import 'package:ag_mortgage/onboarding_pages/first_page.dart';
import 'package:ag_mortgage/onboarding_pages/second_page.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';

import 'Authentication/Login_Controller/controller.dart';
// Import the BottomNavBar

void main() {
  Get.lazyPut(() => ProfileController());
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(
            create: (_) => MortgagController()), // Provide MortgageProvider
      ],
      child: MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      initialRoute: '/',
      onGenerateRoute: (settings) {
        print("Navigating to: ${settings.name}");
        switch (settings.name) {
          case '/':
            return MaterialPageRoute(
                builder: (context) => const LandingPage(startIndex: 0));
          case '/second':
            return MaterialPageRoute(
                builder: (context) => const MortgagePageHome(startIndex: 0));
          case '/register':
            return MaterialPageRoute(
                builder: (context) => const RegisterScreen());
          case '/login':
            return MaterialPageRoute(builder: (context) => const Login());
          case '/dashBoardPage':
            return MaterialPageRoute(
                builder: (context) => const LandingPage(startIndex: 1));
          case '/dashBoardPage/mortgage':
            return MaterialPageRoute(
                builder: (context) => const MortgagePageHome(startIndex: 0));
          case '/main_page':
            return MaterialPageRoute(
                builder: (context) => const MortgagePageHome());
          case 'login/propertyView':
            final argument = settings.arguments as int?;

            return MaterialPageRoute(
              builder: (context) => PropertyDetailsPage(id: argument),
            );
          case '/rent-to-own':
            return MaterialPageRoute(
              builder: (context) => const Rent_To_Own(),
            );
          case '/construction':
            return MaterialPageRoute(
              builder: (context) => const ConstructionPage(),
            );

          default:
            return MaterialPageRoute(
                builder: (context) =>
                    const LandingPage()); // Handle unknown routes
        }
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
    _currentIndex = widget.startIndex; // ✅ Initialize with provided index
  }

  // ✅ Corrected List of Pages (Should be Widgets, not Routes)
  final List<Widget> _pages = [
    const Logo_Screen(),
    const DashboardPage(),
    const MarketMain(),
    const NotificationsPage(),
    const ProfilePagewidget(startIndex: 0),
    const MortgagePageHome(startIndex: 0)
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
              onTap: (index) => _onItemTapped(index + 1),
              items: const [], // Adjust for LandingPage
            )
          : null,
    );
  }
}
