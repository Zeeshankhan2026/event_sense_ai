import 'package:cloud_firestore/cloud_firestore.dart';

class AppNotificationModel {
  final String receiverId; // vendorId
  final String senderId; // plannerId
  final String eventName;
  final String eventLocation;
  final String eventDate;
  final String eventImage;
  final String type; // application_status
  final String title;
  final String body;
  final String applicationId;
  final String eventId;
  final String categoryId;
  final String status; // accepted / rejected
  final bool isRead;
  final String price;
  final Timestamp createdAt;

  AppNotificationModel({
    required this.receiverId,
    required this.senderId,
    required this.type,
    required this.title,
    required this.body,
    required this.applicationId,
    required this.eventId,
    required this.categoryId,
    required this.status,
    required this.eventName,
    required this.eventLocation,
    required this.eventImage,
    required this.eventDate,
    required this.price,
    this.isRead = false,
    Timestamp? createdAt,
  }) : createdAt = createdAt ?? Timestamp.now();

  factory AppNotificationModel.fromJson(Map<String, dynamic> map, String id) {
    return AppNotificationModel(
      receiverId: map["receiverId"]  ?? '',
      senderId: map["senderId"] ?? '',
      type: map["type"] ?? '',
      title: map["title"] ?? '',
      body: map["body"] ?? '',
      applicationId: map["applicationId"]  ?? '',
      eventId: map["eventId"] ?? '',
      categoryId: map["categoryId"]  ?? '',
      status: map["status"]  ?? '',
      eventName: map["eventName"]  ?? '',
      eventLocation: map["eventLocation"]  ?? '',
      eventImage: map["eventImage"]  ?? '',
      eventDate: map["eventDate"]  ?? '',
      price: map["price"]  ?? '',
    );
  }
  Map<String, dynamic> toMap() {
    return {
      "receiverId": receiverId,
      "senderId": senderId,
      "type": type,
      "title": title,
      "body": body,
      "applicationId": applicationId,
      "eventId": eventId,
      "categoryId": categoryId,
      "status": status,
      "isRead": isRead,
      "createdAt": createdAt,
      "eventName": eventName,
      "eventImage": eventImage,
      "eventLocation": eventLocation,
      "eventDate": eventDate,
      "price": price,
    };
  }
}
