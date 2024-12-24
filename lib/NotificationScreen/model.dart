class NotificationItem {
  final String iconUrl;
  final String title;
  final String description;
  final String timestamp;
  final int id;

  NotificationItem({
    required this.iconUrl,
    required this.title,
    required this.description,
    required this.timestamp,
    required this.id,
  });

  factory NotificationItem.fromJson(Map<String, dynamic> json) {
    return NotificationItem(
      iconUrl: json['iconUrl'] ?? '',
      title: json['title'] ?? '',
      description: json['description'] ?? '',
      timestamp: json['timestamp'] ?? '',
      id: json['id'] ?? 0,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'iconUrl': iconUrl,
      'title': title,
      'description': description,
      'timestamp': timestamp,
      'id': id,
    };
  }
}

class NotificationSectionModel {
  final String date;
  final List<NotificationItem> data;

  NotificationSectionModel({required this.date, required this.data});

  factory NotificationSectionModel.fromJson(Map<String, dynamic> json) {
    return NotificationSectionModel(
      date: json['date'] ?? '',
      data: (json['data'] as List<dynamic>)
          .map((item) => NotificationItem.fromJson(item as Map<String, dynamic>))
          .toList(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'date': date,
      'data': data.map((item) => item.toJson()).toList(),
    };
  }
}