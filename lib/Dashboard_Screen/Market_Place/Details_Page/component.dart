import 'package:ag_mortgage/Dashboard_Screen/Market_Place/main.dart';
import 'package:ag_mortgage/Dashboard_Screen/Rent-To-own/rent_To_Own.dart';
import 'package:ag_mortgage/main.dart';
import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
// import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';
import '../../../const/mapPage.dart';
import '../../Mortgage/MortgageHome.dart';
import 'controller.dart';
import 'models.dart';
import '../../Mortgage/MortgagePage.dart';
import '../../../const/colors.dart';
import '../../../const/Image.dart';

class PropertyDetailsPage extends StatefulWidget {
  final int? id;

  const PropertyDetailsPage({super.key, required this.id});

  @override
  _PropertyDetailsPageState createState() => _PropertyDetailsPageState();
}

class _PropertyDetailsPageState extends State<PropertyDetailsPage> {
  String? _selectedPlan;
  final controller = Get.put(House_view_controller());
  late Future<Houseview> fetchhouseViewedHouses;

  @override
  void initState() {
    super.initState();
    fetchhouseViewedHouses = controller.fetchMostviewList(widget.id);
  }

  void _onBackPressed(BuildContext context) {
    // Custom logic for back navigation
    if (Navigator.of(context).canPop()) {
      print("its working");
      Navigator.pushNamed(context, "/marketMain");
    } else {
      // Show exit confirmation dialog if needed
      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: const Text("Exit App"),
          content: const Text("Do you want to exit the app?"),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: const Text("No"),
            ),
            TextButton(
              onPressed: () => Navigator.of(context).pop(true),
              child: const Text("Yes"),
            ),
          ],
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
        onWillPop: () async {
          // Handle custom back navigation logic
          _onBackPressed(context);
          return false; // Prevent default back behavior
        },
        child: Scaffold(
          appBar: AppBar(
            title: const Text("Property Details"),
            centerTitle: true,
            leading: IconButton(
              icon: const Icon(Icons.arrow_back, color: Colors.black),
              onPressed: () =>  Navigator.pop(context)
            ),
          ),
          body: FutureBuilder<Houseview>(
            future: fetchhouseViewedHouses,
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const Center(child: CircularProgressIndicator());
              } else if (snapshot.hasError) {
                return Center(child: Text('Error: ${snapshot.error}'));
              } else if (!snapshot.hasData || snapshot.data == null) {
                return const Center(child: Text('No Data Available'));
              }

              final house = snapshot.data!;

              return SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Image Slider
                    if (house.housePictures.isNotEmpty)
                      CarouselSlider(
                        options: CarouselOptions(
                          height: 250.0,
                          autoPlay: true,
                          enlargeCenterPage: true,
                        ),
                        items: house.housePictures.map((url) {
                          return Builder(
                            builder: (BuildContext context) {
                              return Container(
                                margin:
                                    const EdgeInsets.symmetric(horizontal: 5.0),
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10),
                                  image: DecorationImage(
                                    image: NetworkImage(url),
                                    fit: BoxFit.cover,
                                  ),
                                ),
                              );
                            },
                          );
                        }).toList(),
                      ),

                    // Price and Details
                    Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                'NGN ${house.price}',
                                style: const TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              Column(
                                children: [
                                  Row(
                                    children: List.generate(5, (index) {
                                      return Icon(
                                        index < house.rating
                                            ? Icons.star
                                            : Icons.star_border,
                                        color: Colors.orange,
                                      );
                                    }),
                                  ),
                                  GestureDetector(
                                    onTap: () {
                                      showDialog(
                                        context: context,
                                        builder: (BuildContext context) =>
                                            ReviewPopup(),
                                      );
                                    },
                                    child: Container(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 15, vertical: 4),
                                      decoration: BoxDecoration(
                                        color: baseColor,
                                        borderRadius: BorderRadius.circular(10),
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
                                  )
                                ],
                              )
                            ],
                          ),
                          Row(
                            children: [
                              const Icon(Icons.location_on, size: 16),
                              const SizedBox(width: 5),
                              Text(house.street),
                              const SizedBox(width: 10),
                              const Icon(Icons.apartment, size: 16),
                              const SizedBox(width: 5),
                              Text(house.houseType),
                              const SizedBox(width: 10),
                              const Icon(Icons.square_foot, size: 16),
                              const SizedBox(width: 5),
                              Text('${house.totalArea} SqFt'),
                            ],
                          ),
                        ],
                      ),
                    ),

                    // About Section
                    sectionCard(
                      title: 'About',
                      content: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            house.houseDescription,
                            maxLines: 3,
                            overflow: TextOverflow.ellipsis,
                          ),
                          const SizedBox(height: 10),
                          GestureDetector(
                            onTap: () => showReadMorePopup(
                              context,
                              'About',
                              house.houseDescription,
                              null,
                            ),
                            child: const Align(
                              alignment: Alignment.centerRight,
                              child: Text(
                                'Read More',
                                style: TextStyle(
                                  color: Colors.blue,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),

                    // Amenities Section
                    sectionCard(
                      title: 'Amenities',
                      content: amenitiesGrid(house.houseAmenities),
                    ),
                    sectionCard(
                      title: 'Location',
                      content: HouseLocationMap(
                        latitude: house.latitude,
                        longitude: house.longitude,
                      ),
                    ),

                    // Developer Section
                    sectionCard(
                      title: 'Developer',
                      content: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Center(
                            child: Image.asset(Images.developerLogo,
                                fit: BoxFit.cover, width: 100),
                          ),
                          const SizedBox(height: 10),
                          Text(
                            house.contractorNameAndDescription,
                            maxLines: 3,
                            overflow: TextOverflow.ellipsis,
                          ),
                          const SizedBox(height: 10),
                          GestureDetector(
                            onTap: () => showReadMorePopup(
                              context,
                              'Developer',
                              house.contractorNameAndDescription,
                              Images.developerLogo,
                            ),
                            child: const Align(
                              alignment: Alignment.centerRight,
                              child: Text(
                                'Read More',
                                style: TextStyle(
                                  color: Colors.blue,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),

                    // Plan Selector and Proceed Button
                    Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          DropdownButtonFormField<String>(
                            value: _selectedPlan,
                            items: const [
                              DropdownMenuItem(
                                  value: 'mortgage', child: Text('Mortgage')),
                              DropdownMenuItem(
                                  value: 'rentToOwn',
                                  child: Text('Rent-To-Own')),
                            ],
                            onChanged: (value) {
                              setState(() {
                                _selectedPlan = value;
                              });
                            },
                            decoration: const InputDecoration(
                              labelText: 'Choose Plan',
                              border: OutlineInputBorder(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(40)),
                              ),
                            ),
                          ),
                          const SizedBox(height: 20),
                          ElevatedButton(
                            onPressed: _selectedPlan == null
                                ? null
                                : () {
                                    Navigator.pushReplacement(context,
                                        MaterialPageRoute(
                                      builder: (context) {
                                        if (_selectedPlan == "mortgage") {
                                          print("house${house.houseNumber}");
                                          return TermsAndConditionsDialog(
                                              viewBtn: false, house: house);
                                        } else if (_selectedPlan ==
                                            "rentToOwn") {
                                          return TermsAndConditionsDialogRentown(
                                              house: house,
                                              viewBtn:
                                                  false); // Ensure RentToOwnPage exists
                                        } else {
                                          return const MortgagePageHome(
                                              startIndex: 1); // Default case
                                        }
                                      },
                                    ));
                                  },
                            style: ElevatedButton.styleFrom(
                              backgroundColor: baseColor,
                              padding: const EdgeInsets.symmetric(vertical: 16),
                            ),
                            child: const Text(
                              'Proceed',
                              style: TextStyle(color: Colors.white),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              );
            },
          ),
        ));
  }

  Widget sectionCard({required String title, required Widget content}) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
      child: Card(
        elevation: 8,
        shadowColor: Colors.black.withOpacity(0.3),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 10),
              content,
            ],
          ),
        ),
      ),
    );
  }

  Widget amenitiesGrid(List<String> amenities) {
    // Define a map of amenities to icons
    final Map<String, IconData> amenitiesIcons = {
      "garden": Icons.park,
      "Swimming Pool": Icons.pool,
      "gym": Icons.fitness_center,
      "Parking": Icons.local_parking,
      "WiFi": Icons.wifi,
      "Restaurant": Icons.restaurant,
      "Spa": Icons.spa,
      "Bar": Icons.local_bar,
      "TV": Icons.tv,
      "Air Conditioning": Icons.ac_unit,
      "Laundry": Icons.local_laundry_service,
      "backYard": Icons.grass_outlined,
      "totalArea": Icons.square_foot,
      "Area": Icons.map,
    };

    return GridView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: amenities.length,
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 3,
        mainAxisSpacing: 10,
        crossAxisSpacing: 10,
        childAspectRatio: 1.5,
      ),
      itemBuilder: (context, index) {
        final item = amenities[index];
        final icon =
            amenitiesIcons[item] ?? Icons.check; // Default icon if not found

        return Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(icon, size: 40, color: Colors.blue), // Show mapped icon
            const SizedBox(height: 5),
            Text(
              item, // Display the amenity name
              textAlign: TextAlign.center,
              style: const TextStyle(fontSize: 12),
            ),
          ],
        );
      },
    );
  }

  void showReadMorePopup(
    BuildContext context,
    String title,
    String content,
    String? image,
  ) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(title),
          content: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                if (image != null) Image.asset(image, height: 50, width: 50),
                Text(content),
              ],
            ),
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text('Close'),
            ),
          ],
        );
      },
    );
  }
}

