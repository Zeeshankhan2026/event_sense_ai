import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:gap/gap.dart';

import '../../../core/widgets/apptext.dart';

class AiGenerateCards extends StatelessWidget {
  final String icons;
  final String title;
  final String tag;
  final Color bg_color;
  final Color container_color;
  final VoidCallback voidCallback;

  const AiGenerateCards({
    required this.icons,
    required this.title,
    required this.tag,
    required this.bg_color,
    required this.voidCallback,
    required this.container_color,
    super.key,
  });

  AiGenerateCards copyWith({
    String? icons,
    String? title,
    String? tag,
    Color? bg_color,
    Color? container_color,
    VoidCallback? voidCallback,
  }) {
    return AiGenerateCards(
      icons: icons ?? this.icons,
      title: title ?? this.title,
      tag: tag ?? this.tag,
      bg_color: bg_color ?? this.bg_color,
      container_color: container_color ?? this.container_color,
      voidCallback: voidCallback ?? this.voidCallback,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: InkWell(
        onTap: voidCallback,
        child: Container(
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
      ),
    );
  }
}
