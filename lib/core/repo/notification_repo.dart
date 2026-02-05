import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:event_sense_ai/core/models/event_day_status_model.dart';
import '../models/notification_model.dart';

class NotificationRepository {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<void> createNotification(
      AppNotificationModel notification,
      ) async {
    final docRef = _firestore.collection("notifications").doc();

    await docRef.set(notification.toMap());


  }


  ///  Fetch vendor notifications (realtime)
  Stream<List<AppNotificationModel>> fetchVendorNotifications(String vendorId,) {
    return _firestore.collection("notifications").where("receiverId", isEqualTo: vendorId).
    orderBy("createdAt", descending: true).snapshots()
        .map((snapshot) {
      return snapshot.docs.map((doc) {
        return AppNotificationModel.fromJson(
          doc.data(),
          doc.id,
        );
      }).toList();
    });
  }
  ///  Fetch planner notifications (realtime)
  Stream<List<AppNotificationModel>> fetchPlannerNotifications(String plannerId,) {
    return _firestore.collection("notifications").where("plannerId", isEqualTo: plannerId).
    orderBy("createdAt", descending: true).snapshots()
        .map((snapshot) {
      return snapshot.docs.map((doc) {
        return AppNotificationModel.fromJson(
          doc.data(),
          doc.id,
        );
      }).toList();
    });
  }

  /// 🔥 Planner ke liye event day updates (realtime)
  Stream<List<EventDayStatusModel>> fetchPlannerEventUpdates(
      String plannerId,
      ) {
    return _firestore
        .collection("event_day_progress")
        .where("plannerId", isEqualTo: plannerId)
        .orderBy("createdAt", descending: true)
        .snapshots()
        .map(
          (query) => query.docs
          .map((doc) => EventDayStatusModel.fromJson(doc.data()))
          .toList(),
    );
  }
}
