import 'package:flutter/cupertino.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:gap/gap.dart';

import '../../../core/widgets/apptext.dart';

class QuickAccessCard extends StatelessWidget {
   double height,width;
   String title;
   Color? bg_color;
   Color? text_color;
   double radius;
   String prefix_icon;
   String suffix_icon;



   QuickAccessCard({
     required this.title,
    required this.height,
    required this.width,
    required this.bg_color,
     this.text_color,
    required this.radius,
    required this.prefix_icon,
    required this.suffix_icon,

    super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 12),
      width: width,
      height: height,
      decoration: BoxDecoration(
        color: bg_color,
        borderRadius: BorderRadius.circular(radius),

      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              SvgPicture.asset(prefix_icon),
              Gap(4),
              AppText(title, fontWeight: FontWeight.w600,fontSize: 16,color: CupertinoColors.white,)
            ],
          ),
          SvgPicture.asset(suffix_icon,color: CupertinoColors.white,),
        ],
      ),
    );
  }
}
