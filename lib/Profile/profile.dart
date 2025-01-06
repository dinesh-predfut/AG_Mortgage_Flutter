import 'package:ag_mortgage/Botam_Tab/bottam_tap.dart';
import 'package:ag_mortgage/Dashboard_Screen/Market_Place/Dashboard_Page/Anniversary/component.dart';
import 'package:ag_mortgage/Dashboard_Screen/Market_Place/Refer_Page/component.dart';
import 'package:ag_mortgage/Profile/Dashboard/component.dart';
import 'package:ag_mortgage/Profile/Edit_Profile/Document/component.dart';
import 'package:ag_mortgage/Profile/Edit_Profile/Employment_Details/component.dart';
import 'package:ag_mortgage/Profile/Edit_Profile/Home_Address/components.dart';
import 'package:ag_mortgage/Profile/Edit_Profile/Login_Details/components.dart';
import 'package:ag_mortgage/Profile/Edit_Profile/Profile_Details/component.dart';
import 'package:ag_mortgage/Profile/Edit_Profile/component.dart';


import 'package:flutter/material.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'AG Mortgage',
      home: ProfilePagewidget(startIndex: 0,),
    );
  }
}
class ProfilePagewidget extends StatefulWidget {
  final int startIndex;
  const   ProfilePagewidget({super.key, required this.startIndex});

  @override
  State<ProfilePagewidget> createState() => _ProfilePagewidgetState();
}

class _ProfilePagewidgetState extends State<ProfilePagewidget> {
   int _currentIndex = 1;
    @override
  void initState() {
    super.initState();
    _currentIndex = widget.startIndex; // Initialize with provided index
  }
  // List of pages to show based on the index
  final List<Widget> _pages = [
    const AccountPage(),
    const Edit_Profile(),
    const PersonalDetailsPage(),
    const EditLoginDetails(),
    const EmploymentDetails(),
    const Home_Address(),
    const InviteFriendsPage(),
    const CalendarPage(),
    DocumentsPage()
  ];    

  void _onItemTapped(int index) {
    setState(() {
      _currentIndex = index;
    });
  }
  @override
  Widget build(BuildContext context) {
// H
    return Scaffold(
      body: _pages[_currentIndex],
     
    );
  }
}