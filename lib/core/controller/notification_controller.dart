import 'dart:async';

import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:event_sense_ai/core/models/event_day_status_model.dart';
import 'package:get/get.dart';
import 'package:firebase_auth/firebase_auth.dart';

import '../models/notification_model.dart';
import '../repo/notification_repo.dart';
import '../routes/app_routes.dart';

class NotificationController extends GetxController {
  final NotificationRepository _repo = NotificationRepository();

  /// Vendor notifications (UI bind)
  final RxList<AppNotificationModel> notifications = <AppNotificationModel>[].obs;

  /// Planner notifications (event updates)
  final RxList<EventDayStatusModel> plannerNotifications = <EventDayStatusModel>[].obs;

  /// Separate loading flags (better UI control)
  final RxBool isVendorLoading = false.obs;
  final RxBool isPlannerLoading = false.obs;

  StreamSubscription<List<AppNotificationModel>>? _vendorSub;
  StreamSubscription<List<EventDayStatusModel>>? _plannerSub;


  int get unreadCount => notifications.where((n) => n.isRead == false).length;

  /// Create notification when application accepted/rejected
  Future<void> createApplicationStatusNotification({
    required String vendorId,
    required String plannerId,
    required String eventName,
    required String eventImage,
    required String eventDate,
    required String eventLocation,
    required String applicationId,
    required String eventId,
    required String price,
    required String categoryId,
    required bool isAccepted,
  }) async {
    final notification = AppNotificationModel(
      eventDate: eventDate,
      eventImage: eventImage,
      eventLocation: eventLocation,
      eventName: eventName,
      receiverId: vendorId,
      senderId: plannerId,
      price: price,
      type: "application_status",
      title: isAccepted ? "Application Accepted" : "Application Rejected",
      body: isAccepted
          ? "Your proposal has been accepted"
          : "Your proposal has been rejected",
      applicationId: applicationId,
      eventId: eventId,
      categoryId: categoryId,
      status: isAccepted ? "accepted" : "rejected",
      // If your model supports it, ensure createdAt exists:
      // createdAt: DateTime.now().toIso8601String(),
    );

    await _repo.createNotification(notification);
  }

  /// FETCH vendor notifications (Realtime)
  void listenVendorNotifications() {
    final vendorId = FirebaseAuth.instance.currentUser?.uid;

    if (vendorId == null) {
      notifications.clear();
      return;
    }

    isVendorLoading.value = true;

    //  cancel old stream before new subscription
    _vendorSub?.cancel();
    _vendorSub = _repo.fetchVendorNotifications(vendorId).listen(
          (data) {
        notifications.assignAll(data);
        isVendorLoading.value = false;
      },
      onError: (error) {
        isVendorLoading.value = false;
        print(" Vendor notifications error: $error");
      },
    );
  }

  void initAwesomeNotificationListener() {
    AwesomeNotifications().setListeners(
      onActionReceivedMethod: (ReceivedAction action) async {
        final payload = action.payload ?? {};

        final applicationId = payload["applicationId"];
        final eventId = payload["eventId"];

        Get.toNamed(
          AppRoutes.vendorNotificationScreen,
          arguments: {
            "fromPush": true,
            "applicationId": applicationId,
            "eventId": eventId,
          },
        );
      },
    );
  }

  /// Planner event updates (Realtime)
  void listenPlannerNotifications() {
    final plannerId = FirebaseAuth.instance.currentUser?.uid;

    if (plannerId == null) {
      plannerNotifications.clear();
      return;
    }

    isPlannerLoading.value = true;

    _plannerSub?.cancel();
    _plannerSub = _repo.fetchPlannerEventUpdates(plannerId).listen(
          (data) {
        plannerNotifications.assignAll(data);
        isPlannerLoading.value = false;
      },
      onError: (error) {
        isPlannerLoading.value = false;
        print("Planner notifications error: $error");
      },
    );
  }

  @override
  void onClose() {
    _vendorSub?.cancel();
    _plannerSub?.cancel();
    super.onClose();
  }
}
