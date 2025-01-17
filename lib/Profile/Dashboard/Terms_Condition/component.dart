import 'package:ag_mortgage/Authentication/Registration/Components/rigister.dart';
import 'package:ag_mortgage/Profile/Dashboard/component.dart';
import 'package:ag_mortgage/const/Image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';

void main() {
  runApp(const Terms_andcondition());
}

class Terms_andcondition extends StatelessWidget {
  const Terms_andcondition({super.key});

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
              "Terms of Service",
              style: TextStyle(fontSize: 30, fontWeight: FontWeight.w600),
            ),
          ),
          
          const Padding(
            padding: EdgeInsets.all(10),
            child: SingleChildScrollView(
              child: Center(
                child: Text(
                  "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Faucibus tincidunt id arcu, ultrices in varius neque, vel. Viverra cras et sagittis, mattis scelerisque in enim nibh. Fringilla et at eget faucibus ipsum dui. Lacus, quis etiam hac fusce euismod faucibus tincidunt non molestie Lorem ipsum dolor sit amet, consectetur adipiscing elit. \n\nFaucibus tincidunt id arcu, ultrices in varius neque, vel. Viverra cras et sagittis, mattis scelerisque in enim nibh. Fringilla et at eget faucibus ipsum dui. Lacus, quis etiam hac fusce euismod faucibus tincidunt non molestie Lorem ipsum dolor sit amet,  mattis scelerisque in enim nibh. Fringilla et at eget faucibus .\n\n Lorem ipsum dolor sit amet, consectetur adipiscing elit. Faucibus tincidunt id arcu, ultrices in varius neque, vel. Viverra cras et sagittis, mattis scelerisque in enim nibh. Fringilla et at eget faucibus ipsum dui. Lacus, quis etiam hac fusce euismod faucibus tincidu",
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
