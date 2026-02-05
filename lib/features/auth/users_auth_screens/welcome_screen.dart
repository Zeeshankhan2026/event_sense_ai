import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:event_sense_ai/utils/app_assets.dart';
import 'package:event_sense_ai/utils/app_colors.dart';
import 'package:event_sense_ai/utils/app_icons.dart';
import 'package:event_sense_ai/utils/app_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:go_router/go_router.dart';

import '../../../core/routes/app_routes.dart';
import '../../../core/widgets/app_buttons.dart';
import '../../../core/widgets/snackbar_widget.dart';
import '../vendor_auth_screen/vendor_welcome_screen.dart';

class WelcomeScreen extends StatefulWidget {
  const WelcomeScreen({super.key});

  @override
  State<WelcomeScreen> createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends State<WelcomeScreen> {
  String? selectedCard; // "personal" or "professional"

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _initNotifications();

  }

  void _initNotifications() async {
    final isAllowed =
    await AwesomeNotifications().isNotificationAllowed();

    if (!isAllowed) {
      await AwesomeNotifications()
          .requestPermissionToSendNotifications();
    }
  }
  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;
    return Scaffold(
      body: Column(
        children: [
          SizedBox(
            width: width,
            height: height * 0.2,
            child: SvgPicture.asset(AppIcons.welcome_baner,fit: BoxFit.cover,)
          ),
          const SizedBox(height: 10),
          Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              AppText(
                "How are you planing?",
                color: Colors.indigo,
                fontSize: 20,
                fontWeight: FontWeight.w700,
              ),
              const SizedBox(height: 10),
              AppText(
                "We'll customize AI tools based on \n your needs",
                textAlign: TextAlign.center,
                type: AppTextType.body,
              ),
              const SizedBox(height: 20),

              /// ---------------- Personal Card ----------------
              GestureDetector(
                onTap: () {
                  setState(() {
                    selectedCard = "personal";
                  });
                },
                child: Container(
                  width: width * 0.95,
                  height: height * 0.18,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(
                      color: selectedCard == "personal"
                          ? Colors.indigo
                          : Colors.grey.shade300, // 👈 light grey default
                      width: 1.5,
                    ),
                  ),
                  child: Row(
                    children: [
                      SizedBox(
                        width: width * 0.65,
                        child: Padding(
                          padding: const EdgeInsets.all(12),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                children: [
                                  SvgPicture.asset(
                                      AppIcons.welcome_screen_icon_celeb),
                                  const SizedBox(width: 8),
                                  AppText(
                                    "For Individuals",
                                    type: AppTextType.heading1Normal,
                                    fontSize: 18,
                                  ),
                                ],
                              ),
                              const Gap(8),
                              AppText(
                                "Personal Planner",
                                type: AppTextType.heading1,
                                fontSize: 18,
                              ),
                              const Gap(4),
                              AppText(
                                "For birthday, weddings and family gathering",
                                type: AppTextType.captionDark,
                              ),
                            ],
                          ),
                        ),
                      ),
                      SizedBox(
                        width: width * 0.28,
                        height: height * 0.14,
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(12),
                          child: Image.asset(
                            AppAssets.wellcome_screen_image1,
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),

              const SizedBox(height: 20),

              /// ---------------- Professional Card ----------------
              GestureDetector(
                onTap: () {
                  setState(() {
                    selectedCard = "professional";
                  });
                },
                child: Container(
                  width: width * 0.95,
                  height: height * 0.19,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(
                      color: selectedCard == "professional"
                          ? Colors.indigo
                          : Colors.grey.shade300, // 👈 light grey default
                      width: 1.5,
                    ),
                  ),
                  child: Row(
                    children: [
                      SizedBox(
                        width: width * 0.65,
                        child: Padding(
                          padding: const EdgeInsets.all(12),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                children: [
                                  SvgPicture.asset(
                                      AppIcons.welcome_screen_icon_bag),
                                  const SizedBox(width: 8),
                                  AppText(
                                    "For Business",
                                    type: AppTextType.heading1Normal,
                                    fontSize: 18,
                                  ),
                                ],
                              ),
                              const Gap(8),
                              AppText(
                                "Professional Planner",
                                type: AppTextType.heading1,
                                fontSize: 18,

                              ),
                              const Gap(4),
                              AppText(
                                "For corporate events, conference and client management",
                                type: AppTextType.captionDark,
                              ),
                            ],
                          ),
                        ),
                      ),
                      SizedBox(
                        width: width * 0.28,
                        height: height * 0.14,
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(12),
                          child: Image.asset(
                            AppAssets.wellcome_screen_image2,
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),

              const SizedBox(height: 30),

              /// ---------------- Get Started Button ----------------
              AppButtonWidget(
                onPressed: () {
                  if (selectedCard == "personal") {
                    Get.toNamed(AppRoutes.login);
                  } else if (selectedCard == "professional") {
                    Get.toNamed(AppRoutes.joinAsVendorScreen);
                  } else {
                    AppSnackbar.show(
                      context,
                      message:
                      "Please select Personal or Professional first.",
                      backgroundColor: Colors.grey,
                    );
                  }
                },
                text: "Get Started",
                height: height * 0.06,
                width: width * 0.91,
                buttonColor: AppColors.fieldColor,
              ),
            ],
          ),
        ],
      ),
    );
  }
}
