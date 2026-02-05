import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:event_sense_ai/core/controller/vendor_job_controller.dart';
import 'package:event_sense_ai/core/models/jobs_model.dart';
import 'package:event_sense_ai/core/models/vendor_application_model.dart';
import 'package:event_sense_ai/features/user_home_screen/components/event_card.dart';
import 'package:event_sense_ai/features/vendor_home_screen/components/new_job_card.dart';
import 'package:event_sense_ai/utils/app_assets.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';
import '../../core/controller/notification_controller.dart';
import '../../core/controller/vendor_controller.dart';
import '../../core/routes/app_routes.dart';
import '../../core/widgets/apptext.dart';
import '../../utils/app_colors.dart';
import 'components/active_jobs_widget.dart';
import 'components/vendor_tiles_widgets.dart';

class VendorHomeScreen extends StatefulWidget {
  VendorHomeScreen({super.key});

  @override
  State<VendorHomeScreen> createState() => _VendorHomeScreenState();
}

class _VendorHomeScreenState extends State<VendorHomeScreen> {
  final controller = Get.find<VendorController>();

  final jobController = Get.find<VendorJobController>();

  final notificationController = Get.find<NotificationController>();
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    notificationController.listenVendorNotifications();
    notificationController.initAwesomeNotificationListener();
  }

  @override
  Widget build(BuildContext context) {
    List<VendorTilesWidgets> vendorTile = [
      VendorTilesWidgets(
        onPressed: () {
          Get.toNamed(AppRoutes.findNewOppurtunities);
        },
        title: "Find Job",
        iconData: Icons.search_outlined,
        container_color: Colors.greenAccent.shade100,
      ),
      VendorTilesWidgets(
        onPressed: () {
          Get.toNamed(AppRoutes.vendorMessageScreen);
        },
        title: "Message",
        iconData: Icons.message_outlined,
        container_color: Colors.redAccent.shade100,
      ),
      VendorTilesWidgets(
        onPressed: () {
          Get.toNamed(AppRoutes.vendorProfileScreeen);
        },
        title: "Profile",
        iconData: Icons.person_outline,
        container_color: Colors.cyan.shade100,
      ),
    ];

    return PopScope(
      canPop: false,
      onPopInvoked: (didPop) async {
        if (didPop) return;

        // Minimize / exit app
        await SystemNavigator.pop();
      },
      child: Scaffold(
        backgroundColor: Colors.white,
        body: SafeArea(
          child: SingleChildScrollView(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 6, vertical: 8),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 16,
                      vertical: 12,
                    ),
                    margin: const EdgeInsets.symmetric(
                      horizontal: 16,
                      vertical: 12,
                    ),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(16),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.08),
                          blurRadius: 12,
                          spreadRadius: 2,
                          offset: const Offset(0, 6),
                        ),
                      ],
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        // Profile + Greeting
                        Obx(() {
                          final data = controller.vendor.value;

                          // Professional placeholder while loading or if not found
                          if (data == null) {
                            return Row(
                              children: [
                                Container(
                                  width: 48,
                                  height: 48,
                                  decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                    color: Colors.grey.shade200,
                                  ),
                                ),
                                const SizedBox(width: 12),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Container(
                                      width: 80,
                                      height: 12,
                                      decoration: BoxDecoration(
                                        color: Colors.grey.shade200,
                                        borderRadius: BorderRadius.circular(4),
                                      ),
                                    ),
                                    const SizedBox(height: 6),
                                    Container(
                                      width: 120,
                                      height: 16,
                                      decoration: BoxDecoration(
                                        color: Colors.grey.shade200,
                                        borderRadius: BorderRadius.circular(4),
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            );
                          }

                          return Row(
                            children: [
                              // Profile Image
                              Container(
                                width: 48,
                                height: 48,
                                decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  color: Colors.blue.withOpacity(0.1),
                                  boxShadow: [
                                    BoxShadow(
                                      color: Colors.black.withOpacity(0.1),
                                      blurRadius: 8,
                                      offset: const Offset(0, 4),
                                    ),
                                  ],
                                ),
                                child: ClipOval(
                                  child:
                                      (data.profileImage != null &&
                                          data.profileImage!.isNotEmpty)
                                      ? Image.network(
                                          data.profileImage!,
                                          fit: BoxFit.cover,
                                          errorBuilder:
                                              (context, error, stackTrace) {
                                                return Center(
                                                  child: Text(
                                                    (data.companyName != null &&
                                                            data
                                                                .companyName!
                                                                .isNotEmpty)
                                                        ? data.companyName![0]
                                                              .toUpperCase()
                                                        : "U",
                                                    style: TextStyle(
                                                      fontSize: 20,
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      color:
                                                          Colors.blue.shade700,
                                                    ),
                                                  ),
                                                );
                                              },
                                        )
                                      : Center(
                                          child: Text(
                                            (data.companyName != null &&
                                                    data
                                                        .companyName!
                                                        .isNotEmpty)
                                                ? data.companyName![0]
                                                      .toUpperCase()
                                                : "U",
                                            style: TextStyle(
                                              fontSize: 20,
                                              fontWeight: FontWeight.bold,
                                              color: Colors.blue.shade700,
                                            ),
                                          ),
                                        ),
                                ),
                              ),
                              const SizedBox(width: 12),
                              // Text
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    "Welcome Back",
                                    style: TextStyle(
                                      fontSize: 13,
                                      color: Colors.grey,
                                    ),
                                  ),
                                  Text(
                                    data.companyName.toString(),
                                    style: TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.black87,
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          );
                        }),

                        // Notification Bell with Dot
                        GestureDetector(
                          onTap: () {
                            Get.toNamed(AppRoutes.vendorNotificationScreen);
                          },
                          child: Stack(
                            clipBehavior: Clip.none,
                            children: [
                              Icon(
                                Icons.notifications,
                                size: 30,
                                color: AppColors.fieldColor,
                              ),

                              ///  BADGE
                              Obx(() {
                                final count = notificationController.unreadCount;

                                if (count == 0) return const SizedBox.shrink();

                                return Positioned(
                                  right: -2,
                                  top: -2,
                                  child: Container(
                                    height: 18,
                                    width: 18,
                                    decoration: BoxDecoration(
                                      shape: BoxShape.circle,
                                      color: Colors.indigo.shade900,
                                      border: Border.all(color: Colors.white, width: 1.5),
                                    ),
                                    child: Center(
                                      child: AppText(
                                        count > 9 ? "9+" : count.toString(),
                                        color: Colors.white,
                                        fontWeight: FontWeight.bold,
                                        fontSize: 10,
                                      ),
                                    ),
                                  ),
                                );
                              }),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  // Gap(1.h),
                  Container(
                    width: 100.w,
                    height: 19.h,
                    padding: const EdgeInsets.all(16),
                    margin: const EdgeInsets.symmetric(
                      horizontal: 16,
                      vertical: 12,
                    ),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(16),
                      border: BoxBorder.all(
                        color: Color(0xff137FEC).withOpacity(0.5),
                      ),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.08),
                          blurRadius: 12,
                          spreadRadius: 2,
                          offset: const Offset(0, 6),
                        ),
                      ],
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        AppText(
                          "Total Earnings",
                          fontSize: 20,
                          fontWeight: FontWeight.w600,
                          color: Colors.grey.shade500,
                        ),
                        const SizedBox(height: 8),
                        AppText(
                          "\$4,250",
                          fontSize: 32,
                          fontWeight: FontWeight.w700,
                          color: Colors.black,
                        ),

                        const SizedBox(height: 6),
                        Container(
                          width: 18.w,
                          height: 3.h,
                          decoration: BoxDecoration(
                            color: Colors.grey.shade200,
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: Center(
                            child: Row(
                              children: const [
                                Icon(
                                  Icons.keyboard_double_arrow_up_outlined,
                                  size: 18,
                                  color: Colors.green,
                                ),
                                SizedBox(width: 2),
                                Text(
                                  "+12%",
                                  style: TextStyle(
                                    fontSize: 14,
                                    fontWeight: FontWeight.w500,
                                    color: Colors.green,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Gap(1.h),
                  SizedBox(
                    width: 100.w,
                    height: 12.h,
                    child: ListView.builder(
                      scrollDirection: Axis.horizontal,
                      itemCount: vendorTile.length,
                      physics: NeverScrollableScrollPhysics(),
                      itemBuilder: (context, index) {
                        final data = vendorTile[index];
                        return VendorTilesWidgets(
                          onPressed: data.onPressed,
                          title: data.title,
                          iconData: data.iconData,
                          container_color: data.container_color,
                        );
                      },
                    ),
                  ),
                  Gap(1.h),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 8.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        AppText(
                          "New Request",
                          fontSize: 20,
                          fontWeight: FontWeight.w600,
                        ),
                        GestureDetector(
                          onTap: () {
                            Get.toNamed(AppRoutes.findNewOppurtunities);
                          },
                          child: AppText(
                            "See All",
                            fontSize: 14,
                            fontWeight: FontWeight.w500,
                            color: Colors.indigo.shade700,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Gap(1.h),
                  Obx(() {
                    final vendor = controller.vendor.value;

                    // Show loader while vendor data is being fetched
                    if (vendor == null) {
                      return const SizedBox(
                        height: 120,
                        child: Center(child: CircularProgressIndicator()),
                      );
                    }

                    return StreamBuilder<QuerySnapshot<Map<String, dynamic>>>(
                      stream: jobController.loadJobs(
                        vendor.serviceCategory?.trim().toLowerCase() ?? "",
                        vendor.location?.trim().toLowerCase() ?? "",
                      ),
                      builder: (context, jobSnap) {
                        if (jobSnap.connectionState ==
                            ConnectionState.waiting) {
                          return const SizedBox(
                            height: 120,
                            child: Center(child: CircularProgressIndicator()),
                          );
                        }

                        if (!jobSnap.hasData || jobSnap.data!.docs.isEmpty) {
                          return const SizedBox(
                            height: 120,
                            child: Center(child: Text("No new requests")),
                          );
                        }

                        final jobs = jobSnap.data!.docs
                            .map((doc) => VendorJobModel.fromMap(doc.data()))
                            .toList();

                        return SizedBox(
                          height: 40.h,
                          child: ListView.builder(
                            scrollDirection: Axis.horizontal,
                            itemCount: jobs.length,
                            itemBuilder: (context, index) {
                              final job = jobs[index];

                              return EventJobCard(
                                imagePath: AppAssets.wedding_reception2,
                                title: job.title,
                                location: job.city,
                                dateTime: job.eventDate,
                                onViewDetails: () {
                                  Get.toNamed(
                                    AppRoutes.submitApplications,
                                    arguments: job,
                                  );
                                },
                              );
                            },
                          ),
                        );
                      },
                    );
                  }),

                  Gap(1.h),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 12.0),
                    child: AppText(
                      "Active Jobs",
                      fontSize: 20,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  Gap(1.h),
                  SizedBox(
                    width: 100.w,
                    height: 32.h,
                    child: StreamBuilder(
                        stream: jobController.fetchAcceptedApplication() ,
                        builder: (context, snap){
                          if(snap.connectionState == ConnectionState.waiting){
                            return Center(child: CircularProgressIndicator(),);
                          }
                          if(!snap.hasData || snap.data!.docs.isEmpty){
                            return Center(child: AppText("Don't have active jobs yet"),);
                          }
                          if(snap.hasError){
                            return Center(child: AppText(snap.hasError.toString()),);
                          }
                          final data = snap.data!.docs;
                          return ListView.builder(
                            physics: NeverScrollableScrollPhysics(),
                            itemCount: data.length,
                            itemBuilder: (context, index) {
                              final snap_data = data[index];
                              return ActiveJobCard(
                                  eventName: snap_data["title"],
                                  eventDate: snap_data["eventDate"],
                                  eventLocation: snap_data["city"],
                                  imageUrl: AppAssets.wedding_reception2,
                                  onTap: (){
                                    Get.toNamed(AppRoutes.EventDayProgress,
                                    arguments: snap_data
                                    );

                                  });
                            },
                          );
                        })
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
