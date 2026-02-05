class EventModel {
  late String eventName;
  late String eventType;
  late String eventStartDate;
  late String eventEndDate;
  late String eventLocation;
  late String guestCount;
  late double  eventBudget;
  late String userId;
  late String status;
  late String eventDescriptions;
  late String eventId;

  EventModel({
    required this.eventLocation,
    required this.eventBudget,
    required this.eventEndDate,
    required this.eventStartDate,
    required this.eventName,
    required this.eventType,
    required this.guestCount,
    required this.userId,
    required this.status,
    required this.eventDescriptions,
    required this.eventId,
  });

  factory EventModel.fromJson(Map<String, dynamic> map, String id) {
    return EventModel(
      eventLocation: map["eventLocation"] ?? "",
      eventBudget: (map["eventBudget"] ?? 0.0).toDouble(),
      eventEndDate: map["eventEndDate"] ?? "",
      eventStartDate: map["eventStartDate"] ?? "",
      eventName: map["eventName"] ?? "",
      eventType: map["eventType"] ?? "",
      guestCount: map["guestCount"] ?? "0",
      userId: map["userId"] ?? "",
      status: map["status"] ?? "",
      eventDescriptions: map["eventDescriptions"] ?? "",
      eventId: id,
    );
  }

  Map<String, dynamic> ToJson() {
    return {
      "eventName": eventName,
      "eventLocation": eventLocation,
      "eventBudget": eventBudget,
      "eventEndDate": eventEndDate,
      "eventStartDate": eventStartDate,
      "eventType": eventType,
      "guestCount": guestCount,
      "userId": userId,
      "status": status,
      "eventDescriptions": eventDescriptions,
      "eventId": eventId,
    };
  }
}
