import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:sizer/sizer.dart';

import '../../utils/app_text.dart';

class CustomHeaderBar extends StatelessWidget {
  final String title;
  final String? subtitle;
  final bool showBackButton;
  final VoidCallback? onBack;

  const CustomHeaderBar({
    super.key,
    required this.title,
    this.subtitle,
    this.showBackButton = false,
    this.onBack,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (showBackButton)
            IconButton(
              icon: const Icon(Icons.arrow_back_ios, size: 20),
              onPressed: onBack ?? () => Navigator.pop(context),
            ),
          if (!showBackButton) const SizedBox(width: 8),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Gap(1.h),
                AppText( title,fontSize: 20,
                  fontWeight: FontWeight.w700,
                  color: Color(0xff1A2B4C),),
                if (subtitle != null)
                  const SizedBox(height: 4),
                if (subtitle != null)
                  AppText( title,fontSize: 14,
                    fontWeight: FontWeight.w400,
                    color: Colors.grey),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
