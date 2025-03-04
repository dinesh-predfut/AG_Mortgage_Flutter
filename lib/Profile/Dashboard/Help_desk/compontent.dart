import 'package:ag_mortgage/Profile/Dashboard/component.dart';
import 'package:ag_mortgage/Profile/profile.dart';
import 'package:ag_mortgage/Profile/profile_All_controller.dart';
import 'package:ag_mortgage/main.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_instance/get_instance.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../const/Image.dart';
import '../../../const/colors.dart';
import '../../../const/constant.dart';

class HeplDeskPage extends StatefulWidget {
  const HeplDeskPage({super.key});

  @override
  State<HeplDeskPage> createState() => _HeplDeskPageState();
}

class _HeplDeskPageState extends State<HeplDeskPage> {
  final cardControllers = Get.put(Profile_Controller());
  final String token = Params.userToken;
  @override
  void initState() {
    super.initState();
    cardControllers.helpDisk(context);
  }

  Future<void> openERPSystem(String token) async {
    final String erpNextURL =
        "http://198.204.243.58/api/method/custom_app.api.jwt_auth.validate_jwt?token=$token";

    final Uri url = Uri.parse(erpNextURL);
    await launchUrl(Uri.parse(erpNextURL),
        mode: LaunchMode.externalApplication);
  }
 void _onBackPressed(BuildContext context) {
    // Custom logic for back navigation
    if (Navigator.of(context).canPop()) {
   
         Navigator.pushNamed(context, "/settings");
    } else {
      // Show exit confirmation dialog if needed
      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: const Text("Exit App"),
          content: const Text("Do you want to exit the app?"),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: const Text("No"),
            ),
            TextButton(
              onPressed: () => Navigator.of(context).pop(true),
              child: const Text("Yes"),
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
      child: Scaffold(
        appBar: AppBar(
          title: const Text("Help Desk"),
          centerTitle: true,
          leading: IconButton(
            icon: const Icon(Icons.arrow_back, color: Colors.black),
            onPressed: () => {
              Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                      builder: (context) => const MainLayout(
                          showBottomNavBar: true,
                          startIndex: 3,
                          child: ProfilePagewidget(startIndex: 0))))
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
                  "Tickets",
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
                    _buildTicketOption(
                      icon: Images.raiseTicket,
                      label: "Raise Ticket",
                      onTap: () => openERPSystem(token),
                    ),
                    _buildTicketOption(
                      icon: Images.viewTickey,
                      label: "View Ticket",
                      onTap: () => openERPSystem(token),
                    ),
                  ],
                ),
                // Contact Support Section
                const SizedBox(height: 16.0),
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
                        await launchUrl(smsUri);
                        // if (await canLaunchUrl(smsUri)) {
                        // } else {
                        //   throw "Could not launch $smsUri";
                        // }
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
                        await launchUrl(whatsappUri);
                        // if (await canLaunchUrl(whatsappUri)) {

                        // } else {
                        //   throw "Could not launch WhatsApp";
                        // }
                      },
                    ),
                    _buildContactOption(
                      icon: Icons.email,
                      label: "Send Email",
                      onTap: () async {
                        final Uri emailUri = Uri.parse(
                            "mailto:${cardControllers.HelpDiskEmail}");
                        await launchUrl(emailUri);
                        // if (await canLaunchUrl(emailUri)) {

                        // } else {
                        //   throw "Could not launch $emailUri";
                        // }
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

  Widget _buildTicketOption({
    required String icon,
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
            Image.asset(icon, width: 30, height: 30),
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
