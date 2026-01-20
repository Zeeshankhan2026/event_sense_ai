import 'dart:ui';
import 'package:event_sense_ai/utils/app_icons.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:sizer/sizer.dart';

import '../../../core/widgets/apptext.dart';

class ServiceStatusCard extends StatelessWidget {
  final String title;
  final String status;
  final String estimate;
  final String actionLabel;
  final IconData icon;
  final Color statusColor;
  VoidCallback voidCallback;
   ServiceStatusCard({
    Key? key,
    required this.voidCallback,
    required this.title,
    required this.status,
    required this.estimate,
    required this.actionLabel,
    required this.icon,
    required this.statusColor,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(18),
        child: BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 12, sigmaY: 12),
          child: Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: Colors.white.withOpacity(0.85),
              borderRadius: BorderRadius.circular(18),
              border: Border.all(color: Colors.grey.withOpacity(0.2)),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.05),
                  blurRadius: 12,
                  offset: const Offset(0, 6),
                ),
              ],
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [

                /// Status Badge
                IntrinsicWidth(
                  child: Container(
                    padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                    height: 3.h,
                    decoration: BoxDecoration(
                      color: statusColor.withOpacity(0.15),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Container(
                          width: 8,
                          height: 8,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: statusColor,
                          ),
                        ),
                        const SizedBox(width: 6),
                        AppText(
                          status,
                          fontSize: 12,
                          fontWeight: FontWeight.w500,
                          maxLines: 1,
                          color: Colors.black87,
                        ),
                      ],
                    ),
                  ),
                ),

                const SizedBox(height: 12),

                /// Title + Icon
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    AppText(
                      title,
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                      color: Colors.black87,
                    ),
                    Container(
                      height: 5.h,
                      width: 11.w,
                      decoration: BoxDecoration(
                        color: statusColor.withOpacity(0.3),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Icon(icon, color: Colors.pinkAccent, size: 28),
                    ),
                  ],
                ),

                const SizedBox(height: 8),

                /// Estimate Row
                Row(
                  children: [
                    SvgPicture.asset(AppIcons.wallet_icon, color: Colors.grey),
                    const SizedBox(width: 6),
                    AppText(
                      ": $estimate",
                      fontSize: 12,
                      fontWeight: FontWeight.w400,
                      color: Colors.grey.shade700,
                    ),
                  ],
                ),

                const SizedBox(height: 12),

                /// Action Button
                SizedBox(
                  width: double.infinity,
                  child: OutlinedButton(
                    onPressed: voidCallback,
                    style: OutlinedButton.styleFrom(
                      side: BorderSide(color: Colors.grey.shade300),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                      padding: const EdgeInsets.symmetric(vertical: 14),
                      backgroundColor: Colors.white.withOpacity(0.2),
                    ),
                    child: AppText(
                      actionLabel,
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
                      color: Colors.black87,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
