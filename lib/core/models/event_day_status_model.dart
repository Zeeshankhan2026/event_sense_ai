class EventDayStatusModel {
  final String plannerId;
  final String title;
  final String eventLocation;
  final String eventDate;
  final String statusUpdate;
  final String vendorName;

  EventDayStatusModel({
    required this.title,
    required this.eventLocation,
    required this.eventDate,
    required this.plannerId,
    required this.statusUpdate,
    required this.vendorName,
  });

  factory EventDayStatusModel.fromJson(Map<String, dynamic> map) {
    return EventDayStatusModel(
      title: map["title"] ?? "",
      eventLocation: map["eventLocation"] ?? "",
      eventDate: map["eventDate"] ?? "",
      plannerId: map["plannerId"] ?? "",
      statusUpdate: map["statusUpdate"] ?? "",
      vendorName: map["vendorName"] ?? "",
    );
  }

  Map<String,dynamic> toJson() {
    return {
      "title" : title,
      "eventLocation" : eventLocation,
      "eventDate" : eventDate,
      "plannerId" : plannerId,
      "statusUpdate" : statusUpdate,
      "vendorName" : vendorName
    };
  }
}
