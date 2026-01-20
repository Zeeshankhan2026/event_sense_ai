import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../../core/widgets/apptext.dart';

class InfoProgressCard extends StatelessWidget {
  final String title;
  final String mainValue;
  final String icons;
  final String caption;
  final double progress; // 0.0 to 1.0
  final List<ProgressSegment>? segments; // optional for multi-color bars
  final Color backgroundColor;
  final Color textColor;
  bool? showSlashWithCaption;
  bool showCaptionBelow;
  bool showProgressPercent;
   InfoProgressCard({
    Key? key,
    required this.title,
    required this.icons,
    required this.mainValue,
    required this.caption,
    required this.progress,
    this.segments,
    this.backgroundColor = Colors.white,
    this.textColor = Colors.black,
     required  showSlashWithCaption,
     required  this.showCaptionBelow,
     required this.showProgressPercent,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 160,
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: backgroundColor,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.06),
            blurRadius: 6,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              AppText(title, type: AppTextType.bodyTextBold,),
              Spacer(),
              SvgPicture.asset(icons),
            ],
          ),
          const SizedBox(height: 8),
          Row(
            children: [
              AppText(mainValue, type: AppTextType.heading2,),
              AppText("/", type: AppTextType.heading1,),

              AppText("100", type: AppTextType.caption,),
            ],
          ),
          const SizedBox(height: 4),
          segments != null
              ? Row(
            children: segments!
                .map((seg) => Expanded(
              flex: seg.flex,
              child: Container(
                height: 8,
                margin: const EdgeInsets.only(right: 2),
                decoration: BoxDecoration(
                  color: seg.color,
                  borderRadius: BorderRadius.circular(4),
                ),
              ),
            ))
                .toList(),
          )
              : ClipRRect(
            borderRadius: BorderRadius.circular(4),
            child: LinearProgressIndicator(
              value: progress,
              minHeight: 8,
              backgroundColor: Colors.grey.shade300,
              valueColor: AlwaysStoppedAnimation<Color>(Colors.blue),
            ),
          ),
        ],
      ),
    );
  }
}

class ProgressSegment {
  final int flex;
  final Color color;

  const ProgressSegment({required this.flex, required this.color});
}
