import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:sizer/sizer.dart';

import '../../../core/widgets/app_buttons.dart';
import '../../../core/widgets/apptext.dart';
import '../../../utils/app_colors.dart';

class EventJobCard extends StatelessWidget {
  final String imagePath;
  final String title;
  final String location;
  final String dateTime;
  final VoidCallback onViewDetails;

  const EventJobCard({
    super.key,
    required this.imagePath,
    required this.title,
    required this.location,
    required this.dateTime,
    required this.onViewDetails,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 80.w,
      height: 35.h,
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
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
            /// IMAGE + DATE BADGE
            Stack(
              children: [
                Container(
                  width: 80.w,
                  height: 20.h,
                  decoration: BoxDecoration(
                    borderRadius: const BorderRadius.vertical(
                      top: Radius.circular(16),
                    ),
                    image: DecorationImage(
                      image: AssetImage(imagePath),
                      fit: BoxFit.cover,
                    ),
                  ),
                ),

                Positioned(
                  top: 12,
                  right: 12,
                  child: Container(
                    padding:
                    const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                    decoration: BoxDecoration(
                      color: Colors.white.withOpacity(0.9),
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: AppText(
                      dateTime,
                      fontSize: 12,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ],
            ),

            Gap(1.5.h),

            /// DETAILS
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 14),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  AppText(
                    title,
                    fontSize: 16,
                    fontWeight: FontWeight.w700,
                  ),
                  Gap(0.8.h),

                  Row(
                    children: [
                      Icon(
                        Icons.location_on_outlined,
                        size: 18,
                        color: Colors.indigo.shade700,
                      ),
                      Gap(0.5.w),
                      AppText(
                        location,
                        fontSize: 12,
                        fontWeight: FontWeight.w600,
                        color: Colors.indigo.shade700,
                      ),
                    ],
                  ),

                  Gap(1.5.h),

                  AppButtonWidget(
                    onPressed: onViewDetails,
                    width: 70.w,
                    height: 6.h,
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                    buttonColor: AppColors.fieldColor.withOpacity(0.9),
                    text: "Apply",
                  ),
                ],
              ),
            ),

            Gap(1.5.h),
          ],
        ),
      ),
    );
  }
}
