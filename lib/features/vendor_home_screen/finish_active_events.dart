
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';
import 'package:sizer/sizer.dart';

import '../../core/routes/app_routes.dart';
import '../../core/widgets/app_buttons.dart';
import '../../core/widgets/apptext.dart';
import '../../core/widgets/custom_headerbar.dart';
import '../../utils/app_colors.dart';

class FinishActiveEvents extends StatelessWidget {
  const FinishActiveEvents({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 12),
          child: Column(
            children: [
            CustomHeaderBar(title: "Vendors Applications", showBackButton: true,onBack: (){
              context.pop();
            },),
              Gap(1.h),
              Container(
                width: 100.w,
                height: 80.h,
                margin: const EdgeInsets.symmetric( vertical: 20),
                padding: const EdgeInsets.all(20),
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
                    Align(
                      alignment: Alignment.center,
                      child:  const Icon(Icons.check_circle, size: 64, color: Colors.green),

                    ),
                    Gap(2.h),
                    AppText("Your Job is Completed",fontSize: 28,fontWeight: FontWeight.w700,color: Colors.black54,),
                    Gap(1.h),
                    AppText( "Great work! The event Wedding Reception 2025 is now Closed",
                      fontSize: 14,fontWeight: FontWeight.w400,color: Colors.grey,textAlign: TextAlign.center,
                    ),

                    Gap(4.h),
                    // Status Rows
                    const StatusRow(
                      icon: Icons.event_available,
                      label: "Event Done",
                      message: "Contract Fulfilled Successfully",
                      iconColor: Colors.green,
                    ),
                Container( width: 1.5, height: 60,  color: Colors.grey,
                  margin: const EdgeInsets.symmetric(horizontal: 12), ),
                    const StatusRow(
                      icon: Icons.alarm,
                      label: "Review Pending",
                      message: "Waiting for Planner Feedback",
                      iconColor: Colors.orange,
                    ),
                     Gap(5.h),

                    // Back Button
                    AppButtonWidget(
                      onPressed: () {
                        context.goNamed(AppRoutes.VendorHomeScreen);
                      },
                      width: 80.w,
                      height: 6.h,
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                      buttonColor: AppColors.fieldColor
                          .withOpacity(0.9),
                      text: 'Back to Dashboard',),
                  ],
                ),
              )

            ],
          ),
        ),
      ),
    );
  }
}

class StatusRow extends StatelessWidget {
  final IconData icon;
  final String label;
  final String message;
  final Color iconColor;

  const StatusRow({
    super.key,
    required this.icon,
    required this.label,
    required this.message,
    required this.iconColor,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Icon(icon, color: iconColor, size: 24),
        const SizedBox(width: 12),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(label,
                style: const TextStyle(
                    fontSize: 14, fontWeight: FontWeight.bold)),
            const SizedBox(height: 2),
            Text(message, style: const TextStyle(fontSize: 13, color: Colors.grey)),
          ],
        ),
      ],
    );
  }
}
