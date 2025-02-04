import 'package:ag_mortgage/Authentication/Registration/Components/rigister.dart';
import 'package:ag_mortgage/Profile/Dashboard/component.dart';
import 'package:ag_mortgage/const/Image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';



class AccountTermsandcondition extends StatelessWidget {
  const AccountTermsandcondition({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Padding(
      padding: const EdgeInsets.all(20),
      child: Column(
        children: <Widget>[
          Row(
            children: <Widget>[
              GestureDetector(
                onTap: () {
                 
              Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                              builder: (context) =>
                                  const AccountPage(), // Start with MortgagePage
                            ),
                          );
      
                },
                child: const Icon(Icons.arrow_back),
              ),
              Expanded(
                child: Center(
                  child: Image.asset(
                    Images.Iconstext,
                    width: 180, // Adjust size as needed
                    height: 100,
                  ),
                ),
              ),
            ],
          ),
          const Center(
            child: Text(
              "How We Work",
              style: TextStyle(fontSize: 30, fontWeight: FontWeight.w600),
            ),
          ),
          
          const Padding(
            padding: EdgeInsets.all(10),
            child: SingleChildScrollView(
              child: Center(
                child: Text(
                  "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Faucibus tincidunt id arcu, ultrices in varius neque, vel. Viverra cras et sagittis, mattis scelerisque in enim nibh. Fringilla et at eget faucibus ipsum dui. Lacus, quis etiam hac fusce euismod faucibus tincidunt non molestie Lorem ipsum dolor sit amet, consectetur adipiscing elit. Faucibus tincidunt id arcu, ultrices in varius neque, vel. Viverra cras et sagittis, mattis scelerisque in enim nibh. Fringilla et at eget faucibus ipsum dui. Lacus, quis etiam hac fusce euismod faucibus tincidunt non molestie Lorem ipsum dolor sit amet,  mattis scelerisque in enim nibh. Fringilla et at eget faucibus ",
                  textAlign: TextAlign.justify,
                  overflow: TextOverflow.visible,
                  style: TextStyle(fontSize: 15,color: Colors.black, fontWeight: FontWeight.w500),
                ),
              ),
            ),
          ),
       
        ],
      ),
    ));
  }
}
