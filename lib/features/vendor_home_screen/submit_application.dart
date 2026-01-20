import 'package:event_sense_ai/utils/app_assets.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';
import 'package:sizer/sizer.dart';

import '../../core/widgets/app_buttons.dart';
import '../../core/widgets/apptext.dart';
import '../../core/widgets/custom_headerbar.dart';
import '../../utils/app_colors.dart';

class SubmitApplication extends StatefulWidget {
  SubmitApplication({super.key});

  @override
  State<SubmitApplication> createState() => _SubmitApplicationState();
}

class _SubmitApplicationState extends State<SubmitApplication> {
  final TextEditingController quoteController = TextEditingController(
    text: "\$0.00",
  );

  final TextEditingController messageController = TextEditingController();

  String selectedSetupTime = "1 hour";

  final List<String> setupOptions = [
    "30 minutes",
    "1 hour",
    "2 hours",
    "3+ hours",
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 12),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              CustomHeaderBar(title: "Vendors Applications",showBackButton: true,onBack: (){
                context.pop();
              },),
              Gap(1.h),
              Container(
                height: 15.h,
                width: 100.w,
                margin: EdgeInsets.all(8),
                padding: EdgeInsets.all(8),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(12),
                  border: BoxBorder.all(color: Colors.grey.shade300),
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
                                  "Wedding",
                                  fontWeight: FontWeight.w500,
                                  fontSize: 10,
                                  color: Colors.redAccent,
                                ),
                              ),

                              const SizedBox(height: 6),

                              /// TITLE
                              AppText(
                                "Professional Wedding DJ",
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
                                    "July 24th . The Grand Hall",
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
              AppText("Quote & Setup", fontSize: 20,fontWeight: FontWeight.w600,),
              Gap(1.h),
              Container(
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
                    AppText("Custom Quote",fontWeight: FontWeight.w400,fontSize: 12,color: Colors.grey,),
                     SizedBox(height: 6),
                    TextField(
                      controller: quoteController,
                      keyboardType: TextInputType.number,
                      decoration: InputDecoration(
                        hintText: "\$0.00",
                        border: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.grey.shade100),
                          borderRadius: BorderRadius.circular(8),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.grey.shade100),
                          borderRadius: BorderRadius.circular(8),
                        ),
                        contentPadding: const EdgeInsets.symmetric(
                          horizontal: 12,
                          vertical: 10,
                        ),
                      ),
                    ),
                    Gap(2.h),
                    AppText("EST. Setup Time",fontWeight: FontWeight.w400,fontSize: 12,color: Colors.grey,),
                    const SizedBox(height: 6),
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 12),
                      decoration: BoxDecoration(
                        border: Border.all(color: Colors.grey.shade100),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: DropdownButton<String>(
                        value: selectedSetupTime,
                        isExpanded: true,
                        underline: const SizedBox(),
                        items: setupOptions.map((time) {
                          return DropdownMenuItem(
                            value: time,
                            child: Text(time),
                          );
                        }).toList(),
                        onChanged: (value) {
                          setState(() {
                            selectedSetupTime = value!;
                          });
                        },
                      ),
                    ),
                    Gap(3.h),
                   AppText("Proposal Message",fontWeight: FontWeight.w400,fontSize: 12,color: Colors.grey,),
                    Gap(1.h),
                    TextField(
                      controller: messageController,
                      maxLines: 10,
                      decoration: InputDecoration(
                        hintText: "Write your message...",
                        border: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.grey.shade50),
                          borderRadius: BorderRadius.circular(8),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.grey.shade50),
                          borderRadius: BorderRadius.circular(8),
                        ),
                        contentPadding: const EdgeInsets.symmetric(
                          horizontal: 12,
                          vertical: 10,
                        ),
                      ),
                    ),

                  ],
                ),
              ),
              Gap(2.h),
              AppButtonWidget(
                onPressed: () {
                  // context.goNamed(AppRoutes.VendorSetLocation);
                },
                width: 80.w,
                height: 6.h,
                fontSize: 16,
                fontWeight: FontWeight.w600,
                buttonColor: AppColors.fieldColor
                    .withOpacity(0.9),
                text: 'Submit Application',),
            ],
          ),
        ),
      ),
    );
  }
}
