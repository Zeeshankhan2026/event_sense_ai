import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:event_sense_ai/features/user_home_screen/components/job_resuable_cad.dart';

class EventCategoryModel {
  final String categoryId;
  final String eventId;
  final String title;
  final int recommendedBudget;
  final JobStatus? status; // not_posted | posted | applied
  final String jobDescription;
  final String jobInstructions;
  final String eventDate;
  final String eventType;
  final String guests;
  EventCategoryModel({
    required this.categoryId,
    required this.jobDescription,
    required this.jobInstructions,
    required this.eventId,
    required this.title,
    required this.recommendedBudget,
    required this.status,
    required this.eventDate,
    required this.eventType,
    required this.guests
  });

  factory EventCategoryModel.fromMap(String id, Map<String, dynamic> map) {
    return EventCategoryModel(
      categoryId: id,
      eventId: map['eventId'],
      title: map['title'],
      recommendedBudget: map['recommendedBudget'],
      status: map['status'] != null
          ? JobStatus.values.firstWhere(
              (e) => e.toString().split('.').last == map['status'],
              orElse: () => JobStatus.notStarted,
            )
          : JobStatus.notStarted,
      jobDescription: map['jobDescription'] ?? "",
      jobInstructions: map['jobInstructions'] ?? "",
      eventDate: map["eventDate"] ?? "",
      eventType: map["eventType"] ?? "",
      guests: map["guests"] ?? "",
    );
  }

  /// ✅ copyWith method
  EventCategoryModel copyWith({
    String? categoryId,
    String? eventId,
    String? title,
    int? recommendedBudget,
    JobStatus? status ,
    String? jobDescription,
    String? jobInstructions,
    String? eventDate,
    String? eventType,
    String? guests,
  }) {
    return EventCategoryModel(
      categoryId: categoryId ?? this.categoryId,
      eventId: eventId ?? this.eventId,
      title: title ?? this.title,
      recommendedBudget: recommendedBudget ?? this.recommendedBudget,
      status: status ?? this.status,
      jobDescription: jobDescription ?? this.jobDescription,
      jobInstructions: jobInstructions ?? this.jobInstructions,
      eventDate: eventDate ?? this.eventDate,
      eventType: eventType ?? this.eventType,
      guests: guests ?? this.guests
    );
  }

  Map<String, dynamic> toMap() {
    return {
      "eventId": eventId,
      "title": title,
      "recommendedBudget": recommendedBudget,
      "status": status?.name ?? JobStatus.notStarted.name,
      "jobInstructions": jobInstructions,
      "jobDescription": jobDescription,
      "createdAt": Timestamp.now(),
      "eventDate" : eventDate,
      "eventType" : eventType,
      "guests" : guests,
    };
  }
}
