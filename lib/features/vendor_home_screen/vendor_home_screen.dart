import 'package:event_sense_ai/features/user_home_screen/components/event_card.dart';
import 'package:event_sense_ai/utils/app_assets.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';
import 'package:sizer/sizer.dart';

import '../../core/routes/app_routes.dart';
import '../../core/widgets/app_buttons.dart';
import '../../core/widgets/apptext.dart';
import '../../utils/app_colors.dart';
import 'components/active_jobs_widget.dart';
import 'components/vendor_tiles_widgets.dart';

class VendorHomeScreen extends StatelessWidget {
  VendorHomeScreen({super.key});

  List<EventCard> eventCardList = [
    EventCard(
      imagePath: AppAssets.wedding_reception2,
      date: "Nov 12 / 6:00 PM",
      title: "Wedding Receion:n",
      location: "San Francisco, CA",
      onTap: () {
        print("View Details tapped");
      },
      peoples_image: "",
      wallet: '',
      calender_image: '',
      location_icon: '',

      attendees: 34,
      cost: 453,
      countdown: '23',
    ),
    EventCard(
      imagePath: AppAssets.wedding_reception2,
      date: "Nov 12 / 6:00 PM",
      title: "Wedding Receion:n",
      location: "San Francisco, CA",
      onTap: () {
        print("View Details tapped");
      },
      peoples_image: '',
      wallet: '',
      calender_image: '',
      location_icon: '',

      attendees: 34,
      cost: 453,
      countdown: '23',
    ),
  ];

