import 'package:event_sense_ai/utils/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:sizer/sizer.dart';

import '../../../core/widgets/apptext.dart';

class EventInfoTile extends StatelessWidget {
  final String label;
  final String value;
  final IconData icon;

  const EventInfoTile({
    super.key,
    required this.label,
    required this.value,
    required this.icon,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
          margin: EdgeInsets.all(12),
          width: 14.w,
          height: 7.h,
          decoration: BoxDecoration(
            color: AppColors.first_tile_color.withOpacity(0.4),
            borderRadius: BorderRadius.circular(12)
          ),
          child: Center(
            child: Icon(icon),
          ),
        ),
        Gap(1.w),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            AppText(label, fontSize: 14,fontWeight: FontWeight.w500,color: Colors.grey,),
            AppText(value, fontSize: 16,fontWeight: FontWeight.w600,color: Colors.indigo.shade900,),
          ],
        ),

      ],
    );
  }
}
