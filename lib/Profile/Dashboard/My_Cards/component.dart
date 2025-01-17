import 'package:ag_mortgage/Profile/Dashboard/My_Cards/add_card_component.dart';
import 'package:ag_mortgage/Profile/Dashboard/component.dart';
import 'package:ag_mortgage/const/colors.dart';
import 'package:flutter/material.dart';

class MyCardsPage extends StatefulWidget {
  const MyCardsPage({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _MyCardsPageState createState() => _MyCardsPageState();
}

class _MyCardsPageState extends State<MyCardsPage>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
  }

  Widget _buildCard({
    required String name,
    required String cardNumber,
    required String cvv,
    required String expiry,
    required List<Color> gradientColors, // Gradient colors
    required String logoText,
  }) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: gradientColors, // Apply gradient colors
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(12.0),
      ),
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              name == "Gyi"
                  ? const Text(
                      "GYI",
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 22,
                          fontWeight: FontWeight.w900,
                          letterSpacing: 2),
                    )
                  : const CircleAvatar(
                      radius: 20,
                      backgroundColor: Colors.white,
                      child: Icon(Icons.circle, color: Colors.black12),
                    ),
              const Spacer(),
              IconButton(
                onPressed: () {},
                icon: const Icon(Icons.more_vert, color: Colors.white),
              ),
            ],
          ),
          const SizedBox(height: 30),
          Text(
            name,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 10),
          Text(
            cardNumber,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 16,
              letterSpacing: 2.0,
            ),
          ),
          const SizedBox(height: 10),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "CVV: $cvv",
                style: const TextStyle(color: Colors.white),
              ),
              Text(
                "EXP: $expiry",
                style: const TextStyle(color: Colors.white),
              ),
            ],
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("My Cards"),
        centerTitle: true,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => {
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                builder: (context) =>
                    const AccountPage(), // Start with MortgagePage
              ),
            ),
          },
        ),
        bottom: TabBar(
          controller: _tabController,
          labelColor: Colors.orange,
          unselectedLabelColor: Colors.grey,
          indicatorColor: Colors.orange,
          tabs: const [
            Tab(text: "Active"),
            Tab(text: "Expired"),
          ],
        ),
      ),
      body: TabBarView(
        controller: _tabController,
        children: [
          // Active Cards Tab
          ListView(
            children: [
              _buildCard(
                name: "Adeyemi Pelumi",
                cardNumber: "3098 9576 1876 6521",
                cvv: "010",
                expiry: "12/29",
                gradientColors: [
                  const Color.fromARGB(255, 24, 78, 26),
                  const Color.fromARGB(244, 3, 245, 15)
                ], // Gradient colors
                logoText: "Active",
              ),
              _buildCard(
                name: "Gyi",
                cardNumber: "2134 7431 0076 4120",
                cvv: "222",
                expiry: "09/27",
                gradientColors: [
                  const Color.fromARGB(255, 129, 17, 9),
                  const Color.fromARGB(235, 248, 8, 3),
                ], // Gradient colors
                logoText: "GY",
              ),
              const SizedBox(
                height: 20,
              ),
              Padding(
                padding: const EdgeInsets.only(left: 20, right: 20),
                child: ElevatedButton.icon(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: baseColor, // Transparent background
                    elevation: 0, // Remove shadow
                    foregroundColor: Colors.white,
                    padding: const EdgeInsets.all(18),
                  ),
                  onPressed: () {
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                        builder: (context) =>
                            const AddCardDetailsPage(), // Start with MortgagePage
                      ),
                    );
                  },
                  icon: const Icon(Icons.add),
                  label: const Text("Add New Card"),
                ),
              ),
            ],
          ),
          // Expired Cards Tab
          ListView(
            children: [
              _buildCard(
                name: "Adeyemi Pelumi",
                cardNumber: "1234 5678 9101 1121",
                cvv: "555",
                expiry: "08/22",
                gradientColors: [
                  const Color.fromARGB(162, 109, 1, 100),
                  const Color.fromARGB(234, 214, 1, 161)
                ], // Gradient colors
                logoText: "EX",
              ),
              _buildCard(
                name: "Adeyemi Pelumi",
                cardNumber: "1234 5678 9101 1121",
                cvv: "555",
                expiry: "08/22",
                gradientColors: [
                  const Color.fromARGB(202, 1, 87, 75),
                  const Color.fromARGB(255, 17, 201, 176),
                ], // Gradient colors
                logoText: "EX",
              ),
              const SizedBox(
                height: 20,
              ),
              ElevatedButton.icon(
                style: ElevatedButton.styleFrom(
                  backgroundColor: baseColor, // Transparent background
                  elevation: 0, // Remove shadow
                  foregroundColor: Colors.white,
                ),
                onPressed: () {
                  // _showDocumentPopup(filePath, label);
                },
                icon: const Icon(Icons.add),
                label: const Text("Add New Card"),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
