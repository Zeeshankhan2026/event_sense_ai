import 'package:event_sense_ai/utils/app_assets.dart';
import 'package:event_sense_ai/utils/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';
import 'package:sizer/sizer.dart';

import '../../core/routes/app_routes.dart';
import '../../core/widgets/app_buttons.dart';
import '../../core/widgets/apptext.dart';
import '../../core/widgets/custom_headerbar.dart';
import 'components/review_card.dart';

class ProposalDetails extends StatelessWidget {
  String? image_url;
  String? company_name;
  String? rating;
  String? review;
  String? price;
  ProposalDetails({
    required this.image_url,
    required this.company_name,
    required this.rating,
    required this.review,
    required this.price,
    super.key,
  });

  List<String> recent_event = [
    AppAssets.event_recent_1,
    AppAssets.event_recent_2,
  ];

  List<ReviewCard> review_card_list = [
    ReviewCard(
      userName: "Jane Cooper",
      userImage: AppAssets.person_1,
      rating: 4.2,
      timeAgo: "2 mins ago",
      reviewText:
          "Ullamco tempor adipisicing et voluptate duis sit esse aliqua esse ex.",
    ),
    ReviewCard(
      userName: "Courtney Henry",
      userImage: AppAssets.person_2,
      rating: 4.7,
      timeAgo: "2 mins ago",
      reviewText:
      "Consequat velit qui adipisicing sunt do rependerit "
          "ad laborum tempor ullamco exercitation. Ullamco "
          "tempor adipisicing et voluptate duis sit esse aliqua",
    ),
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: SafeArea(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 6, vertical: 12),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                CustomHeaderBar(title: "Vendors Applications",showBackButton: true,onBack: (){
                  context.pop();
                },),
                Gap(2.h),
                Container(
                  height: 210, // total card height
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    image: DecorationImage(
                      image: AssetImage(AppAssets.wedding_reception2),
                      fit: BoxFit.cover,
                    ),
                  ),
                  child: SizedBox(
                    height: 160, // image area height
                    child: Stack(
                      children: [
                        Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(16),
                            color: Colors.black.withOpacity(0.4),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(16),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Gap(14.h),

                              AppText(
                                company_name.toString(),
                                color: Colors.white,
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                              ),

                              Row(
                                children: [
                                  const Icon(
                                    Icons.star,
                                    color: Colors.amber,
                                    size: 16,
                                  ),
                                  const SizedBox(width: 4),
                                  Row(
                                    children: [
                                      AppText("$rating", color: Colors.white),
                                      const SizedBox(width: 6),
                                      AppText(
                                        "$review reviews)",
                                        fontSize: 12,
                                        color: Colors.white,
                                      ),
                                      SizedBox(width: 6),
                                    ],
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      AppText(
                        "Recent Events",
                        fontSize: 20,
                        fontWeight: FontWeight.w600,
                      ),
                      AppText(
                        "View All",
                        fontSize: 14,
                        fontWeight: FontWeight.w500,
                      ),
                    ],
                  ),
                ),
                Gap(1.h),
                SizedBox(
                  height: 20.h,
                  child: ListView.builder(
                    itemCount: recent_event.length,
                    scrollDirection: Axis.horizontal,

                    physics: BouncingScrollPhysics(),
                    itemBuilder: (context, index) {
                      return Container(
                        margin: EdgeInsets.symmetric(
                          horizontal: 5,
                          vertical: 4,
                        ),
                        height: 14.w,
                        width: 70.w,
                        decoration: BoxDecoration(
                          image: DecorationImage(
                            image: AssetImage(recent_event[index]),
                            fit: BoxFit.cover,
                          ),
                          borderRadius: BorderRadius.circular(20),
                        ),
                      );
                    },
                  ),
                ),
                Gap(1.h),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8.0),
                  child: AppText(
                    "Service Included",
                    fontSize: 20,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                Gap(1.h),
                Container(
                  // padding: EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(12),
                    border: BoxBorder.all(color: Colors.grey.shade200),
                  ),
                  child: Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Column(
                          children: [
                            Row(
                              children: [
                                Container(
                                  width: 40,
                                  height: 40,
                                  decoration: BoxDecoration(
                                    color: Colors.grey.shade200,
                                    shape: BoxShape.circle,
                                  ),
                                  child: Icon(Icons.check),
                                ),
                                Gap(2.w),
                                AppText(
                                  "Full Gourmet Buffet Setup",
                                  fontSize: 14,
                                  fontWeight: FontWeight.w500,
                                  color: Colors.grey,
                                ),
                              ],
                            ),
                            Gap(2.h),
                            Row(
                              children: [
                                Container(
                                  width: 40,
                                  height: 40,
                                  decoration: BoxDecoration(
                                    color: Colors.grey.shade200,
                                    shape: BoxShape.circle,
                                  ),
                                  child: Icon(Icons.check),
                                ),
                                Gap(2.w),
                                AppText(
                                  "3 Professional Waitstaff ( 4 Hours)",
                                  fontSize: 14,
                                  fontWeight: FontWeight.w500,
                                  color: Colors.grey,
                                ),
                              ],
                            ),
                            Gap(2.h),
                            Row(
                              children: [
                                Container(
                                  width: 40,
                                  height: 40,
                                  decoration: BoxDecoration(
                                    color: Colors.grey.shade200,
                                    shape: BoxShape.circle,
                                  ),
                                  child: Icon(Icons.check),
                                ),
                                Gap(2.w),
                                AppText(
                                  "Full Gourmet Buffet Setup",
                                  fontSize: 14,
                                  fontWeight: FontWeight.w500,
                                  color: Colors.grey,
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                      Divider(color: Colors.grey.shade200),
                      AppText(
                        "View Full Proposal PDF",
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                      ),
                      Gap(1.h),
                    ],
                  ),
                ),
                Gap(2.h),
                AppText(
                  "Proposal Price",
                  fontSize: 20,
                  fontWeight: FontWeight.w700,
                ),
                Gap(1.h),
                Container(
                  decoration: BoxDecoration(
                    border: BoxBorder.all(color: Colors.grey.shade200),
                    borderRadius: BorderRadius.only(
                      topRight: Radius.circular(20),
                      topLeft: Radius.circular(20),
                    ),
                  ),
                  child: Column(
                    children: [
                      Container(
                        width: 100.w,
                        height: 12.h,
                        padding: EdgeInsets.all(20),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.only(
                            topRight: Radius.circular(20),
                            topLeft: Radius.circular(20),
                          ),
                          color: AppColors.fieldColor.withOpacity(0.4),
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            AppText(
                              "Total Estimate",
                              fontSize: 16,
                              fontWeight: FontWeight.w600,
                            ),
                            Row(
                              children: [
                                AppText(
                                  "\$4,500",
                                  fontSize: 24,
                                  fontWeight: FontWeight.w600,
                                ),
                                Gap(2.w),
                                AppText(
                                  "for 150 Guests",
                                  fontSize: 12,
                                  fontWeight: FontWeight.w400,
                                  color: Colors.grey.shade900,
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                      Container(
                        padding: EdgeInsets.all(20),
                        child: Column(
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                AppText(
                                  "Food & Beverage",
                                  fontSize: 14,
                                  fontWeight: FontWeight.w500,
                                  color: Colors.grey,
                                ),
                                AppText(
                                  "\$30,00",
                                  fontSize: 14,
                                  fontWeight: FontWeight.w600,
                                ),
                              ],
                            ),
                            Gap(1.h),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                AppText(
                                  "Service Staff",
                                  fontSize: 14,
                                  fontWeight: FontWeight.w500,
                                  color: Colors.grey,
                                ),
                                AppText(
                                  "\$10,00",
                                  fontSize: 14,
                                  fontWeight: FontWeight.w600,
                                ),
                              ],
                            ),
                            Gap(1.h),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                AppText(
                                  "Rental and Equipment",
                                  fontSize: 14,
                                  fontWeight: FontWeight.w500,
                                  color: Colors.grey,
                                ),
                                AppText(
                                  "\$5,00",
                                  fontSize: 14,
                                  fontWeight: FontWeight.w600,
                                ),
                              ],
                            ),
                            Gap(1.h),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                Gap(2.h),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    AppText(
                      "Reviews",
                      fontSize: 20,
                      fontWeight: FontWeight.w700,
                    ),
                    AppText(
                      "See all",
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
                      color: Colors.indigo.shade900,
                    ),
                  ],
                ),
                Gap(2.h),
                SizedBox(
                  width: 100.w,

                  child: ListView.builder(
                    shrinkWrap: true,
                    physics: NeverScrollableScrollPhysics(),
                    itemCount: review_card_list.length,
                      itemBuilder: (context, index) {
                      final data = review_card_list[index];
                    return ReviewCard(
                        userName: data.userImage,
                        userImage: data.userImage,
                        rating: data.rating,
                        timeAgo: data.timeAgo,
                        reviewText: data.reviewText);
                  }),
                ),
                Gap(2.h),
                Row(
                  children: [
                    AppButtonWidget(
                      buttonColor: Colors.deepOrangeAccent.shade100,
                        width: 30.w,
                        height: 6.h,
                        text: "Reject", fontSize: 16,fontWeight: FontWeight.w600,),
                    Gap(2.w),
                    AppButtonWidget(
                      onPressed: (){
                        context.pushNamed(AppRoutes.ProposalAprovalScreen);
                      },
                        buttonColor: Colors.indigo.shade600,
                        width: 60.w,
                        height: 6.h,
                        text: "Accept  Proposal" ,fontSize: 16,fontWeight: FontWeight.w600,),
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
