import 'package:event_sense_ai/utils/app_text.dart';
import 'package:flutter/material.dart';

class CustomActionCard extends StatelessWidget {
  final double width;
  final AppTextType? type;
  final double? fontWeight;
  final double height;
  final Color bgColor;
  final double? fontsize;
  final Color? textColor;
  final Widget startIcon;
  final String title;
  final Widget? endIcon;


  const CustomActionCard({
    Key? key,
    this.textColor,
    this.fontsize,
    this.fontWeight,
    this.type,
    required this.width,
    required this.height,
    required this.bgColor,
    required this.startIcon,
    required this.title,
    required this.endIcon,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      height: height,
      padding: const EdgeInsets.symmetric(horizontal: 16),
      decoration: BoxDecoration(
        color: bgColor,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.08),
            blurRadius: 6,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          // Start icon + title
          Row(
            children: [
              SizedBox(height: 28,width: 28,child: startIcon,),
              const SizedBox(width: 8),
             AppText(title,fontSize: fontWeight,)
            ],
          ),

          // End icon
          SizedBox(height: 28,width: 28,child: endIcon,),
        ],
      ),
    );
  }
}
