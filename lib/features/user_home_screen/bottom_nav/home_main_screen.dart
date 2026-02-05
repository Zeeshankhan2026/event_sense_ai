import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:event_sense_ai/core/controller/event_controller.dart';
import 'package:event_sense_ai/core/controller/user_controller.dart';
import 'package:event_sense_ai/core/models/event_model.dart';
import 'package:event_sense_ai/core/widgets/snackbar_widget.dart';
import 'package:event_sense_ai/utils/app_assets.dart';
import 'package:event_sense_ai/utils/app_icons.dart';
import 'package:event_sense_ai/features/user_home_screen/components/event_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:shimmer/shimmer.dart';
import 'package:sizer/sizer.dart';
import '../../../core/routes/app_routes.dart';
import '../../../core/widgets/IconTextButton.dart';
import '../../../core/widgets/app_buttons.dart';
import '../../../core/widgets/apptext.dart';
import '../../../core/widgets/custom_circle_avator.dart';
import '../../../utils/app_colors.dart';
import '../components/quick_access_card.dart';

class HomeMainScreen extends StatelessWidget {
  HomeMainScreen({super.key});

  final List<IconTextButton> iconTextButton = [
    IconTextButton(
      width: 110,
      height: 70,
      onPressed: () {},
      backgroundColor: Color(0xffCDEAF9),
      label: "Draft Invite",
      icon: AppIcons.draft_invite,
    ),
    IconTextButton(
      width: 100,
      height: 70,
      onPressed: () {},
      backgroundColor: Color(0xffFBE1CE),
      label: "Find Venue",
      icon: AppIcons.find_venue,
    ),
    IconTextButton(
      width: 100,
      height: 70,
      onPressed: () {},
      backgroundColor: Color(0xffD0F1DC),
      label: "Check Budget",
      icon: AppIcons.check_budget,
    ),
    IconTextButton(
      width: 100,
      height: 70,
      onPressed: () {},
      backgroundColor: Color(0xffEBDBFB),
      label: "Guest List",
      icon: AppIcons.guest_list,
    ),
  ];

