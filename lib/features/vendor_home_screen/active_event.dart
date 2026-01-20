import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';
import 'package:sizer/sizer.dart';

import '../../core/routes/app_routes.dart';
import '../../core/widgets/app_buttons.dart';
import '../../core/widgets/apptext.dart';
import '../../core/widgets/custom_headerbar.dart';
import '../../utils/app_assets.dart';
import '../../utils/app_colors.dart';
import 'components/status_tile_widget.dart';

class ActiveEvent extends StatefulWidget {
  const ActiveEvent({super.key});

  @override
  State<ActiveEvent> createState() => _ActiveEventState();
}

class _ActiveEventState extends State<ActiveEvent> {

  int selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 12),
          child: Column(
            children: [
              CustomHeaderBar(title: "Event Day Progress",showBackButton: true,onBack: (){
                context.pop();
              },),
              Gap(2.h),
        Container(
          height: 15.h,
          width: 100.w,
          margin: const EdgeInsets.all(8),
          padding: const EdgeInsets.all(8),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(12),
            border: Border.all(color: Colors.grey.shade300),
            boxShadow: [
              BoxShadow(
                color: Colors.grey.withOpacity(0.08),
                blurRadius: 6,
                spreadRadius: 2,
                offset: const Offset(0, 6),
              ),
            ],
          ),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              /// LEFT SIDE - TEXT
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 10,
                        vertical: 4,
                      ),
                      decoration: BoxDecoration(
                        color: Color(0xff3C9C5F).withOpacity(0.1),
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: AppText(
                        "Live Now",
                        fontWeight: FontWeight.w500,
                        fontSize: 10,
                        color: Colors.redAccent,
                      ),
                    ),

                    Gap(2.h),

                    AppText(
                      "Professional Wedding DJ",
                      fontWeight: FontWeight.w600,
                      fontSize: 16,
                    ),

                    Gap(2.h),

                    Row(
                      children: [
                        const Icon(
                          Icons.calendar_month_outlined,
                          size: 16,
                          color: Colors.blueGrey,
                        ),

                     Gap(1.w),
                        AppText(
                          "July 24th . The Grand Hall",
                          fontWeight: FontWeight.w800,
                          fontSize: 12,
                          color: Colors.black54,
                        ),
                      ],
                    ),
                  ],
                ),
              ),

              const SizedBox(width: 12),

              /// RIGHT SIDE - IMAGE
              ClipRRect(
                borderRadius: BorderRadius.circular(14),
                child: Image.asset(
                  AppAssets.wedding_reception2,
                  height: 12.h,
                  width: 30.w,
                  fit: BoxFit.cover,
                ),
              ),
            ],
          ),
        ),

        Column(
                children: [
                  Gap(2.h),
                  AppText(
                    "Update Your Status",
                    fontSize: 24,
                    fontWeight: FontWeight.w700,
                  ),
                  Gap(1.h),
                  AppText(
                    "Tap to notify the planner automatically. our AI will handle the communication.",
                    textAlign: TextAlign.center,
                    fontSize: 14,
                    fontWeight: FontWeight.w400,
                    color: Colors.grey,
                  ),
                ],
              ),
              Gap(2.h),
      Column(
        children: [
          StatusTile(
            isSelected: selectedIndex == 0,
            containerColor: const Color(0xff3C9C5F).withOpacity(0.4),
            icon: Icons.control_point,
            iconColor: Colors.green,
            title: "On the Way",
            subtitle: "Estimated arrival: 1:45 PM",
            statusLabel: "Sent",
            statusColor: Colors.green,
            onTap: () {
              setState(() => selectedIndex = 0);
            },
          ),

          const SizedBox(height: 12),

          StatusTile(
            isSelected: selectedIndex == 1,
            containerColor: const Color(0xff1B2A57).withOpacity(0.2),
            icon: Icons.location_on_outlined,
            iconColor: Colors.blue,
            title: "Arrived",
            subtitle: "Tap to confirm arrival at venue",
            onTap: () {
              setState(() => selectedIndex = 1);
            },
          ),

          const SizedBox(height: 12),

          StatusTile(
            isSelected: selectedIndex == 2,
            containerColor: const Color(0xffE0E0E0).withOpacity(0.4),
            icon: Icons.check_circle_outline,
            iconColor: Colors.grey,
            title: "Setup Completed",
            subtitle: "Mark when ready for guest",
            onTap: () {
              setState(() => selectedIndex = 2);
            },
          ),
        ],
      ),
              Spacer(),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  AppButtonWidget(
                    width: 28.w,
                    height: 6.h,
                    onPressed: () {
                      // context.goNamed(AppRoutes.VendorSetLocation);
                    },
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                    buttonColor: Colors.deepOrangeAccent.shade100
                        .withOpacity(0.9),
                    text: "Contact",
                  ),
                  AppButtonWidget(
                    onPressed: () {
                     context.pushNamed(AppRoutes.FinishActiveEvents);
                    },
                    width: 65.w,
                    height: 6.h,
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                    buttonColor: AppColors.fieldColor.withOpacity(0.6)
                        .withOpacity(0.9),
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
