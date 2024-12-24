import 'dart:convert';
import 'package:ag_mortgage/Dashboard_Screen/Market_Place/Dashboard_Page/model.dart';
import 'package:ag_mortgage/Dashboard_Screen/Market_Place/main.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class TodayDeals extends StatefulWidget {
  const TodayDeals({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _TodayDealsState createState() => _TodayDealsState();
}

class _TodayDealsState extends State<TodayDeals>
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
        title: const Text('Today Deal', style: TextStyle(color: Colors.black)),
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
              (section) => section.title == "Today's Deal",
              orElse: () => Section(
                  title: "Today's Deal",
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
                todayDeals(mostView),
              ],
            );
          }
        },
      ),
    );
  }

  Widget todayDeals(Section section) {
  return Column(
     crossAxisAlignment: CrossAxisAlignment.center,
    children: [
    
     Wrap(
      spacing: 8.0, // Horizontal spacing between cards
          runSpacing: 8.0, 
          children: section.homes.map((home) {
            return Container(
              margin: const EdgeInsets.symmetric(horizontal: 8.0),
              width: 340,
              height: 400, // Adjust as needed for card width
              decoration: BoxDecoration(
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.1),
                    blurRadius: 8,
                    offset: const Offset(0, 4),
                  ),
                ],
                borderRadius: BorderRadius.circular(10),
                image: DecorationImage(
                  image: AssetImage(home.image),
                  colorFilter: const ColorFilter.mode(
                    Color.fromARGB(101, 0, 0, 0), // Semi-transparent overlay
                    BlendMode.darken,
                  ),
                  fit: BoxFit.cover,
                ),
              ),
              child: Stack(
                children: [
                  Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      gradient: LinearGradient(
                        colors: [
                          Colors.black.withOpacity(0.6),
                          Colors.transparent,
                        ],
                        begin: Alignment.bottomCenter,
                        end: Alignment.topCenter,
                      ),
                    ),
                  ),
                  Positioned(
                    bottom: 10,
                    right: 10,
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 8, vertical: 4),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(40),
                      ),
                      child: const Text(
                        'View',
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 12,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                  Positioned(
                    top: 10,
                    left: 10,
                    child: GestureDetector(
                      onTap: () {
                        setState(() {
                          isFavorite = !isFavorite; // Toggle favorite state
                        });
                      },
                      child: Icon(
                        isFavorite
                            ? Icons.favorite
                            : Icons.favorite_border,
                        color: isFavorite ? Colors.red : Colors.white,
                        size: 24,
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Text(
                          home.price,
                          style: const TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          home.type,
                          style: const TextStyle(
                            fontSize: 14,
                            color: Colors.white,
                          ),
                        ),
                        const SizedBox(height: 4),
                        Row(
                          children: [
                            const Icon(Icons.location_on,
                                size: 14, color: Colors.white),
                            const SizedBox(width: 6),
                            Text(
                              home.location,
                              style: const TextStyle(
                                  fontSize: 12, color: Colors.white),
                            ),
                            const SizedBox(width: 16),
                            const Icon(Icons.bed,
                                size: 14, color: Colors.white),
                            const SizedBox(width: 3),
                            Text(
                              home.type.length > 10
                                  ? home.type.substring(0, 10)
                                  : home.type,
                              style: const TextStyle(
                                  fontSize: 12, color: Colors.white),
                            ),
                            const SizedBox(width: 16),
                            const Icon(Icons.square_foot,
                                size: 14, color: Colors.white),
                            const SizedBox(width: 3),
                            const Text(
                              "2900 Sqft",
                              style: TextStyle(
                                  fontSize: 12, color: Colors.white),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            );
          }).toList(),
        ),
    ]
      );
  
}

}
