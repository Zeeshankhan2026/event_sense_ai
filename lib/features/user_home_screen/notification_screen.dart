import 'package:event_sense_ai/core/controller/notification_controller.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import '../../core/widgets/apptext.dart';
import 'package:flutter/material.dart';
import '../../core/widgets/custom_headerbar.dart';


class PlannerNotificationScreen extends StatefulWidget {
  PlannerNotificationScreen({super.key});

  @override
  State<PlannerNotificationScreen> createState() => _PlannerNotificationScreenState();
}

class _PlannerNotificationScreenState extends State<PlannerNotificationScreen> {
  final controller = Get.put(NotificationController());

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    controller.listenPlannerNotifications();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Padding(
          padding:  EdgeInsets.symmetric(horizontal: 12),
          child: Column(
            children: [
               Gap(12),
              CustomHeaderBar(
                title: "Notifications",
                showBackButton: true,
                onBack: () => Navigator.of(context).pop(),
              ),

              Expanded(
                child: Obx(() {
                  if (controller.isLoading.value) {
                    return const Center(
                      child: CircularProgressIndicator(),
                    );
                  }

                  if (controller.planner_notifications.isEmpty) {
                    return const Center(
                      child: Text("No notifications yet"),
                    );
                  }

                  return ListView.builder(
                    itemCount: controller.planner_notifications.length,
                    itemBuilder: (context, index) {
                      final item =
                      controller.planner_notifications[index];

                      return Container(
                        margin: const EdgeInsets.only(bottom: 12),
                        padding: const EdgeInsets.all(14),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(14),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withOpacity(0.06),
                              blurRadius: 8,
                              offset: const Offset(0, 4),
                            ),
                          ],
                        ),
                        child: Column(
                          crossAxisAlignment:
                          CrossAxisAlignment.start,
                          children: [
                            AppText(
                              item.title,
                              fontSize: 16,
                              fontWeight: FontWeight.w600,
                            ),
                            const Gap(6),
                            AppText(
                              "${item.vendorName} • ${item.statusUpdate}",
                              fontSize: 14,
                              color: Colors.grey.shade700,
                            ),
                            const Gap(6),
                            AppText(
                              "${item.eventDate} | ${item.eventLocation}",
                              fontSize: 12,
                              color: Colors.grey.shade500,
                            ),
                          ],
                        ),
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