class ReviewPopup extends StatefulWidget {
  @override
  _ReviewPopupState createState() => _ReviewPopupState();
}

class _ReviewPopupState extends State<ReviewPopup> {
  int _rating = 0; // Initial value of the rating

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20),
      ),
      child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Align(
                alignment: Alignment.topRight,
                child: IconButton(
                  icon: const Icon(Icons.close, color: Colors.black),
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                ),
              ),
              const Text(
                'Rate the Apartment',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: List.generate(5, (index) {
                  return IconButton(
                    onPressed: () {
                      setState(() {
                        _rating = index + 1;
                      });
                    },
                    icon: Icon(
                      index < _rating ? Icons.star : Icons.star_border,
                      size: 30,
                      color: index < _rating ? Colors.amber : Colors.grey,
                    ),
                  );
                }),
              ),
              const SizedBox(height: 10),
              const Text(
                'Your feedback is well appreciated',
                style: TextStyle(color: Colors.grey),
              ),
              const SizedBox(height: 20),
              TextField(
                maxLines: 4,
                decoration: InputDecoration(
                  hintText: 'Drop a comment',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  primary: const Color(0xFF1D0E77),
                  padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 15),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                onPressed: () {
                  // You can handle form submission here
                  Navigator.of(context).pop();
                },
                child: const Text(
                  'Submit Review',
                  style: TextStyle(color: Colors.white),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}