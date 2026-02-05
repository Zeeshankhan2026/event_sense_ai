import 'package:event_sense_ai/utils/app_assets.dart';
import 'package:event_sense_ai/utils/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:go_router/go_router.dart';
import 'package:sizer/sizer.dart';

import '../../core/routes/app_routes.dart';
import '../../core/widgets/app_buttons.dart';
import '../../core/widgets/custom_headerbar.dart';
import '../../utils/app_text.dart';

class InviteGuest extends StatelessWidget {
  const InviteGuest({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric( horizontal: 8),
            child: Column(
              children: [
                // Header Row
                CustomHeaderBar(title: "Invite Guests",showBackButton: true,onBack: (){
                  Get.back();
                },),

                Gap(1.h),

                // Title
                AppText(
                  "How would you like to invite guests?",
                  color: Colors.indigo.shade900,
                  fontWeight: FontWeight.w700,
                  fontSize: 24,
                ),

                Gap(1.h),

                // Event Card
                Container(
                  padding: const EdgeInsets.all(12),
                  margin: const EdgeInsets.symmetric(vertical: 8),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(12),
                      boxShadow: [ BoxShadow( color: Colors.black.withOpacity(0.08),
                  blurRadius: 12,
                  spreadRadius: 2,
                  offset: const Offset(0, 6),  ), ],
                  ),
                  child: Row(
                    children: [
                      ClipRRect(
                        borderRadius: BorderRadius.circular(8),
                        child: Image.asset(
                          AppAssets.wedding_image,
                          width: 60,
                          height: 60,
                          fit: BoxFit.cover,
                        ),
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: const [
                            Text(
                              "Birthday Bash 2024",
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                            SizedBox(height: 6),
                            Row(
                              children: [
                                Icon(
                                  Icons.calendar_today,
                                  size: 14,
                                  color: Colors.grey,
                                ),
                                SizedBox(width: 6),
                                Text(
                                  "Saturday, Oct 24 · 8:00 PM",
                                  style: TextStyle(
                                    fontSize: 12,
                                    color: Colors.grey,
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),

                Gap(1.h),

                // RSVP Link Card
                Container(
                  decoration: BoxDecoration(
                  boxShadow:   [ BoxShadow( color: Colors.black.withOpacity(0.08),
                      blurRadius: 12,
                      spreadRadius: 2,
                      offset: const Offset(0, 6),  ), ],
                  ),
                  height: 40.h,
                  child: Stack(
                    children: [
                      ClipRRect(
                        borderRadius: BorderRadius.circular(16),
                        child: SizedBox(
                          height: 40.h,
                          child: Image.asset(
                            AppAssets.wellcome_screen_image1,
                            width: double.infinity,
                            height: 200,
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                      Positioned.fill(
                        child: Container(
                          padding: const EdgeInsets.all(12),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(16),
                            color: Colors.black.withOpacity(0.4),
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Gap(19.h), // FIXED: replaces Gap(5.h)
                              const Text(
                                "Send RSVP Link",
                                style: TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white,
                                ),
                              ),
                              const SizedBox(height: 8),
                              const Text(
                                "The fastest way to get response. Share a direct\n link to your dynamic event page via SMS or email.",
                                style: TextStyle(
                                  fontSize: 13,
                                  color: Colors.white70,
                                ),
                              ),
                              const SizedBox(height: 16),
                              Row(
                                children: [
                                  Row(
                                    children: [
                                      Container(
                                        width: 65.w,
                                        child: ElevatedButton.icon(
                                          onPressed: () {
                                            print("Copy Link tapped");
                                          },
                                          icon: Icon(
                                            Icons.copy,
                                            color: Colors.black54,
                                          ),
                                          style: ElevatedButton.styleFrom(
                                            backgroundColor: Colors.white,
                                            foregroundColor: Colors.black,
                                            padding: const EdgeInsets.symmetric(
                                              horizontal: 20,
                                              vertical: 12,
                                            ),
                                            shape: RoundedRectangleBorder(
                                              borderRadius:
                                                  BorderRadius.circular(8),
                                            ),
                                          ),
                                          label: const Text("Copy Link"),
                                        ),
                                      ),
                                    ],
                                  ),
                                  const SizedBox(width: 12),
                                  Container(
                                    width: 44,
                                    height: 44,
                                    decoration: BoxDecoration(
                                      color: Colors.white,
                                      borderRadius: BorderRadius.circular(8),
                                    ),
                                    child: IconButton(
                                      icon: const Icon(
                                        Icons.share,
                                        color: Colors.black,
                                      ),
                                      onPressed: () {
                                        print("Share tapped");
                                      },
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),

                Gap(1.h),
                // Generate Cards Section
                Container(
                  padding: const EdgeInsets.all(16),
                  margin: const EdgeInsets.symmetric(vertical: 12),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(16),
                    boxShadow:   [ BoxShadow( color: Colors.black.withOpacity(0.08),
                      blurRadius: 12,
                      spreadRadius: 2,
                      offset: const Offset(0, 6),  ), ],
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                children: [
                                  Container(
                                    width: 60.w,
                                    child: Column(
                                      crossAxisAlignment : CrossAxisAlignment.start,
                                      children: [
                                        Container(
                                          width: 10.w,
                                          height: 5.h,
                                          decoration: BoxDecoration(
                                            color: Colors.indigo.shade900,
                                            borderRadius: BorderRadius.circular(
                                              18,
                                            ),
                                            boxShadow:   [ BoxShadow( color: Colors.black.withOpacity(0.08),
                                              blurRadius: 12,
                                              spreadRadius: 2,
                                              offset: const Offset(0, 6),  ), ],
                                          ),
                                          child: Center(
                                            child: Icon(
                                              Icons.link,
                                              color: Colors.white,
                                            ),
                                          ),
                                        ),
                                        Gap(2.h),
                                        // Title
                                        AppText(
                                          "Generate Cards",
                                          fontSize: 27,
                                          fontWeight: FontWeight.w700,
                                          color: Colors.indigo.shade900,
                                        ),
                                        const SizedBox(height: 6),

                                        // Description
                                        const Text(
                                          "Create a custom visual invite using Ai.Perfect for Instagram stories or\n whatsapp status.",
                                          style: TextStyle(
                                            fontSize: 13,
                                            color: Colors.grey,
                                          ),
                                        ),
                                        const SizedBox(height: 16),
                                      ],
                                    ),
                                  ),
                                  Container(
                                    width: 25.w,
                                    height: 13.h,
                                    decoration: BoxDecoration(
                                      image: DecorationImage(
                                        fit: BoxFit.cover,
                                        image: AssetImage(
                                          AppAssets.wellcome_screen_image1,

                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ],
                      ),
                      Gap(2.h),
                      AppButtonWidget(
                        onPressed: (){
                          Get.toNamed(
                             AppRoutes.createInvitaionCardDesign
                          );
                        },
                        width: 80.w,
                        height: 6.h,
                        text: "Create Design", fontWeight: FontWeight.w600,fontSize: 14,buttonColor: Colors.indigo.shade900,),

                    ],
                  ),
                ),
                Gap(1.h),
                Align(child: AppText("Manage guest list >", fontSize: 16,fontWeight: FontWeight.w600,color: AppColors.textGrey1,))
                ,Gap(1.h),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
