import 'package:ag_mortgage/All_Cards/Get_all_Cards/controller.dart';
import 'package:ag_mortgage/Authentication/Login/login.dart';
import 'package:ag_mortgage/Main_Dashboard/Mortgage/Withdraw/controller.dart';
import 'package:ag_mortgage/Profile/Dashboard/FAQs/components.dart';
import 'package:ag_mortgage/Profile/Dashboard/Help_desk/compontent.dart';
import 'package:ag_mortgage/Profile/Dashboard/How_We_Work/component.dart';
import 'package:ag_mortgage/Profile/Dashboard/Logout/component.dart';
import 'package:ag_mortgage/Profile/Dashboard/My_Cards/component.dart';
import 'package:ag_mortgage/Profile/Dashboard/Terms_Condition/component.dart';
import 'package:ag_mortgage/Profile/profile.dart';
import 'package:ag_mortgage/Profile/profile_All_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';

class AccountPage extends StatefulWidget {
  const AccountPage({super.key});

  @override
  State<AccountPage> createState() => _AccountPageState();
}

class _AccountPageState extends State<AccountPage> {
  final controller = Get.put(Main_Dashboard_controller());
  @override
  void initState() {
    super.initState();
    controller.fetchPlanOptions();
    // controller.fetchCustomerDetails();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Account'),
        centerTitle: true,
       
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            const SizedBox(height: 20),
            // Profile Section
            Column(
              children: [
                Obx(() => Container(
                        padding: const EdgeInsets.all(
                            2), // Optional spacing between image and border
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          border: Border.all(
                            color: Colors.grey, // Border color
                            width: 1.0, // Border width (1px)
                          ),
                        ),
                        child: CircleAvatar(
                          radius: 40,
                          backgroundImage: controller
                                  .profileImageUrl.value.isNotEmpty
                              ? NetworkImage(controller.profileImageUrl.value)
                              : const AssetImage('assets/image.png')
                                  as ImageProvider,
                        ),
                      )),
                const SizedBox(height: 10),
                Obx(() => Text(
                      'Hello, ${controller.profileName.value} ${controller.lastName.value}',
                      style: const TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                      ),
                    )),
                Text(
                  controller.phoneNumber,
                  style: const TextStyle(color: Colors.grey),
                ),
                const SizedBox(height: 20),
                ElevatedButton.icon(
                  onPressed: () {
                    Navigator.pushReplacementNamed(context, '/editProfile');
                  },
                  icon: const Icon(
                    Icons.edit,
                    color: Colors.white,
                  ),
                  label: const Text(
                    'Edit Profile',
                    style: TextStyle(color: Colors.white),
                  ),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color.fromARGB(255, 216, 167, 77),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30),
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 30),
            // Menu Options
            // ignore: avoid_unnecessary_containers
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
                        icon: Icons.credit_card,
                        text: 'My Cards',
                        onTap: () {
                          Navigator.pushReplacementNamed(
                              context, '/settings/getallCards');
                        },
                      ),
                      _buildMenuItem(
                        icon: Icons.info,
                        text: 'How We Work',
                        onTap: () {
                          // Handle navigation

                          Navigator.pushReplacementNamed(
                              context, '/howwearework');
                        },
                      ),
                      _buildMenuItem(
                        icon: Icons.help,
                        text: 'Help Desk',
                        onTap: () {
                          Navigator.pushReplacementNamed(context, '/helpDisk');
                        },
                      ),
                      _buildMenuItem(
                        icon: Icons.question_answer,
                        text: 'FAQ',
                        onTap: () {
                          Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                              builder: (context) => const FAQPage(),
                            ),
                          );
                          Navigator.pushReplacementNamed(
                              context, '/settings/faq');
                        },
                      ),
                      _buildMenuItem(
                        icon: Icons.description,
                        text: 'Terms of Service',
                        onTap: () {
                          Navigator.pushReplacementNamed(
                              context, '/settings/termofservice');
                          // Handle navigation
                        },
                      ),
                      Align(
                        child: ListTile(
                          titleAlignment: ListTileTitleAlignment.center,
                          leading: const Icon(
                            Icons.logout,
                            color: Colors.red,
                          ),
                          title: const Text(
                            'Log Out',
                            style: TextStyle(color: Colors.red),
                          ),
                          onTap: () {
                            // Get.deleteAll(force: true);
                            controller.onLogout(context);
                          },
                        ),
                      )
                    ],
                  ),
                ))
          ],
        ),
      ),
    );
  }

  Widget _buildMenuItem({
    required IconData icon,
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
        leading: Icon(icon),
        title: Text(text),
        trailing: const Icon(Icons.chevron_right),
        onTap: onTap,
      ),
    );
  }
}
