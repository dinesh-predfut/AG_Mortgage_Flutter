// ignore_for_file: depend_on_referenced_packages

import 'package:ag_mortgage/Dashboard_Screen/Mortgage/MortgageHome.dart';
import 'package:ag_mortgage/const/Image.dart';
import 'package:ag_mortgage/const/colors.dart';
import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
// import 'package:google_maps_flutter/google_maps_flutter.dart';

class PropertyDetailsPage extends StatelessWidget {
  PropertyDetailsPage({super.key});
  final List<String> imageUrls = [
    'assets/1.jpg',
    'assets/2.jpg',
    'assets/3.jpg',
  ];

  num get rating => 4;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Property Details'),
        centerTitle: true,
         leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: SingleChildScrollView(
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
              items: imageUrls.map((url) {
                return Builder(
                  builder: (BuildContext context) {
                    return Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        image: DecorationImage(
                          image: AssetImage(url),
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
                       
                      const Text(
                        'NGN 40,000,000',
                        style: TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Row(
                        children: List.generate(5, (index) {
                          // Determine if the current index is less than the rating
                          if (index < rating) {
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
                          
                        },
                        
                        ),
                      ),
                    ],
                  ),
                  const Row(
                    children: [
                      Icon(Icons.location_on, size: 16),
                      SizedBox(width: 5),
                      Text('Lagos'),
                      SizedBox(width: 10),
                      Icon(Icons.apartment, size: 16),
                      SizedBox(width: 5),
                      Text('Studio'),
                      SizedBox(width: 10),
                      Icon(Icons.square_foot, size: 16),
                      SizedBox(width: 5),
                      Text('3,890 SqFt'),
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
                  const Text(
                    'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Leo mattis id diam nec laoreet aliquam...',
                    maxLines: 3,
                    overflow: TextOverflow.ellipsis,
                  ),
                  const SizedBox(height: 10),
                  GestureDetector(
                    onTap: () => showReadMorePopup(
                      context,
                      'About',
                      'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Leo mattis id diam nec laoreet aliquam. At lectus netus morbi ornare morbi volutpat. Volutpat, id vivamus gravida nullam et aliquam. Vitae et elit est rhoncus tempor ullamcorper nunc eu tempor. Dui interdum volutpat nunc augue phasellus feugiat.',
                      null
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
              content: amenitiesGrid(),
            ),

            // Location Section with Map
            sectionCard(
              title: 'Location',
              content: const Column(
                children: [
                  Text('No 4, Ogunlana Area, Lagos, Lagos State, Nigeria.'),
                  SizedBox(height: 10),
                  SizedBox(
                    height: 400,
                    // child: GoogleMap(
                    //   initialCameraPosition: CameraPosition(
                    //     target: LatLng(6.5244, 3.3792),
                    //     zoom: 14,
                    //   ),
                    // ),
                  ),
                ],
              ),
            ),

            // Developer Section
            sectionCard(
              title: 'Developer',
              content: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Center(
                      child: Image.asset(Images.logo,
                          fit: BoxFit.cover, width: 100)),
                  const SizedBox(height: 10),
                  const Text(
                    'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Leo mattis id diam nec laoreet aliquam...',
                    maxLines: 3,
                    overflow: TextOverflow.ellipsis,
                  ),
                  const SizedBox(height: 10),
                  GestureDetector(
                    onTap: () => showReadMorePopup(
                      context,
                      'Developer',
                      'Detailed developer information goes here. This can include information about the company, projects, history, etc.',
                      "assets/logo.jpg"
                      
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
                    items: ['Plan A', 'Plan B', 'Plan C']
                        .map((plan) => DropdownMenuItem(
                              value: plan,
                              child: Text(plan),
                            ))
                        .toList(),
                    onChanged: (value) {},
                    decoration: const InputDecoration(
                      labelText: 'Choose Plan',
                      border: OutlineInputBorder(),
                    ),
                  ),
                  const SizedBox(height: 20),
                  ElevatedButton(
                    onPressed: () {
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                    builder: (context) =>
                        const MortgagePage(startIndex: 1),
                  ),
                );
              },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: baseColor,

                      padding: const EdgeInsets.symmetric(vertical: 16),
                    ),
                    child: const Text('Proceed',style: TextStyle(color: Colors.white),),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget sectionCard({required String title, required Widget content}) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
      child: Card(
        color: Colors.white, // Set the desired background color here
        elevation: 8,
        shadowColor:
            Colors.black.withOpacity(0.3), // Customize the shadow color
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

  Widget amenitiesGrid() {
    final amenities = [
      {'icon': Icons.home, 'label': 'Area\n200,000 SqFt'},
      {'icon': Icons.bed, 'label': 'Rooms\n3 Bedrooms'},
      {'icon': Icons.pool, 'label': 'Pool\n1 Big Pool'},
      {'icon': Icons.park, 'label': 'Garden\n30,000 SqFt'},
      {'icon': Icons.car_rental, 'label': 'Parking\n3 Cars'},
    ];

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
            Icon(item['icon'] as IconData, size: 20),
            const SizedBox(height: 5),
            Text(
              item['label'] as String,
              textAlign: TextAlign.center,
              style: const TextStyle(fontSize: 12),
            ),
          ],
        );
      },
    );
  }
void showReadMorePopup(BuildContext context, String title, String content, String? image) {
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        title: Text(title),
        content: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              if (image != null) // Check if image is provided
                Image.asset(image, height: 50, width: 50),
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
