import 'package:ag_mortgage/NotificationScreen/model.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'dart:convert';

class NotificationsPage extends StatelessWidget {
  const NotificationsPage({Key? key}) : super(key: key);

  // Load and parse the JSON file
  Future<List<NotificationSectionModel>> loadSections() async {
    String jsonString = await rootBundle.loadString('assets/notification.json');
    final jsonData = json.decode(jsonString) as List<dynamic>;
    return jsonData
        .map((section) => NotificationSectionModel.fromJson(section as Map<String, dynamic>))
        .toList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Notifications'),
        centerTitle: true,
        actions: [
          IconButton(
            icon: const Icon(Icons.delete_forever_outlined, color: Colors.red),
            onPressed: () {
              // Add logic to delete all notifications
            },
          ),
        ],
      ),
      body: FutureBuilder<List<NotificationSectionModel>>(
        future: loadSections(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return const Center(child: Text('No notifications'));
          }

          final notifications = snapshot.data!;
          return ListView.builder(
            itemCount: notifications.length,
            itemBuilder: (context, index) {
              final section = notifications[index];
              return NotificationSection(section: section);
            },
          );
        },
      ),
    );
  }
}

class NotificationSection extends StatelessWidget {
  final NotificationSectionModel section;

  const NotificationSection({required this.section, Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final date = section.date;
    final items = section.data;

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  date,
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                TextButton(
                  onPressed: () {
                    // Add logic for marking all as read
                  },
                  child: const Text('Read All'),
                ),
              ],
            ),
          ),
          ...items.map((item) => NotificationCard(item: item)).toList(),
        ],
      ),
    );
  }
}

class NotificationCard extends StatelessWidget {
  final NotificationItem item;

  const NotificationCard({required this.item, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      shadowColor: Colors.black.withOpacity(1), 
      color: Colors.white,
      margin: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 4.0),
      child: ListTile(
        leading: CircleAvatar(
        backgroundImage: item.iconUrl.startsWith('http')
              ? NetworkImage(item.iconUrl) // For online images
              : AssetImage(item.iconUrl) as ImageProvider, 
        ),
        title: Text(item.title),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(item.description),
            Text(
              item.timestamp,
              style: const TextStyle(fontSize: 12, color: Colors.grey),
            ),
          ],
        ),
        trailing: IconButton(
          icon: const Icon(Icons.delete_forever_outlined, color: Colors.red),
          onPressed: () {
            // Add logic for deleting a notification
          },
        ),
      ),
    );
  }
}