  List<ActiveJobReusable> activeJobWidget = [
    ActiveJobReusable(
      location: "San Francisco, CA",
      title: "Miller Wedding",
      datetime: "Nov 12 / 6:00 PM",
      ImagePath: AppAssets.activeJob_image,
    ),
    ActiveJobReusable(
      location: "San Francisco, CA",
      title: "Miller Wedding",
      datetime: "Nov 12 / 6:00 PM",
      ImagePath: AppAssets.activeJob_image,
    ),
  ];
  @override
  Widget build(BuildContext context) {
    List<VendorTilesWidgets> vendorTile = [
      VendorTilesWidgets(
        onPressed: () {
          context.pushNamed(AppRoutes.FindNewOppurtunities);
        },
        title: "Find Job",
        iconData: Icons.search_outlined,
        container_color: Colors.greenAccent.shade100,
      ),
      VendorTilesWidgets(
        onPressed: () {
          context.pushNamed(AppRoutes.VendorMessageScreen);
        },
        title: "Message",
        iconData: Icons.message_outlined,
        container_color: Colors.redAccent.shade100,
      ),
      VendorTilesWidgets(
        onPressed: () {
          context.pushNamed(AppRoutes.VendorProfileScreeen);
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
                        Row(
                          children: [
                            // Profile Image
                            Container(
                              width: 48,
                              height: 48,
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.black.withOpacity(0.1),
                                    blurRadius: 8,
                                    offset: const Offset(0, 4),
                                  ),
                                ],
                              ),
                              child: ClipOval(
                                child: Image.asset(
                                  AppAssets
                                      .vendor_profile, // Replace with actual image
                                  fit: BoxFit.cover,
                                ),
                              ),
                            ),
                            const SizedBox(width: 12),
                            // Text
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: const [
                                Text(
                                  "Welcome Back",
                                  style: TextStyle(
                                    fontSize: 13,
                                    color: Colors.grey,
                                  ),
                                ),
                                Text(
                                  "Sarah Jenkins",
                                  style: TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.black87,
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),

                        // Notification Bell with Dot
                        GestureDetector(
                          onTap: (){
                            context.pushNamed(AppRoutes.VendorNotificationScreen);
                          },
                          child: Stack(
                            children: [
                              const Icon(
                                Icons.notifications_none,
                                size: 28,
                                color: Colors.indigo,
                              ),
                              Positioned(
                                top: -1,
                                right: 2,
                                child: Container(
                                  width: 18,
                                  height: 20,
                                  decoration:  BoxDecoration(
                                    color: Colors.indigo.shade900,
                                    shape: BoxShape.circle,
                                  ),
                                  child: Center(child: AppText("0",color: Colors.white,), ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  // Gap(1.h),
                  Container(
                    width: 100.w,
                    height: 18.h,
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
                          onTap: (){
                            context.pushNamed(AppRoutes.NewRequestDetails);
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
                  SizedBox(
                    height: 45.h,
                    child: ListView.builder(
                      itemCount: eventCardList.length,
                      scrollDirection: Axis.horizontal,
                      itemBuilder: (context, index) {
                        final event_card_data = eventCardList[index];
                        return SizedBox(
                          width: 80.w,
                          child: Container(
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
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Stack(
                                  children: [
                                    Container(
                                      width: 80.w,
                                      height: 25.h,

                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(12),
                                        image: DecorationImage(
                                          image: AssetImage(
                                            event_card_data.imagePath,
                                          ),
                                          fit: BoxFit.cover,
                                        ),
                                      ),
                                    ),
                                    Positioned(
                                      top: 12,
                                      left: 33.w,
                                      child: Container(
                                        padding: EdgeInsets.symmetric(
                                          horizontal: 12,
                                          vertical: 3,
                                        ),
                                        decoration: BoxDecoration(
                                          color: Colors.grey.shade200,
                                          borderRadius: BorderRadius.circular(12),
                                        ),
                                        width: 33.w,
                                        height: 3.h,
                                        child: AppText(
                                          event_card_data.date,
                                          type: AppTextType.caption,color: Colors.black,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                                Gap(1.h),
                                Padding(
                                  padding: const EdgeInsets.symmetric(
                                    horizontal: 8.0,
                                  ),
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      AppText(
                                        "Wedding Reception",
                                        fontSize: 16,
                                        fontWeight: FontWeight.w700,
                                      ),
                                      Gap(1.h),
                                      Row(
                                        children: [
                                          Icon(Icons.location_on_outlined,color: Colors.indigo.shade700,),
                                          AppText(
                                            event_card_data.location,
                                            fontWeight: FontWeight.w600,
                                            fontSize: 12,
                                            color: Colors.indigo.shade700,
                                          ),
                                        ],
                                      ),
                                      Gap(1.h),
                                      AppButtonWidget(
                                        onPressed: () {
                                          context.pushNamed(
                                            AppRoutes.NewRequestDetails,
                                          );
                                        },
                                        width: 70.w,
                                        height: 6.h,
                                        fontSize: 16,
                                        fontWeight: FontWeight.w600,
                                        buttonColor: AppColors.fieldColor
                                            .withOpacity(0.9),
                                        text: "View Details",
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        );
                      },
                    ),
                  ),
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
                    child: ListView.builder(
                      itemCount: activeJobWidget.length,
                      itemBuilder: (context, index) {
                        final active_jobevent = activeJobWidget[index];
                        return Container(
                          margin: EdgeInsets.all(8),
                          padding: EdgeInsets.all(8),
                          width: 100.w,
                          height: 14.h,
                          decoration: BoxDecoration(
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black.withOpacity(0.08),
                                blurRadius: 12,
                                spreadRadius: 2,
                                offset: const Offset(0, 6),
                              ),
                            ],
                            border: BoxBorder.all(color: Colors.grey.shade300),
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: Row(
                            children: [
                              Container(
                                width: 30.w,
                                height: 40.h,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(20),
                                  image: DecorationImage(
                                    image: AssetImage(AppAssets.activeJob_image),
                                    fit: BoxFit.cover,
                                  ),
                                ),
                              ),
                              Gap(2.w),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Gap(1.w),
                                  AppText(
                                    active_jobevent.title.toString(),
                                    fontWeight: FontWeight.w600,
                                    fontSize: 20,
                                  ),
                                  Gap(1.w),
                                  Row(
                                    children: [
                                      Icon(
                                        Icons.calendar_today_outlined,
                                        size: 22,
                                      ),
                                      Gap(1.w),
                                      AppText(
                                        active_jobevent.datetime.toString(),
                                        fontWeight: FontWeight.bold,
                                        fontSize: 10,
                                        color: Colors.black54,
                                      ),
                                    ],
                                  ),
                                  Gap(1.w),
                                  Row(
                                    children: [
                                      Icon(Icons.location_on_outlined, size: 22),
                                      Gap(1.w),
                                      AppText(
                                        active_jobevent.location.toString(),
                                        fontWeight: FontWeight.bold,
                                        fontSize: 10,
                                        color: Colors.black54,
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                              Spacer(),
                              GestureDetector(
                                onTap: () {
                                  context.pushNamed(AppRoutes.ActiveEvent);
                                },
                                child: Container(
                                  width: 14.w,
                                  height: 6.h,

                                  decoration: BoxDecoration(
                                    color: AppColors.first_tile_color.withOpacity(
                                      0.5,
                                    ),
                                    borderRadius: BorderRadius.circular(26),
                                  ),
                                  child: Center(
                                    child: Icon(Icons.arrow_forward_rounded),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        );
                      },
                    ),
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
