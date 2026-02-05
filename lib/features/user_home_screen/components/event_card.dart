import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:gap/gap.dart';
import 'package:sizer/sizer.dart';

import '../../../core/widgets/apptext.dart';
import '../../../utils/app_colors.dart';

class EventCard extends StatelessWidget {
  final String title;
  final String date;
  final String location;
  final String imagePath;
  final String calender_image;
  final String location_icon;
  final String peoples_image;
  final String wallet;
  final int attendees;
  final double cost;
  final String countdown;
  final VoidCallback? onTap;

  const EventCard({
    Key? key,
    required this.title,
    required this.peoples_image,
    required this.wallet,
    required this.calender_image,
    required this.location_icon,
    required this.date,
    required this.location,
    required this.imagePath,
    required this.attendees,
    required this.cost,
    required this.countdown,
    this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;

    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 80.w,
        margin: const EdgeInsets.only(right: 12,bottom: 12),
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16),
          boxShadow: [
            BoxShadow(color: Colors.grey.shade300, offset: Offset(3, 6),blurRadius: 3)


          ],
        ),
        child: Column(
          children: [
            Row(
              children: [
                // Thumbnail
                ClipRRect(
                  borderRadius: BorderRadius.circular(12),
                  child: imagePath.startsWith('http')
                      ? Image.network(
                    imagePath,
                    height: 72,
                    width: 72,
                    fit: BoxFit.cover,
                    errorBuilder: (context, error, stackTrace) => Image.asset(
                      imagePath, // If network fails, try as asset (though unlikely to be same path)
                      height: 72,
                      width: 72,
                      fit: BoxFit.cover,
                      errorBuilder: (context, error, stackTrace) => const Icon(Icons.image, size: 72),
                    ),
                  )
                      : Image.asset(
                    imagePath,
                    height: 72,
                    width: 72,
                    fit: BoxFit.cover,
                    errorBuilder: (context, error, stackTrace) => const Icon(Icons.image, size: 72),
                  ),
                ),
                const SizedBox(width: 12),

                // Event details
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      AppText(title,type: AppTextType.heading3,),
                      const SizedBox(height: 4),
                      Row(
                        children: [
                          SvgPicture.asset(calender_image),
                          Gap(4),
                          AppText(date,type: AppTextType.caption,fontWeight: FontWeight.bold,),

                        ],
                      ),
                      const SizedBox(height: 4),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            children: [
                              SvgPicture.asset(location_icon),
                              Gap(4),
                              AppText(location,type: AppTextType.caption,fontWeight: FontWeight.bold,),

                            ],
                          ),
                          Container(
                            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                            decoration: BoxDecoration(
                              color: AppColors.first_tile_color,
                              borderRadius: BorderRadius.circular(8),
                            ),
                            child: AppText("${countdown + "  left"}",type: AppTextType.caption,color: Colors.black,),

                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
            const SizedBox(height: 18),
            Divider(thickness: 1.5,),
            const SizedBox(height: 18),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    Row(
                      children: [
                        SvgPicture.asset(peoples_image,color: Colors.black87,),
                        Gap(4),
                        AppText("${attendees}",fontSize: 10,fontWeight: FontWeight.w600,),

                      ],
                    ),
                    Gap(25),
                    Row(
                      children: [
                        SvgPicture.asset(wallet),
                        Gap(4),
                        Text(
                          "\$${(cost as num).round()}",
                          style:  TextStyle(
                            fontSize: 10,
                            color: AppColors.second_tile_color,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(width: 6),
                  ],
                ),
                const Icon(Icons.arrow_forward_ios,
                    size: 18, color: Colors.black45),

              ],
            ),
          ],
        ),
      )

    );
  }

  Widget _infoChip(String text) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      decoration: BoxDecoration(
        color: Colors.grey.shade200,
        borderRadius: BorderRadius.circular(8),
      ),
      child: Text(text,
          style: const TextStyle(fontSize: 11, color: Colors.black87)),
    );
  }
}
