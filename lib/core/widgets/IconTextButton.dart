import 'package:event_sense_ai/utils/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../utils/app_text.dart';

class IconTextButton extends StatelessWidget {
  final String label;
  final String icon;
  final Color? backgroundColor;
  final Color borderColor;
  final Color textColor;
  final double width;
  final double height;
  final VoidCallback? onPressed;

  const IconTextButton({
    Key? key,
    required this.label,
    required this.icon,
    this.backgroundColor,
    this.borderColor = Colors.white,
    this.textColor = Colors.black,
    this.width = 100,
    this.height = 70,
    this.onPressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onPressed,
      borderRadius: BorderRadius.circular(12),
      child: Container(
        width: width,
        height: height,
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: AppColors.white,
          boxShadow: [
            BoxShadow(
              color: AppColors.textGrey1,
              offset: Offset(0.5, 0.7)
            )
          ],
          border: Border.all(color: borderColor),
          borderRadius: BorderRadius.circular(12),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              width: 50,
                height: 90,
                decoration: BoxDecoration(
                  color: backgroundColor,
                  borderRadius: BorderRadius.circular(12)
                ),
                child: Center(child: SvgPicture.asset(icon))),
            const SizedBox(width: 8),
            AppText(label, type: AppTextType.captionPrimary,color: AppColors.black,)
          ],
        ),
      ),
    );
  }
}
