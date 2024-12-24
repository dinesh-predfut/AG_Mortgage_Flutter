import 'dart:convert';
import 'package:ag_mortgage/Dashboard_Screen/Market_Place/Dashboard_Page/model.dart';
import 'package:ag_mortgage/Dashboard_Screen/Market_Place/New_House/component.dart';
import 'package:ag_mortgage/Dashboard_Screen/Market_Place/main.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class MarketplacePage extends StatefulWidget {
  const MarketplacePage({super.key});

  @override
  _MarketplacePageState createState() => _MarketplacePageState();
}

class _MarketplacePageState extends State<MarketplacePage>
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
    _tabController = TabController(length: 12, vsync: this);
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
        title: const Text('Marketplace', style: TextStyle(color: Colors.black)),
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
            final sponsoredSection = sections.firstWhere(
              (section) => section.title == "Sponsored",
              orElse: () => Section(
                  title: "Sponsored",
                  homes: []), // Default in case no section matches
            );
            final mostView = sections.firstWhere(
              (section) => section.title == "Most Viewed",
              orElse: () => Section(
                  title: "Most Viewed",
                  homes: []), // Default in case no section matches
            );
            final TodayDeals = sections.firstWhere(
              (section) => section.title == "Today's Deal",
              orElse: () => Section(
                  title: "Today's Deal",
                  homes: []), // Default in case no section matches
            );
            final newHouse = sections.firstWhere(
              (section) => section.title == "New House",
              orElse: () => Section(
                  title: "New House",
                  homes: []), // Default in case no section matches
            );

            return ListView(
              children: [
                buildSection(sponsoredSection),
                const SizedBox(height: 12),
                Align(
                  alignment: Alignment.centerLeft,
                  child: TabBar(
                    controller: _tabController,
                    isScrollable: true, // Makes the tabs scrollable
                    labelColor: Colors.white,
                    // Active tab text color
                    unselectedLabelColor:
                        Colors.orange, // Inactive tab text color
                    indicator: BoxDecoration(
                      borderRadius: BorderRadius.circular(
                          40), // Rounded corners for active tab
                      color: Colors.orange,

                      // Active tab background color
                    ),

                    tabs: _tabs.map((tab) {
                      return Tab(
                        child: Container(
                          width: 100,
                          height: 50,
                          padding: const EdgeInsets.only(left: 5, right: 5),
                          decoration: BoxDecoration(
                            border: Border.all(
                              color: Colors.orange, // Inactive tab border color
                            ),
                            borderRadius:
                                BorderRadius.circular(40), // Rounded corners
                            // Inactive tab background color
                          ),
                          child: Center(
                            child: Text(
                              tab, // Tab text
                              style: const TextStyle(fontSize: 14),
                            ),
                          ),
                        ),
                      );
                    }).toList(),
                  ),
                ),
                const SizedBox(height: 12),
                buildSectionmostview(mostView),
                todayDeals(TodayDeals),
                newHouses(context, newHouse)
              ],
            );
          }
        },
      ),
    );
  }

  Widget buildSection(Section section) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text(
            section.title, // Displaying the section name dynamically
            style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),
        ),
        SizedBox(
          height: 300,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: section.homes.length,
            itemBuilder: (context, index) {
              final home = section.homes[index];
              return Container(
                margin: const EdgeInsets.symmetric(horizontal: 8.0),
                width: 340,
                // Adjust as needed for the card width
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  image: DecorationImage(
                    image: AssetImage(home.image),

                    colorFilter: const ColorFilter.mode(
                      Color.fromARGB(101, 0, 0,
                          0), // Applies a semi-transparent overlay color
                      BlendMode.darken,
                    ), // Replace with AssetImage if local
                    fit: BoxFit
                        .cover, // Ensures the image covers the entire container
                  ),
                ),
                child: Stack(
                  children: [
                    // Overlay for gradient (optional, for better text visibility)
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
                    // Text Content
                    Positioned(
                      top: 10,
                      right: 10,
                      child: Container(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 8, vertical: 4),
                        decoration: BoxDecoration(
                          color: Colors.red,
                          borderRadius: BorderRadius.circular(4),
                        ),
                        child: const Text(
                          'Sponsored',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 12,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),

                    // Favorite button (Top-left)
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
                          isFavorite ? Icons.favorite : Icons.favorite_border,
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
                          Text(home.price,
                              style: const TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                              )),
                          const SizedBox(height: 4),
                          Text(home.type,
                              style: const TextStyle(
                                fontSize: 14,
                                color: Colors.white70,
                              )),
                          const SizedBox(height: 4),
                          Row(
                            children: [
                              const Icon(Icons.location_on,
                                  size: 14, color: Colors.white70),
                              const SizedBox(width: 6),
                              Text(home.location,
                                  style: const TextStyle(
                                      fontSize: 12, color: Colors.white70)),
                              const SizedBox(width: 16),
                              const Icon(Icons.bed,
                                  size: 14, color: Colors.white70),
                              const SizedBox(width: 3),
                              Text(home.type.substring(0, 10),
                                  style: const TextStyle(
                                      fontSize: 12, color: Colors.white70)),
                              const SizedBox(width: 16),
                              const Icon(Icons.square_foot,
                                  size: 14, color: Colors.white70),
                              const SizedBox(width: 3),
                              const Text("2900 Sqft",
                                  style: TextStyle(
                                      fontSize: 12, color: Colors.white70))
                            ],
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              );
            },
          ),
        ),
      ],
    );
  }

  Widget buildSectionmostview(Section section) {
    return Column(children: [
      Padding(
        padding: const EdgeInsets.all(8.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              section.title,
              style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            TextButton(
              onPressed: () {
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                    builder: (context) =>
                        const Market_place_connection(startIndex: 1),
                  ),
                );
              },
              child: const Text(
                "See all",
                style: TextStyle(color: Colors.blue),
              ),
            )
          ],
        ),
      ),
      const Align(
          alignment: Alignment.centerLeft,
          child: Padding(
            padding: EdgeInsets.only(left: 8),
            child: Text(
              "Explore the most viewed homes by our customers",
              textAlign: TextAlign.start,
              style: TextStyle(
                color: Colors.grey,
              ),
            ),
          )),
      Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            height: 250,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: section.homes.length,
              itemBuilder: (context, index) {
                final home = section.homes[index];
                return Container(
                  width: 300,
                  decoration: BoxDecoration(
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.1),
                        blurRadius: 8,
                        offset: const Offset(0, 4),
                      ),
                    ],
                  ),
                  margin: const EdgeInsets.all(8.0),
                  child: Card(
                    color: Colors.white,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10)),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Expanded(
                          child: ClipRRect(
                            borderRadius: const BorderRadius.vertical(
                                top: Radius.circular(10)),
                            child: Image.asset(home.image,
                                fit: BoxFit.cover, width: double.infinity),
                          ),
                        ),
                        Container(
                            color: Colors.white,

                            // ignore: avoid_unnecessary_containers
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(home.price,
                                      style: const TextStyle(
                                          fontSize: 16,
                                          fontWeight: FontWeight.bold)),
                                  const SizedBox(height: 4),
                                  Text(home.type,
                                      style: const TextStyle(
                                          fontSize: 14, color: Colors.grey)),
                                  const SizedBox(height: 4),
                                  Row(
                                    children: [
                                      const Icon(Icons.location_on,
                                          size: 14, color: Colors.grey),
                                      const SizedBox(width: 4),
                                      Text(home.location,
                                          style: const TextStyle(
                                              fontSize: 12,
                                              color: Colors.grey)),
                                      const SizedBox(width: 16),
                                      const Icon(Icons.bed,
                                          size: 14, color: Colors.grey),
                                      const SizedBox(width: 3),
                                      Text(
                                          home.type.length > 10
                                              ? home.type.substring(0, 10)
                                              : home.type,
                                          style: const TextStyle(
                                              fontSize: 12,
                                              color: Colors.grey)),
                                      const SizedBox(width: 16),
                                      const Icon(Icons.square_foot,
                                          size: 14, color: Colors.grey),
                                      const SizedBox(width: 3),
                                      const Text("2900 Sqft",
                                          style: TextStyle(
                                              fontSize: 12, color: Colors.grey))
                                    ],
                                  ),
                                  Align(
                                    alignment: Alignment.topRight,
                                    child: GestureDetector(
                                      onTap: () {
                                        // Handle the onTap function here
                                        Navigator.pushReplacement(
                                          context,
                                          MaterialPageRoute(
                                            builder: (context) =>
                                                const Market_place_connection(
                                                    startIndex: 4),
                                          ),
                                        );
                                      },
                                      child: Container(
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: 8, vertical: 4),
                                        decoration: BoxDecoration(
                                          color: Colors.blue,
                                          borderRadius:
                                              BorderRadius.circular(4),
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
                                  )
                                ],
                              ),
                            )),
                      ],
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      )
    ]);
  }

  Widget todayDeals(Section section) {
    return Column(children: [
      Padding(
        padding: const EdgeInsets.all(8.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              section.title,
              style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            TextButton(
              onPressed: () {
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                    builder: (context) =>
                        const Market_place_connection(startIndex: 2),
                  ),
                );
              },
              child: const Text(
                "See all",
                style: TextStyle(color: Colors.blue),
              ),
            )
          ],
        ),
      ),
      const Align(
          alignment: Alignment.centerLeft,
          child: Padding(
            padding: EdgeInsets.only(left: 8, bottom: 10),
            child: Text(
              "Get the best deals today and live in your dream house",
              textAlign: TextAlign.start,
              style: TextStyle(
                color: Colors.grey,
              ),
            ),
          )),
      Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            height: 300,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: section.homes.length,
              itemBuilder: (context, index) {
                final home = section.homes[index];
                return Container(
                  margin: const EdgeInsets.symmetric(horizontal: 8.0),
                  width: 340,
                  // Adjust as needed for the card width
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
                        Color.fromARGB(101, 0, 0,
                            0), // Applies a semi-transparent overlay color
                        BlendMode.darken,
                      ), // Replace with AssetImage if local
                      fit: BoxFit
                          .cover, // Ensures the image covers the entire container
                    ),
                  ),
                  child: Stack(
                    children: [
                      // Overlay for gradient (optional, for better text visibility)
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
                      // Text Content

                      Align(
                        alignment: Alignment.bottomRight,
                        child: GestureDetector(
                          onTap: () {
                            // Handle the onTap function here
                            Navigator.pushReplacement(
                              context,
                              MaterialPageRoute(
                                builder: (context) =>
                                    const Market_place_connection(
                                        startIndex: 4),
                              ),
                            );
                          },
                          child: Container(
                            margin: const EdgeInsets.all(5),
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
                      ),
                      // Favorite button (Top-left)
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
                            isFavorite ? Icons.favorite : Icons.favorite_border,
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
                            Text(home.price,
                                style: const TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white,
                                )),
                            const SizedBox(height: 4),
                            Text(home.type,
                                style: const TextStyle(
                                  fontSize: 14,
                                  color: Colors.white70,
                                )),
                            const SizedBox(height: 4),
                            Row(
                              children: [
                                const Icon(Icons.location_on,
                                    size: 14, color: Colors.white70),
                                const SizedBox(width: 6),
                                Text(home.location,
                                    style: const TextStyle(
                                        fontSize: 12, color: Colors.white70)),
                                const SizedBox(width: 16),
                                const Icon(Icons.bed,
                                    size: 14, color: Colors.white70),
                                const SizedBox(width: 3),
                                Text(
                                    home.type.length > 10
                                        ? home.type.substring(0, 10)
                                        : home.type,
                                    style: const TextStyle(
                                        fontSize: 12, color: Colors.white70)),
                                const SizedBox(width: 16),
                                const Icon(Icons.square_foot,
                                    size: 14, color: Colors.white70),
                                const SizedBox(width: 3),
                                const Text("2900 Sqft",
                                    style: TextStyle(
                                        fontSize: 12, color: Colors.white70))
                              ],
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                );
              },
            ),
          ),
        ],
      ),
    ]);
  }
}

