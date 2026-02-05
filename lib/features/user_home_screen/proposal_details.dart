import 'package:event_sense_ai/core/controller/notification_controller.dart';
import 'package:event_sense_ai/core/controller/submit_application_controller.dart';
import 'package:event_sense_ai/utils/app_assets.dart';
import 'package:event_sense_ai/utils/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:go_router/go_router.dart';
import 'package:sizer/sizer.dart';
import '../../core/widgets/app_buttons.dart';
import '../../core/widgets/apptext.dart';
import '../../core/widgets/custom_headerbar.dart';
import 'components/review_card.dart';


class ProposalDetails extends StatefulWidget {
  ProposalDetails({super.key,});

  @override
  State<ProposalDetails> createState() => _ProposalDetailsState();
}

class _ProposalDetailsState extends State<ProposalDetails> {
  final application = Get.arguments as Map<String,dynamic>;

  final controller = Get.find<SubmitApplicationController>();
  final notificationController = Get.find<NotificationController>();

  List<String> recentEvent = [
    AppAssets.event_recent_1,
    AppAssets.event_recent_2,
  ];

  List<ReviewCard> reviewCardList = [
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
                CustomHeaderBar(title: "Proposal Details",showBackButton: true,onBack: (){
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
                          padding:  EdgeInsets.all(16),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Gap(14.h),

                              AppText(
                                application["vendorName"],
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
                                      AppText("4.3", color: Colors.white),
                                      const SizedBox(width: 6),
                                      AppText(
                                        "443 reviews)",
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
                    itemCount: recentEvent.length,
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
                            image: AssetImage(recentEvent[index]),
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
                    "Descriptions",
                    fontSize: 20,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                Gap(1.h),
                Container(
                  padding: EdgeInsets.all(12),
                  height: 15.h,
                  width: 97.w,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(12),
                    border: BoxBorder.all(color: Colors.grey.shade400),
                  ),
                  child: AppText(application["proposalMessage"])
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
                                  application["quotedPrice"].toString(),
                                  fontSize: 24,
                                  fontWeight: FontWeight.w600,
                                ),
                                Gap(2.w),
                                AppText(
                                  application["guest"],
                                  fontSize: 12,
                                  fontWeight: FontWeight.w400,
                                  color: Colors.grey.shade900,
                                ),
                              ],
                            ),
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
                    itemCount: reviewCardList.length,
                      itemBuilder: (context, index) {
                      final data = reviewCardList[index];
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
                      onPressed: application["status"] == "rejected" || application["status"] == "accepted" ? null : () async {
                        setState(() {
                          application["status"] = "rejected";
                        });
                        await controller.rejectApplication(application["applicationId"], "rejected");
                        await    notificationController.createApplicationStatusNotification(
                            vendorId: application["vendorId"],
                            plannerId: application["plannerId"] ?? "",
                            eventName: application["eventName"],
                            eventImage: application["eventImage"],
                            eventDate: application["eventDate"],
                            eventLocation: application["eventLocation"],
                            applicationId: application["applicationId"],
                            eventId: application["eventId"] ?? "",
                            categoryId: application["categoryId"] ?? "",
                            isAccepted: false);
                      },
                      buttonColor: application["status"] == "rejected" ? Colors.grey : Colors.deepOrangeAccent.shade100,
                      width: 30.w,
                      height: 6.h,
                      text: application["status"] == "rejected" ? "Rejected" : "Reject",
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                    ),
                    Gap(2.w),
                    Obx(() {
                      return AppButtonWidget(
                        onPressed: application["status"] == "accepted" || application["status"] == "rejected" ? null : () async {
                          setState(() {
                            application["status"] = "accepted";
                          });
                          await controller.AcceptApplication(
                            vendorId: application["vendorId"],
                            applicationId: application["applicationId"],
                            status: "accepted",
                            plannerId: application["plannerId"] ?? "",
                            eventId: application["eventId"] ?? "",
                            categoryId: application["categoryId"] ?? "",
                            jobId: application["jobId"] ?? "",
                          );
                          /////notification will triggered here ////////////////

                       await    notificationController.createApplicationStatusNotification(
                              vendorId: application["vendorId"],
                              plannerId: application["plannerId"] ?? "",
                              eventName: application["eventName"],
                              eventImage: application["eventImage"],
                              eventDate: application["eventDate"],
                              eventLocation: application["eventLocation"],
                              applicationId: application["applicationId"],
                              eventId: application["eventId"] ?? "",
                              categoryId: application["categoryId"] ?? "",
                              isAccepted: true);
                        },
                        buttonColor: Colors.indigo.shade600,
                        loader: controller.isLoading.value,
                        width: 60.w,
                        height: 6.h,
                        text: application["status"] == "accepted" ? "Accepted" : "Accept Proposal",
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                      );
                    }),
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