  final controller = Get.find<EventController>();
  final userController = Get.find<UserController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          padding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
          child: StreamBuilder<QuerySnapshot>(
            stream: controller.allEventsStream(),
            builder: (context, eventSnap) {
              if (eventSnap.connectionState == ConnectionState.waiting) {
                return Shimmer(
                  gradient: LinearGradient(
                    begin: Alignment.centerLeft,
                    end: Alignment.centerRight,
                    colors: [
                      Colors.grey.shade300,
                      Colors.grey.shade100,
                      Colors.grey.shade300,
                    ],
                    stops: const [0.1, 0.5, 0.9],
                  ),
                  child: Row(
                    children: [
                      //  Avatar shimmer
                      Container(
                        width: 60,
                        height: 60,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: Colors.white,
                        ),
                      ),

                      const Gap(12),

                      // Text shimmer
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            width: 160,
                            height: 18,
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(6),
                            ),
                          ),

                          const Gap(8),

                          Container(
                            width: 120,
                            height: 12,
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(6),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                );
              }
              final eventData = eventSnap.data!.docs;
              final active_events = eventData.length;
              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Header
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Obx(() {
                        if (userController.isLoading.value == true) {
                          return Shimmer(
                            gradient: LinearGradient(
                              begin: Alignment.centerLeft,
                              end: Alignment.centerRight,
                              colors: [
                                Colors.grey.shade300,
                                Colors.grey.shade100,
                                Colors.grey.shade300,
                              ],
                              stops: const [0.1, 0.5, 0.9],
                            ),
                            child: Row(
                              children: [
                                //  Avatar shimmer
                                Container(
                                  width: 60,
                                  height: 60,
                                  decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                    color: Colors.white,
                                  ),
                                ),

                                const Gap(12),

                                // Text shimmer
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Container(
                                      width: 160,
                                      height: 18,
                                      decoration: BoxDecoration(
                                        color: Colors.white,
                                        borderRadius: BorderRadius.circular(6),
                                      ),
                                    ),

                                    const Gap(8),

                                    Container(
                                      width: 120,
                                      height: 12,
                                      decoration: BoxDecoration(
                                        color: Colors.white,
                                        borderRadius: BorderRadius.circular(6),
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          );
                        }
                        final users = userController.user.value;

                        if (users == null) {
                          return AppText("No user data");
                        }
                        return Row(
                          children: [
                            CustomCircleAvatar(
                              radius: 30,
                              imageUrl: users.profileImage,
                              assetImage: AppIcons.profile_icon,
                            ),
                            const Gap(5),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                AppText(
                                  users.name.toString(),
                                  fontSize: 18,
                                  fontWeight: FontWeight.w700,
                                  color: Colors.indigo.shade900,
                                ),
                                AppText(
                                  "You have $active_events Active Events Today.",
                                  type: AppTextType.caption,
                                  fontSize: 9,
                                ),
                              ],
                            ),
                          ],
                        );
                      }),
                      GestureDetector(
                        onTap: () {
                          Get.toNamed(AppRoutes.notificationScreen);
                        },
                        child: Stack(
                          children: [
                            Icon(
                              Icons.notifications,
                              size: 30,
                              color: AppColors.fieldColor,
                            ),
                            Positioned(
                              left: 12,
                              child: Container(
                                height: 22,
                                width: 18,
                                decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  border: BoxBorder.all(color: Colors.white),
                                  color: Colors.indigo.shade900,
                                ),
                                child: Center(
                                  child: AppText(
                                    "1",
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 11,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),

                  const Gap(20),

                  // Dashboard tiles
                  SizedBox(
                    height: 125,
                    width: 100.w,
                    child: Row(
                      children: [
                        GestureDetector(
                          onTap: () {},
                          child: Container(
                            width: 110,
                            height: 125,
                            padding: const EdgeInsets.all(12),
                            decoration: BoxDecoration(
                              color: Color(0xFF96A2D5).withOpacity(0.3),
                              borderRadius: BorderRadius.circular(12),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.grey.shade200,
                                  blurRadius: 3,
                                  offset: Offset(2, 7),
                                ),
                              ],
                            ),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Container(
                                  width: 40,
                                  height: 40,
                                  decoration: BoxDecoration(
                                    color: Colors.indigo,
                                    borderRadius: BorderRadius.circular(20),
                                  ),
                                  child: Center(
                                    child: SvgPicture.asset(
                                      AppIcons.calender_icon,
                                      color: Colors.white,
                                      width: 28,
                                      height: 26,
                                    ),
                                  ),
                                ),
                                AppText(
                                  active_events.toString(),
                                  type: AppTextType.heading1Normal,
                                  color: Colors.indigo,
                                ),
                                AppText(
                                  "Active events",
                                  type: AppTextType.caption,
                                  color: AppColors.black,
                                  textAlign: TextAlign.center,
                                ),
                              ],
                            ),
                          ),
                        ),
                        Gap(10),
                        GestureDetector(
                          onTap: () {},
                          child: Container(
                            width: 110,
                            height: 125,
                            padding: const EdgeInsets.all(12),
                            decoration: BoxDecoration(
                              color: Color(0xFF3C9C5F).withOpacity(0.5),
                              borderRadius: BorderRadius.circular(12),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.grey.shade200,
                                  blurRadius: 3,
                                  offset: Offset(2, 7),
                                ),
                              ],
                            ),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Container(
                                  width: 40,
                                  height: 40,
                                  decoration: BoxDecoration(
                                    color: Colors.green,
                                    borderRadius: BorderRadius.circular(20),
                                  ),
                                  child: Center(
                                    child: SvgPicture.asset(
                                      AppIcons.people_icon,
                                      color: Colors.white,
                                      width: 28,
                                      height: 26,
                                    ),
                                  ),
                                ),
                                AppText(
                                  "85",
                                  type: AppTextType.heading1Normal,
                                  color: Color(0xFF3C9C5F),
                                ),
                                AppText(
                                  "Confirm",
                                  type: AppTextType.caption,
                                  color: AppColors.black,
                                  textAlign: TextAlign.center,
                                ),
                              ],
                            ),
                          ),
                        ),
                        Gap(20),
                        GestureDetector(
                          onTap: () {},
                          child: Container(
                            width: 110,
                            height: 125,
                            padding: const EdgeInsets.all(12),
                            decoration: BoxDecoration(
                              color: Color(0xFF8896B6).withOpacity(0.5),
                              borderRadius: BorderRadius.circular(12),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.grey.shade200,
                                  blurRadius: 3,
                                  offset: Offset(2, 7),
                                ),
                              ],
                            ),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Container(
                                  width: 40,
                                  height: 40,
                                  decoration: BoxDecoration(
                                    color: Color(0xFF8896B6),
                                    borderRadius: BorderRadius.circular(20),
                                  ),
                                  child: Center(
                                    child: SvgPicture.asset(
                                      AppIcons.calender_icon,
                                      width: 28,
                                      height: 26,
                                    ),
                                  ),
                                ),
                                AppText(
                                  "07",
                                  type: AppTextType.heading1Normal,
                                  color: AppColors.primary,
                                ),
                                AppText(
                                  "Vendors",
                                  type: AppTextType.caption,
                                  color: AppColors.black,
                                  textAlign: TextAlign.center,
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  const Gap(10),

                  // Upcoming events header
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      AppText(
                        "Upcoming Events",
                        fontSize: 18,
                        fontWeight: FontWeight.w600,
                        color: Colors.black87,
                      ),
                      GestureDetector(
                        onTap: () {
                          Get.toNamed(AppRoutes.events);
                        },
                        child: AppText(
                          "See all",
                          fontSize: 14,
                          fontWeight: FontWeight.w700,
                          color: Colors.indigo.shade900,
                        ),
                      ),
                    ],
                  ),
                  // Upcoming events list
                  Container(
                    margin: const EdgeInsets.symmetric(vertical: 6),
                    padding: const EdgeInsets.all(8),
                    height: 25.h,
                    width: 100.w,
                    child: eventData.isEmpty
                        ? Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const AppText(
                          "You don't have any event yet",
                          type: AppTextType.heading4,
                          textAlign: TextAlign.center,
                        ),
                        Gap(2.h),
                        AppButtonWidget(
                          onPressed: () => Get.toNamed(AppRoutes.createEvent),
                          prefixIcon: const Icon(Icons.add, color: Colors.white, size: 30),
                          text: "Event",
                          width: 30.w,
                          height: 6.h,
                          buttonColor: AppColors.fieldColor,
                          fontSize: 14,
                          fontWeight: FontWeight.w600,
                        ),
                      ],
                    )
                        : ListView.builder(
                      scrollDirection: Axis.horizontal,
                      itemCount: eventData.length,
                      padding: const EdgeInsets.symmetric(horizontal: 12),
                      itemBuilder: (context, index) {
                        final event = eventData[index];

                        return GestureDetector(
                          onTap: () {
                            final eventModel = EventModel.fromJson(
                              event.data() as Map<String, dynamic>,
                              event.id,
                            );
                            Get.toNamed(
                              AppRoutes.eventDetails,
                              arguments: eventModel,
                            );
                          },
                          child: EventCard(
                            title: event["eventName"],
                            peoples_image: AppIcons.people_icon,
                            wallet: AppIcons.wallet_icon,
                            calender_image: AppIcons.calender_icon,
                            location_icon: AppIcons.location_icon,
                            date: event["eventStartDate"],
                            location: event["eventLocation"],
                            imagePath: AppAssets.wedding_reception2,
                            attendees: int.tryParse(event["guestCount"].toString()) ?? 0,
                            cost: event["eventBudget"],
                            countdown: calculateDaysLeft(
                              event["eventStartDate"],
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                  AppText(
                    "AI Assistant",
                    fontSize: 18,
                    fontWeight: FontWeight.w600,
                    color: Colors.black87,
                  ),
                  Gap(1.h),
                  SizedBox(
                    height: 18.h,
                    child: GridView(
                      physics: NeverScrollableScrollPhysics(),
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        mainAxisSpacing: 8,
                        crossAxisSpacing: 8,
                        childAspectRatio: 3,
                        crossAxisCount: 2,
                      ),
                      children: [
                        InkWell(
                          onTap: () {
                            if (eventData.isNotEmpty) {
                              final eventModel = EventModel.fromJson(
                                eventData[0].data() as Map<String, dynamic>,
                                eventData[0].id,
                              );
                              Get.toNamed(AppRoutes.createInvitaionCardDesign,
                                  arguments: eventModel);
                            } else {
                              SafeSnackbar.info(
                                  "Notice", "Please create an event first");
                            }
                          },
                          borderRadius: BorderRadius.circular(12),
                          child: Container(
                            padding: const EdgeInsets.all(12),
                            decoration: BoxDecoration(
                              color: AppColors.white,
                              boxShadow: [
                                BoxShadow(
                                  color: AppColors.textGrey1,
                                  offset: Offset(0.5, 0.7),
                                ),
                              ],
                              border: Border.all(color: Color(0xffCDEAF9)),
                              borderRadius: BorderRadius.circular(12),
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Container(
                                  width: 40,
                                  height: 90,
                                  decoration: BoxDecoration(
                                    color: Color(0xffCDEAF9).withOpacity(0.8),
                                    borderRadius: BorderRadius.circular(12),
                                  ),
                                  child: Center(
                                    child: SvgPicture.asset(
                                      AppIcons.draft_invite,
                                    ),
                                  ),
                                ),
                                const SizedBox(width: 8),
                                AppText(
                                  "Draft Invite",
                                  fontWeight: FontWeight.w600,
                                  fontSize: 14,
                                ),
                              ],
                            ),
                          ),
                        ),
                        InkWell(
                          onTap: () {},

                          borderRadius: BorderRadius.circular(12),
                          child: Container(
                            padding: const EdgeInsets.all(12),
                            decoration: BoxDecoration(
                              color: AppColors.white,
                              boxShadow: [
                                BoxShadow(
                                  color: AppColors.textGrey1,
                                  offset: Offset(0.5, 0.7),
                                ),
                              ],
                              border: Border.all(color: Color(0xffCDEAF9)),
                              borderRadius: BorderRadius.circular(12),
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Container(
                                  width: 40,
                                  height: 90,
                                  decoration: BoxDecoration(
                                    color: Color(0xffF97316).withOpacity(0.3),
                                    borderRadius: BorderRadius.circular(12),
                                  ),
                                  child: Center(
                                    child: SvgPicture.asset(
                                      AppIcons.find_venue,
                                    ),
                                  ),
                                ),
                                const SizedBox(width: 8),
                                AppText(
                                  "Find Venue",
                                  fontWeight: FontWeight.w600,
                                  fontSize: 14,
                                ),
                              ],
                            ),
                          ),
                        ),
                        InkWell(
                          onTap: () {
                            if (eventData.isNotEmpty) {
                              final eventModel = EventModel.fromJson(
                                eventData[0].data() as Map<String, dynamic>,
                                eventData[0].id,
                              );
                              Get.toNamed(AppRoutes.budgetBreakdown,
                                  arguments: eventModel);
                            } else {
                              SafeSnackbar.info(
                                  "Notice", "Please create an event first");
                            }
                          },

                          borderRadius: BorderRadius.circular(12),
                          child: Container(
                            padding: const EdgeInsets.all(12),
                            decoration: BoxDecoration(
                              color: AppColors.white,
                              boxShadow: [
                                BoxShadow(
                                  color: AppColors.textGrey1,
                                  offset: Offset(0.5, 0.7),
                                ),
                              ],
                              border: Border.all(color: Color(0xffCDEAF9)),
                              borderRadius: BorderRadius.circular(12),
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Container(
                                  width: 40,
                                  height: 90,
                                  decoration: BoxDecoration(
                                    color: Color(0xff22C75E).withOpacity(0.3),
                                    borderRadius: BorderRadius.circular(12),
                                  ),
                                  child: Center(
                                    child: SvgPicture.asset(
                                      AppIcons.check_budget,
                                    ),
                                  ),
                                ),
                                const SizedBox(width: 8),
                                AppText(
                                  "Check Budget",
                                  fontWeight: FontWeight.w600,
                                  fontSize: 14,
                                ),
                              ],
                            ),
                          ),
                        ),
                        InkWell(
                          onTap: () {
                          Get.toNamed(AppRoutes.GuestManagementScreen);
                          },

                          borderRadius: BorderRadius.circular(12),
                          child: Container(
                            padding: const EdgeInsets.all(12),
                            decoration: BoxDecoration(
                              color: AppColors.white,
                              boxShadow: [
                                BoxShadow(
                                  color: AppColors.textGrey1,
                                  offset: Offset(0.5, 0.7),
                                ),
                              ],
                              border: Border.all(color: Color(0xffCDEAF9)),
                              borderRadius: BorderRadius.circular(12),
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Container(
                                  width: 40,
                                  height: 90,
                                  decoration: BoxDecoration(
                                    color: Color(0xffA855F7).withOpacity(0.3),
                                    borderRadius: BorderRadius.circular(12),
                                  ),
                                  child: Center(
                                    child: SvgPicture.asset(
                                      AppIcons.guest_list,
                                    ),
                                  ),
                                ),
                                const SizedBox(width: 8),
                                AppText(
                                  "Guest List",
                                  fontWeight: FontWeight.w600,
                                  fontSize: 14,
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  AppText(
                    "Quick Access",
                    fontSize: 18,
                    fontWeight: FontWeight.w600,
                    color: Colors.black87,
                  ),

                  Gap(8),
                  GestureDetector(
                    onTap: () {
                      Get.toNamed(AppRoutes.vendersManagement);
                    },
                    child: QuickAccessCard(
                      title: "Vendors Management",
                      height: 50,
                      width: 800,
                      bg_color: AppColors.fieldColor,

                      radius: 12,
                      prefix_icon: AppIcons.vendors,
                      suffix_icon: AppIcons.right_arrow,
                    ),
                  ),
                  Gap(8),
                  GestureDetector(
                    onTap: () {
                      Get.toNamed(AppRoutes.guestList);
                    },
                    child: QuickAccessCard(
                      title: "Guest Management",
                      height: 50,
                      width: 800,
                      bg_color: AppColors.second_tile_color,
                      text_color: AppColors.second_tile_color,
                      radius: 12,
                      prefix_icon: AppIcons.guests,
                      suffix_icon: AppIcons.right_arrow,
                    ),
                  ),
                ],
              );
            },
          ),
        ),
      ),
    );
  }

  String calculateDaysLeft(dynamic startDate) {
    if (startDate == null) return "Date nahi hai";

    DateTime eventDate;

    // Timestamp
    if (startDate is Timestamp) {
      eventDate = startDate.toDate();
    }
    // String format: dd/MM/yyyy
    else if (startDate is String) {
      try {
        final parts = startDate.split('/');
        if (parts.length != 3) return "Invalid date";

        final day = int.parse(parts[0]);
        final month = int.parse(parts[1]);
        final year = int.parse(parts[2]);

        eventDate = DateTime(year, month, day);
      } catch (e) {
        return "Invalid date";
      }
    } else {
      return "Invalid date";
    }

    //  Sirf date compare (time ignore)
    final now = DateTime.now();
    final todayDate = DateTime(now.year, now.month, now.day);
    final eventOnlyDate = DateTime(
      eventDate.year,
      eventDate.month,
      eventDate.day,
    );

    final difference = eventOnlyDate.difference(todayDate).inDays;

    if (difference < 0) {
      return "Event passed";
    } else if (difference == 0) {
      return "Today";
    } else {
      return "$difference days";
    }
  }
}
