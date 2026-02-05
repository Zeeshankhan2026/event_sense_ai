import 'package:event_sense_ai/core/controller/submit_application_controller.dart';
import 'package:event_sense_ai/core/models/jobs_model.dart';
import 'package:event_sense_ai/core/models/vendor_application_model.dart';
import 'package:event_sense_ai/core/models/vendor_model.dart';
import 'package:event_sense_ai/core/repo/vendor_applicatiion_repository.dart';
import 'package:event_sense_ai/core/routes/app_routes.dart';
import 'package:event_sense_ai/core/widgets/app_textfield.dart';
import 'package:event_sense_ai/utils/app_assets.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';

import '../../core/widgets/app_buttons.dart';
import '../../core/widgets/apptext.dart';
import '../../core/widgets/custom_headerbar.dart';
import '../../utils/app_colors.dart';

class SubmitApplication extends GetView<SubmitApplicationController> {
  const SubmitApplication({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 12),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                CustomHeaderBar(
                  title: "Apply For Job",
                  showBackButton: true,
                  onBack: () {
                    Get.back();
                  },
                ),
                Gap(1.h),
                Container(
                  height: 15.h,
                  width: 100.w,
                  margin: EdgeInsets.all(8),
                  padding: EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(color: Colors.grey.shade300),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.withOpacity(0.08),
                        blurRadius: 6,
                        spreadRadius: 2,
                        offset: const Offset(0, 6),
                      ),
                    ],
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      /// TOP SECTION
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          /// IMAGE
                          ClipRRect(
                            borderRadius: BorderRadius.circular(14),
                            child: Image.asset(
                              AppAssets.wedding_reception2,
                              height: 12.h,
                              width: 30.w,
                              fit: BoxFit.cover,
                            ),
                          ),

                          const SizedBox(width: 12),

                          /// INFO
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                /// TAG
                                Container(
                                  padding: const EdgeInsets.symmetric(
                                    horizontal: 10,
                                    vertical: 4,
                                  ),
                                  decoration: BoxDecoration(
                                    color: const Color(0xffFDECEC),
                                    borderRadius: BorderRadius.circular(20),
                                  ),
                                  child: AppText(
                                    controller.job.categoryId.toUpperCase(),
                                    fontWeight: FontWeight.w500,
                                    fontSize: 10,
                                    color: Colors.redAccent,
                                  ),
                                ),

                                const SizedBox(height: 6),

                                /// TITLE
                                AppText(
                                  controller.job.title,
                                  fontWeight: FontWeight.w600,
                                  fontSize: 16,
                                ),

                                const SizedBox(height: 8),

                                /// DATE
                                Row(
                                  children: [
                                    const Icon(
                                      Icons.calendar_month_outlined,
                                      size: 16,
                                      color: Colors.blueGrey,
                                    ),
                                    const SizedBox(width: 6),
                                    AppText(
                                      controller.job.eventDate ?? "Date N/A",
                                      fontWeight: FontWeight.w500,
                                      fontSize: 12,
                                      color: Colors.grey,
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                Gap(1.h),
                AppText(
                  "Quote & Setup",
                  fontSize: 20,
                  fontWeight: FontWeight.w600,
                ),
                Gap(1.h),
                Container(
                  padding: EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(16),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.08),
                        blurRadius: 12,
                        spreadRadius: 2,
                        offset: const Offset(0, 6),
                      ),
                    ],
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      AppText(
                        "Custom Quote",
                        fontWeight: FontWeight.w400,
                        fontSize: 12,
                        color: Colors.grey,
                      ),
                      SizedBox(height: 6),
                      AppFormField(
                        showBorder: true,
                        borderColor: Colors.grey.shade300,
                        focusedBorderColor: Colors.grey.shade300,
                        title: "\$0.00",
                        textEditingController: controller.customQuote,
                      ),
                      Gap(2.h),
                      AppText(
                        "EST. Setup Time",
                        fontWeight: FontWeight.w400,
                        fontSize: 12,
                        color: Colors.grey,
                      ),
                      const SizedBox(height: 6),
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 12),
                        decoration: BoxDecoration(
                          border: Border.all(color: Colors.grey.shade100),
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: DropdownButton<String>(
                          value: controller.estimatedTimeSetup.value,
                          isExpanded: true,
                          underline: const SizedBox(),
                          items:
                          [
                            "30 minutes",
                            "1 hour",
                            "2 hours",
                            "3+ hours",
                          ].map((time) {
                            return DropdownMenuItem(
                              value: time,
                              child: Text(time),
                            );
                          }).toList(),
                          onChanged: (value) {
                            if (value != null) {
                              controller.estimatedTimeSetup.value = value;
                            }
                          },
                        ),
                      ),
                      Gap(3.h),
                      AppText(
                        "Proposal Message",
                        fontWeight: FontWeight.w400,
                        fontSize: 12,
                        color: Colors.grey,
                      ),
                      Gap(1.h),
                      AppFormField(
                        showBorder: true,
                        borderColor: Colors.grey.shade300,
                        focusedBorderColor: Colors.grey.shade300,
                        isMultiline: true,
                        title: "Write your message",
                        textEditingController: controller.proposalMessage,
                      ),
                    ],
                  ),
                ),
                Gap(2.h),
                Obx(() => AppButtonWidget(
                  loader: controller.isLoading.value,
                  onPressed: () {
                    controller.submitApplication();
                  },
                  width: 80.w,
                  height: 6.h,
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                  buttonColor: AppColors.fieldColor.withOpacity(0.9),
                  text: 'Submit Application',
                )),
                Gap(2.h),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
