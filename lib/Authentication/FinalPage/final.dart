import 'package:ag_mortgage/Authentication/Login/login.dart';
import 'package:ag_mortgage/const/Image.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const FinalPageAuth());
}

class FinalPageAuth extends StatelessWidget {
  const FinalPageAuth({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Stack(
      children: [
        Positioned.fill(
            child: Image.asset(
          Images.house1,
          fit: BoxFit.cover,
        )),
        Align(
          alignment: Alignment.bottomCenter,
          child: Container(
            decoration: const BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.vertical(top: Radius.circular(30))),
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Center(
                  child: Image.asset(
                    Images.Iconstext,
                    width: 180, // Adjust size as needed
                    height: 100,
                  ),
                ),
                const Center(
                  child: Text(
                    "Welcome to AG Mortgage Bank Plc",
                    textAlign:TextAlign.center ,
                    style: TextStyle(fontSize: 40, fontWeight: FontWeight.w700,
                    
                    color: Color.fromARGB(255, 238, 172, 50))),
                  ),
                  const Padding(padding: EdgeInsets.all(30)
                  ,
                  child: Center(
                    child: Text(
                      "At AG Mortgage Bank Plc, we understand your housing journey. Whether you’re looking for your first home, need a quick mortgage approval, or funds to complete your dream project, we’re here to support you every step of the way.",
                      textAlign: TextAlign.center,
                      style: TextStyle(fontSize: 15, fontWeight: FontWeight.w400),
                    ),
                  ),
                  
                  ),
                  ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.deepPurple,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30),
                    ),
                    minimumSize: const Size(160, 50),
                  ),
                  onPressed: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const Login(),
                        ));
                  },
                  child: const Text(
                    "Proceed",
                    style: TextStyle(color: Colors.white),
                  ),
                ),
                
              ],
            ),
          ),
        ),
      ],
    ));
  }
}
