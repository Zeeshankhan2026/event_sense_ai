import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:gap/gap.dart';
import 'package:sizer/sizer.dart';

import '../../../core/widgets/apptext.dart';

class EventInfoCard extends StatelessWidget {
  final String value;
  final String label;
  final String icon;
  final Color backgroundColor;
  final Color container_color;
  final Color textColor;

  const EventInfoCard({
    Key? key,
    required this.value,
    required this.container_color,
    required this.label,
    required this.icon,
    this.backgroundColor = const Color(0xFFF5F5F5),
    this.textColor = Colors.black,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 3.w),
      width: 25.w,
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: backgroundColor,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 4, offset: const Offset(0, 2),
          ), ], ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            height: 4.h,
            width: 8.w,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(4),
                color: container_color
            ),
            child: Center(child: SvgPicture.asset(icon,height: 20,)),
          ),
          Gap(1.h),
          AppText(value, color: textColor,type: AppTextType.bodyTextBold,),
          AppText(label, color: textColor.withOpacity(0.6),type: AppTextType.micro,),
        ], ), );
  }
}
