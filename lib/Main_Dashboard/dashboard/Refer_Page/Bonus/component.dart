import 'package:ag_mortgage/Main_Dashboard/Mortgage/Withdraw/controller.dart';
import 'package:ag_mortgage/Main_Dashboard/dashboard/dashboardController.dart';
import 'package:ag_mortgage/Profile/profile.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

import '../../../../const/colors.dart';

// ignore: camel_case_types
class Refer_Bonus extends StatefulWidget {
  const Refer_Bonus({super.key});

  @override
  State<Refer_Bonus> createState() => _Refer_BonusState();
}

// ignore: camel_case_types
class _Refer_BonusState extends State<Refer_Bonus>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  final controller = Get.put(DashboardController());

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(vsync: this);
    controller.ALLinvite(context);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title:  Text("Bonus",style: TextStyle(color: baseColor,fontWeight: FontWeight.bold)),
          centerTitle: true,
          leading: IconButton(
            icon: const Icon(Icons.arrow_back),
            onPressed: () => Navigator.pop(context),
          ),
        ),
        body: Obx(() {
          if (controller.isLoading.value) {
            return const Center(child: CircularProgressIndicator());
          } else {
           return SingleChildScrollView(
                child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Align(
                    alignment: Alignment.topCenter,
                    child: Text(
                        "Invite Friends and Earn when they register and apply for any of our services.",
                        textAlign: TextAlign.center),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Container(
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(15),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.1),
                          blurRadius: 10,
                          offset: const Offset(0, 5),
                        ),
                      ],
                    ),
                    padding: const EdgeInsets.all(20),
                    child: Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            const Text(
                              "Number of people Invited",
                              style: TextStyle(fontSize: 12),
                            ),
                            Text(controller.totalPeople.toString())
                          ],
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            const Text("Number of people that didn’t click",
                                style: TextStyle(fontSize: 12)),
                            Text(controller.totalClick.toString())
                          ],
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            const Text(
                                "Number of people that joined after clicking ",
                                style: TextStyle(fontSize: 12)),
                            Text(controller.totalJoin.toString(),
                                style: const TextStyle(color: Colors.green))
                          ],
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            const Text(
                                "Number of people that left after joining",
                                style: TextStyle(fontSize: 12)),
                            Text(
                              controller.totalnotClick.toString(),
                              style: const TextStyle(color: Colors.red),
                            )
                          ],
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Container(
                    decoration: BoxDecoration(
                      color: Colors.yellow[800],
                      borderRadius: BorderRadius.circular(15),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.1),
                          blurRadius: 10,
                          offset: const Offset(0, 5),
                        ),
                      ],
                    ),
                    padding: const EdgeInsets.all(20),
                    child: const Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Expected Yield",
                            style: TextStyle(
                                fontSize: 18, fontWeight: FontWeight.w800),
                          ),
                          Text(
                            "You are eligible for reward if a friend you referred clicked the link and joined AG Mortgage Bank Plc as a customer. They must complete all process and must not withdraw their money at any point in time, if they do then we are eligible to withdraw our bonus since they didn’t complete the whole process.",
                            style: TextStyle(fontSize: 12),
                          )
                        ]),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Container(
                    decoration: BoxDecoration(
                      color: const Color.fromARGB(193, 255, 255, 255),
                      borderRadius: BorderRadius.circular(15),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.1),
                          blurRadius: 10,
                          offset: const Offset(0, 5),
                        ),
                      ],
                    ),
                    padding: const EdgeInsets.all(16),
                    child: const Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Total Reward Earned",
                          style: TextStyle(color: Colors.grey),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              "Amount Per Referral",
                              style: TextStyle(),
                            ),
                            Text("NGN 8,000",
                                style: TextStyle(fontWeight: FontWeight.w800))
                          ],
                        )
                      ],
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Container(
                    decoration: BoxDecoration(
                      color: const Color.fromARGB(193, 255, 255, 255),
                      borderRadius: BorderRadius.circular(15),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.1),
                          blurRadius: 10,
                          offset: const Offset(0, 5),
                        ),
                      ],
                    ),
                    padding: const EdgeInsets.all(16),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          "Reward Details",
                          style: TextStyle(color: Colors.grey),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              'NGN ${(int.parse(controller.totalJoin!) * 8000).toString()}',
                              style: const TextStyle(
                                fontWeight: FontWeight.w800,
                                color: Colors.green,
                                fontSize: 23,
                              ),
                            ),
                            // ElevatedButton(
                            //   onPressed: () {
                            //          Navigator.push(
                            //     context,
                            //     MaterialPageRoute(
                            //       builder: (context) => const ProfilePagewidget(startIndex: 6),
                            //     ));
                            //   },
                            //   style: ElevatedButton.styleFrom(
                            //     padding: const EdgeInsets.symmetric(
                            //         horizontal: 24.0, vertical: 12.0),
                            //     backgroundColor: Colors.yellow[800],
                            //     shape: RoundedRectangleBorder(
                            //       borderRadius: BorderRadius.circular(20),
                            //     ),
                            //   ),
                            //   child: const Text("Reedem Now",
                            //       style: TextStyle(color: Colors.white)),
                            // ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Align(
                    alignment: Alignment.center,
                    child: ElevatedButton(
                      onPressed: () {
                        Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                            builder: (context) =>
                                const ProfilePagewidget(startIndex: 6),
                          ),
                        );
                      },
                      style: ElevatedButton.styleFrom(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 24.0, vertical: 12.0),
                        backgroundColor: baseColor,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20),
                        ),
                      ),
                      child: const Text("Invite Friends & Earn",
                          style: TextStyle(color: Colors.white)),
                    ),
                  )
                ],
              ),
            ));
          }
        }));
  }
}
