import 'package:ag_mortgage/Dashboard_Screen/Market_Place/main.dart';
import 'package:ag_mortgage/Dashboard_Screen/dashboard_Screen.dart';
import 'package:ag_mortgage/NotificationScreen/notification.dart';
import 'package:ag_mortgage/Profile/profile.dart';
import 'package:flutter/material.dart';

class NavigationProvider with ChangeNotifier {
  int _selectedIndex = 0;

  int get selectedIndex => _selectedIndex;

  void setSelectedIndex(int index, BuildContext context) {
    _selectedIndex = index;
    
    switch (index) {
      case 0:
        // Navigate to Home
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => const DashboardPage()),
        );
        break;
      case 1:
        // Navigate to Cards
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => const MarketMain()),
        );
        break;
      case 2:
        // Navigate to Settings
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) =>NotificationsPage()),
        );
        break;
           case 3:
        // Navigate to Settings
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) =>  const ProfilePagewidget(startIndex: 0,)),
        );
        break;
    } 
    notifyListeners();
  }
}