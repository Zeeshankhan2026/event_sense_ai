import 'package:dotted_border/dotted_border.dart';
import 'package:event_sense_ai/utils/app_assets.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';
import 'package:sizer/sizer.dart';

import '../../../core/routes/app_routes.dart';
import '../../../core/widgets/app_buttons.dart';
import '../../../core/widgets/apptext.dart';

class vendorPortfolio extends StatelessWidget {
  vendorPortfolio({super.key});

  List<String> portfolio = [
    AppAssets.portfolio_1,
    AppAssets.portfolio_2,
    AppAssets.portfolio_3,
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
              Row(
                children: [
                  IconButton(
                    onPressed: () {
                      context.pop();
                    },
                    icon: Icon(Icons.arrow_back_ios),
                  ),
                  Gap(20.w),
                  AppText(
                    "Portfolio",
                    fontSize: 20,
                    fontWeight: FontWeight.w600,
                  ),
                ],
              ),
              Gap(2.h),
              AppText(
                "Show case your work",
                fontSize: 24,
                fontWeight: FontWeight.w700,
                color: Colors.indigo.shade900,
              ),
              Gap(1.h),
              AppText(
                "Upload your best photos and videos. Our Ai analyzes clients. "
                "your visual style to match you with ",
                fontSize: 14,
                fontWeight: FontWeight.w400,
                color: Colors.grey.shade500,
              ),
              Gap(4.h),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  AppText(
                    "Media Gallery",
                    fontSize: 17,
                    fontWeight: FontWeight.w700,
                  ),
                  AppText(
                    "0/10 Uploaded",
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                    color: Colors.grey,
                  ),
                ],
              ),
              Gap(2.h),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    width: 38.w,
                    height: 15.h,
                    margin: const EdgeInsets.symmetric(
                      vertical: 12,
                      horizontal: 16,
                    ),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(40),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(
                            0.08,
                          ), // soft professional shadow
                          offset: const Offset(0, 6), // shadow slightly down
                          blurRadius: 18, // smooth blur
                          spreadRadius: 1, // subtle spread
                        ),
                      ],
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Container(
                          height: 6.h,
                          width: 13.w,
                          decoration: BoxDecoration(
                            color: Colors.grey.shade300,
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child: Icon(
                            Icons.camera_alt_outlined,
                            size: 36,
                            color: Colors.grey,
                          ),
                        ),
                        SizedBox(height: 8),
                        Text(
                          "Add Photos",
                          style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w500,
                            color: Colors.grey,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    width: 38.w,
                    height: 15.h,
                    margin: const EdgeInsets.symmetric(
                      vertical: 12,
                      horizontal: 16,
                    ),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(40),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(
                            0.08,
                          ), // soft professional shadow
                          offset: const Offset(0, 6), // shadow slightly down
                          blurRadius: 18, // smooth blur
                          spreadRadius: 1, // subtle spread
                        ),
                      ],
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Container(
                          height: 6.h,
                          width: 13.w,
                          decoration: BoxDecoration(
                            color: Colors.grey.shade300,
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child: Icon(
                            Icons.videocam_outlined,
                            size: 36,
                            color: Colors.grey,
                          ),
                        ),
                        SizedBox(height: 8),
                        AppText(
                          "Add Video",
                          fontWeight: FontWeight.w500,
                          fontSize: 14,
                          color: Colors.grey,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              Gap(2.h),
              SizedBox(
                height: 18.h,
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: portfolio.length,
                  itemBuilder: (context, index) {
                    return Container(
                      margin: EdgeInsets.symmetric(horizontal: 8),
                      width: 35.w,
                      height: 10.h,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                        image: DecorationImage(
                          image: AssetImage(portfolio[index]),
                          fit: BoxFit.cover,
                        ),
                      ),
                    );
                  },
                ),
              ),
              Gap(1.h),
              AppText(
                "External Links",
                fontSize: 18,
                fontWeight: FontWeight.w700,
              ),
              Gap(1.h),
              GestureDetector(
                onTap: () {
                  print("Add link tapped");
                  // Add link input logic here
                },
                child: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
                  margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                  decoration: BoxDecoration(
                    color: Colors.grey.shade100,
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
                    children: const [
                      Icon(Icons.link, color: Colors.grey, size: 20),
                      SizedBox(width: 12),
                      Text(
                        "Add link to previous work",
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w500,
                          color: Colors.black87,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Gap(1.h),
              AppButtonWidget(
                onPressed: (){
                  context.goNamed(AppRoutes.VendorHomeScreen);
                },
                width: 100.w,
                height: 7.h,
                buttonColor: Colors.indigo.shade900,
                text: "Finish Profile",fontSize: 16,fontWeight: FontWeight.w600,)

            ],
          ),
        ),
      ),
    );
  }
}
