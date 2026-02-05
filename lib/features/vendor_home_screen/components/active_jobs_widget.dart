import 'package:event_sense_ai/utils/app_assets.dart';
import 'package:event_sense_ai/utils/app_icons.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:gap/gap.dart';
import 'package:sizer/sizer.dart';

class ActiveJobCard extends StatelessWidget {
  final String eventName;
  final String eventDate;
  final String eventLocation;
  final String imageUrl;
  final VoidCallback onTap;

  const ActiveJobCard({
    required this.eventName,
    required this.eventDate,
    required this.eventLocation,
    required this.imageUrl,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        margin: EdgeInsets.all(8),
        decoration: BoxDecoration(
          boxShadow: [
            BoxShadow(
              color: Colors.grey.shade100,
              offset: Offset(2.1, 2.1),
              blurRadius: 2
            )
          ],
          border: BoxBorder.all(color: Colors.grey.shade300,),
          borderRadius: BorderRadius.circular(20)
        ),
        padding: EdgeInsets.all(16.0),
        child: Row(
          children: [
            // Image
            ClipRRect(
              borderRadius: BorderRadius.circular(8.0),
              child: Image.asset(
                imageUrl,
                width: 100,
                height: 100,
                fit: BoxFit.cover,
              ),
            ),
            SizedBox(width: 16.0),
            // Event Details
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    eventName,
                    style: TextStyle(
                      fontSize: 20.0,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  SizedBox(height: 8.0),
                  Row(
                    children: [
                      SvgPicture.asset(AppIcons.calender_icon),
                      Gap(4),
                      Text(
                        eventDate,
                        style: TextStyle(
                          fontSize: 14.0,
                          color: Colors.grey[600],
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 4.0),
                  Row(
                    children: [
                      SvgPicture.asset(AppIcons.location_icon),
                      Gap(4),
                      Text(
                        eventLocation,
                        style: TextStyle(
                          fontSize: 14.0,
                          color: Colors.grey[600],
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            // Arrow Icon
            Container(
              height: 5.h,
              width: 12.w,
              decoration: BoxDecoration(
                color: Color(0xff253EA77A).withOpacity(0.1),
                shape: BoxShape.circle
              ),
              child: Icon(
                Icons.arrow_forward,
                size: 18.0,
                color: Colors.black54,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
