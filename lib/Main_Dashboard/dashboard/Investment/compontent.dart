import 'package:flutter/material.dart';

class Investment_Forms extends StatelessWidget {
  const Investment_Forms({super.key});

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      appBar: AppBar(
        title: const Text("Investment Certificate"),
        centerTitle: true,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body:  Padding(padding: const EdgeInsets.all(16),
      child: Column(
        children: [
          const Text("Est pellentesque fermentum cursus curabitur pharetra, vene",textAlign: TextAlign.center,),
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
                child: const Padding(padding: EdgeInsets.all(16),
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text("Amount",style: TextStyle(color: Colors.grey),),
                         Text("NGN 600,000")
                      ],
                    ),
                    SizedBox(height: 10,),
                      Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text("Duration",style: TextStyle(color: Colors.grey)),
                         Text("2 Years")
                      ],
                    ),
                    SizedBox(height: 10,),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text("Start Date",style: TextStyle(color: Colors.grey)),
                         Text("1 October,2024")
                      ],
                    ),
                    SizedBox(height: 10,),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text("Interest",style: TextStyle(color: Colors.grey)),
                         Text("10 %")
                      ],
                    ),
                    SizedBox(height: 10,),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text("Maturity Date",style: TextStyle(color: Colors.grey)),
                         Text("30 September,2026")
                      ],
                    ),
                    SizedBox(height: 10),
                  ],
                ),
                ),),
                const SizedBox(height: 16,),
                 Container(
                  padding: const EdgeInsets.all(16),
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
                child:const Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text("Expected Yield"),
                    Text("NGN 660,000")
                  ],
                ) ,
                 ),
                Center(
              
              child: Row(
                 mainAxisAlignment: MainAxisAlignment.center,
                children: [
                   const Text("Over/Under Estimated? "),
                  TextButton(
                    onPressed: () {},
                    child: const Text("Recalculate" ,style: TextStyle(color: Color.fromARGB(255, 10, 72, 143)),),
                  ),

                 
              ],)
             
            ),
            const SizedBox(
                height: 20,
              ),
                    Align(
                      alignment: Alignment.center,
                      child: ElevatedButton(
                          onPressed: () {
                            // Navigator.pushReplacement(
                            //   context,
                            //   MaterialPageRoute(
                            //     builder: (context) => const ProfilePagewidget(startIndex: 6),
                            //   ),
                            // );
                          },
                          style: ElevatedButton.styleFrom(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 140.0, vertical: 17.0),
                            backgroundColor: Colors.deepPurple,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(20),
                            ),
                          ),
                          child: const Text("Invest More",
                              style: TextStyle(color: Colors.white)),
                        ),
                    )
        ],
      ),
      ),
    );
  }
}