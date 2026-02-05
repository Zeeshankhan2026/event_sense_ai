import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

import '../../../core/widgets/apptext.dart';
import '../../../utils/app_assets.dart';

class GuestReusableWidget extends StatelessWidget {
  final String name;
  final String role;
  final String status;
  final Color statusColor;
  final ImageProvider profileImage;
  final IconData roleIcon;
  final IconData status_icon;

  const GuestReusableWidget({
    Key? key,
    required this.name,
    required this.role,
    required this.status,
    required this.statusColor,
    required this.profileImage,
    this.roleIcon = Icons.group,
    this.status_icon = Icons.check,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: Row(
        children: [
          SizedBox(
            height: 8.h,
            width: 20.w,
            child: Stack(
              children: [
                CircleAvatar(
                  radius: 32,
                  backgroundImage: AssetImage(AppAssets.wedding_image2),
                ),
                Positioned(
                  top: 5.h,
                  left: 12.w,
                  child: Container(
                    height: 20,
                    width: 20,
                    decoration: BoxDecoration(
                      color: statusColor,
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Icon(status_icon, size: 14, color: Colors.white),
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  name,
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                const SizedBox(height: 4),
                Row(
                  children: [
                    Icon(roleIcon, size: 14, color: Colors.grey),
                    const SizedBox(width: 4),
                    Text(
                      role,
                      style: const TextStyle(fontSize: 12, color: Colors.grey),
                    ),
                  ],
                ),
              ],
            ),
          ),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
            decoration: BoxDecoration(
              color: statusColor.withOpacity(0.1),
              borderRadius: BorderRadius.circular(20),
            ),
            child: AppText(status, fontSize: 12, fontWeight: FontWeight.w500),
          ),
        ],
      ),
    );
  }
}
