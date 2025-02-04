import 'package:ag_mortgage/Dashboard_Screen/Market_Place/main.dart';
import 'package:ag_mortgage/const/colors.dart';
import 'package:flutter/material.dart';

class FavoritesPage extends StatelessWidget {
  const FavoritesPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // Example list of favorite items
    final List<Map<String, dynamic>> favorites = [
      {
        'image': 'assets/8.jpg',
        'price': 'NGN 65,000,000',
        'title': '2 Bedroom Semi-Detached Apartment',
        'location': 'Osapa',
      },
      {
        'image': 'assets/9.jpg',
        'price': 'NGN 96,000,000',
        'title': '3 Bedroom Semi-Detached Apartment',
        'location': 'Lekki',
      },
      {
        'image': 'assets/3.jpg',
        'price': 'NGN 80,000,000',
        'title': '2 Bedroom Semi-Detached Apartment',
        'location': 'Lekki',
      },
      {
        'image': 'assets/4.jpg',
        'price': 'NGN 100,000,000',
        'title': '2 Bedroom Semi-Detached Apartment',
        'location': 'Lekki Phase 1',
      },
      {
        'image': 'assets/1.jpg',
        'price': 'NGN 92,000,000',
        'title': '3 Bedroom Semi-Detached Apartment',
        'location': 'Lagos',
      },
    ];

    return Scaffold(
      appBar: AppBar(
        title: const Text('Favorites', style: TextStyle(color: Colors.purple)),
        backgroundColor: Colors.white,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () => Navigator.pop(context),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.delete, color: Colors.red),
            onPressed: () {
              // Handle delete all action
            },
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Est pellentesque fermentum cursus curabitur pharetra, vene',
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 12, color: Colors.grey),
            ),
            const SizedBox(height: 16),
            Expanded(
              child: GridView.builder(
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  crossAxisSpacing: 16,
                  mainAxisSpacing: 16,
                  childAspectRatio: 0.75,
                ),
                itemCount: favorites.length,
                itemBuilder: (context, index) {
                  final item = favorites[index];
                  return FavoriteCard(
                    image: item['image'],
                    price: item['price'],
                    title: item['title'],
                    location: item['location'],
                  );
                },
              ),
            ),
          ],
        ),
      ),
      
    );
  }
}

class FavoriteCard extends StatelessWidget {
  final String image;
  final String price;
  final String title;
  final String location;

  const FavoriteCard({
    Key? key,
    required this.image,
    required this.price,
    required this.title,
    required this.location,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Colors.white,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      elevation: 2,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Stack(
            children: [
              ClipRRect(
                borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(12),
                  topRight: Radius.circular(12),
                ),
                child: Image.asset(
                  image,
                  height: 100,
                  width: double.infinity,
                  fit: BoxFit.cover,
                ),
              ),
              Positioned(
                top: 8,
                left: 8,
                child: IconButton(
                  icon: const Icon(Icons.close, color: Colors.black),
                  onPressed: () {
                    // Handle remove from favorites
                  },
                ),
              ),
              Positioned(
                top: 8,
                right: 8,
                child: IconButton(
                  icon: const Icon(Icons.favorite, color: Colors.red),
                  onPressed: () {
                    // Handle toggle favorite
                  },
                ),
              ),
            ],
          ),
          Padding(
            padding: const EdgeInsets.all(4.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(price, style: const TextStyle(fontWeight: FontWeight.bold,fontSize: 12)),
                const SizedBox(height: 2),
                Text(title, style: const TextStyle(fontSize: 10)),
                const SizedBox(height: 2),
                
                Row(
                  children: [
                    const Icon(Icons.location_on, size: 10, color: Colors.grey),
                    const SizedBox(width: 4),
                    Text(location, style: const TextStyle(fontSize: 10, color: Colors.grey)),
                  ],
                ),
                const SizedBox(height: 0),
                Align(
                  alignment: Alignment.topRight,
child:  ElevatedButton(
                  
                    onPressed: () {
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                    builder: (context) =>
                        const MarketMain(startIndex: 4),
                  ),
                );
              
                  },
                  style: ElevatedButton.styleFrom(
                    minimumSize: const Size(40, 30),
                    backgroundColor: baseColor,
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(40)),
                  ),
                  child: const Text('View',style: TextStyle(color: Colors.white),),
                ),
                )
               
              ],
            ),
          ),
        ],
      ),
    );
  }
}
