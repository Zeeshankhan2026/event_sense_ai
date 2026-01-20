import 'package:event_sense_ai/utils/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../../core/widgets/apptext.dart';

class DashboardTile extends StatelessWidget {
  final String label;
  final int count;
  final Color backgroundColor;
  final Color containerColor;
  final Color textColor;
  final String icon;
  final double width;
  final double height;
  final VoidCallback? onTap;

  const DashboardTile({
    Key? key,
    required this.containerColor,
    required this.label,
    required this.count,
    required this.icon,
    this.backgroundColor = const Color(0xFF2F6FED),
    this.textColor = Colors.white,
    required this.width,
    required this.height,
    this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: width,
        height: height,
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: backgroundColor,
          borderRadius: BorderRadius.circular(12),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Container(
              width: 40,
                height: 40,
                decoration: BoxDecoration(
                  color: containerColor,
                  borderRadius: BorderRadius.circular(20)
                ),
                child: Center(child: SvgPicture.asset(icon,width: 28,height: 26,))),
            AppText(
              "$count",
              type: AppTextType.heading1Normal,
              color: textColor,
            ),
            AppText(
              label,
              type: AppTextType.caption,
              color: AppColors.black,
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
}
