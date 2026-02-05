import 'package:event_sense_ai/core/enums/status_enum.dart';

class GuestModel {
  final String guestName;
  final String guestEmail;
  final String guestPhone;
  final String guestCategory;
  final bool bringPartner;
  final String eventId;
  final String guestId;
  final GuestStatus status;

  GuestModel({
    required this.guestName,
    required this.guestEmail,
    required this.guestPhone,
    required this.guestCategory,
    required this.bringPartner,
    required this.eventId,
    required this.guestId,
    required this.status,
  });

  ///  Firestore → Model
  factory GuestModel.fromJson(Map<String, dynamic> map) {
    return GuestModel(
      guestName: map["guestName"] ?? "",
      guestEmail: map["guestEmail"] ?? "",
      guestPhone: map["guestPhone"] ?? "",
      guestCategory: map["guestCategory"] ?? "",
      bringPartner: map["bringPartner"] ?? false,
      eventId: map["eventId"] ?? "",
      guestId: map["guestId"] ?? "",
      status: GuestStatus.values.firstWhere(
            (e) => e.name == map["status"],
        orElse: () => GuestStatus.pending,
      ),
    );
  }

  ///  Model → Firestore
  Map<String, dynamic> toJson() {
    return {
      "guestName": guestName,
      "guestEmail": guestEmail,
      "guestPhone": guestPhone,
      "guestCategory": guestCategory,
      "bringPartner": bringPartner,
      "eventId": eventId,
      "guestId": guestId,
      "status": status.name, // enum → string
    };
  }

  /// copyWith (MOST IMPORTANT)
  GuestModel copyWith({
    String? guestName,
    String? guestEmail,
    String? guestPhone,
    String? guestCategory,
    bool? bringPartner,
    String? eventId,
    String? guestId,
    GuestStatus? status,
  }) {
    return GuestModel(
      guestName: guestName ?? this.guestName,
      guestEmail: guestEmail ?? this.guestEmail,
      guestPhone: guestPhone ?? this.guestPhone,
      guestCategory: guestCategory ?? this.guestCategory,
      bringPartner: bringPartner ?? this.bringPartner,
      eventId: eventId ?? this.eventId,
      guestId: guestId ?? this.guestId,
      status: status ?? this.status,
    );
  }
}
