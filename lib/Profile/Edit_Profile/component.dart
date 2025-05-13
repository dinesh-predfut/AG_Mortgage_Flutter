import 'package:ag_mortgage/Profile/profile.dart';
import 'package:ag_mortgage/const/colors.dart';
import 'package:flutter/material.dart';

// ignore: camel_case_types
class Edit_Profile extends StatefulWidget {
  const Edit_Profile({super.key});

  @override
  State<Edit_Profile> createState() => _Edit_ProfileState();
}

class _Edit_ProfileState extends State<Edit_Profile> {
  bool hasElectricalDrawing = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Edit Profiless"),
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
                         Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const ProfilePagewidget(startIndex: 2),
                        ));
                        // Handle navigat                                 ion
                      },
                    ),
                    _buildMenuItem(
                      text: 'Login Details',
                      onTap: () {
                          Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const ProfilePagewidget(startIndex: 3),
                        ));
                        // Handle navigation
                      },
                    ),
                    _buildMenuItem(
                      text: 'Employments Detailsaaa',
                      onTap: () {
                            Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const ProfilePagewidget(startIndex:6),
                        ));
                        // Handle navigation
                      },
                    ),
                    _buildMenuItem(
                      text: 'Home Address Details',
                      onTap: () {
                        // Handle navigation
                         Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const ProfilePagewidget(startIndex: 5),
                        ));
                      },
                    ),
                    _buildMenuItem(
                      text: 'Invite Friends',
                      onTap: () {
                        // Handle navigation
                        Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const ProfilePagewidget(startIndex: 6),
                        ));
                      },
                    ),
                    _buildMenuItem(
                      text: 'Anniversary',
                      onTap: () {
                        // Handle navigation
                        Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const ProfilePagewidget(startIndex: 7),
                        ));
                      },
                    ),
                    _buildMenuItem(
                      text: 'Documents',
                      onTap: () {
                         Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const ProfilePagewidget(startIndex: 8),
                        ));
                        // Handle navigation
                      },
                    ),
                    _buildSwitchTile('Notification',
                        hasElectricalDrawing, (value) {
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
    );
  }

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
