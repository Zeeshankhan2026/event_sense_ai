class VendorJobModel {
  final String eventId;
  final String plannerId;
  final String categoryId;
  final String title;
  final int budget;
  final String city;
  final String status;
  final String eventDate;
  final String eventType;
  final String jobId;
  final String guest;
  final String eventImage;
  VendorJobModel({
    required this.eventId,
    required this.plannerId,
    required this.categoryId,
    required this.title,
    required this.budget,
    required this.city,
    required this.status,
    required this.eventDate,
    required this.eventType,
    required this.jobId,
    required this.guest,
    required this.eventImage,
  });

  factory VendorJobModel.fromMap(Map<String, dynamic> map) {
    return VendorJobModel(
      eventDate: map["eventDate"] ?? "",
      eventId: map['eventId'] ?? "",
      plannerId: map['plannerId'] ?? "",
      categoryId: map['categoryId'] ?? "",
      title: map['title'] ?? "",
      budget: map['budget'] ?? 0,
      city: map['city'] ?? "",
      status: map['status'] ?? "",
      eventType: map["eventType"] ?? "",
      jobId: map["jobId"] ?? "",
      guest: map["guest"] ?? "",
      eventImage: map["eventImage"] ?? "",
    );
  }

  Map<String, dynamic> ToJson() {
    return {
      "eventId" : eventId,
      "plannerId" : plannerId,
      "categoryId" : categoryId,
      "title" : title,
      "budget" : budget,
      "city" : city,
      "status" : status,
      "eventDate" : eventDate,
      "eventType" : eventType,
      "jobId" : jobId,
      "guest" : guest,
      "eventImage" : eventImage,
    };
  }
}
