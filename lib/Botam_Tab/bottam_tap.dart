import 'package:ag_mortgage/const/colors.dart';
import 'package:flutter/material.dart';

class BottomNavBar extends StatelessWidget {
  final int currentIndex;
  final Function(int) onTap;

  const BottomNavBar({
    Key? key,
    required this.currentIndex,
    required this.onTap, required List<BottomNavigationBarItem> items, 
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      currentIndex: currentIndex,
       onTap: (index) {
        print("Current Index: $currentIndex"); // Print the index when tapped
        onTap(index); // Call the original onTap function passed from the parent
      },
        items:  [
          BottomNavigationBarItem(
            icon: const Icon(Icons.home),
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
    );
  }
}
