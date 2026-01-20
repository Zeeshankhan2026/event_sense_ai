import 'package:flutter/material.dart';

import '../../utils/app_text.dart';

class AppSnackbar {
  /// Shows a customizable Snackbar
  static void show(
      BuildContext context, {
        required String message,
        IconData icon = Icons.info_outline,
        Color iconBgColor = Colors.blueAccent,
        Color iconColor = Colors.white,
        Color backgroundColor = Colors.white,

        bool isTop = true,
        Duration duration = const Duration(seconds: 3),
      }) {
    final snackBar = SnackBar(
dismissDirection: DismissDirection.startToEnd,

      behavior: SnackBarBehavior.floating,
      backgroundColor: backgroundColor,
      elevation: 6,
      margin: isTop
          ? const EdgeInsets.fromLTRB(16, 16, 16, 40)
          : const EdgeInsets.fromLTRB(16, 0, 16, 36),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      duration: duration,
      content: Row(
        children: [
          CircleAvatar(
            radius: 16,
            backgroundColor: iconBgColor,
            child: Icon(
              icon,
              color: iconColor,
              size: 20,
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: AppText(message, type: AppTextType.captionDark,color: Colors.white,)
          ),
        ],
      ),
    );

    // Remove current SnackBars before showing a new one
    ScaffoldMessenger.of(context)
      ..hideCurrentSnackBar()
      ..showSnackBar(snackBar);
  }
}
