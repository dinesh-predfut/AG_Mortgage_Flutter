import 'package:ag_mortgage/Dashboard_Screen/Market_Place/Dashboard_Page/controller.dart';
import 'package:ag_mortgage/Dashboard_Screen/Market_Place/Dashboard_Page/model.dart';
import 'package:ag_mortgage/Dashboard_Screen/Market_Place/main.dart';
import 'package:ag_mortgage/const/colors.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

import '../../../const/commanFunction.dart';

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
  late Future<FavoriteHouseList> favoriteHouses;
  final _selectedColor = const Color(0xff1a73e8);
  final _unselectedColor = const Color(0xff5f6368);
  @override
  void initState() {
    super.initState();

    futureHouses = controller.fetchHouses();
    fetchnewtViewedHouses = controller.fetchnewtViewedHouses();
    fetchmostViewedHouses = controller.fetchmostViewedHouses();
    futureTodayDeals = controller.fetchTodayDeals();
    _tabController =
        TabController(length: controller.posts.length, vsync: this);
    controller.getFavoriteAll();
    fetchFavorites();
  }

  void fetchFavorites() async {
    try {
      List<FavoriteHouse> favoriteData = await controller.getFavoriteAll();
      print("Fetched Favorite Houses: $favoriteData");

      setState(() {
        controller.favoriteHouseIds =
            favoriteData.map((house) => house.id.toInt()).toList();
      });

      print("Updated favoriteHouseIds: ${controller.favoriteHouseIds}");
    } catch (e) {
      print("Error fetching favorite houses: $e");
    }
  }

  @override
  void dispose() {
    super.dispose();
    _tabController.dispose();
  }

  Future<void> fetchTabs() async {
    try {
      setState(() {
        _tabController =
            TabController(length: controller.posts.length, vsync: this);
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
              Navigator.pushNamed(context, "/favoritePage");
            },
            icon: const Icon(Icons.favorite_border),
          ),
          IconButton(
            onPressed: () {
              Navigator.pushNamed(context, "/marketMain/filter");
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
            future:
                futureHouses, // Replace with the API call for sponsored houses
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const Center(child: CircularProgressIndicator());
              } else if (snapshot.hasError) {
                return const Center(
                    child: Text('Error loading sponsored data'));
              } else if (snapshot.hasData && snapshot.data!.items.isNotEmpty) {
                return buildSection(
                    snapshot.data!.items); // Pass the sponsored items
              } else {
                return const Text(
                    "Data Not Available in Sponsoreds"); // Show nothing if no data
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
              tabs: [
                // Add "All" tab manually
                Tab(
                  child: Container(
                    width: 80,
                    height: 30,
                    padding: const EdgeInsets.symmetric(horizontal: 6),
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.orange),
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: const Center(
                      child: Text("All", style: TextStyle(fontSize: 14)),
                    ),
                  ),
                ),
                // Dynamically add posts from controller
                ...controller.posts.map((post) {
                  return Tab(
                    child: Container(
                      width: 80,
                      height: 30,
                      padding: const EdgeInsets.symmetric(horizontal: 6),
                      decoration: BoxDecoration(
                        border: Border.all(color: Colors.orange),
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Center(
                        child: Text(post.name.toString(),
                            style: const TextStyle(fontSize: 14)),
                      ),
                    ),
                  );
                }).toList(),
              ],
            ),
          ),

          const SizedBox(height: 12),

          // Most Viewed Section
          FutureBuilder<ApinewHoseview>(
            future:
                fetchnewtViewedHouses, // Replace with the API call for most viewed houses
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const Center(child: CircularProgressIndicator());
              } else if (snapshot.hasError) {
                return const Center(
                    child: Text('Error loading most viewed data'));
              } else if (snapshot.hasData && snapshot.data!.items.isNotEmpty) {
                return newHouses(context,
                    snapshot.data!.items); // Pass the most viewed items
              } else {
                return const Text("Data Not Available in New House");
              }
            },
          ),

          // const SizedBox(height: 12),

          // // Today's new hosu Section
          FutureBuilder<ApiResponsemostview>(
            future:
                fetchmostViewedHouses, // Replace with the API call for today's deal houses
            builder: (context, snapshot) {
              print('_someMethod: Foo Error ${snapshot} Error:{e.toString()}');
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const Center(child: CircularProgressIndicator());
              } else if (snapshot.hasError) {
                return const Center(
                    child: Text('Error loading today\'s deals'));
              } else if (snapshot.hasData && snapshot.data!.items.isNotEmpty) {
                return buildSectionmostview(
                    snapshot.data!.items, context); // Pass today's deal items
              } else {
                return const Text("Data Not Available in Most viewe");
              }
            },
          ),

          const SizedBox(height: 12),

          // New Houses Section
          FutureBuilder<ApiTodayDeals>(
            future:
                futureTodayDeals, // Replace with the API call for new houses
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const Center(child: CircularProgressIndicator());
              } else if (snapshot.hasError) {
                return const Center(child: Text('Error loading new houses'));
              } else if (snapshot.hasData && snapshot.data!.items.isNotEmpty) {
                return todayDeals(
                    snapshot.data!.items, context); // Pass new house items
              } else {
                return const Text("Data Not Available Today Deals");
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
            "Explore Properties", // Displaying section name statically or dynamically if available
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
                            horizontal: 15, vertical: 4),
                        decoration: BoxDecoration(
                          color: Colors.red,
                          borderRadius: BorderRadius.circular(30),
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
                          onTap: () => {
                                controller.toggleFavorite(home.id.toInt()),
                                fetchFavorites()
                              },
                          child: Icon(
                            controller.favoriteHouseIds
                                    .contains(home.id.toInt())
                                ? Icons.favorite
                                : Icons.favorite_border,
                            color: controller.favoriteHouseIds
                                    .contains(home.id.toInt())
                                ? Colors.red
                                : Colors.white,
                            size: 24,
                          )),
                    ),
                    Positioned(
                      bottom: 10,
                      right: 10,
                      child: GestureDetector(
                        onTap: () {
                          // Handle the onTap function here

                          Navigator.pushReplacementNamed(
                              context, '/marketMain/sponsered',
                              arguments: home.id);
                        },
                        child: Container(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 15, vertical: 4),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(10),
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
                    // Information Content (Price, Type, Location, etc.)
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          Text(
                            "NGN ${formattedEMI(home.price)}",
                            style: const TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                            ),
                          ),
                          const SizedBox(height: 4),
                          Text(
                            "${home.rooms} Bedroom Apartment ", // House type dynamically
                            style: const TextStyle(
                              fontSize: 12,
                              color: Colors.white70,
                            ),
                          ),
                          const SizedBox(height: 4),
                          Row(
                            children: [
                              const Icon(Icons.location_on,
                                  size: 15, color: Colors.white70),
                              const SizedBox(width: 6),
                              Text(
                                home.street ?? "Unknown City", // Dynamic city
                                style: const TextStyle(
                                    fontSize: 10, color: Colors.white70),
                              ),
                              const SizedBox(width: 10),
                              const Icon(Icons.bed,
                                  size: 15, color: Colors.white70),
                              const SizedBox(width: 3),
                              Text(
                                home.rooms?.toString() ??
                                    "0", // Rooms dynamically
                                style: const TextStyle(
                                    fontSize: 10, color: Colors.white70),
                              ),
                              const SizedBox(width: 10),
                              const Icon(Icons.square_foot,
                                  size: 15, color: Colors.white70),
                              const SizedBox(width: 3),
                              Text(
                                "${home.street ?? '0'} Sqft", // Area dynamically
                                style: const TextStyle(
                                    fontSize: 10, color: Colors.white70),
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

  Widget buildSectionmostview(List<dynamic> section, BuildContext context) {
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
                Navigator.pushNamed(context, "/seemoremostview");
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
        ),
      ),
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
                    ? home.housePictures[0] // Taking the first image
                    : '';

                return Container(
                  width: 300,
                  margin: const EdgeInsets.all(8.0),
                  decoration: BoxDecoration(
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.1),
                        blurRadius: 8,
                        offset: const Offset(0, 4),
                      ),
                    ],
                  ),
                  child: Stack(
                    children: [
                      Card(
                        color: Colors.white,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Expanded(
                              child: ClipRRect(
                                borderRadius: const BorderRadius.vertical(
                                  top: Radius.circular(10),
                                ),
                                child: Image.network(
                                  imageUrl,
                                  fit: BoxFit.cover,
                                  width: double.infinity,
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
                                    Text("NGN ${formattedEMI(home.price)}",
                                        style: const TextStyle(
                                            fontSize: 16,
                                            fontWeight: FontWeight.bold)),
                                    const SizedBox(height: 4),
                                    Text("${home.rooms} Bedroom Apartment ",
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
                                                ? home.houseType
                                                    .substring(0, 10)
                                                : home.houseType,
                                            style: const TextStyle(
                                                fontSize: 10,
                                                color: Colors.grey)),
                                        const SizedBox(width: 12),
                                        const Icon(Icons.square_foot,
                                            size: 12, color: Colors.grey),
                                        const SizedBox(width: 3),
                                        Text(home.totalArea,
                                            style: const TextStyle(
                                                fontSize: 12,
                                                color: Colors.grey))
                                      ],
                                    ),
                                    Align(
                                      alignment: Alignment.topRight,
                                      child: GestureDetector(
                                        onTap: () {
                                          Navigator.pushReplacementNamed(
                                              context, '/marketMain/sponsered',
                                              arguments: home.id);
                                        },
                                        child: Container(
                                          padding: const EdgeInsets.symmetric(
                                              horizontal: 15, vertical: 4),
                                          decoration: BoxDecoration(
                                            color: baseColor,
                                            borderRadius:
                                                BorderRadius.circular(14),
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
                              ),
                            ),
                          ],
                        ),
                      ),

                      // Positioned Favorite Button
                      Positioned(
                        top: 10,
                        left: 10,
                        child: GestureDetector(
                          onTap: () {
                            controller.toggleFavorite(home.id.toInt());
                            fetchFavorites();
                          },
                          child: Icon(
                            controller.favoriteHouseIds
                                    .contains(home.id.toInt())
                                ? Icons.favorite
                                : Icons.favorite_border,
                            color: controller.favoriteHouseIds
                                    .contains(home.id.toInt())
                                ? Colors.red
                                : Colors.white,
                            size: 24,
                          ),
                        ),
                      ),
                    ],
                  ),
                );
              },
            ),
          ),
        ],
      )
    ]);
  }

  Widget todayDeals(List<dynamic> section, BuildContext context) {
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
                Navigator.pushNamed(context, "/seemoretodaydeals");
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
                final imageUrl =
                    home.housePictures.isNotEmpty ? home.housePictures[0] : '';
                return Container(
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
                        top: 10,
                        left: 10,
                        child: GestureDetector(
                          onTap: () {
                            controller.toggleFavorite(home.id.toInt());
                            fetchFavorites();
                          },
                          child: Icon(
                            controller.favoriteHouseIds
                                    .contains(home.id.toInt())
                                ? Icons.favorite
                                : Icons.favorite_border,
                            color: controller.favoriteHouseIds
                                    .contains(home.id.toInt())
                                ? Colors.red
                                : Colors.white,
                            size: 24,
                          ),
                        ),
                      ),
                      Align(
                        alignment: Alignment.bottomRight,
                        child: GestureDetector(
                          onTap: () {
                            Navigator.pushReplacementNamed(
                                context, '/marketMain/sponsered',
                                arguments: home.id);
                          },
                          child: Container(
                            margin: const EdgeInsets.all(5),
                            padding: const EdgeInsets.symmetric(
                                horizontal: 15, vertical: 4),
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
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                          Text("NGN ${formattedEMI(home.price)}",
                                style: const TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white,
                                )),
                            const SizedBox(height: 4),
                            Text("${home.rooms} Bedroom Apartment ",
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
                                        fontSize: 10, color: Colors.grey)),
                                const SizedBox(width: 16),
                                const Icon(Icons.square_foot,
                                    size: 12, color: Colors.white70),
                                const SizedBox(width: 3),
                                Text(home.totalArea,
                                    style: const TextStyle(
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
                Navigator.pushNamed(context, "/seemorenewhouse");
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
      SizedBox(
        height: 300,
        child: ListView.builder(
          scrollDirection: Axis.horizontal,
          itemCount: section.length,
          itemBuilder: (context, index) {
            final home = section[index];
            final imageUrl = home.housePictures.isNotEmpty
                ? home.housePictures[0] // Taking the first image
                : '';

            return Container(
              width: 300,
              margin: const EdgeInsets.all(8.0),
              decoration: BoxDecoration(
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.1),
                    blurRadius: 8,
                    offset: const Offset(0, 4),
                  ),
                ],
              ),
              child: Card(
                color: Colors.white,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10)),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Stack(
                      children: [
                        Container(
                          width: 340,
                          height: 160,
                          decoration: BoxDecoration(
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
                        // Favorite (Like) Button Positioned on Top-Left
                        Positioned(
                          top: 10,
                          left: 10,
                          child: GestureDetector(
                            onTap: () {
                              controller.toggleFavorite(home.id.toInt());
                              fetchFavorites();
                            },
                            child: Icon(
                              controller.favoriteHouseIds
                                      .contains(home.id.toInt())
                                  ? Icons.favorite
                                  : Icons.favorite_border,
                              color: controller.favoriteHouseIds
                                      .contains(home.id.toInt())
                                  ? Colors.red
                                  : Colors.white,
                              size: 24,
                            ),
                          ),
                        ),
                      ],
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text("NGN ${formattedEMI(home.price)}",
                              style: const TextStyle(
                                  fontSize: 16, fontWeight: FontWeight.bold)),
                          const SizedBox(height: 4),
                          Text(home.rooms,
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
                                      fontSize: 10, color: Colors.grey)),
                            ],
                          ),
                          Align(
                            alignment: Alignment.bottomRight,
                            child: GestureDetector(
                              onTap: () {
                                Navigator.pushReplacementNamed(
                                  context,
                                  '/marketMain/sponsered',
                                  arguments: home.id,
                                );
                              },
                              child: Container(
                                margin: const EdgeInsets.all(5),
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 15, vertical: 4),
                                decoration: BoxDecoration(
                                  color: baseColor,
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
          },
        ),
      ),
    ]);
  }
}
