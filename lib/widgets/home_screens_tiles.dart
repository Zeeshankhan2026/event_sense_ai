import 'package:event_sense_ai/utils/app_colors.dart';
import 'package:event_sense_ai/widgets/apptext.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class DashboardTile extends StatelessWidget {
  final String label;
  final int count;
  final Color backgroundColor;
  final Color textColor;
  final String icon;
  final double size;
  final VoidCallback? onTap;

  const DashboardTile({
    Key? key,
    required this.label,
    required this.count,
    required this.icon,
    this.backgroundColor = const Color(0xFF2F6FED),
    this.textColor = Colors.white,
    this.size = 100,
    this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: size,
        height: size,
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
                  color: Colors.indigo,
                  borderRadius: BorderRadius.circular(20)
                ),
                child: Center(child: SvgPicture.asset(icon,width: 28,height: 26,))),
            AppText(
              "$count",
              fontSize: 28,
              fontWeight: FontWeight.w600,
              type: AppTextType.caption,
              color: AppColors.white,
              textAlign: TextAlign.center,
            ),
            AppText(
              label,
              type: AppTextType.caption,
              color: AppColors.white,
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
}
