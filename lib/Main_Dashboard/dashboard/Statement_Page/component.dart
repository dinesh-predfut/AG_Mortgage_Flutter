import 'package:ag_mortgage/All_Cards/Get_all_Cards/all_cards.dart';
import 'package:ag_mortgage/All_Cards/Get_all_Cards/controller.dart';
import 'package:ag_mortgage/Main_Dashboard/dashboard/Dashboard/component.dart';
import 'package:ag_mortgage/Main_Dashboard/dashboard/Statement_Page/controller.dart';
import 'package:ag_mortgage/const/Image.dart';
import 'package:ag_mortgage/const/colors.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class StatementOfAccount extends StatefulWidget {
  const StatementOfAccount({Key? key}) : super(key: key);

  @override
  _StatementOfAccountState createState() => _StatementOfAccountState();
}

class _StatementOfAccountState extends State<StatementOfAccount> {
   final Controllers = Get.put(StatementPage());
  @override
  void initState() {
    super.initState();
   Controllers.getAllTransactions(context);
  }
  final List<Map<String, dynamic>> transactions = [
    {
      "date": "Today",
      "type": "Deposit",
      "amount": 450000,
      "source": "From Visa...6521",
      "time": "25 minutes ago",
      "isDeposit": true,
    },
    {
      "date": "9 September, 2024",
      "type": "Withdraw",
      "amount": 76000,
      "source": "Into Visa...9102",
      "time": "6:32 pm",
      "isDeposit": false,
    },
    {
      "date": "30 August, 2024",
      "type": "Deposit",
      "amount": 450000,
      "source": "From Bank Transfer",
      "time": "2:35 pm",
      "isDeposit": true,
    },
    {
      "date": "30 August, 2024",
      "type": "Withdraw",
      "amount": 84000,
      "source": "Into Visa...9102",
      "time": "9:12 am",
      "isDeposit": false,
    },
  ];

  final TextEditingController _amountController = TextEditingController();

