import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:get/get.dart';

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
        Color textColor = Colors.black54,

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
            child: AppText(message, fontSize: 16,color: textColor,)
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

/// Safe snackbar utility that prevents LateInitializationError
/// This is a drop-in replacement for Get.snackbar
class SafeSnackbar {
  /// Shows a GetX snackbar safely, handling potential LateInitializationError
  /// that can occur during navigation or overlay operations in GetX 4.7.x
  static void show(
    String title,
    String message, {
    SnackPosition snackPosition = SnackPosition.TOP,
    Duration duration = const Duration(seconds: 3),
    Color? backgroundColor,
    Color? colorText,
    IconData? icon,
    bool isDismissible = true,
  }) {
    // Use post frame callback to ensure we're not in build phase
    SchedulerBinding.instance.addPostFrameCallback((_) {
      try {
        // Close any existing snackbars to prevent overlay conflicts
        if (Get.isSnackbarOpen) {
          Get.closeCurrentSnackbar();
        }
        
        // Small delay to allow overlay cleanup
        Future.delayed(const Duration(milliseconds: 100), () {
          try {
            // Check if the app is still in a valid state for showing snackbar
            if (Get.context != null) {
              Get.snackbar(
                title,
                message,
                snackPosition: snackPosition,
                duration: duration,
                backgroundColor: backgroundColor ?? Colors.white,
                colorText: colorText ?? Colors.black87,
                icon: icon != null ? Icon(icon, color: colorText ?? Colors.black87) : null,
                isDismissible: isDismissible,
                margin: const EdgeInsets.all(12),
                borderRadius: 8,
              );
            }
          } catch (e) {
            // Silently handle any errors during snackbar display
            debugPrint('SafeSnackbar: Failed to show snackbar - $e');
          }
        });
      } catch (e) {
        // Silently handle any errors
        debugPrint('SafeSnackbar: Error during snackbar preparation - $e');
      }
    });
  }
  
  /// Shows a success snackbar with green styling
  static void success(String title, String message) {
    show(
      title,
      message,
      backgroundColor: Colors.green.shade50,
      colorText: Colors.green.shade800,
      icon: Icons.check_circle_outline,
    );
  }
  
  /// Shows an error snackbar with red styling
  static void error(String title, String message) {
    show(
      title,
      message,
      backgroundColor: Colors.red.shade50,
      colorText: Colors.red.shade800,
      icon: Icons.error_outline,
    );
  }
  
  /// Shows an info/alert snackbar with blue styling
  static void info(String title, String message) {
    show(
      title,
      message,
      backgroundColor: Colors.blue.shade50,
      colorText: Colors.blue.shade800,
      icon: Icons.info_outline,
    );
  }
}
