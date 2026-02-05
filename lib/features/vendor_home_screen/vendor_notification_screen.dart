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
  final controller = Get.find<NotificationController>();
  @override
  void initState() {
    super.initState();
    controller.listenVendorNotifications();
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
             CustomHeaderBar(title: "Notifications", showBackButton: true, onBack: (){
               Navigator.of(context).pop();
             },),
              Expanded(
                child: Obx((){
                  if (controller.isLoading.value) {
                    return const Center(child: CircularProgressIndicator());
                  }

                  if (controller.notifications.isEmpty) {
                    return const Center(child: Text("No notifications"));
                  }

                  return ListView.builder(
                      itemCount: controller.notifications.length,
                      itemBuilder: (_, index) {
                        final n =  controller.notifications[index];
                        return RsvpNotification(
                          onPressed: (){
                            if(n.status == "accepted"){
                              Get.toNamed(AppRoutes.NotificationDetailsScreen,
                              arguments: n);
                            }

                          },
                          iconContainerColor: n.status == "accepted" ?  Colors.greenAccent : Colors.redAccent,
                          status_icons: n.status == "accepted" ?  Icons.check : Icons.cancel_outlined,
                          name: n.eventName,
                          message: n.body,

                        );
                      });
                }
                ),
              ),

            ],
          ),
        ),
      ),
    );
  }


}
