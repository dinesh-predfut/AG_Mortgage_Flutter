import 'package:ag_mortgage/Botam_Tab/bottam_tap.dart';
import 'package:ag_mortgage/Dashboard_Screen/Market_Place/Dashboard_Page/Anniversary/component.dart';
import 'package:ag_mortgage/Dashboard_Screen/Market_Place/Refer_Page/component.dart';
import 'package:ag_mortgage/Dashboard_Screen/dashboard_Screen.dart';
import 'package:ag_mortgage/NotificationScreen/notification.dart';
import 'package:ag_mortgage/Profile/Dashboard/component.dart';
import 'package:ag_mortgage/Profile/Edit_Profile/Document/component.dart';
import 'package:ag_mortgage/Profile/Edit_Profile/Employment_Details/component.dart';
import 'package:ag_mortgage/Profile/Edit_Profile/Home_Address/components.dart';
import 'package:ag_mortgage/Profile/Edit_Profile/Login_Details/components.dart';
import 'package:ag_mortgage/Profile/Edit_Profile/Profile_Details/component.dart';
import 'package:ag_mortgage/Profile/Edit_Profile/component.dart';
import 'package:ag_mortgage/Profile/profile_All_controller.dart';
import 'package:ag_mortgage/const/colors.dart';
import 'package:ag_mortgage/main.dart';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

class ProfilePagewidget extends StatefulWidget {
  final int startIndex;
  const ProfilePagewidget({super.key, required this.startIndex});

  @override
  State<ProfilePagewidget> createState() => _ProfilePagewidgetState();
}

class _ProfilePagewidgetState extends State<ProfilePagewidget> {
  int _currentStepIndex = 0; // Controls mortgage flow
  int _selectedIndex = 0;

  @override
  void initState() {
    super.initState();
    _currentStepIndex = widget.startIndex; // Initialize with provided index
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
    print('indexof mare${index}`');
    setState(() {
      _selectedIndex = index;
    });
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => _navPages[index],
      ),
    );
  }

  final List<Widget> _navPages = [
    const DashboardPage(),
    // const LandingPage(
    //   startIndex: 1,
    // ),
     NotificationsPage(),
    const ProfilePagewidget(startIndex: 0),
  ];

  void _goToNextStep() {
    setState(() {
      if (_currentStepIndex < _pages.length - 1) {
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
// H

    return Scaffold(
      body: IndexedStack(
        index: _selectedIndex,
        children: [
          Stack(
            children: [
              _navPages[_selectedIndex],
              Positioned.fill(
                child: Column(
                  children: [
                    Expanded(child: _pages[_currentStepIndex]),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
      // bottomNavigationBar: BottomNavBar(
      //   currentIndex: 3,
      //   onTap: _onItemTapped,

      // ),
    );
  }
}

class Edit_Profile extends StatefulWidget {
  const Edit_Profile({super.key});

  @override
  State<Edit_Profile> createState() => _Edit_ProfileState();
}

class _Edit_ProfileState extends State<Edit_Profile> {
  bool hasElectricalDrawing = false;
  final controller = Get.put(Profile_Controller());
  @override
  void initState() {
    super.initState();
    controller.fetchCustomerDetails();
  }
 void _onBackPressed(BuildContext context) {
    // Custom logic for back navigation
    if (Navigator.of(context).canPop()) {
      print("its working");
         Navigator.pushNamed(context, "/settings");
    } else {
      // Show exit confirmation dialog if needed
      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: Text("Exit App"),
          content: Text("Do you want to exit the app?"),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: Text("No"),
            ),
            TextButton(
              onPressed: () => Navigator.of(context).pop(true),
              child: Text("Yes"),
            ),
          ],
        ),
      );
    }
  }
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        // Handle custom back navigation logic
        _onBackPressed(context);
        return false; // Prevent default back behavior
      },
    child: 
    Scaffold(
      appBar: AppBar(
        title: const Text("Edit Profile"),
        centerTitle: true,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.1),
                      blurRadius: 8,
                      offset: const Offset(0, 4),
                    ),
                  ],
                ),
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  children: [
                    _buildMenuItem(
                      text: 'Personal Details',
                      onTap: () {
                      
                             Navigator.pushReplacementNamed(context, '/editProfile/profileinFoDetails');
                        // Handle navigat                                 ion
                      },
                    ),
                    _buildMenuItem(
                      text: 'Login Details',
                      onTap: () {
                         Navigator.pushReplacementNamed(context, '/editProfile/LoginDetails');
                      
                        // Handle navigation
                      },
                    ),
                    _buildMenuItem(
                      text: 'Employments Details',
                      onTap: () {
                         Navigator.pushReplacementNamed(context, '/editProfile/employementDetails');
                      
                        // Handle navigation
                      },
                    ),
                    _buildMenuItem(
                      text: 'Home Address Details',
                      onTap: () {
                        // Handle navigation
                         Navigator.pushReplacementNamed(context, '/editProfile/homeAddress');
                      
                      },
                    ),
                    _buildMenuItem(
                      text: 'Invite Friends',
                      onTap: () {
                        // Handle navigation
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) =>
                                  const ProfilePagewidget(startIndex: 6),
                            ));
                      },
                    ),
                    _buildMenuItem(
                      text: 'Anniversary',
                      onTap: () {
                        // Handle navigation
                         Navigator.pushReplacementNamed(context, '/editProfile/anniversary');
                       
                      },
                    ),
                    _buildMenuItem(
                      text: 'Documents',
                      onTap: () {
                           Navigator.pushReplacementNamed(context, '/editProfile/documentUpload');
                        
                        // Handle navigation
                      },
                    ),
                    _buildSwitchTile('Notification', hasElectricalDrawing,
                        (value) {
                      setState(() {
                        hasElectricalDrawing = value;
                      });
                    }),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    )
  );}

  Widget _buildMenuItem({
    required String text,
    required VoidCallback onTap,
  }) {
    return Container(
      decoration: const BoxDecoration(
        border: Border(
          bottom:
              BorderSide(color: Colors.grey, width: 0.5), // Adds bottom border
        ),
      ),
      child: ListTile(
        title: Text(text),
        trailing: const Icon(Icons.chevron_right),
        onTap: onTap,
      ),
    );
  }
}

Widget _buildSwitchTile(String title, bool value, Function(bool) onChanged) {
  return Container(
    // padding: const EdgeInsets.all(6.0),

    decoration: const BoxDecoration(
      border: Border(
        bottom:
            BorderSide(color: Colors.grey, width: 0.5), // Adds bottom border
      ),
    ),
    child: SwitchListTile(
      activeColor: Colors.white,
      activeTrackColor: Colors.orange,
      inactiveTrackColor: baseColor,
      inactiveThumbColor: Colors.white,
      title: Text(
        title,
        style: const TextStyle(fontSize: 15),
      ),
      value: value,
      onChanged: onChanged,
    ),
  );
}
