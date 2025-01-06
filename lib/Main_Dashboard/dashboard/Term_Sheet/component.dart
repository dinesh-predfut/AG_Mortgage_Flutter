import 'package:ag_mortgage/const/colors.dart';
import 'package:flutter/material.dart';

class Term_Sheets extends StatefulWidget {
  const Term_Sheets({super.key});

  @override
  State<Term_Sheets> createState() => _Term_SheetsState();
}

class _Term_SheetsState extends State<Term_Sheets>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(vsync: this);
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
        title: const Text('Term Sheet'),
        centerTitle: true,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              "Est pellentesque fermentum cursus curabitur pharetra, vene",
              textAlign: TextAlign.center,
              style: TextStyle(color: Colors.grey, fontSize: 13),
            ),
            const SizedBox(
              height: 5,
            ),
            // Align(
            //   alignment: Alignment.bottomRight,
            //   child: ElevatedButton(
            //     onPressed: () {},
            //     style: ElevatedButton.styleFrom(
            //       backgroundColor: baseColor,
            //       padding: const EdgeInsets.symmetric(
            //           horizontal: 20.0, vertical: 10.0),
            //       shape: RoundedRectangleBorder(
            //         borderRadius: BorderRadius.circular(20),
            //       ),
            //     ),
            //     child: const Text("View House",
            //         style: TextStyle(color: Colors.white, fontSize: 12)),
            //   ),
            // ),
            const SizedBox(height: 0.0),
            _buildSection(
              "House Details",
              [
              
                _buildRow("City", "Lagos"),
                _buildRow("Area", "Ogunlana Area"),
                  _buildRow("Construction Type", "Bungalow"),
                _buildRow("Estimated Budget", "NGN 40,000,000"),
              ],
              buttonAction: () {},
            ),
            const SizedBox(height: 16.0),
            _buildSection(
              "Loan Details",
              [
                _buildRow("Initial Deposit", "NGN 500,000"),
                _buildRow("Loan", "NGN 33,200,000"),
                _buildRow("Repayment Period", "10 Years"),
                _buildRow("Monthly Repayment", "NGN 350,000"),
                _buildRow("Starting Date", "1 August, 2024"),
              ],
            ),
            const SizedBox(height: 16.0),
            _buildSection(
              "Deposit & Profiling",
              [
                _buildRow("Screening Period", "18 Months"),
                _buildRow("Estimated Profile Date", "30 January, 2026"),
                _buildRow("Estimated Total Monthly Savings", "NGN 6,300,000"),
                _buildRow("Initial Deposit", "0.00"),
                _buildRow("Total Expected Saving", "NGN 6,800,000"),
              ],
            ),
            const SizedBox(height: 16.0),
            Container(
              padding: const EdgeInsets.all(16.0),
              decoration: BoxDecoration(
                color: Colors.amber[100],
                borderRadius: BorderRadius.circular(8.0),
              ),
              child: const Column(
                
                
                children: [
                  Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "Amount to Deposit",
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                      Text("NGN 0.00"),
                    ],
                  )
                 
                ],
              ),
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
            const SizedBox(height: 24.0),
           
          ],
        ),
      ),
    );
  }

  Widget _buildSection(String title, List<Widget> rows,
      {String? buttonText, VoidCallback? buttonAction}) {
    return Card(
      margin: const EdgeInsets.only(top: 8.0),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  title,
                  style: const TextStyle(
                      fontWeight: FontWeight.bold, fontSize: 16.0),
                ),
                if (buttonText != null && buttonAction != null)
                  TextButton(
                    onPressed: buttonAction,
                    child: Text(buttonText),
                  ),
              ],
            ),
            const SizedBox(height: 8.0),
            Column(children: rows),
          ],
        ),
      ),
    );
  }

  Widget _buildRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(label, style: const TextStyle(color: Colors.grey)),
          Text(value, style: const TextStyle(fontWeight: FontWeight.bold)),
        ],
      ),
    );
  }

}