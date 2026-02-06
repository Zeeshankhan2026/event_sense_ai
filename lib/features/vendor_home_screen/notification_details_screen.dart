import 'package:event_sense_ai/core/models/notification_model.dart';
import 'package:event_sense_ai/core/widgets/app_buttons.dart';
import 'package:event_sense_ai/core/widgets/custom_headerbar.dart';
import 'package:event_sense_ai/features/vendor_home_screen/components/notification_detials_card.dart';
import 'package:event_sense_ai/utils/app_assets.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';

class NotificationDetailsScreen extends StatelessWidget {
   NotificationDetailsScreen({super.key});
final notification = Get.arguments as AppNotificationModel;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              children: [
                CustomHeaderBar(title: "Booking details", showBackButton: true,onBack: (){
                  Navigator.of(context).pop();
                },),
                Gap(1.h),
                Container(
                  height: 16.h,
                  width: 50.w,
                  decoration: BoxDecoration(
                      color: Color(0xff96A2D5).withOpacity(.48),
                      shape: BoxShape.circle
                  ),
                  child: Center(child: Icon(Icons.check_circle_outline_outlined, color: Colors.indigo.shade600,size: 90,),),
                ),
                Gap(2.h),
                NotificationDetailsCard(
                  eventName: notification.eventName,
                  agreedPrice: notification.price,
                  scope: notification.body,
                  date: notification.eventDate,
                  time: "12:00 am",
                  location: notification.eventLocation,
                  imageUrl: AppAssets.wedding_reception2,),
                Gap(2.h),
                AppButtonWidget(
                  width: 88.w,
                    height: 6.h,
                    buttonColor: Color(0xff17316C),
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                    text: "View Status")
              ],
            ),
          ),
        ),
      ),
    );
  }
}
