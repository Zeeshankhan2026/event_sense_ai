import 'package:event_sense_ai/core/controller/notification_controller.dart';
import 'package:event_sense_ai/core/routes/app_routes.dart';
import 'package:event_sense_ai/core/widgets/custom_headerbar.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'components/notification_widget.dart';

class VendorNotificationScreen extends StatefulWidget {
  const VendorNotificationScreen({super.key});

  @override
  State<VendorNotificationScreen> createState() => _VendorNotificationScreenState();
}

class _VendorNotificationScreenState extends State<VendorNotificationScreen> {
  late final NotificationController controller;

  @override
  void initState() {
    super.initState();

    //  safer than Get.find (avoid "Controller not found" crash)
    controller = Get.isRegistered<NotificationController>()
        ? Get.find<NotificationController>()
        : Get.put(NotificationController());

    controller.listenVendorNotifications(); //  important
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 12),
          child: Column(
            children: [
              const Gap(12),
              CustomHeaderBar(
                title: "Notifications",
                showBackButton: true,
                onBack: () => Navigator.of(context).pop(),
              ),
              Expanded(
                child: Obx(() {
                  //  use vendor loading flag
                  if (controller.isVendorLoading.value) {
                    return const Center(child: CircularProgressIndicator());
                  }

                  if (controller.notifications.isEmpty) {
                    return const Center(child: Text("No notifications"));
                  }

                  return ListView.builder(
                    itemCount: controller.notifications.length,
                    itemBuilder: (_, index) {
                      final n = controller.notifications[index];

                      final isAccepted = (n.status == "accepted");

                      return RsvpNotification(
                        onPressed: () {
                          if (isAccepted) {
                            Get.toNamed(
                              AppRoutes.NotificationDetailsScreen,
                              arguments: n,
                            );
                          }
                        },
                        iconContainerColor:
                        isAccepted ? Colors.greenAccent : Colors.redAccent,
                        status_icons:
                        isAccepted ? Icons.check : Icons.cancel_outlined,
                        name: n.eventName,
                        message: n.body,
                      );
                    },
                  );
                }),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
