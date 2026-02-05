import 'package:event_sense_ai/core/controller/vendor_job_controller.dart';
import 'package:event_sense_ai/core/routes/app_routes.dart';
import 'package:event_sense_ai/core/widgets/app_buttons.dart';
import 'package:event_sense_ai/core/widgets/apptext.dart';
import 'package:event_sense_ai/core/widgets/custom_headerbar.dart';
import 'package:event_sense_ai/utils/app_assets.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';

import '../../core/controller/vendor_controller.dart';

class EventDayProgress extends StatefulWidget {
  EventDayProgress({super.key});
  @override
  State<EventDayProgress> createState() => _EventDayProgressState();
}

class _EventDayProgressState extends State<EventDayProgress> {
  final activeEventData = Get.arguments;

  // Variable to store selected status for Firebase notifications
  String? selectedStatus;
  final vendorController = Get.find<VendorJobController>();
  
  // Track which status has been sent successfully
  String? sentStatus;
  
  // Track which status is currently loading
  String? loadingStatus;
  
  // Method to update event progress
  Future<void> updateEventProgress(String status, String vendorName) async {
    setState(() {
      loadingStatus = status;
      selectedStatus = status;
    });
    
    try {
      await vendorController.updateEventDayProgress(
        vendorName,
        activeEventData["title"],
        activeEventData["city"],
        activeEventData["plannerId"],
        status,
        activeEventData["title"],
        activeEventData["eventDate"],
      );
      
      // On success, mark as sent
      setState(() {
        sentStatus = status;
        loadingStatus = null;
      });
    } catch (e) {
      // On error, clear loading state
      setState(() {
        loadingStatus = null;
      });
      Get.snackbar("Error", "Failed to update status: ${e.toString()}");
    }
  }

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<VendorController>();
    final vendorName = controller.vendor.value!.companyName;
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 6.w),
          child: Column(
            children: [
              CustomHeaderBar(
                title: "Event Day Progress",
                showBackButton: true,
                onBack: () {
                  Navigator.of(context).pop();
                },
              ),
              Container(
                width: 95.w,
                height: 22.h,
                padding: EdgeInsets.all(8),
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.grey.shade300),
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      padding: EdgeInsets.all(8),
                      margin: EdgeInsets.all(8),
                      width: 17.w,
                      height: 4.h,
                      decoration: BoxDecoration(
                        color: Color(0xffADD3BB),
                        borderRadius: BorderRadius.circular(32),
                      ),
                      child: AppText(
                        "Live Now",
                        fontSize: 11,
                        color: Colors.green,
                      ),
                    ),
                    Row(
                      children: [
                        SizedBox(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              SizedBox(
                                width: 40.w,
                                height: 4.h,
                                child: AppText(
                                  activeEventData["title"],
                                  fontSize: 20,
                                  overflow: TextOverflow.ellipsis,
                                ),
                              ),
                              Gap(1.h),
                              Row(
                                children: [
                                  Icon(Icons.calendar_today_outlined),
                                  AppText(
                                    activeEventData["eventDate"],
                                    fontSize: 12,
                                  ),
                                  AppText("/"),
                                  AppText(
                                    activeEventData["city"],
                                    fontSize: 12,
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                        Spacer(),
                        Container(
                          width: 40.w,
                          height: 13.h,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(20),
                            image: DecorationImage(
                              image: AssetImage(AppAssets.wedding_reception2),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              Gap(2.h),
              AppText(
                "Update Your  Status",
                fontSize: 24,
                fontWeight: FontWeight.w700,
              ),
              AppText(
                "Tap to notify the planner automatically. our AI will handle the communication.",
                textAlign: TextAlign.center,
                fontSize: 14,
                fontWeight: FontWeight.w400,
                color: Colors.grey.shade700,
              ),
              Gap(1.h),
              GestureDetector(
                onTap: () {
                  updateEventProgress("On the Way", vendorName!);
                },
                child: Container(
                  width: 99.w,
                  height: 13.h,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    border: BoxBorder.all(color: Colors.grey, width: 1),
                    color: selectedStatus == "On the Way"
                        ? Color(0xff9DCDAF).withOpacity(0.3)
                        : Colors.transparent,
                  ),
                  child: Row(
                    children: [
                      Container(
                        width: 23.w,
                        height: 10.h,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: Color(0xff9DCDAF),
                          border: BoxBorder.all(color: Colors.grey),
                        ),
                        child: Center(
                          child: Icon(
                            Icons.add_circle_outline,
                            size: 40,
                            color: Color(0xff3C9C5F),
                          ),
                        ),
                      ),
                      Gap(2.w),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Gap(3.h),
                          Row(
                            children: [
                              SizedBox(
                                width: 30.w,
                                child: AppText(
                                  "On the Way",
                                  fontSize: 20,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                              Gap(15.w),
                              if (loadingStatus == "On the Way")
                                SizedBox(
                                  width: 14.w,
                                  height: 3.h,
                                  child: Center(
                                    child: CircularProgressIndicator(
                                      strokeWidth: 2,
                                      valueColor: AlwaysStoppedAnimation<Color>(Color(0xff3C9C5F)),
                                    ),
                                  ),
                                )
                              else if (sentStatus == "On the Way")
                                Container(
                                  width: 14.w,
                                  height: 3.h,
                                  decoration: BoxDecoration(
                                    color: Color(0xff9DCDAF),
                                    borderRadius: BorderRadius.circular(20),
                                  ),
                                  child: Center(
                                    child: AppText(
                                      "Sent",
                                      color: Color(0xff3C9C5F),
                                      fontSize: 16,
                                    ),
                                  ),
                                ),
                            ],
                          ),
                          AppText(
                            "Estimated arrival: 1:45 PM",
                            fontSize: 14,
                            fontWeight: FontWeight.w400,
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
              Gap(1.h),
              GestureDetector(
                onTap: () {
                  updateEventProgress("Arrived", vendorName!);
                },
                child: Container(
                  width: 99.w,
                  height: 13.h,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    border: BoxBorder.all(color: Colors.grey, width: 1),
                    color: selectedStatus == "Arrived"
                        ? Color(0xff96A2D5).withOpacity(0.3)
                        : Colors.transparent,
                  ),
                  child: Row(
                    children: [
                      Container(
                        width: 23.w,
                        height: 10.h,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: Color(0xff96A2D5),
                          border: BoxBorder.all(color: Colors.grey),
                        ),
                        child: Center(
                          child: Icon(
                            Icons.location_on_outlined,
                            size: 40,
                            color: Color(0xff1B2A57),
                          ),
                        ),
                      ),
                      Gap(2.w),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Gap(3.h),
                          Row(
                            children: [
                              SizedBox(
                                width: 30.w,
                                child: AppText(
                                  "Arrived",
                                  fontSize: 20,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                              Gap(15.w),
                              if (loadingStatus == "Arrived")
                                SizedBox(
                                  width: 14.w,
                                  height: 3.h,
                                  child: Center(
                                    child: CircularProgressIndicator(
                                      strokeWidth: 2,
                                      valueColor: AlwaysStoppedAnimation<Color>(Color(0xff1B2A57)),
                                    ),
                                  ),
                                )
                              else if (sentStatus == "Arrived")
                                Container(
                                  width: 14.w,
                                  height: 3.h,
                                  decoration: BoxDecoration(
                                    color: Color(0xff9DCDAF),
                                    borderRadius: BorderRadius.circular(20),
                                  ),
                                  child: Center(
                                    child: AppText(
                                      "Sent",
                                      color: Color(0xff3C9C5F),
                                      fontSize: 16,
                                    ),
                                  ),
                                ),
                            ],
                          ),
                          AppText(
                            "Tap to confirm arrival at venue",
                            fontSize: 14,
                            fontWeight: FontWeight.w400,
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
              Gap(1.h),
              GestureDetector(
                onTap: () {
                  updateEventProgress("Completed", vendorName!);
                },
                child: Container(
                  width: 99.w,
                  height: 13.h,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    border: BoxBorder.all(color: Colors.grey, width: 1),
                    color: selectedStatus == "Completed"
                        ? Color(0xffE0E0E0).withOpacity(0.5)
                        : Colors.transparent,
                  ),
                  child: Row(
                    children: [
                      Container(
                        width: 23.w,
                        height: 10.h,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: Color(0xffE0E0E0),
                          border: BoxBorder.all(color: Colors.grey),
                        ),
                        child: Center(
                          child: Icon(
                            Icons.check_circle_outline,
                            size: 40,
                            color: Color(0xff6C7278),
                          ),
                        ),
                      ),
                      Gap(2.w),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Gap(3.h),
                          Row(
                            children: [
                              AppText(
                                "Completed",
                                fontSize: 20,
                                fontWeight: FontWeight.w600,
                              ),
                              Gap(15.w),
                              if (loadingStatus == "Completed")
                                SizedBox(
                                  width: 14.w,
                                  height: 3.h,
                                  child: Center(
                                    child: CircularProgressIndicator(
                                      strokeWidth: 2,
                                      valueColor: AlwaysStoppedAnimation<Color>(Color(0xff6C7278)),
                                    ),
                                  ),
                                )
                              else if (sentStatus == "Completed")
                                Container(
                                  width: 14.w,
                                  height: 3.h,
                                  decoration: BoxDecoration(
                                    color: Color(0xff9DCDAF),
                                    borderRadius: BorderRadius.circular(20),
                                  ),
                                  child: Center(
                                    child: AppText(
                                      "Sent",
                                      color: Color(0xff3C9C5F),
                                      fontSize: 16,
                                    ),
                                  ),
                                ),
                            ],
                          ),
                          AppText(
                            "Estimated arrival: 1:45 PM",
                            fontSize: 14,
                            fontWeight: FontWeight.w400,
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
              Spacer(),
              Row(
                children: [
                  AppButtonWidget(
                    onPressed: () {
                      Get.toNamed(
                        AppRoutes.chatDetailsScreen,
                        arguments: activeEventData,
                      );
                    },
                    width: 30.w,
                    height: 6.h,
                    buttonColor: Color(0xffE68D7E),
                    text: "Message",
                  ),
                  Gap(2.w),
                  AppButtonWidget(
                    width: 53.w,
                    height: 6.h,
                    buttonColor: Color(0xff23325D),
                    text: "Complete Order",
                  ),
                ],
              ),
              Gap(1.h),
            ],
          ),
        ),
      ),
    );
  }
}
