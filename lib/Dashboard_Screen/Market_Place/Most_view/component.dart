import 'dart:convert';
import 'package:ag_mortgage/Dashboard_Screen/Market_Place/Dashboard_Page/model.dart';
import 'package:ag_mortgage/Dashboard_Screen/Market_Place/main.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class MostViewedPage extends StatefulWidget {
  const MostViewedPage({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _MostViewedPageState createState() => _MostViewedPageState();
}

class _MostViewedPageState extends State<MostViewedPage>
    with SingleTickerProviderStateMixin {
  late Future<List<Section>> _sections;
  bool isFavorite = false;
  late TabController _tabController;
  final _selectedColor = const Color(0xff1a73e8);
  final _unselectedColor = const Color(0xff5f6368);
  @override
  void initState() {
    super.initState();
    _sections = loadSections();
    _tabController = TabController(length: _tabs.length, vsync: this);
    _tabController.addListener(() {
      setState(() {}); // Refresh UI when tab changes
    });
  }

  @override
  void dispose() {
    super.dispose();
    _tabController.dispose();
  }

  final List<String> _tabs = [
    "All",
    "Lagos",
    "Ogun",
    "Anambra",
    "Abuja",
    "oyo",
    "Kaduna",
    "Kano"
  ];
  Future<List<Section>> loadSections() async {
    String jsonString = await rootBundle.loadString('assets/data.json');
    final jsonData = json.decode(jsonString) as List;
    return jsonData.map((section) => Section.fromJson(section)).toList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Most Viewed', style: TextStyle(color: Colors.black)),
        backgroundColor: Colors.white,
        iconTheme: const IconThemeData(color: Colors.black),
        actions: [
          IconButton(onPressed: () {
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                    builder: (context) =>
                        const Market_place_connection(startIndex: 6),
                  ),
                );
              }, icon: const Icon(Icons.favorite_border)),
          IconButton(
              onPressed: () {
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                    builder: (context) =>
                        const Market_place_connection(startIndex: 5),
                  ),
                );
              },
              icon: const Icon(Icons.tune)),
        ],
      ),
      body: FutureBuilder<List<Section>>(
        future: _sections,
        builder: (context, snapshot) {
          print('_someMethod: Foo Error ${snapshot} Error:{e.toString()}');
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return const Center(child: Text('Error loading data'));
          } else {
            final sections = snapshot.data ?? [];

            // Filter sections to only show the "Sponsored" section

            final mostView = sections.firstWhere(
              (section) => section.title == "Most Viewed",
              orElse: () => Section(
                  title: "Most Viewed",
                  homes: []), // Default in case no section matches
            );

            return ListView(
              children: [
                const SizedBox(height: 12),
                Align(
                  alignment: Alignment.centerLeft,
                  child: TabBar(
                    controller: _tabController,
                    isScrollable: true, // Makes the tabs scrollable
                    labelColor: Colors.white, // Active tab text color
                    // unselectedLabelColor:
                    //     Colors.orange, // Inactive tab text color
                    // indicator: BoxDecoration(
                    //   borderRadius: BorderRadius.circular(
                    //       40), // Rounded corners for active tab
                    //   color: Colors.orange// Active tab background color
                    // ),
                    indicator: const BoxDecoration(),
                    splashFactory:
                        NoSplash.splashFactory, // Removes ripple effect
                    overlayColor: MaterialStateProperty.all(Colors.transparent),
                    tabs: _tabs.asMap().entries.map((entry) {
                      int index = entry.key;
                      String tab = entry.value;

                      bool isActive = _tabController.index ==
                          index; // Check if the tab is active

                      return Tab(
                        child: Column(
                          children: [
                            Container(
                              width: 60,
                              padding: const EdgeInsets.symmetric(horizontal: 3),
                              height: isActive
                                  ? 40
                                  : 40, // Increased height for active tab
                              decoration: BoxDecoration(
                                border: Border.all(
                                  color: isActive
                                      ? Colors.white
                                      : Colors.orange, // Border color
                                ),
                                borderRadius: BorderRadius.circular(
                                    40), // Rounded corners
                                color: isActive
                                    ? Colors.orange // Active background
                                    : Colors
                                        .transparent, // Inactive tab background color
                              ),
                              child: Center(
                                child: Text(
                                  tab, // Tab text
                                  style: TextStyle(
                                    fontSize: 12,
                                    fontWeight: isActive
                                        ? FontWeight.bold
                                        : FontWeight.normal,
                                    color:
                                        isActive ? Colors.white : Colors.orange,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      );
                    }).toList(),
                  ),
                ),
                const SizedBox(height: 12),
                buildSectionmostview(mostView),
              ],
            );
          }
        },
      ),
    );
  }

  Widget buildSectionmostview(Section section) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Wrap(
          spacing: 8.0, // Horizontal spacing between cards
          runSpacing: 8.0, // Vertical spacing between rows of cards
          children: section.homes.map((home) {
            return SizedBox(
              width: 350, // Fixed width for each card
              child: Card(
                color: Colors.white,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10)),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    ClipRRect(
                      borderRadius:
                          const BorderRadius.vertical(top: Radius.circular(10)),
                      child: Image.asset(
                        home.image,
                        fit: BoxFit.cover,
                        width: double.infinity,
                        height: 150, // Fixed height for images
                      ),
                    ),
                    Container(
                      color: Colors.white,
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            home.price,
                            style: const TextStyle(
                                fontSize: 16, fontWeight: FontWeight.bold),
                          ),
                          const SizedBox(height: 4),
                          Text(
                            home.type,
                            style: const TextStyle(
                                fontSize: 14, color: Colors.grey),
                          ),
                          const SizedBox(height: 4),
                          Row(
                            children: [
                              const Icon(Icons.location_on,
                                  size: 14, color: Colors.grey),
                              const SizedBox(width: 4),
                              Text(
                                home.location,
                                style: const TextStyle(
                                    fontSize: 12, color: Colors.grey),
                              ),
                              const SizedBox(width: 16),
                              const Icon(Icons.bed,
                                  size: 14, color: Colors.grey),
                              const SizedBox(width: 3),
                              Text(
                                home.type.length > 10
                                    ? home.type.substring(0, 10)
                                    : home.type,
                                style: const TextStyle(
                                    fontSize: 12, color: Colors.grey),
                              ),
                              const SizedBox(width: 16),
                              const Icon(Icons.square_foot,
                                  size: 14, color: Colors.grey),
                              const SizedBox(width: 3),
                              const Text("2900 Sqft",
                                  style: TextStyle(
                                      fontSize: 12, color: Colors.grey)),
                            ],
                          ),
                          Align(
                            alignment: Alignment.topRight,
                            child: Container(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 8, vertical: 4),
                              decoration: BoxDecoration(
                                color: Colors.blue,
                                borderRadius: BorderRadius.circular(4),
                              ),
                              child: const Text(
                                'View',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 12,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            );
          }).toList(),
        ),
      ],
    );
  }
}
