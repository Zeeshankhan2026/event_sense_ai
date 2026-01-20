
import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

import '../../../utils/app_text.dart';

class StatusTile extends StatelessWidget {
  final IconData icon;
  final Color iconColor;
  final String title;
  final String subtitle;
  final String? statusLabel;
  final Color? statusColor;
  final Color containerColor;
  final bool isSelected;
  final VoidCallback? onTap;

  const StatusTile({
    super.key,
    required this.icon,
    required this.iconColor,
    required this.title,
    required this.subtitle,
    required this.containerColor,
    required this.isSelected,
    this.statusLabel,
    this.statusColor,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 1),
        padding: const EdgeInsets.all(16),
        height: 12.h,
        decoration: BoxDecoration(
          color: isSelected ? const Color(0xff1B2A57).withOpacity(0.3) : Colors.white,
          borderRadius: BorderRadius.circular(12),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.08),
              blurRadius: 12,
              spreadRadius: 2,
              offset: const Offset(0, 6),
            ),
          ],
        ),
        child: Row(
          children: [
            Container(
              width: 18.w,
              height: 10.h,
              decoration: BoxDecoration(
                color: isSelected
                    ? Colors.white.withOpacity(0.2)
                    : containerColor,
                borderRadius: BorderRadius.circular(52),
              ),
              child: Icon(
                icon,
                color: isSelected ? Colors.white : iconColor,
                size: 28,
              ),
            ),

            const SizedBox(width: 12),

            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    title,
                    style: TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.bold,
                      color: isSelected ? Colors.white : Colors.black,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    subtitle,
                    style: TextStyle(
                      fontSize: 13,
                      color:
                      isSelected ? Colors.white70 : Colors.grey,
                    ),
                  ),
                ],
              ),
            ),
            if (statusLabel != null)
              Container(
                width: 14.w,
                height: 5.h,
                decoration: BoxDecoration(
                  color: isSelected
                      ? Colors.white.withOpacity(0.2)
                      : statusColor?.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(18),
                ),
                child: Center(
                  child: AppText(
                    statusLabel!,
                    fontWeight: FontWeight.w600,
                    fontSize: 14,
                    color: isSelected ? Colors.white : statusColor,
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }
}
