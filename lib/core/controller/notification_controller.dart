import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:event_sense_ai/core/models/event_day_status_model.dart';
import 'package:get/get.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../models/notification_model.dart';
import '../repo/notification_repo.dart';
import '../routes/app_routes.dart';

class NotificationController extends GetxController {
  final NotificationRepository _repo = NotificationRepository();

  ///  Vendor notifications list (UI bind karegi)
  RxList<AppNotificationModel> notifications = <AppNotificationModel>[].obs;
  RxList<EventDayStatusModel> planner_notifications = <EventDayStatusModel>[].obs;

  RxBool isLoading = false.obs;
  @override
  void onInit() {
    super.onInit();
    listenPlannerNotifications();
  }

  int get unreadCount => notifications.where((n) => n.isRead == false).length;

  ///  Create notification when application is accepted/rejected
  Future<void> createApplicationStatusNotification({
    required String vendorId,
    required String plannerId,
    required String eventName,
    required String eventImage,
    required String eventDate,
    required String eventLocation,
    required String applicationId,
    required String eventId,
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
      type: "application_status",
      title: isAccepted
          ? "Application Accepted"
          : "Application Rejected",
      body: isAccepted
          ? "Your proposal has been accepted"
          : "Your proposal has been rejected",
      applicationId: applicationId,
      eventId: eventId,
      categoryId: categoryId,
      status: isAccepted ? "accepted" : "rejected",
    );

    await _repo.createNotification(notification);

  }

  ///  FETCH vendor notifications (Realtime)
  void listenVendorNotifications() {
    final vendorId = FirebaseAuth.instance.currentUser?.uid;
    if (vendorId == null) return;

    isLoading.value = true;

    _repo.fetchVendorNotifications(vendorId).listen(
          (data) {
        notifications.value = data;
        isLoading.value = false;
      },
      onError: (error) {
        isLoading.value = false;
      },
    );
  }

  void initAwesomeNotificationListener() {
    AwesomeNotifications().setListeners(
      onActionReceivedMethod: (ReceivedAction action) async {
        final payload = action.payload ?? {};

        final applicationId = payload["applicationId"];
        final eventId = payload["eventId"];

        /// 🟢 ALWAYS open Notification Screen first
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


  void listenPlannerNotifications() {
    final plannerId = FirebaseAuth.instance.currentUser?.uid;
    if (plannerId == null) return;

    isLoading.value = true;

    _repo.fetchPlannerEventUpdates(plannerId).listen(
          (data) {
        planner_notifications.value = data;
        isLoading.value = false;
      },
      onError: (_) {
        isLoading.value = false;
      },
    );
  }

}
