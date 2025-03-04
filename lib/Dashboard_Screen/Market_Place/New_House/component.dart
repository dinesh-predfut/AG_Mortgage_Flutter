import 'dart:convert';
import 'package:ag_mortgage/Dashboard_Screen/Market_Place/Dashboard_Page/controller.dart';
import 'package:ag_mortgage/Dashboard_Screen/Market_Place/Dashboard_Page/model.dart';
import 'package:ag_mortgage/Dashboard_Screen/Market_Place/Details_Page/component.dart';
import 'package:ag_mortgage/Dashboard_Screen/Market_Place/main.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

class New_house extends StatefulWidget {
  const New_house({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _New_houseState createState() => _New_houseState();
}

class _New_houseState extends State<New_house>
    with SingleTickerProviderStateMixin {
  // late Future<List<ApiResponsemostview>> _sections;
  final controller = Get.put(Market_Place_controller());
  late Future<ApiResponsemostview> fetchmostViewedHouses;
  bool isFavorite = false;
  late TabController _tabController;
  final _selectedColor = const Color(0xff1a73e8);
  final _unselectedColor = const Color(0xff5f6368);
  @override
  void initState() {
    super.initState();
    fetchmostViewedHouses = controller.fetchmostViewedHouses();
    _tabController = TabController(length: 4, vsync: this);
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
  // Future<List<Section>> loadSections() async {
  //   String jsonString = await rootBundle.loadString('assets/data.json');
  //   final jsonData = json.decode(jsonString) as List;
  //   return jsonData.map((section) => Section.fromJson(section)).toList();
  // }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
        length: _tabs.length,
        child: Scaffold(
          appBar: AppBar(
            title: const Text('New House',
                style: TextStyle(color: Colors.black)),
            backgroundColor: Colors.white,
            iconTheme: const IconThemeData(color: Colors.black),
            actions: [
              IconButton(
                  onPressed: () {
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const MarketMain(startIndex: 6),
                      ),
                    );
                  },
                  icon: const Icon(Icons.favorite_border)),
              IconButton(
                  onPressed: () {
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const MarketMain(startIndex: 5),
                      ),
                    );
                  },
                  icon: const Icon(Icons.tune)),
            ],
            bottom: TabBar(
              controller: _tabController,
              isScrollable: true,
              dividerHeight: 0,
              indicator: const BoxDecoration(),
              splashFactory: NoSplash.splashFactory,
              overlayColor: MaterialStateProperty.all(Colors.transparent),
              tabs: _tabs.asMap().entries.map((entry) {
                int index = entry.key;
                String tab = entry.value;
                bool isActive = _tabController.index == index;
                ; // Check if the tab is active

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
                          borderRadius:
                              BorderRadius.circular(40), // Rounded corners
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
                              color: isActive ? Colors.white : Colors.orange,
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
          body: FutureBuilder<ApinewHoseview>(
            future: controller.fetchnewtViewedHouses(),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const Center(child: CircularProgressIndicator());
              } else if (snapshot.hasError) {
                return const Center(
                    child: Text('Error loading today\'s deals'));
              } else if (snapshot.hasData && snapshot.data!.items.isNotEmpty) {
                return newHouses(
                    context, snapshot.data!.items); // Pass today's deal items
              } else {
                return ListView(
                  children: [
                    const SizedBox(height: 12),
                    Align(
                      alignment: Alignment.centerLeft,
                      child: TabBar(
                        controller: _tabController,
                        isScrollable: true,
                        indicator: const BoxDecoration(),
                        splashFactory: NoSplash.splashFactory,
                        overlayColor:
                            MaterialStateProperty.all(Colors.transparent),
                        tabs: _tabs.asMap().entries.map((entry) {
                          int index = entry.key;
                          String tab = entry.value;
                          bool isActive = _tabController.index == index;
                          ; // Check if the tab is active

                          return Tab(
                            child: Column(
                              children: [
                                Container(
                                  width: 60,
                                  padding:
                                      const EdgeInsets.symmetric(horizontal: 3),
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
                                        color: isActive
                                            ? Colors.white
                                            : Colors.orange,
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
                  ],
                );
              }
            },
          ),
        ));
  }

  Widget newHouses(BuildContext context, List<dynamic> section) {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Padding(
            padding: EdgeInsets.only(left: 8),
            child: Text(
              "Choose a home from a trusted developer",
              textAlign: TextAlign.start,
              style: TextStyle(color: Colors.grey),
            ),
          ),
          const SizedBox(height: 10),
          Column(
            children: List.generate(section.length, (index) {
              final home = section[index];
              final imageUrl =
                  home.housePictures.isNotEmpty ? home.housePictures[0] : '';

              return Container(
                margin: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
                decoration: BoxDecoration(
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.1),
                      blurRadius: 8,
                      offset: const Offset(0, 4),
                    ),
                  ],
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Card(
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10)),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Image Section
                      ClipRRect(
                        borderRadius:
                            BorderRadius.vertical(top: Radius.circular(10)),
                        child: AspectRatio(
                          aspectRatio: 16 / 9, // Maintains image consistency
                          child: Image.network(
                            imageUrl,
                            fit: BoxFit.cover,
                            errorBuilder: (context, error, stackTrace) =>
                                Container(
                              color: Colors.grey[300],
                              child: Icon(Icons.image,
                                  color: Colors.grey, size: 50),
                            ),
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(home.price.toString(),
                                style: const TextStyle(
                                    fontSize: 16, fontWeight: FontWeight.bold)),
                            const SizedBox(height: 4),
                            Text(home.houseType ?? "Unknown Type",
                                style: const TextStyle(
                                    fontSize: 12, color: Colors.grey)),
                            const SizedBox(height: 4),
                            Row(
                              children: [
                                const Icon(Icons.location_on,
                                    size: 12, color: Colors.grey),
                                const SizedBox(width: 4),
                                Text(home.street ?? "Unknown City",
                                    style: const TextStyle(
                                        fontSize: 10, color: Colors.grey)),
                                const SizedBox(width: 12),
                                const Icon(Icons.bed,
                                    size: 12, color: Colors.grey),
                                const SizedBox(width: 3),
                                Text(
                                    home.houseType.length > 10
                                        ? home.houseType.substring(0, 10)
                                        : home.houseType,
                                    style: const TextStyle(
                                        fontSize: 10, color: Colors.grey)),
                                const SizedBox(width: 12),
                                const Icon(Icons.square_foot,
                                    size: 12, color: Colors.grey),
                                const SizedBox(width: 3),
                                Text(home.totalArea ?? "Unknown City",
                                    style: const TextStyle(
                                        fontSize: 10, color: Colors.grey))
                              ],
                            ),
                            const SizedBox(height: 8),
                            Align(
                              alignment: Alignment.bottomRight,
                              child: GestureDetector(
                                onTap: () {
                                  Navigator.pushReplacement(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => MarketMain(
                                          startIndex: 4, id: home.id),
                                    ),
                                  );
                                },
                                child: Container(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 12, vertical: 6),
                                  decoration: BoxDecoration(
                                    color: Colors.orange[200],
                                    borderRadius: BorderRadius.circular(40),
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
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              );
            }),
          ),
        ],
      ),
    );
  }
}