Widget newHouses(BuildContext context, Section section) {
  return Column(children: [
    Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            section.title,
            style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
          TextButton(
            onPressed: () {
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                  builder: (context) =>
                      const Market_place_connection(startIndex: 3),
                ),
              );
            },
            child: const Text(
              "See all",
              style: TextStyle(color: Colors.blue),
            ),
          )
        ],
      ),
    ),
    const Align(
        alignment: Alignment.centerLeft,
        child: Padding(
          padding: EdgeInsets.only(left: 8),
          child: Text(
            "Choose a home from a trusted developer",
            textAlign: TextAlign.start,
            style: TextStyle(
              color: Colors.grey,
            ),
          ),
        )),
    Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(
          height: 250,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: section.homes.length,
            itemBuilder: (context, index) {
              final home = section.homes[index];
              return Container(
                width: 300,
                decoration: BoxDecoration(
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.1),
                      blurRadius: 8,
                      offset: const Offset(0, 4),
                    ),
                  ],
                ),
                margin: const EdgeInsets.all(8.0),
                child: Card(
                  color: Colors.white,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10)),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Expanded(
                        child: ClipRRect(
                          borderRadius: const BorderRadius.vertical(
                              top: Radius.circular(10)),
                          child: Image.asset(home.image,
                              fit: BoxFit.cover, width: double.infinity),
                        ),
                      ),
                      Container(
                          color: Colors.white,

                          // ignore: avoid_unnecessary_containers
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(home.price,
                                    style: const TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.bold)),
                                const SizedBox(height: 4),
                                Text(home.type,
                                    style: const TextStyle(
                                        fontSize: 14, color: Colors.grey)),
                                const SizedBox(height: 4),
                                Row(
                                  children: [
                                    const Icon(Icons.location_on,
                                        size: 14, color: Colors.grey),
                                    const SizedBox(width: 4),
                                    Text(home.location,
                                        style: const TextStyle(
                                            fontSize: 12, color: Colors.grey)),
                                    const SizedBox(width: 16),
                                    const Icon(Icons.bed,
                                        size: 14, color: Colors.grey),
                                    const SizedBox(width: 3),
                                    Text(
                                        home.type.length > 10
                                            ? home.type.substring(0, 10)
                                            : home.type,
                                        style: const TextStyle(
                                            fontSize: 12, color: Colors.grey)),
                                    const SizedBox(width: 16),
                                    const Icon(Icons.square_foot,
                                        size: 14, color: Colors.grey),
                                    const SizedBox(width: 3),
                                    const Text("2900 Sqft",
                                        style: TextStyle(
                                            fontSize: 12, color: Colors.grey))
                                  ],
                                ),
                                Align(
                                  alignment: Alignment.bottomRight,
                                  child: GestureDetector(
                                    onTap: () {
                                      // Handle the onTap function here
                                      Navigator.pushReplacement(
                                        context,
                                        MaterialPageRoute(
                                          builder: (context) =>
                                              const Market_place_connection(
                                                  startIndex: 4),
                                        ),
                                      );
                                    },
                                    child: Container(
                                      margin: const EdgeInsets.all(5),
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 8, vertical: 4),
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
                          )),
                    ],
                  ),
                ),
              );
            },
          ),
        ),
      ],
    )
  ]);
}
