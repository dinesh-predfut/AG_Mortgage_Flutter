// screens/get_all_cards.dart
import 'package:ag_mortgage/All_Cards/Add_New_Cards/add_cards.dart';
import 'package:ag_mortgage/All_Cards/Get_all_Cards/controller.dart';
import 'package:ag_mortgage/All_Cards/Select_Amount/select_Amount.dart';
import 'package:ag_mortgage/Dashboard_Screen/Mortgage/MortgageHome.dart';
import 'package:ag_mortgage/Dashboard_Screen/Mortgage/MortgagePage.dart';
import 'package:ag_mortgage/const/colors.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';

class Get_All_Cards extends StatefulWidget {
  const Get_All_Cards({super.key});

  @override
  State<Get_All_Cards> createState() => _Get_All_CardsState();
}

class _Get_All_CardsState extends State<Get_All_Cards> {
  // CardController cardDetails = Get.find<CardController>();
  final cardControllers = Get.put(CardController());
  CardController controller = CardController();
  //  void refreshUI() {
  //
  //  }
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

  void handleEditCard(
    int id,
    BuildContext context,
  ) {
    print('Response body@@@: ${controller.nameController}');
    controller.cardID = id;
    controller.cardGetbyID();
    showEditWindow(context, controller);
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => CardController()..fetchCards(),
      child: Scaffold(
        appBar: AppBar(
          title: const Text("My Cards"),
          centerTitle: true,
          leading: IconButton(
            icon: const Icon(Icons.arrow_back),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
        ),
        body: Padding(
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

  void showEditWindow(BuildContext context, cardController) {
    showModalBottomSheet(
      context: context,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
      ),
      isScrollControlled: true,
      builder: (context) => FractionallySizedBox(
        heightFactor: 0.8,
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
                            icon: const Icon(Icons.more_vert,
                                color: Colors.white),
                          ),
                        ],
                      ),
                      const SizedBox(height: 30),
                      Text(
                        cardController.nameController.text,
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 10),
                      Text(
                        cardController.cardNumber.text,
                        style: const TextStyle(
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
                          backgroundColor: Colors.deepPurple,
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
}
// ignore: must_be_immutable
