import 'dart:async';
import 'dart:convert';

import 'package:ag_mortgage/Dashboard_Screen/Construction/construction.dart';
import 'package:ag_mortgage/Dashboard_Screen/Investment/investment.dart';
import 'package:ag_mortgage/Dashboard_Screen/Market_Place/main.dart';
import 'package:ag_mortgage/Dashboard_Screen/Mortgage/MortgageHome.dart';
import 'package:ag_mortgage/Dashboard_Screen/Rent-To-own/rent_To_Own.dart';
import 'package:ag_mortgage/Main_Dashboard/Mortgage/Withdraw/controller.dart';
import 'package:ag_mortgage/Main_Dashboard/dashboard/Dashboard/component.dart';
import 'package:ag_mortgage/const/Image.dart';
import 'package:ag_mortgage/const/colors.dart';
import 'package:ag_mortgage/const/constant.dart';
import 'package:ag_mortgage/const/url.dart';
import 'package:ag_mortgage/main.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
// ignore: depend_on_referenced_packages

class DashboardPage extends StatefulWidget {
  const DashboardPage({super.key});

  @override
  State<DashboardPage> createState() => _DashboardPageState();
}

class _DashboardPageState extends State<DashboardPage> {
  final controller = Get.put(Main_Dashboard_controller());
  var planOptions = <String>[].obs; // Observable list to store plan options
  var isLoading = false.obs;
  var profileName = "";
  var lastName = "";
  var profileImage = "";
  @override
  void initState() {
    super.initState();
    print('Params.userId Code: ${Params.refreshToken}');
    Timer(const Duration(seconds: 2), () {
      fetchPlanOptions();
      controller.fetchPlanOptions();
    });
  }

  Future<void> fetchPlanOptions() async {
    try {
      isLoading.value = true;
      var url = Uri.parse('${Urls.getEmployeeDetailsID}?id=${Params.userId}');
      var headers = {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer ${Params.userToken ?? ''}',
      };

      var response = await http.get(url, headers: headers);

      print('Response Code: ${response.statusCode}');
      print('Responsesss Body: ${response.body}');

      if (response.statusCode == 200) {
        var data = json.decode(response.body);

        setState(() {
          profileName = data['firstName'];
          lastName = data['lastName'];
          profileImage = data['profileImage'];
        });

        if (data['planOption'] != null) {
          planOptions.value = List<String>.from(data['planOption']);
        }
      } else {
        print("Error: ${response.body}");
      }
    } catch (e) {
      print("API Call Error: $e");
    } finally {
      isLoading.value = false;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              Row(
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
                  const SizedBox(width: 16),
                  Obx(() => SizedBox(
                        width: 250,
                        child: Text(
                           'Hello, ${controller.profileName.value ?? ''} ${controller.lastName.value ?? ''} 👋',
                          style: const TextStyle(
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                          ),
                          softWrap: true,
                          overflow: TextOverflow.visible,
                        ),
                      ))
                ],
              ),
              const SizedBox(height: 8),
              const Text(
                'What brings you to AG Mortgage Bank Plc today?',
                style: TextStyle(fontSize: 16),
              ),
              const SizedBox(height: 46),
              Expanded(
                child: ListView(
                  children: [
                    MenuButton(
                      title: ' KWIK Mortgage',
                      icon: Image.asset(
                        Images.keyIcon,
                        width: 24,
                        height: 24,
                        color: Colors.white,
                        colorBlendMode: BlendMode.srcIn,
                      ),
                      onTap: () {
                        if (controller.planOptions.contains(25)) {
                          Navigator.pushNamed(context, "/mainDashboard",
                              arguments: "Mortgage");
                        } else if (controller.planOptions.contains(26)) {
                          Navigator.pushNamed(context, "/mainDashboard",
                              arguments: "Rent-to-Own");
                        } else if (controller.planOptions.contains(27)) {
                          Navigator.pushNamed(context, "/mainDashboard",
                              arguments: "Construction Finance");
                        } else {
                          Navigator.pushNamed(
                              context, "/dashBoardPage/mortgage");
                        }
                      },
                    ),
                    const SizedBox(height: 16),
                    MenuButton(
                      title: 'KWIK Rent-to-Own',
                      icon: Image.asset(
                        Images.rendtoHome,
                        width: 24,
                        height: 24,
                        color: Colors.white,
                        colorBlendMode: BlendMode.srcIn,
                      ),
                      onTap: () {
                        print(
                            "controller.planOptions${controller.planOptions}");
                        if (controller.planOptions.contains(25)) {
                          Navigator.pushNamed(context, "/mainDashboard",
                              arguments: "Mortgage");
                        } else if (controller.planOptions.contains(26)) {
                          Navigator.pushNamed(context, "/mainDashboard",
                              arguments: "Rent-to-Own");
                        } else if (controller.planOptions.contains(27)) {
                          Navigator.pushNamed(context, "/mainDashboard",
                              arguments: "Construction Finance");
                        } else {
                          Navigator.pushNamed(context, "/rent-to-own");
                        }
                      },
                    ),
                    const SizedBox(height: 16),
                    MenuButton(
                        title: 'KWIK Complete My Home',
                        icon: Image.asset(
                          Images.constraction,
                          width: 24,
                          height: 24,
                          color: Colors.white,
                          colorBlendMode: BlendMode.srcIn,
                        ),
                        onTap: () {
                          if (controller.planOptions.contains(25)) {
                            Navigator.pushNamed(context, "/mainDashboard",
                                arguments: "Mortgage");
                          } else if (controller.planOptions.contains(26)) {
                            Navigator.pushNamed(context, "/mainDashboard",
                                arguments: "Rent-to-Own");
                          } else if (controller.planOptions.contains(27)) {
                            Navigator.pushNamed(context, "/mainDashboard",
                                arguments: "Construction Finance");
                          } else {
                            Navigator.pushNamed(context, "/construction");
                          }
                        }),
                    const SizedBox(height: 16),
                    MenuButton(
                      title: 'KWIK Real Estate Investment',
                      icon: Image.asset(
                        Images.investment,
                        width: 24,
                        height: 24,
                        color: Colors.white,
                        colorBlendMode: BlendMode.srcIn,
                      ),
                      onTap: () {
                        if (controller.planOptions.contains(28)) {
                          Navigator.pushNamed(context, "/investmentmore");
                        } else {
                          Navigator.pushNamed(context, "/investment");
                        }
                      },
                    ),
                    const SizedBox(height: 16),
                    MenuButton(
                      title: 'Marketplace',
                      icon: Image.asset(
                        Images.market,
                        width: 24,
                        height: 24,
                      ),
                      onTap: () {
                        Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                                builder: (context) => const MainLayout(
                                    showBottomNavBar: true,
                                    startIndex: 1,
                                    child: MarketMain())));
                      },
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class MenuButton extends StatelessWidget {
  final String title;
  final Widget icon;
  final VoidCallback onTap;

  const MenuButton({
    Key? key,
    required this.title,
    required this.icon,
    required this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        margin: const EdgeInsets.symmetric(vertical: 8),
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: baseColor,
          borderRadius: BorderRadius.circular(8),
        ),
        child: Row(
          children: [
            icon,
            const SizedBox(width: 16),
            Text(
              title,
              style: const TextStyle(color: Colors.white, fontSize: 16),
            ),
          ],
        ),
      ),
    );
  }
}
