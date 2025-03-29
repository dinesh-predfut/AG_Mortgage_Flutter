import 'package:ag_mortgage/NotificationScreen/notification.dart';

class NotificationModel {
  final int id;
  final int documentId;
  final int customer;
  final String notificationType;
  final String notificationMessage;
  final bool viewed;
  final bool deleted;
  final DateTime createdDate;
  final DateTime dueDate;

  NotificationModel({
    required this.id,
    required this.documentId,
    required this.customer,
    required this.notificationType,
    required this.notificationMessage,
    required this.viewed,
    required this.deleted,
    required this.createdDate,
    required this.dueDate,
  });

  factory NotificationModel.fromJson(Map<String, dynamic> json) {
    return NotificationModel(
      id: json['id'] ?? 0,
      documentId: json['documentId'] ?? 0,
      customer: json['customer'] ?? 0,
      notificationType: json['notificationType'] ?? 'Unknown Type',
      notificationMessage: json['notificationMessage'] ?? 'No Message Available',
      viewed: json['viewed'] ?? false,
      deleted: json['deleted'] ?? false,
      createdDate: json['createdDate'] != null
          ? DateTime.parse(json['createdDate'])
          : DateTime.now(),  // Providing a default if null
      dueDate: json['dueDate'] != null
          ? DateTime.parse(json['dueDate'])
          : DateTime.now(),  // Providing a default if null
    );
  }

  map(NotificationCard Function(dynamic item) param0) {}
}
