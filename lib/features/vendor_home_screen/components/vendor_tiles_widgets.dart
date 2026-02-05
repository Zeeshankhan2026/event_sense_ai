import 'dart:ui';

import 'package:event_sense_ai/utils/app_colors.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:sizer/sizer.dart';

import '../../../core/widgets/apptext.dart';

class VendorTilesWidgets extends StatelessWidget {
  String title;
  Color? container_color;
  IconData? iconData;
  VoidCallback onPressed;

   VendorTilesWidgets({
     required this.onPressed,
    required this.title,
    required this.iconData,
    required this.container_color,
    super.key});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      splashColor: Colors.white,
      onTap: (){
        onPressed();
      },
      child: Container(
        margin: EdgeInsets.all(8),
        width: 28.w,
        height: 17.h,
        decoration: BoxDecoration(
         color:  AppColors.white,
          borderRadius: BorderRadius.circular(16),
          boxShadow: [
            BoxShadow(
              color: AppColors.black.withOpacity(0.09),
              blurRadius: 12,
              spreadRadius: 2,
              offset: const Offset(0, 6),
            ),
          ],
        ),

        child: Center(
          child: Column(
            children: [
              Gap(1.h),
              Container(
                // margin: EdgeInsets.all(10),
                width: 10.w,
                height: 5.h,
                decoration: BoxDecoration(
                  color: container_color,
                  // borderRadius: BorderRadius.circular(18),
                  shape: BoxShape.circle
                ),
                child: Icon(iconData),
              ),
              // Gap(1.h),
              AppText(title, fontSize: 15,fontWeight: FontWeight.w600,)
            ],
          ),
        ),
      ),
    );
  }
}
