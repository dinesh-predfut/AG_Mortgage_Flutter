import 'package:ag_mortgage/Profile/Dashboard/component.dart';
import 'package:ag_mortgage/Profile/profile_All_controller.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_instance/get_instance.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../const/colors.dart';

class HeplDeskPage extends StatefulWidget {
  const HeplDeskPage({super.key});

  @override
  State<HeplDeskPage> createState() => _HeplDeskPageState();
}

class _HeplDeskPageState extends State<HeplDeskPage> {
  final cardControllers = Get.put(Profile_Controller());
  @override
  void initState() {
    super.initState();
    cardControllers.helpDisk(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Help Desk"),
        centerTitle: true,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () => {
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                builder: (context) =>
                    const AccountPage(), // Start with MortgagePage
              ),
            ),
          },
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Contact Support Section
              const Text(
                "Contact Support",
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 16.0),
              GridView(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  crossAxisSpacing: 16.0,
                  mainAxisSpacing: 16.0,
                  childAspectRatio: 1.5,
                ),
                children: [
                  _buildContactOption(
                    icon: Icons.phone,
                    label: "Call",
                    onTap: () async {
                      final Uri phoneUri = Uri.parse(
                          "tel:${cardControllers.HelpDiskPhone}"); // Replace with the desired phone number
                      if (await canLaunchUrl(phoneUri)) {
                        await launchUrl(phoneUri);
                      } else {
                        throw "Could not launch $phoneUri";
                      }
                    },
                  ),
                  _buildContactOption(
                    icon: Icons.message,
                    label: "Text Message",
                    onTap: () async {
                      final Uri smsUri = Uri.parse(
                          "sms:${cardControllers.HelpDiskPhone}?body=Welcome to Ag Mortgage");

                      if (await canLaunchUrl(smsUri)) {
                        await launchUrl(smsUri);
                      } else {
                        throw "Could not launch $smsUri";
                      }
                    },
                  ),
                  _buildContactOption(
                    icon: FontAwesomeIcons.whatsapp,
                    label: "Whatsapp",
                    onTap: () async {
                      var phoneNumber = '7907412589';
                      var url = 'https://wa.me/$phoneNumber';
                      final Uri whatsappUri = Uri.parse(
                          "https://wa.me/${cardControllers.HelpDiskWhatapp}");
                      print(
                          "cardControllers.HelpDiskWhatapp: ${cardControllers.HelpDiskWhatapp}");

                      if (await canLaunchUrl(whatsappUri)) {
                        await launchUrl(whatsappUri);
                      } else {
                        throw "Could not launch WhatsApp";
                      }
                    },
                  ),
                  _buildContactOption(
                    icon: Icons.email,
                    label: "Send Email",
                    onTap: () async {
                      final Uri emailUri = Uri.parse(
                          "mailto:${cardControllers.HelpDiskEmail}");

                      if (await canLaunchUrl(emailUri)) {
                        await launchUrl(emailUri);
                      } else {
                        throw "Could not launch $emailUri";
                      }
                    },
                  ),
                ],
              ),
              const SizedBox(height: 24.0),

              // Social Media Section
              const Text(
                "Social Media",
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 16.0),
              GridView(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  crossAxisSpacing: 16.0,
                  mainAxisSpacing: 16.0,
                  childAspectRatio: 1.5,
                ),
                children: [
                  _buildContactOption(
                    icon: FontAwesomeIcons.facebook,
                    label: "Facebook",
                    onTap: () {
                      // Handle Facebook action
                    },
                  ),
                  _buildContactOption(
                    icon: FontAwesomeIcons.xTwitter,
                    label: "X",
                    onTap: () {
                      // Handle X (Twitter) action
                    },
                  ),
                  _buildContactOption(
                    icon: FontAwesomeIcons.squareInstagram,
                    label: "Instagram",
                    onTap: () {
                      // Handle Instagram action
                    },
                  ),
                  _buildContactOption(
                    icon: FontAwesomeIcons.linkedin,
                    label: "LinkedIn",
                    onTap: () {
                      // Handle LinkedIn action
                    },
                  ),
                ],
              ),
              const SizedBox(height: 24.0),

              // Postal Address Section

              const SizedBox(height: 8.0),
              Container(
                  padding: const EdgeInsets.all(13),
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(12.0),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.1),
                          blurRadius: 8.0,
                          offset: const Offset(0, 4),
                        ),
                      ]),
                  // ignore: prefer_const_constructors
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: const [
                      Text(
                        "Postal & Physical Address",
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text(
                        "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Faucibus tincidunt id arcu, ultrices in varius neque.\n\nLorem ipsum dolor sit amet, consectetur adipiscing elit. Faucibus tincidunt id arcu, ultrices in varius neque.",
                        style: TextStyle(
                          fontSize: 14,
                          color: Colors.grey,
                          height: 1.5,
                        ),
                      ),
                    ],
                  ))
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildContactOption({
    required IconData icon,
    required String label,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12.0),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.1),
              blurRadius: 8.0,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(icon, color: baseColor),
            const SizedBox(height: 8.0),
            Text(
              label,
              style: const TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w500,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
