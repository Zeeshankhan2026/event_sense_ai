import 'package:event_sense_ai/widgets/apptext.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:gap/gap.dart';

class AiGenerateCards extends StatelessWidget {
  String icons;
  String title;
  String tag;
  Color bg_color;
  Color container_color;
   AiGenerateCards({
     required this.icons,
     required this.title,
     required this.tag,
     required this.bg_color,
     required this.container_color,
     super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: 200,
        height: 100,
        color: bg_color,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Container(
              width: 70,
              height: 70,
              decoration: BoxDecoration(
                color: container_color,
                borderRadius: BorderRadius.circular(8),
              ),
              child: Center(child: SvgPicture.asset(icons),),
            ),
            Gap(10),
            AppText(title, type: AppTextType.captionDark,),
            Gap(10),
            AppText(tag, type: AppTextType.captionDark,),
          ],
        ),
      ),
    );
  }
}
