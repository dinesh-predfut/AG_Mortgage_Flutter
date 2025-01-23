import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:get/get.dart';
// import 'package:google_maps_flutter/google_maps_flutter.dart';

import '../../Mortgage/MortgageHome.dart';
import 'controller.dart'; // Replace with actual import
import 'models.dart'; // Replace with actual import
import '../../Mortgage/MortgagePage.dart'; // Replace with actual import
import '../../../const/colors.dart';
import '../../../const/Image.dart';

class PropertyDetailsPage extends StatefulWidget {
  final int? id;

  const PropertyDetailsPage({Key? key, required this.id}) : super(key: key);

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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Property ID: ${widget.id}"),
        centerTitle: true,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: FutureBuilder<Houseview>(
        future: fetchhouseViewedHouses,
        builder: (context, snapshot) {
          print('`maintance${snapshot}`');
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else if (snapshot.hasData) {
            final house = snapshot.data!;
            return SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Image Slider
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
                                fontSize: 24,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            Row(
                              children: List.generate(5, (index) {
                                if (index < house.rating) {
                                  return const Icon(
                                    Icons.star,
                                    color: Colors.orange,
                                  );
                                } else {
                                  return const Icon(
                                    Icons.star_border,
                                    color: Colors.orange,
                                  );
                                }
                              }),
                            ),
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

                  // Location Section with Map
                  sectionCard(
                    title: 'Location',
                    content: Column(
                      children: [
                        Text(house.street),
                        const SizedBox(height: 10),
                        const SizedBox(
                            // height: 400,
                            // Uncomment and configure this section for Google Map
                            // child: GoogleMap(
                            //   initialCameraPosition: CameraPosition(
                            //     target: LatLng(house.latitude, house.longitude),
                            //     zoom: 14,
                            //   ),
                            // ),
                            ),
                      ],
                    ),
                  ),
                  sectionCard(
                    title: 'Developer',
                    content: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Center(
                            child: Image.asset(Images.logo,
                                fit: BoxFit.cover, width: 100)),
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
                              'Develope',
                              house.contractorNameAndDescription,
                              "assets/logo.jpg"),
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
                              value: 'mortgage',
                              child: Text('Mortgage'),
                            ),
                            DropdownMenuItem(
                              value: 'rentToOwn',
                              child: Text('Rent-To-Own'),
                            ),
                          ],
                          onChanged: (value) {
                            setState(() {
                              _selectedPlan =
                                  value; // Update the selected value
                            });
                          },
                          decoration: const InputDecoration(
                            labelText: 'Choose Plan',
                            border: OutlineInputBorder(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(40))),
                          ),
                        ),
                        const SizedBox(height: 20),
                        ElevatedButton(
                          
                          onPressed: () {
                            Navigator.pushReplacement(
                              context,
                              MaterialPageRoute(
                                builder: (context) =>
                                    _selectedPlan == "mortgage"
                                        ?  MortgageFormPage(viewBtn:false,house: house)
                                        : const MortgagePage(startIndex: 1),
                              ),
                            );
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
          } else {
            return const Center(child: Text('No Data Available'));
          }
        },
      ),
    );
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

  Widget amenitiesGrid(List<dynamic> amenities) {
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
        return Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(item.icon, size: 20),
            const SizedBox(height: 5),
            Text(
              item.label,
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