  void _setAmount(int amount) {
    setState(() {
      _amountController.text = " $amount";
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () => Navigator.pop(context),
        ),
        title: const Text(
          "Statement of Account",
          style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            // Balance and Withdrawal Summary
            Container(
              padding: const EdgeInsets.all(16),
              child: Column(
                children: [
                  Container(  
                    height: 140,
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
                    child: Padding(
                      padding: const EdgeInsets.all(16),
                      child: Column(
                        children: [
                          Container(
                            child: const Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Column(
                                  children: [
                                    Text(
                                      "Total Month Paid",
                                      style: TextStyle(color: Colors.grey),
                                    ),
                                    Text(
                                      "03",
                                      textAlign: TextAlign.center,
                                      style: TextStyle(
                                          color: Colors.black,
                                          fontWeight: FontWeight.w900),
                                    )
                                  ],
                                ),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.end,
                                  children: [
                                    Text(
                                      "Total Deposit",
                                      textAlign: TextAlign.right,
                                      style: TextStyle(
                                        color: Colors.grey,
                                      ),
                                    ),
                                    Text(
                                      "NGN 38,700,000",
                                      textAlign: TextAlign.end,
                                      style: TextStyle(
                                          color: Colors.green,
                                          fontWeight: FontWeight.w900,
                                          fontSize: 18),
                                    )
                                  ],
                                ),
                              ],
                            ),
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              const Column(
                                children: [
                                  Text(
                                    "Default Months",
                                    style: TextStyle(color: Colors.grey),
                                  ),
                                  Text(
                                    "03",
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                        color: Colors.black,
                                        fontWeight: FontWeight.w900),
                                  )
                                ],
                              ),
                              ElevatedButton(
                                onPressed: () => {
                                  Navigator.pushReplacement(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) =>
                                          const Get_All_Cards(),
                                    ),
                                  ),
                                },
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: Colors.deepPurple,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(20),
                                  ),
                                  padding: const EdgeInsets.only(
                                      left: 15, right: 15, top: 5, bottom: 5),
                                ),
                                child: const Text(
                                  "Pay Rent",
                                  style: TextStyle(
                                      fontSize: 14, color: Colors.white),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 20),
            // Transaction List
            Expanded(
              child: ListView.builder(
                itemCount: transactions.length,
                itemBuilder: (context, index) {
                  final transaction = transactions[index];
                  final isFirstOfDate = index == 0 ||
                      transactions[index]["date"] !=
                          transactions[index - 1]["date"];
                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      if (isFirstOfDate) ...[
                        const SizedBox(height: 20),
                        Text(
                          transaction["date"],
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            color: Colors.grey.shade700,
                          ),
                        ),
                        const SizedBox(height: 10),
                      ],
                      Card(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: ListTile(
                          leading: CircleAvatar(
                            radius: 25,
                            backgroundColor: transaction["isDeposit"]
                                ? Colors.green
                                : Colors.red,
                            child: Icon(
                              transaction["isDeposit"]
                                  ? Icons.arrow_downward
                                  : Icons.arrow_upward,
                              color: Colors.white,
                            ),
                          ),
                          title: Text(
                            "NGN ${transaction["amount"].toString()}",
                            style: const TextStyle(fontWeight: FontWeight.bold),
                          ),
                          subtitle: Text(transaction["source"]),
                          trailing: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                transaction["isDeposit"]
                                    ? "Deposit"
                                    : "Withdraw",
                                style: TextStyle(
                                  color: transaction["isDeposit"]
                                      ? Colors.green
                                      : Colors.red,
                                ),
                              ),
                              const SizedBox(height: 4),
                              Text(
                                transaction["time"],
                                style: const TextStyle(
                                    fontSize: 12, color: Colors.grey),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  void showDepositBottomSheet(BuildContext context) {
    showModalBottomSheet(
      context: context,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
      ),
      isScrollControlled: true,
      builder: (context) => const Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            SizedBox(height: 16),
            Text(
              "Deposit",
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 16),
            ALL_Card()
          ],
        ),
      ),
    );
  }

  void openSecondPopup(BuildContext context, String method) {
    showModalBottomSheet(
      context: context,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
      ),
      isScrollControlled: true,
      builder: (context) => FractionallySizedBox(
        heightFactor: 0.8,
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const SizedBox(height: 30),
              const Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    "Deposit",
                    style: TextStyle(
                        fontSize: 20,
                        color: Colors.black,
                        fontWeight: FontWeight.w900),
                  )),
              const SizedBox(height: 10),
              // Card Section
              Container(
                decoration: BoxDecoration(
                  gradient: const LinearGradient(
                    colors: [
                      Color.fromARGB(255, 51, 170, 55),
                      Color.fromARGB(209, 45, 245, 51)
                    ],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                  borderRadius: BorderRadius.circular(12),
                ),
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        const CircleAvatar(
                          radius: 20,
                          backgroundColor: Colors.white,
                          child: Icon(Icons.circle, color: Colors.green),
                        ),
                        const Spacer(),
                        IconButton(
                          onPressed: () {},
                          icon:
                              const Icon(Icons.more_vert, color: Colors.white),
                        ),
                      ],
                    ),
                    const SizedBox(height: 30),
                    const Text(
                      "Adeyemi Pelumi",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 10),
                    const Text(
                      "3098 9576 1876 6521",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 10),
                    const Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "CVV: 010",
                          style: TextStyle(color: Colors.white),
                        ),
                        Text(
                          "EXP: 12/29",
                          style: TextStyle(color: Colors.white),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 20),
              TextFormField(
                controller: _amountController,
                decoration: InputDecoration(
                  prefixText: "NGN ",
                  contentPadding:
                      const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                    borderSide: const BorderSide(color: Colors.deepPurple),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                    borderSide:
                        const BorderSide(color: Colors.deepPurple, width: 2),
                  ),
                ),
              ),
              const SizedBox(height: 20),
              Wrap(
                spacing: 10,
                runSpacing: 10,
                children: [
                  _amountButton(context, "#100,000", 100000),
                  _amountButton(context, "#200,000", 200000),
                  _amountButton(context, "#300,000", 300000),
                  _amountButton(context, "#400,000", 400000),
                  _amountButton(context, "#500,000", 500000),
                  _amountButton(context, "#600,000", 600000),
                ],
              ),
              const SizedBox(height: 16),
              ElevatedButton(
                onPressed: () {
                  showSuccessPopup(context);
                },
                //
                style: ElevatedButton.styleFrom(
                  backgroundColor: baseColor,
                  minimumSize: const Size.fromHeight(50),
                ),
                child: const Text(
                  "Processd",
                  style: TextStyle(color: Colors.white, letterSpacing: 2),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _amountButton(BuildContext context, String displayText, int amount) {
    // ignore: unrelated_type_equality_checks

    return ElevatedButton(
      onPressed: () => _setAmount(amount),
      style: ElevatedButton.styleFrom(
        backgroundColor: Colors.white,

        // Set the button's background color
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),

          side: const BorderSide(
            color:
                Colors.orange, // Set the border color to match the button color
            width: 1, // Adjust border width if needed
          ),
          // Rounded corners
        ),
        padding: const EdgeInsets.symmetric(
            horizontal: 20, vertical: 10), // Button padding
      ),
      child: Text(
        displayText,
        style: const TextStyle(color: Colors.black), // Text color
      ),
    );
  }

  void showSuccessPopup(BuildContext context) {
    showModalBottomSheet(
        context: context,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
        ),
        isScrollControlled: true,
        builder: (context) => FractionallySizedBox(
              heightFactor: 0.5,
              child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Image.asset(
                          Images.success, width: 150, // Adjust size as needed
                          height: 150,
                        ),
                        const SizedBox(height: 20),
                        const Text(
                          "Deposite Successful",
                          style: TextStyle(
                              fontSize: 20, fontWeight: FontWeight.w600),
                        ),
                        const Text(
                            "Congratulations Pelumi! You have made your first deposit",
                            style: TextStyle(fontSize: 10)),
                        const SizedBox(height: 20),
                        ElevatedButton(
                          onPressed: () {
                            Navigator.pushReplacement(
                              context,
                              MaterialPageRoute(
                                builder: (context) =>
                                    const Main_Dashboard(), // Start with MortgagePage
                              ),
                            );
                          },
                          //
                          style: ElevatedButton.styleFrom(
                            backgroundColor: baseColor,
                            minimumSize: const Size.fromHeight(50),
                          ),
                          child: const Text(
                            "Processd",
                            style: TextStyle(
                                color: Colors.white, letterSpacing: 2),
                          ),
                        ),
                      ],
                    ),
                  )),
            ));
  }
}

void main() {
  runApp(const MaterialApp(
    home: StatementOfAccount(),
    debugShowCheckedModeBanner: false,
  ));
}
