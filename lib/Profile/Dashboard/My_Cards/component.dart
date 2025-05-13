import 'package:ag_mortgage/All_Cards/Add_New_Cards/add_cards.dart';
import 'package:ag_mortgage/All_Cards/Get_all_Cards/controller.dart';
import 'package:ag_mortgage/All_Cards/Select_Amount/select_Amount.dart';
import 'package:ag_mortgage/Profile/Dashboard/My_Cards/add_card_component.dart';
import 'package:ag_mortgage/Profile/Dashboard/component.dart';
import 'package:ag_mortgage/Profile/profile.dart';
import 'package:ag_mortgage/const/colors.dart';
import 'package:ag_mortgage/main.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';

class MyCardsPage extends StatefulWidget {
  const MyCardsPage({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _MyCardsPageState createState() => _MyCardsPageState();
}

class _MyCardsPageState extends State<MyCardsPage>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;
final cardControllers = Get.put(CardController());
CardController controller = CardController();
  @override
  void dispose() {
    cardControllers.dispose();
    controller.dispose(); // Dispose controller when widget is destroyed
    super.dispose();
    // controller.fetchCards();
    setState(() {
      //     // Force a rebuild to reflect the changes
    });
  }
  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
    controller.fetchCards();
  }

  void handleEditCard(
    int id,
    BuildContext context,
  ) {
    print('Response body@@@: ${controller.nameController}');
    controller.cardID = id;
    controller.cardGetbyID();
    showEditWindow(context, controller);
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
 void _onBackPressed(BuildContext context) {
    // Custom logic for back navigation
    if (Navigator.of(context).canPop()) {
      print("its working");
         Navigator.pushNamed(context, "/settings");
    } else {
      // Show exit confirmation dialog if needed
      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: Text("Exit App"),
          content: Text("Do you want to exit the app?"),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: Text("No"),
            ),
            TextButton(
              onPressed: () => Navigator.of(context).pop(true),
              child: Text("Yes"),
            ),
          ],
        ),
      );
    }
  }
  @override
  Widget build(BuildContext context) {
   return 
   WillPopScope(
      onWillPop: () async {
        // Handle custom back navigation logic
        _onBackPressed(context);
        return false; // Prevent default back behavior
      },
    child: 
   ChangeNotifierProvider(
      create: (_) => CardController()..fetchCards(),
      child: Scaffold(
      appBar: AppBar(
          title:  Text("My Card",style: TextStyle(color: baseColor),),
        centerTitle: true,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => {
            Navigator.pushReplacement(
            context,
            MaterialPageRoute(
                builder: (context) => const MainLayout(
                    showBottomNavBar: true,
                    startIndex: 3,
                    child: ProfilePagewidget(startIndex: 0))))
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
         
               Padding(
          padding: const EdgeInsets.all(16.0),
          child: Consumer<CardController>(
            builder: (context, controller, child) {
              if (controller.isLoading) {
                return const Center(child: CircularProgressIndicator());
              }

              if (controller.errorMessage.isNotEmpty) {
                return Center(child: Text(controller.errorMessage));
              }

              if (controller.cards.isEmpty) {
                return const Center(child: Text("No cards found."));
              }

              return Column(
                children: [
                  Expanded(
                    child: ListView.builder(
                      itemCount: controller.cards
                          .where((card) => card.cardStatus == "Active")
                          .length,
                      itemBuilder: (context, index) {
                        final activeCards = controller.cards
                            .where((card) => card.cardStatus == "Active")
                            .toList();
                        final card = activeCards[index];
                        return GestureDetector(
                            onTap: () {
                              // Navigator.push(
                              //   context,
                              //   MaterialPageRoute(
                              //     builder: (context) =>
                              //         CardPaymentPage(selectedID: card.id),
                              //   ),
                              // );
                            },
                            child: Container(
                              margin: const EdgeInsets.symmetric(vertical: 8.0),
                              decoration: BoxDecoration(
                                gradient: const LinearGradient(
                                  colors: [
                                    Color.fromARGB(255, 51, 170, 55),
                                    Color.fromARGB(209, 45, 245, 51),
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
                                      CircleAvatar(
                                        radius: 20,
                                        backgroundColor: Colors.white,
                                        child: Icon(
                                          Icons.circle,
                                          color: card.cardStatus == "Active"
                                              ? Colors.green
                                              : Colors.grey,
                                        ),
                                      ),
                                      const Spacer(),
                                      Tooltip(
                                        waitDuration:
                                            const Duration(seconds: 1),
                                        showDuration:
                                            const Duration(seconds: 2),
                                        padding: const EdgeInsets.all(5),
                                        height: 35,
                                        textStyle: const TextStyle(
                                            fontSize: 15,
                                            color: Colors.white,
                                            fontWeight: FontWeight.normal),
                                        decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(10),
                                            color: Colors.green),
                                        message: 'Options',
                                        child: PopupMenuButton<String>(
                                          onSelected: (value) {
                                            if (value == 'edit') {
                                              handleEditCard(card.id, context);
                                            } else if (value == 'delete') {
                                              handleDeleteCard(
                                                  card.id, context);
                                            }
                                          },
                                          icon: const Icon(Icons.more_vert,
                                              color: Colors.white),
                                          itemBuilder: (context) => [
                                            const PopupMenuItem(
                                              value: 'edit',
                                              child: Row(
                                                children: [
                                                  Icon(Icons.edit,
                                                      color: Colors.blue),
                                                  SizedBox(width: 8),
                                                  Text('Edit'),
                                                ],
                                              ),
                                            ),
                                            const PopupMenuItem(
                                              value: 'delete',
                                              child: Row(
                                                children: [
                                                  Icon(Icons.delete,
                                                      color: Colors.red),
                                                  SizedBox(width: 8),
                                                  Text('Delete'),
                                                ],
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                  const SizedBox(height: 30),
                                  Text(
                                    card.cardName,
                                    style: const TextStyle(
                                      color: Colors.white,
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  const SizedBox(height: 10),
                                  Text(
                                    card.cardNumber,
                                    style: const TextStyle(
                                      color: Colors.white,
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  const SizedBox(height: 1),
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(
                                        "CVV: ${card.cvv}",
                                        style: const TextStyle(
                                            color: Colors.white),
                                      ),
                                      Text(
                                        "EXP: ${card.expDate}",
                                        style: const TextStyle(
                                            color: Colors.white),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ));
                      },
                    ),
                  ),
                  const SizedBox(height: 16),
                  ElevatedButton.icon(
                    onPressed: () {
                      // handleAddCard(context);
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                          builder: (context) =>
                              const ADD_CardDetailsPage(), // Start with MortgagePageHome
                        ),
                      );
                    },
                    icon: const Icon(Icons.add),
                    label: const Text("Add New Card"),
                    style: ElevatedButton.styleFrom(
                      minimumSize: const Size.fromHeight(50),
                      backgroundColor: baseColor,
                      foregroundColor: Colors.white,
                      textStyle: const TextStyle(fontSize: 18),
                    ),
                  ),
                ],
              );
            },
          ),
        ),
              
           
           Padding(
          padding: const EdgeInsets.all(16.0),
          child: Consumer<CardController>(
            builder: (context, controller, child) {
              if (controller.isLoading) {
                return const Center(child: CircularProgressIndicator());
              }

              if (controller.errorMessage.isNotEmpty) {
                return Center(child: Text(controller.errorMessage));
              }

              if (controller.cards.isEmpty) {
                return const Center(child: Text("No cards found."));
              }

              return Column(
                children: [
                  Expanded(
                    child: ListView.builder(
                      itemCount: controller.cards
                          .where((card) => card.cardStatus == "Expired")
                          .length,
                      itemBuilder: (context, index) {
                        final activeCards = controller.cards
                            .where((card) => card.cardStatus == "Expired")
                            .toList();
                        final card = activeCards[index];
                        return GestureDetector(
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) =>
                                      CardPaymentPage(selectedID: card.id),
                                ),
                              );
                            },
                            child: Container(
                              margin: const EdgeInsets.symmetric(vertical: 8.0),
                              decoration: BoxDecoration(
                                gradient: const LinearGradient(
                                  colors: [
                                    Color.fromARGB(255, 170, 89, 51),
                                    Color.fromARGB(209, 243, 0, 0),
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
                                      CircleAvatar(
                                        radius: 20,
                                        backgroundColor: Colors.white,
                                        child: Icon(
                                          Icons.circle,
                                          color: card.cardStatus == "Active"
                                              ? Colors.green
                                              : Colors.grey,
                                        ),
                                      ),
                                      const Spacer(),
                                      Tooltip(
                                        waitDuration:
                                            const Duration(seconds: 1),
                                        showDuration:
                                            const Duration(seconds: 2),
                                        padding: const EdgeInsets.all(5),
                                        height: 35,
                                        textStyle: const TextStyle(
                                            fontSize: 15,
                                            color: Colors.white,
                                            fontWeight: FontWeight.normal),
                                        decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(10),
                                            color: Colors.green),
                                        message: 'Options',
                                        child: PopupMenuButton<String>(
                                          onSelected: (value) {
                                            if (value == 'edit') {
                                              handleEditCard(card.id, context);
                                            } else if (value == 'delete') {
                                              handleDeleteCard(
                                                  card.id, context);
                                            }
                                          },
                                          icon: const Icon(Icons.more_vert,
                                              color: Colors.white),
                                          itemBuilder: (context) => [
                                            const PopupMenuItem(
                                              value: 'edit',
                                              child: Row(
                                                children: [
                                                  Icon(Icons.edit,
                                                      color: Colors.blue),
                                                  SizedBox(width: 8),
                                                  Text('Edit'),
                                                ],
                                              ),
                                            ),
                                            const PopupMenuItem(
                                              value: 'delete',
                                              child: Row(
                                                children: [
                                                  Icon(Icons.delete,
                                                      color: Colors.red),
                                                  SizedBox(width: 8),
                                                  Text('Delete'),
                                                ],
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                  const SizedBox(height: 30),
                                  Text(
                                    card.cardName,
                                    style: const TextStyle(
                                      color: Colors.white,
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  const SizedBox(height: 10),
                                  Text(
                                    card.cardNumber,
                                    style: const TextStyle(
                                      color: Colors.white,
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  const SizedBox(height: 1),
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(
                                        "CVV: ${card.cvv}",
                                        style: const TextStyle(
                                            color: Colors.white),
                                      ),
                                      Text(
                                        "EXP: ${card.expDate}",
                                        style: const TextStyle(
                                            color: Colors.white),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ));
                      },
                    ),
                  ),
                  const SizedBox(height: 16),
                  ElevatedButton.icon(
                    onPressed: () {
                      // handleAddCard(context);
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                          builder: (context) =>
                              const ADD_CardDetailsPage(), // Start with MortgagePageHome
                        ),
                      );
                    },
                    icon: const Icon(Icons.add),
                    label: const Text("Add New Card"),
                    style: ElevatedButton.styleFrom(
                      minimumSize: const Size.fromHeight(50),
                      backgroundColor: baseColor,
                      foregroundColor: Colors.white,
                      textStyle: const TextStyle(fontSize: 18),
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
   ),
   );
  }
  void showEditWindow(BuildContext context, cardController) {
    showModalBottomSheet(
      context: context,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
      ),
      isScrollControlled: true,
      builder: (context) => FractionallySizedBox(
        heightFactor: 0.6,
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Stack(
                  children: [
                    const Align(
                      alignment: Alignment.centerLeft,
                      child: Padding(
                        padding: EdgeInsets.only(top: 8.0),
                        child: Text(
                          "Cards",
                          style: TextStyle(
                            fontSize: 20,
                            color: Colors.black,
                            fontWeight: FontWeight.w900,
                          ),
                        ),
                      ),
                    ),
                    Align(
                      alignment: Alignment.centerRight,
                      child: IconButton(
                        icon: const Icon(Icons.close),
                        onPressed: () {
                          Navigator.of(context).pop(); // Close the modal
                        },
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 10),
                // Card Section
               
                const SizedBox(height: 20),
                // Form Fields
                TextFormField(
                  controller: cardController.nameController,
                  onChanged: (value) {
                    // Dynamically update state
                    setState(() {
                      cardController.nameController.text = value;
                    });
                  },
                  style: const TextStyle(color: Colors.black),
                  decoration: InputDecoration(
                    contentPadding: const EdgeInsets.symmetric(
                        horizontal: 15, vertical: 10),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide:BorderSide(color: baseColor),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide:
                           BorderSide(color: baseColor, width: 2),
                    ),
                  ),
                ),
                const SizedBox(height: 20),
                TextFormField(
                  controller: cardController.cardNumber,
                  onChanged: (value) {
                    // Dynamically update state
                    setState(() {
                      cardController.cardNumber.text = value;
                    });
                  },
                  decoration: InputDecoration(
                    contentPadding: const EdgeInsets.symmetric(
                        horizontal: 15, vertical: 10),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide:BorderSide(color: baseColor),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide:
                           BorderSide(color: baseColor, width: 2),
                    ),
                  ),
                ),
                const SizedBox(height: 20),
                TextFormField(
                  controller: cardController.expDateController,
                  onChanged: (value) {
                    // Dynamically update state
                    setState(() {
                      cardController.expDateController.text = value;
                    });
                  },
                  decoration: InputDecoration(
                    contentPadding: const EdgeInsets.symmetric(
                        horizontal: 15, vertical: 10),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide:BorderSide(color: baseColor),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide:
                           BorderSide(color: baseColor, width: 2),
                    ),
                  ),
                ),
                const SizedBox(height: 20),
                TextFormField(
                  controller: cardController.cvv,
                  onChanged: (value) {
                    // Dynamically update state
                    setState(() {
                      cardController.cvv.text = value;
                    });
                  },
                  decoration: InputDecoration(
                    contentPadding: const EdgeInsets.symmetric(
                        horizontal: 15, vertical: 10),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide:BorderSide(color: baseColor),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide:
                           BorderSide(color: baseColor, width: 2),
                    ),
                  ),
                ),
                const SizedBox(height: 20),
                Row(
                  children: [
                    Expanded(
                      child: ElevatedButton(
                        onPressed: () {
                          Navigator.of(context).pop(); // Cancel action
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.grey,
                          minimumSize: const Size.fromHeight(50),
                        ),
                        child: const Text(
                          "Cancel",
                          style:
                              TextStyle(color: Colors.white, letterSpacing: 2),
                        ),
                      ),
                    ),
                    const SizedBox(width: 10),
                    Expanded(
                      child: ElevatedButton(
                        onPressed: () {
                          // Submit action here
                          controller.editCard(context);
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: baseColor,
                          minimumSize: const Size.fromHeight(50),
                        ),
                        child: const Text(
                          "Submit",
                          style:
                              TextStyle(color: Colors.white, letterSpacing: 2),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
  void handleDeleteCard(int cardId, BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Delete Card'),
        content: const Text('Are you sure you want to delete this card?'),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.of(context).pop(); // Close the dialog
            },
            child: const Text('Cancel'),
          ),
          ElevatedButton(
            onPressed: () {
              controller.deletedCard(context, cardId); // Close the dialog
              // Perform delete API call or logic here
              print("Card Deleted: $cardId");
            },
            style: ElevatedButton.styleFrom(backgroundColor: Colors.red),
            child: const Text(
              'Delete',
              style: TextStyle(color: Colors.white),
            ),
          ),
        ],
      ),
    );
  }
}
