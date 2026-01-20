import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';

import '../../core/routes/app_routes.dart';
import '../../core/widgets/app_buttons.dart';
import '../../core/widgets/custom_circle_avator.dart';
import '../../core/widgets/custom_dialog.dart';
import '../../utils/app_colors.dart';
import '../../utils/app_icons.dart';
import '../../utils/app_text.dart';
import '../user_home_screen/components/custom_action_card.dart';

class VendorProfileScreeen extends StatelessWidget {
  const VendorProfileScreeen({super.key});

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;
    return Scaffold(
      backgroundColor: AppColors.white,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 18.0, vertical: 12),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              IconButton(
                onPressed: () {
                  context.pop();
                },
                icon: Icon(Icons.arrow_back_ios),
              ),
              Gap(10),
              Row(
                children: [
                  CustomCircleAvatar(assetImage: AppIcons.profile_icon),
                  Gap(20),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      AppText(
                        "Denial Jones",
                        type: AppTextType.heading3,
                        color: AppColors.black,
                      ),
                      AppText(
                        "DenialJones@gmail.com",
                        type: AppTextType.captionPrimary,
                        color: Colors.grey,
                      ),
                    ],
                  ),
                ],
              ),
              Gap(22),
              AppText("General", type: AppTextType.micro),
              Padding(
                padding: EdgeInsets.only(left: 4),
                child: Column(
                  children: [
                    Gap(22),

                    GestureDetector(
                      onTap: () {
                        context.pushNamed(AppRoutes.VendorAccountScreen);
                      },
                      child: CustomActionCard(
                        fontsize: 15,
                        textColor: AppColors.textGrey1,
                        width: width * 0.95,
                        height: height * 0.068,
                        bgColor: AppColors.secondary,
                        startIcon: SvgPicture.asset(AppIcons.profile_icon),
                        title: "Account",
                        endIcon: SvgPicture.asset(AppIcons.right_arrow),
                      ),
                    ),
                    Gap(22),
                    GestureDetector(
                      onTap: () {
                        context.pushNamed(AppRoutes.VendorNotificationScreen);
                      },
                      child: CustomActionCard(
                        fontsize: 15,
                        textColor: AppColors.textGrey1,
                        width: width * 0.95,
                        height: height * 0.068,
                        bgColor: AppColors.secondary,
                        startIcon: SvgPicture.asset(AppIcons.nofication_icon),
                        title: "Notification",
                        endIcon: SvgPicture.asset(AppIcons.right_arrow),
                      ),
                    ),
                  ],
                ),
              ),
              Gap(42),
              AppText("Bottom Section", type: AppTextType.micro),
              Padding(
                padding: EdgeInsets.only(left: 4),
                child: Column(
                  children: [
                    Gap(22),
                    CustomActionCard(
                      fontsize: 15,

                      textColor: AppColors.textGrey1,
                      width: width * 0.95,
                      height: height * 0.068,
                      bgColor: AppColors.secondary,
                      startIcon: SvgPicture.asset(AppIcons.document_icon),
                      title: "Privacy Policy",
                      endIcon: SvgPicture.asset(AppIcons.right_arrow),
                    ),
                    Gap(22),
                    CustomActionCard(
                      fontsize: 15,

                      textColor: AppColors.textGrey1,
                      width: width * 0.95,
                      height: height * 0.068,
                      bgColor: AppColors.secondary,
                      startIcon: SvgPicture.asset(AppIcons.document_icon),
                      title: "Terms Conditions",
                      endIcon: SvgPicture.asset(AppIcons.right_arrow),
                    ),
                  ],
                ),
              ),
              Gap(42),
              AppButtonWidget(
                suffixIcon: Icon(
                  Icons.logout,
                  color: AppColors.white,
                  size: 20,
                ),
                fontSize: 18,
                radius: (32),
                onPressed: () {
                  CustomPlatformWidget.showDefaultDialog(
                    confirmText : "Log out",
                    confirmColor: Colors.indigo,
                    cancelText: "Cancel",
                    cancelColor: Colors.redAccent,
                    onCancel: (){

                    },
                    onConfirm: (){

                    },
                    context: context,

                    title: "Log Out",
                    message: "Are  you sure want to log out application?",
                  );
                },
                width: width * 0.85,
                height: height * 0.06,
                buttonColor: AppColors.fieldColor,
                text: "LogOut",
              ),
            ],
          ),
        ),
      ),
    );
  }

  void showLogoutDialog(BuildContext context) {
    showDialog(
      context: context,
      barrierDismissible: true, // Tap outside to dismiss
      builder: (context) {
        return Center(
          child: ClipRRect(
            borderRadius: BorderRadius.circular(24),
            child: BackdropFilter(
              filter: ImageFilter.blur(sigmaX: 18, sigmaY: 18),
              child: Container(
                width: MediaQuery.of(context).size.width * 0.8,
                padding: const EdgeInsets.symmetric(
                  horizontal: 20,
                  vertical: 24,
                ),
                decoration: BoxDecoration(
                  color: Colors.white.withOpacity(0.9),
                  borderRadius: BorderRadius.circular(24),
                  border: Border.all(color: Colors.grey.withOpacity(0.2)),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.06),
                      blurRadius: 12,
                      offset: const Offset(0, 6),
                    ),
                  ],
                ),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const Text(
                      "Log Out",
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.w700,
                        color: Colors.black87,
                      ),
                    ),
                    const SizedBox(height: 12),
                    const Text(
                      "Are you sure you want to log out?",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w400,
                        color: Colors.black54,
                      ),
                    ),
                    const SizedBox(height: 24),

                    /// Buttons
                    Row(
                      children: [
                        /// Cancel
                        Expanded(
                          child: GestureDetector(
                            onTap: () {
                              Navigator.pop(context);
                            },
                            child: Container(
                              padding: const EdgeInsets.symmetric(vertical: 14),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(16),
                                color: Colors.grey.shade200,
                              ),
                              child: const Center(
                                child: Text(
                                  "Cancel",
                                  style: TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.w600,
                                    color: Colors.black87,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(width: 12),

                        /// Log Out
                        Expanded(
                          child: GestureDetector(
                            onTap: () {
                              // Add your logout logic here
                              Navigator.pop(context);
                            },
                            child: Container(
                              padding: const EdgeInsets.symmetric(vertical: 14),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(16),
                                gradient: const LinearGradient(
                                  colors: [
                                    Color(0xFFff5f6d),
                                    Color(0xFFffc371),
                                  ],
                                  begin: Alignment.topLeft,
                                  end: Alignment.bottomRight,
                                ),
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.black.withOpacity(0.1),
                                    blurRadius: 8,
                                    offset: const Offset(0, 4),
                                  ),
                                ],
                              ),
                              child: const Center(
                                child: Text(
                                  "Log Out",
                                  style: TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.w700,
                                    color: Colors.white,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
