import 'package:ag_mortgage/NotificationScreen/controller.dart';
import 'package:ag_mortgage/NotificationScreen/model.dart';
import 'package:ag_mortgage/const/url.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';
import 'dart:convert';
import '../const/constant.dart';

class NotificationsPage extends StatelessWidget {
   NotificationsPage({Key? key}) : super(key: key);
  final controller = Get.put(Notificationcontroller());

  // Load notifications from API
 

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
      body: FutureBuilder<List<NotificationModel>>(
        future: controller.loadNotifications(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return const Center(child: Text('No notifications'));
          }

          final notifications = snapshot.data!;
          final groupedNotifications = _groupNotificationsByDate(notifications);

          return ListView(
            children: groupedNotifications.entries.map((entry) {
              final date = entry.key;
              final notificationItems = entry.value;

              return Padding(
                padding: const EdgeInsets.symmetric(vertical: 8.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16.0),
                      child: Text(
                        date,
                        style: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    ),
                    ...notificationItems
                        .map((item) => NotificationCard(item: item))
                  ],
                ),
              );
            }).toList(),
          );
        },
      ),
    );
  }

  // Grouping Notifications by Date
  Map<String, List<NotificationModel>> _groupNotificationsByDate(
      List<NotificationModel> notifications) {
    final Map<String, List<NotificationModel>> groupedNotifications = {};

    for (var notification in notifications) {
      final formattedDate =
          NotificationCard.getFormattedDate(notification.createdDate);

      if (groupedNotifications.containsKey(formattedDate)) {
        groupedNotifications[formattedDate]!.add(notification);
      } else {
        groupedNotifications[formattedDate] = [notification];
      }
    }

    return groupedNotifications;
  }
}

class NotificationCard extends StatelessWidget {
  final NotificationModel item;

   NotificationCard({required this.item, Key? key}) : super(key: key);
  final controller = Get.put(Notificationcontroller());

  static String formatDate(DateTime date) {
    return DateFormat('dd-MM-yyyy').format(date);
  }

  static String getDifferenceInMinutes(DateTime date) {
    final DateTime now = DateTime.now();
    final Duration difference = now.difference(date);

    if (difference.inMinutes < 1) {
      return 'Just now';
    } else if (difference.inMinutes < 60) {
      return '${difference.inMinutes} minutes ago';
    } else if (difference.inHours < 24) {
      return '${difference.inHours} hours ago';
    } else {
      return '${difference.inDays} days ago';
    }
  }

  static String getFormattedDate(DateTime date) {
    final DateTime now = DateTime.now();
    final DateTime today = DateTime(now.year, now.month, now.day);
    final DateTime yesterday = today.subtract(const Duration(days: 1));
    final DateTime notificationDate = DateTime(date.year, date.month, date.day);

    if (notificationDate == today) {
      return 'Today';
    } else if (notificationDate == yesterday) {
      return 'Yesterday';
    } else {
      return formatDate(date);
    }
  }

  

  @override
  Widget build(BuildContext context) {
    return InkWell(
        onTap: () {
          print("object${item.viewed}");
          if (item.viewed == false) {
            controller.readNotifications([item.id]); // Pass item.id as a list
          }
        },
        child: Card(
          shadowColor: Colors.black.withOpacity(1),
          color: item.viewed
              ? Colors.white
              : const Color.fromARGB(255, 206, 204, 204),
          margin: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 4.0),
          child: ListTile(
            leading: const CircleAvatar(
              backgroundColor: Colors.blue,
              child: Icon(Icons.notifications, color: Colors.white),
            ),
            title: Text(
              item.notificationType,
              style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w800),
            ),
            subtitle: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  item.notificationMessage,
                  style: const TextStyle(fontSize: 12),
                ),
                Text(
                  getDifferenceInMinutes(item.createdDate),
                  style: const TextStyle(fontSize: 12, color: Colors.grey),
                ),
              ],
            ),
            trailing: IconButton(
              icon:
                  const Icon(Icons.delete_forever_outlined, color: Colors.red),
              onPressed: () {
          
                  controller.deleteNotifications(item.id);
                
              },
            ),
          ),
        ));
  }
}
