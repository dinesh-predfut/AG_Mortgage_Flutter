import 'package:ag_mortgage/Dashboard_Screen/Market_Place/Dashboard_Page/controller.dart';
import 'package:ag_mortgage/Dashboard_Screen/Market_Place/Dashboard_Page/model.dart';
import 'package:ag_mortgage/Dashboard_Screen/Market_Place/main.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

class MarketplacePage extends StatefulWidget {
  const MarketplacePage({super.key});

  @override
  _MarketplacePageState createState() => _MarketplacePageState();
}

class _MarketplacePageState extends State<MarketplacePage>
    with SingleTickerProviderStateMixin {
  final controller = Get.put(Market_Place_controller());

  late Future<ApinewHoseview> fetchnewtViewedHouses;
  late Future<ApiResponsemostview> fetchmostViewedHouses;
  late Future<ApiResponse> futureHouses;
  late Future<ApiTodayDeals> futureTodayDeals;
  bool isFavorite = false;
  late TabController _tabController;
  final _selectedColor = const Color(0xff1a73e8);
  final _unselectedColor = const Color(0xff5f6368);
  @override
  void initState() {
    super.initState();
    futureHouses = controller.fetchHouses();
      fetchnewtViewedHouses = controller.fetchnewtViewedHouses();
      fetchmostViewedHouses=controller.fetchmostViewedHouses();
      futureTodayDeals=controller.fetchTodayDeals();
    _tabController = TabController(length: 12, vsync: this);
    _tabs;
  }

  @override
  void dispose() {
    super.dispose();
    _tabController.dispose();
  }

  List<String> _tabs = [
    "All",
    "Lagos",
    "Ogun",
    "Anambra",
    "Abuja",
    "oyo",
    "Kaduna",
    "Kano"
  ];

  Future<void> fetchTabs() async {
    try {
      List<String> tabs = await controller.tabFetch();
      setState(() {
        _tabs = tabs;
        _tabController = TabController(length: _tabs.length, vsync: this);
        // _isLoading = false;
      });
    } catch (e) {
      setState(() {
        // _isLoading = false;
      });
      print(e.toString());
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Marketplace', style: TextStyle(color: Colors.black)),
        backgroundColor: Colors.white,
        iconTheme: const IconThemeData(color: Colors.black),
        actions: [
          IconButton(
            onPressed: () {
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                  builder: (context) =>
                      const MarketMain(startIndex: 6),
                ),
              );
            },
            icon: const Icon(Icons.favorite_border),
          ),
          IconButton(
            onPressed: () {
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                  builder: (context) =>
                      const MarketMain(startIndex: 4),
                ),  
              );
            },
            icon: const Icon(Icons.tune),
          ),
        ],
      ),
    body: ListView(
  children: [
    const SizedBox(height: 12),

    // Sponsored Section
    FutureBuilder<ApiResponse>(
      future: futureHouses, // Replace with the API call for sponsored houses
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        } else if (snapshot.hasError) {
          return const Center(child: Text('Error loading sponsored data'));
        } else if (snapshot.hasData && snapshot.data!.items.isNotEmpty) {
          return buildSection(snapshot.data!.items); // Pass the sponsored items
        } else {
          return const SizedBox(); // Show nothing if no data
        }
      },
    ),

    const SizedBox(height: 12),

    // TabBar for Most Viewed, Today's Deal, and New House
    Align(
      alignment: Alignment.centerLeft,
      child: TabBar(
        controller: _tabController,
        isScrollable: true,
        labelColor: Colors.white,
        dividerHeight: 0,
        unselectedLabelColor: Colors.orange,
        indicator: BoxDecoration(
          borderRadius: BorderRadius.circular(40),
          color: Colors.orange,
        ),
        tabs: _tabs.map((tab) {
          return Tab(
            child: Container(
              width: 60,
              height: 30,
              padding: const EdgeInsets.symmetric(horizontal: 6),
              decoration: BoxDecoration(
                border: Border.all(color: Colors.orange),
                borderRadius: BorderRadius.circular(20),
              ),
              child: Center(
                child: Text(tab, style: const TextStyle(fontSize: 14)),
              ),
            ),
          );
        }).toList(),
      ),
    ),

    const SizedBox(height: 12),

    // Most Viewed Section
    FutureBuilder<ApinewHoseview>(
      future: fetchnewtViewedHouses, // Replace with the API call for most viewed houses
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        } else if (snapshot.hasError) {
          return const Center(child: Text('Error loading most viewed data'));
        } else if (snapshot.hasData && snapshot.data!.items.isNotEmpty ) {
          return newHouses(context,snapshot.data!.items); // Pass the most viewed items
        } else {
          return const SizedBox(); // Show nothing if no data
        }
      },
    ),

    // const SizedBox(height: 12),

    // // Today's new hosu Section
    FutureBuilder<ApiResponsemostview>(
      future: fetchmostViewedHouses, // Replace with the API call for today's deal houses
      builder: (context, snapshot) {
         print('_someMethod: Foo Error ${snapshot} Error:{e.toString()}');
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        } else if (snapshot.hasError) {
          return const Center(child: Text('Error loading today\'s deals'));
        } else if (snapshot.hasData && snapshot.data!.items.isNotEmpty) {
          return buildSectionmostview (snapshot.data!.items); // Pass today's deal items
        } else {
          return const SizedBox(); // Show nothing if no data
        }
      },
    ),

    const SizedBox(height: 12),

    // New Houses Section
    FutureBuilder<ApiTodayDeals>(
      future: futureTodayDeals, // Replace with the API call for new houses
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        } else if (snapshot.hasError) {
          return const Center(child: Text('Error loading new houses'));
        } else if (snapshot.hasData && snapshot.data!.items.isNotEmpty) {
          return todayDeals( snapshot.data!.items); // Pass new house items
        } else {
          return const SizedBox(); // Show nothing if no data
        }
      },
    ),
  ],
),

    );
  }

  Widget buildSection(List<dynamic> section) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Padding(
          padding: EdgeInsets.all(8.0),
          child: Text(
            "Sponsoreds", // Displaying section name statically or dynamically if available
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),
        ),
        SizedBox(
          height: 300,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: section.length,
            itemBuilder: (context, index) {
              final home = section[index]; // Each house in the section
              final imageUrl = home.housePictures.isNotEmpty
                  ? home.housePictures[
                      0] // Assuming we take the first image for now
                  : ''; // Default image URL if not available

                return Container(
                margin: const EdgeInsets.symmetric(horizontal: 8.0),
                width: 340,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  image: DecorationImage(
                    image: NetworkImage(
                        imageUrl), // Use NetworkImage for network URLs
                    colorFilter: const ColorFilter.mode(
                      Color.fromARGB(101, 0, 0, 0),
                      BlendMode.darken,
                    ),
                    fit: BoxFit.cover,
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
                    // Text Content (Sponsored Badge)
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
                    // Favorite Button (Top-left)
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
                    // Information Content (Price, Type, Location, etc.)
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          Text(
                            home.price.toString(),
                            style: const TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                            ),
                          ),
                          const SizedBox(height: 4),
                          Text(
                            home.houseType ??
                                "Unknown Type", // House type dynamically
                            style: const TextStyle(
                              fontSize: 12,
                              color: Colors.white70,
                            ),
                          ),
                          const SizedBox(height: 4),
                          Row(
                            children: [
                              const Icon(Icons.location_on,
                                  size: 10, color: Colors.white70),
                              const SizedBox(width: 6),
                              Text(
                                home.street ?? "Unknown City", // Dynamic city
                                style: const TextStyle(
                                    fontSize: 8, color: Colors.white70),
                              ),
                              const SizedBox(width: 10),
                              const Icon(Icons.bed,
                                  size: 10, color: Colors.white70),
                              const SizedBox(width: 3),
                              Text(
                                home.rooms?.toString() ??
                                    "0", // Rooms dynamically
                                style: const TextStyle(
                                    fontSize: 8, color: Colors.white70),
                              ),
                              const SizedBox(width: 10),
                              const Icon(Icons.square_foot,
                                  size: 10, color: Colors.white70),
                              const SizedBox(width: 3),
                              Text(
                                "${home.street ?? '0'} Sqft", // Area dynamically
                                style: const TextStyle(
                                    fontSize: 8, color: Colors.white70),
                              ),
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

  Widget buildSectionmostview(List<dynamic> section) {
    return Column(children: [
      Padding(
        padding: const EdgeInsets.all(8.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Text(
              "Most View",
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            TextButton(
              onPressed: () {
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                    builder: (context) =>
                        const MarketMain(startIndex: 1),
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
              itemCount: section.length,
              itemBuilder: (context, index) {
                final home = section[index];
               final imageUrl = home.housePictures.isNotEmpty
                  ? home.housePictures[
                      0] // Assuming we take the first image for now
                  : ''; 
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
                            child:Image(image: NetworkImage(imageUrl),
                                fit: BoxFit.cover, width: double.infinity,) 
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
                                  Text( home.price.toString() ,
                                      style: const TextStyle(
                                          fontSize: 16,
                                          fontWeight: FontWeight.bold)),
                                  const SizedBox(height: 4),
                                  Text(home.houseType,
                                      style: const TextStyle(
                                          fontSize: 12, color: Colors.grey)),
                                  const SizedBox(height: 4),
                                  Row(
                                    children: [
                                      const Icon(Icons.location_on,
                                          size: 12, color: Colors.grey),
                                      const SizedBox(width: 4),
                                      Text(home.street as String,
                                          style: const TextStyle(
                                              fontSize: 10,
                                              color: Colors.grey)),
                                      const SizedBox(width: 12),
                                      const Icon(Icons.bed,
                                          size: 12, color: Colors.grey),
                                      const SizedBox(width: 3),
                                      Text(
                                          home.houseType.length > 10
                                              ? home.houseType.substring(0, 10)
                                              : home.houseType,
                                          style: const TextStyle(
                                              fontSize: 10,
                                              color: Colors.grey)),
                                      const SizedBox(width: 12),
                                      const Icon(Icons.square_foot,
                                          size: 12, color: Colors.grey),
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
                                                const MarketMain(
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

  Widget todayDeals(List<dynamic> section) {
    return Column(children: [
      Padding(
        padding: const EdgeInsets.all(8.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Text(
              "Today Deals",
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),  
            TextButton(
              onPressed: () {
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                    builder: (context) =>
                        const MarketMain(startIndex: 2),
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
              itemCount: section.length,
              itemBuilder: (context, index) {
                final home = section[index];
                final imageUrl = home.housePictures.isNotEmpty
                  ? home.housePictures[
                      0] // Assuming we take the first image for now
                  : ''; 
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
                      image: NetworkImage(imageUrl),

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
                                    const MarketMain(
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
                            Text(home.price.toString(),
                                style: const TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white,
                                )),
                            const SizedBox(height: 4),
                            Text(home.houseType,
                                style: const TextStyle(
                                  fontSize: 12,
                                  color: Colors.white70,
                                )),
                            const SizedBox(height: 4),
                            Row(
                              children: [
                                const Icon(Icons.location_on,
                                    size: 12, color: Colors.white70),
                                const SizedBox(width: 6),
                                Text(home.street as String,
                                    style: const TextStyle(
                                        fontSize: 12, color: Colors.white70)),
                                const SizedBox(width: 16),
                                const Icon(Icons.bed,
                                    size: 12, color: Colors.white70),
                                const SizedBox(width: 3),
                                Text(
                               home.houseType.length > 10
                                              ? home.houseType.substring(0, 10)
                                              : home.houseType,
                                          style: const TextStyle(
                                              fontSize: 10,
                                              color: Colors.grey)),
                                const SizedBox(width: 16),
                                const Icon(Icons.square_foot,
                                    size: 12, color: Colors.white70),
                                const SizedBox(width: 3),
                                const Text("2312",
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
Widget newHouses(BuildContext context, List<dynamic> section) {
  return Column(children: [
    Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          const Text(
            "New House",
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
          TextButton(
            onPressed: () {
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                  builder: (context) =>
                      const MarketMain(startIndex: 3),
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
            itemCount: section.length,
            itemBuilder: (context, index) {
              final home = section[index];
              final imageUrl = home.housePictures.isNotEmpty
                  ? home.housePictures[
                      0] // Assuming we take the first image for now
                  : '';
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
                        child: Container(
                          margin: const EdgeInsets.symmetric(horizontal: 8.0),
                          width: 340,
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
                              image: NetworkImage(imageUrl),
                              colorFilter: const ColorFilter.mode(
                                Color.fromARGB(101, 0, 0, 0),
                                BlendMode.darken,
                              ),
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                      ),
                      Container(
                          color: Colors.white,
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(home.price.toString(),
                                    style: const TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.bold)),
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
                                Align(
                                  alignment: Alignment.bottomRight,
                                  child: GestureDetector(
                                    onTap: () {
                                      Navigator.pushReplacement(
                                        context,
                                        MaterialPageRoute(
                                          builder: (context) =>
                                              MarketMain(
                                                  startIndex: 3,
                                                  id: home.id),
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

