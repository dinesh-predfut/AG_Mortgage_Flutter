import 'dart:convert';
import 'package:ag_mortgage/Dashboard_Screen/Market_Place/Details_Page/models.dart';
import 'package:ag_mortgage/NotificationScreen/model.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

import '../../../const/constant.dart';
import '../../../const/url.dart';
class Notificationcontroller extends ChangeNotifier {
 Future<List<NotificationModel>> loadNotifications() async {

    final response = await http.get(
      Uri.parse('${Urls.getallNotification}?customerId=${Params.userId}'),
      headers: {
        'Authorization': 'Bearer ${Params.userToken ?? ''}',
        'Content-Type': 'application/json',
      },
    );

    if (response.statusCode == 200) {
      final List<dynamic> jsonData = json.decode(response.body);
      return jsonData
          .map((item) =>
              NotificationModel.fromJson(item as Map<String, dynamic>))
          .toList();
    } else {
      throw Exception('Failed to load notifications');
    }
  }
  Future<void> deleteNotifications(id) async {

    final response = await http.delete(
      Uri.parse('${Urls.getallNotification}?id=$id'),
      headers: {
        'Authorization': 'Bearer ${Params.userToken ?? ''}',
        'Content-Type': 'application/json',
      },
    );

    if (response.statusCode == 200) {
        Fluttertoast.showToast(
        msg: "Notifications Delete successfully",
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        backgroundColor: const Color.fromARGB(255, 223, 45, 45),
        textColor: const Color.fromARGB(255, 252, 250, 250),
      );
     loadNotifications();
    } else {
      throw Exception('Failed to load notifications');
    }
  }
Future<List<NotificationModel>> readNotifications(
      List<int> notificationIds) async {
    const String url = 'http://3.253.82.115/api/viewNotification';

    final response = await http.put(
      Uri.parse(url),
      headers: {
        'Authorization': 'Bearer ${Params.userToken ?? ''}',
        'Content-Type': 'application/json',
      },
      body: json.encode({
        'notificationIds': notificationIds,
      }),
    );

    if (response.statusCode == 200) {
      Fluttertoast.showToast(
        msg: "Notifications marked as viewed successfully",
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        backgroundColor: Colors.grey,
        textColor: const Color.fromARGB(255, 15, 15, 15),
      );
           loadNotifications();
      final List<dynamic> jsonData = json.decode(response.body);

      return jsonData
          .map((item) =>
              NotificationModel.fromJson(item as Map<String, dynamic>))
          .toList();
    } else {
      throw Exception('Failed to update notifications');
    }
  }
}