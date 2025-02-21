// import 'package:ag_mortgage/Authentication/Registration/Components/rigister.dart';
// import 'package:ag_mortgage/const/Image.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter/widgets.dart';
// import 'package:get/get.dart';
// import 'package:ag_mortgage/onboarding_pages/termsandcondition.dart';

// void main() {
//   runApp(const LandingScreenTermsandcondition());
// }

// class LandingScreenTermsandcondition extends StatelessWidget {
//   const LandingScreenTermsandcondition({Key? key}) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     return const MaterialApp(
//       debugShowCheckedModeBanner: false,
//       home: Termsandcondition(),
//     );
//   }
// }
// class Termsandcondition extends StatefulWidget {
//   const Termsandcondition({super.key});

//   @override
//   State<Termsandcondition> createState() => _TermsandconditionState();
// }

// class _TermsandconditionState extends State<Termsandcondition> {
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//         body: Padding(
//       padding: const EdgeInsets.all(20),
//       child: Column(
//         children: <Widget>[
//           Row(
//             children: <Widget>[
//               GestureDetector(
//                 onTap: () {
//                   Get.back();
//                 },
//                 child: const Icon(Icons.arrow_back),
//               ),
//               Expanded(
//                 child: Center(
//                   child: Image.asset(
//                     Images.Iconstext,
//                     width: 180, // Adjust size as needed
//                     height: 100,
//                   ),
//                 ),
//               ),
//             ],
//           ),
//           const Center(
//             child: Text(
//               "Terms & Conditions",
//               style: TextStyle(fontSize: 30, fontWeight: FontWeight.w600),
//             ),
//           ),
//           const Center(
//             child: Text(
//               "Read and understand our terms of services, before you create your account.",
//               textAlign: TextAlign.center,
//               style: TextStyle(fontSize: 12, fontWeight: FontWeight.w100),
//             ),
//           ),
//           const Padding(
//             padding: EdgeInsets.all(10),
//             child: SingleChildScrollView(
//               child: Center(
//                 child: Text(
//                   "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Faucibus tincidunt id arcu, ultrices in varius neque, vel. Viverra cras et sagittis, mattis scelerisque in enim nibh. Fringilla et at eget faucibus ipsum dui. Lacus, quis etiam hac fusce euismod faucibus tincidunt non molestie Lorem ipsum dolor sit amet, consectetur adipiscing elit. Faucibus tincidunt id arcu, ultrices in varius neque, vel. Viverra cras et sagittis, mattis scelerisque in enim nibh. Fringilla et at eget faucibus ipsum dui. Lacus, quis etiam hac fusce euismod faucibus tincidunt non molestie Lorem ipsum dolor sit amet,  mattis scelerisque in enim nibh. Fringilla et at eget faucibus ",
//                   textAlign: TextAlign.justify,
//                   overflow: TextOverflow.visible,
//                   style: TextStyle(fontSize: 15,color: Color.fromARGB(255, 107, 106, 105), fontWeight: FontWeight.w300),
//                 ),
//               ),
//             ),
//           ),
//           Padding(
//             padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
//             child: Row(
//               mainAxisAlignment: MainAxisAlignment.spaceBetween,
//               children: [
//                 OutlinedButton(
//                   onPressed: () {},
//                   style: OutlinedButton.styleFrom(
//                     side:
//                         const BorderSide(width: 1.0, color: baseColor),
//                   ),
//                   child: const Text(
//                     "Decline",
//                     style: TextStyle(color: baseColor),
//                   ),
//                 ),
//                 ElevatedButton(
//                   style: ElevatedButton.styleFrom(
//                     backgroundColor: baseColor,
//                     shape: RoundedRectangleBorder(
//                       borderRadius: BorderRadius.circular(30),
//                     ),
//                     minimumSize: const Size(160, 50),
//                   ),
//                   onPressed: () {
//                     Navigator.push(
//                         context,
//                         MaterialPageRoute(
//                           builder: (context) => const Register(),
//                         ));
//                   },
//                   child: const Text(
//                     "Accept",
//                     style: TextStyle(color: Colors.white),
//                   ),
//                 ),
//               ],
//             ),
//           ),
//         ],
//       ),
//     ));
//   }
// }

