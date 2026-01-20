import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../utils/app_text.dart';

class CustomPlatformWidget {

  static Future<void> showDefaultDialog({
    required BuildContext context,
    required String title,
    required String message,
    String confirmText = "OK",
    Color? confirmColor,
    Color? cancelColor,
    VoidCallback? onConfirm,
    String? cancelText,
    VoidCallback? onCancel,
  }) {
    if (Platform.isIOS) {
      return showCupertinoDialog(
        barrierDismissible: true,
        context: context,
        builder: (ctx) => CupertinoAlertDialog(
          title: AppText(  title,textAlign: TextAlign.center,type:AppTextType.heading2 ,fontWeight: FontWeight.w700,),
          content: AppText( message,textAlign: TextAlign.center,type: AppTextType.caption,),
          actions: [
            if (cancelText != null)
              CupertinoDialogAction(
                child: AppText(
                    cancelText,
                  textAlign: TextAlign.center,
                  type: AppTextType.heading2,
                  color: cancelColor,
                ),
                onPressed: () {
                  Navigator.of(ctx).pop();
                  if (onCancel != null) onCancel();
                },
              ),
            CupertinoDialogAction(
              isDefaultAction: true,
              child: AppText(
               confirmText,
                textAlign:
                TextAlign.center,
                type: AppTextType.heading2,
                color: confirmColor,
              ),
              onPressed: () {
                Navigator.of(ctx).pop();
                if (onConfirm != null) onConfirm();
              },
            ),
          ],
        ),
      );
    } else {
      return showDialog(
        context: context,
        builder: (ctx) => AlertDialog(
          title: AppText( title,textAlign: TextAlign.center,type: AppTextType.heading2,fontWeight: FontWeight.w700,),
          content: AppText( message,textAlign: TextAlign.center,type: AppTextType.caption,color: Colors.black54,),
          actions: [
            if (cancelText != null)
              TextButton(
                child: AppText(
                   cancelText,
                  textAlign: TextAlign.center,
                  fontSize: 17,
                  fontWeight: FontWeight.w600,
                  color: Colors.black54,
                ),
                onPressed: () {
                  Navigator.of(ctx).pop();
                  if (onCancel != null) onCancel();
                },
              ),
            TextButton(
              child: AppText(
                confirmText,
                textAlign: TextAlign.center,
                fontSize: 17,
                fontWeight: FontWeight.w600,
                color: Colors.indigo.shade900,
              ),
              onPressed: () {
                Navigator.of(ctx).pop();
                if (onConfirm != null) onConfirm();
              },
            ),
          ],
        ),
      );
    }
  }


  // static void showIOSBottomSheet(BuildContext context) {
  //   final themeCon = Get.find<ThemeController>();
  //
  //   bool isSelected = themeCon.isLightTheme();
  //
  //   showCupertinoModalPopup(
  //     context: context,
  //     builder: (BuildContext context) => CupertinoActionSheet(
  //       title: const Text('Choose an Option'),
  //       message: const Text('Select one of the options below'),
  //       actions: <CupertinoActionSheetAction>[
  //         CupertinoActionSheetAction(
  //           onPressed: () {
  //             themeCon.updateSelectedIndex(0);
  //             Navigator.pop(context);
  //           },
  //           child: const Text('System Default'),
  //         ),
  //         CupertinoActionSheetAction(
  //           onPressed: () {
  //             themeCon.updateSelectedIndex(1);
  //             Navigator.pop(context);
  //           },
  //           child: const Text('Light Mode'),
  //         ),
  //         CupertinoActionSheetAction(
  //           onPressed: () {
  //             themeCon.updateSelectedIndex(2);
  //             Navigator.pop(context);
  //           },
  //           child: const Text('Dark Mode'),
  //         ),
  //       ],
  //       cancelButton: CupertinoActionSheetAction(
  //         onPressed: () {
  //           Navigator.pop(context);
  //         },
  //         isDefaultAction: true,
  //         child: const Text('Cancel'),
  //       ),
  //     ),
  //   );
  // }


}