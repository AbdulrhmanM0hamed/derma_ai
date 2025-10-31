import 'package:flutter/material.dart';

enum NotificationType {
  appointment,
  reminder,
  tip,
  result,
  emergency,
  medication,
  general,
}

class NotificationModel {
  final String id;
  final String title;
  final String message;
  final NotificationType type;
  final DateTime timestamp;
  final bool isRead;
  final String? actionUrl;
  final Map<String, dynamic>? metadata;

  NotificationModel({
    required this.id,
    required this.title,
    required this.message,
    required this.type,
    required this.timestamp,
    this.isRead = false,
    this.actionUrl,
    this.metadata,
  });

  NotificationModel copyWith({
    String? id,
    String? title,
    String? message,
    NotificationType? type,
    DateTime? timestamp,
    bool? isRead,
    String? actionUrl,
    Map<String, dynamic>? metadata,
  }) {
    return NotificationModel(
      id: id ?? this.id,
      title: title ?? this.title,
      message: message ?? this.message,
      type: type ?? this.type,
      timestamp: timestamp ?? this.timestamp,
      isRead: isRead ?? this.isRead,
      actionUrl: actionUrl ?? this.actionUrl,
      metadata: metadata ?? this.metadata,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'message': message,
      'type': type.name,
      'timestamp': timestamp.toIso8601String(),
      'isRead': isRead,
      'actionUrl': actionUrl,
      'metadata': metadata,
    };
  }

  factory NotificationModel.fromJson(Map<String, dynamic> json) {
    return NotificationModel(
      id: json['id'] ?? '',
      title: json['title'] ?? '',
      message: json['message'] ?? '',
      type: NotificationType.values.firstWhere(
        (e) => e.name == json['type'],
        orElse: () => NotificationType.general,
      ),
      timestamp: DateTime.parse(json['timestamp']),
      isRead: json['isRead'] ?? false,
      actionUrl: json['actionUrl'],
      metadata: json['metadata'],
    );
  }

  String get timeAgo {
    final now = DateTime.now();
    final difference = now.difference(timestamp);

    if (difference.inMinutes < 1) {
      return 'الآن';
    } else if (difference.inMinutes < 60) {
      return 'منذ ${difference.inMinutes} دقيقة';
    } else if (difference.inHours < 24) {
      return 'منذ ${difference.inHours} ساعة';
    } else if (difference.inDays < 7) {
      return 'منذ ${difference.inDays} يوم';
    } else {
      return 'منذ ${(difference.inDays / 7).floor()} أسبوع';
    }
  }

  IconData get icon {
    switch (type) {
      case NotificationType.appointment:
        return Icons.calendar_today;
      case NotificationType.reminder:
        return Icons.alarm;
      case NotificationType.tip:
        return Icons.lightbulb;
      case NotificationType.result:
        return Icons.assignment_turned_in;
      case NotificationType.emergency:
        return Icons.emergency;
      case NotificationType.medication:
        return Icons.medication;
      case NotificationType.general:
        return Icons.notifications;
    }
  }

  Color get color {
    switch (type) {
      case NotificationType.appointment:
        return Colors.blue;
      case NotificationType.reminder:
        return Colors.orange;
      case NotificationType.tip:
        return Colors.green;
      case NotificationType.result:
        return Colors.purple;
      case NotificationType.emergency:
        return Colors.red;
      case NotificationType.medication:
        return Colors.teal;
      case NotificationType.general:
        return Colors.grey;
    }
  }

  String get typeArabicName {
    switch (type) {
      case NotificationType.appointment:
        return 'موعد';
      case NotificationType.reminder:
        return 'تذكير';
      case NotificationType.tip:
        return 'نصيحة';
      case NotificationType.result:
        return 'نتيجة';
      case NotificationType.emergency:
        return 'طوارئ';
      case NotificationType.medication:
        return 'دواء';
      case NotificationType.general:
        return 'عام';
    }
  }
}
