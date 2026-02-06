import 'package:event_sense_ai/core/controller/event_controller.dart';
import 'package:event_sense_ai/core/controller/guest_controller.dart';
import 'package:event_sense_ai/core/models/guest_model.dart';
import 'package:event_sense_ai/core/enums/status_enum.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:event_sense_ai/utils/app_assets.dart';
import 'package:event_sense_ai/utils/app_colors.dart';
import 'package:event_sense_ai/utils/app_icons.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';

import '../../core/models/event_model.dart';
import '../../core/routes/app_routes.dart';
import '../../core/widgets/apptext.dart';
import '../../core/widgets/custom_headerbar.dart';
import 'components/InProgressReusableWidget.dart';
import 'components/ai_generate_cards.dart';
import 'components/budget_used_card.dart';

class EventDetailsScreen extends StatefulWidget {
  const EventDetailsScreen({
    super.key,
  });

  @override
  State<EventDetailsScreen> createState() => _EventDetailsScreenState();
}

class _EventDetailsScreenState extends State<EventDetailsScreen> {
  EventModel? eventModel;
  late final String eventId;
  final controller = Get.find<GuestController>();
  final eventController = Get.find<EventController>();
  bool isVisible = false;

  @override
  void initState() {
    super.initState();
    
    final args = Get.arguments;
    if (args is EventModel) {
      eventModel = args;
      eventId = args.eventId;
    } else if (args is String) {
      eventId = args;
    } else if (args is Map && args.containsKey('eventId')) {
      eventId = args['eventId'].toString();
    } else {
      // Fallback/Error state
      eventId = "";
    }

    controller.setEventId(eventId);
    eventController.setEventId(eventId);
  }

  List<AiGenerateCards> _getAiCards(EventModel model, int acceptedCount, int totalInvited) {
    return [
      AiGenerateCards(
        voidCallback: () {
          Get.toNamed(AppRoutes.vendersManagement, arguments: model);
        },
        icons: AppIcons.vender_icon,
        title: "Find Vendors",
        tag: "AI- Powered Search",
        bg_color: Colors.blueAccent.shade200.withOpacity(0.4),
        container_color: Colors.blueAccent.shade100,
      ),
      AiGenerateCards(
          voidCallback: () {
            Get.toNamed(AppRoutes.createInvitaionCardDesign, arguments: model);
          },
          icons: AppIcons.invitaion_icon,
          title: "Invitation",
          tag: "Design and send",
          bg_color: Colors.green.shade200,
          container_color: Colors.green),
      AiGenerateCards(
          voidCallback: () {
            Get.toNamed(AppRoutes.guestList, arguments: model.eventId);
          },
          icons: AppIcons.guest_list,
          title: "Guest List ",
          tag: "$acceptedCount / $totalInvited Confirmed Guests",
          bg_color: const Color(0xffFBE1CE),
          container_color: const Color(0xffea965b)),
      AiGenerateCards(
          voidCallback: () {
            Get.toNamed(AppRoutes.budgetBreakdown, arguments: model);
          },
          icons: AppIcons.budget_allocation,
          title: "Budget Allocation",
          tag: "AI- Budget setup",
          bg_color: const Color(0xffEAB30840).withOpacity(0.3),
          container_color: const Color(0xffEAB30840).withOpacity(0.3)),
    ];
  }

  @override
  Widget build(BuildContext context) {
    if (eventId.isEmpty) {
      return const Scaffold(body: Center(child: Text("Invalid Event ID")));
    }

    return StreamBuilder<DocumentSnapshot<Map<String, dynamic>>>(
      stream: eventController.eventStream(eventId),
      builder: (context, eventSnapshot) {
        if (eventSnapshot.connectionState == ConnectionState.waiting && eventModel == null) {
          return const Scaffold(body: Center(child: CircularProgressIndicator()));
        }

        if (eventSnapshot.hasData && eventSnapshot.data!.data() != null) {
          eventModel = EventModel.fromJson(
            eventSnapshot.data!.data()!,
            eventSnapshot.data!.id,
          );
        }

        if (eventModel == null) {
          return const Scaffold(body: Center(child: Text("Event not found")));
        }

        final model = eventModel!;

        return Scaffold(
          backgroundColor: AppColors.white,
          body: SingleChildScrollView(
            child: SafeArea(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 18.0),
                child: Column(
                  children: [
                    CustomHeaderBar(
                        showBackButton: true,
                        onBack: () {
                          Navigator.of(context).pop();
                        },
                        title: "Event Details"),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Gap(12),
                        Stack(
                          children: [
                            Container(
                              width: 90.w,
                              height: 40.h,
                              decoration: BoxDecoration(
                                  color: Colors.grey,
                                  borderRadius: BorderRadius.circular(20),
                                  image: DecorationImage(
                                      image: AssetImage(AppAssets.wedding_image2),
                                      fit: BoxFit.cover)),
                            ),
                            Positioned(
                                top: 25.h,
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Container(
                                        padding: const EdgeInsets.all(4),
                                        width: 20.w,
                                        height: 25,
                                        decoration: BoxDecoration(
                                          color: Colors.white,
                                          borderRadius: BorderRadius.circular(16),
                                        ),
                                        child: Center(
                                          child: Row(
                                            children: [
                                              SvgPicture.asset(
                                                  AppIcons.calender_icon),
                                              AppText(
                                                model.eventStartDate,
                                                type: AppTextType.caption,
                                                fontSize: 10,
                                                fontWeight: FontWeight.w700,
                                              )
                                            ],
                                          ),
                                        ),
                                      ),
                                      const Gap(10),
                                      AppText(
                                        model.eventName,
                                        type: AppTextType.xlNormal,
                                        color: AppColors.white,
                                      ),
                                      Row(
                                        children: [
                                          SvgPicture.asset(
                                            AppIcons.location_icon,
                                            height: 24,
                                            color: AppColors.white,
                                          ),
                                          const Gap(5),
                                          AppText(
                                            model.eventLocation,
                                            type: AppTextType.captionDark,
                                            color: AppColors.white,
                                            fontWeight: FontWeight.w700,
                                          )
                                        ],
                                      ),
                                    ],
                                  ),
                                )),
                          ],
                        ),
                        const Gap(15),
                        StreamBuilder<QuerySnapshot<Map<String, dynamic>>>(
                          stream: controller.FetchGuest(),
                          builder: (context, snapshot) {
                            int totalInvited = 0;
                            int acceptedCount = 0;
                            int pendingCount = 0;
                            int declinedCount = 0;

                            if (snapshot.hasData && snapshot.data!.docs.isNotEmpty) {
                              final guests = snapshot.data!.docs
                                  .map((doc) => GuestModel.fromJson(doc.data()))
                                  .toList();
                              totalInvited = guests.length;
                              acceptedCount = guests
                                  .where((g) => g.status == GuestStatus.accepted)
                                  .length;
                              pendingCount = guests
                                  .where((g) => g.status == GuestStatus.pending)
                                  .length;
                              declinedCount = guests
                                  .where((g) =>
                                      g.status == GuestStatus.declined ||
                                      g.status == GuestStatus.rejected)
                                  .length;
                            }

                            final double yesPercent = totalInvited > 0
                                ? (acceptedCount / totalInvited)
                                : 0;
                            final double maybePercent = totalInvited > 0
                                ? (pendingCount / totalInvited)
                                : 0;
                            final double noPercent = totalInvited > 0
                                ? (declinedCount / totalInvited)
                                : 0;

                            final aiCards = _getAiCards(model, acceptedCount, totalInvited);

                            return Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                AppText(
                                  "Status",
                                  type: AppTextType.heading4,
                                  color: AppColors.textGrey1,
                                ),
                                const Gap(15),
                                SizedBox(
                                  height: 21.h,
                                  child: Row(
                                    children: [
                                      Expanded(
                                        child: TotalGuestsCard(
                                          total: acceptedCount,
                                          max: totalInvited,
                                          yesPercent: yesPercent,
                                          maybePercent: maybePercent,
                                          noPercent: noPercent,
                                        ),
                                      ),
                                      const SizedBox(width: 12),
                                      Expanded(
                                        child: BudgetUsedCard(
                                          used: model.eventBudget,
                                          total: model.eventBudget,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                const Gap(12),
                                AppText(
                                  "Ai Generates",
                                  fontSize: 18,
                                  fontWeight: FontWeight.w600,
                                  color: AppColors.textGrey1,
                                ),
                                SizedBox(
                                  height: 27.h,
                                  child: GridView.builder(
                                      physics: const NeverScrollableScrollPhysics(),
                                      itemCount: aiCards.length,
                                      gridDelegate:
                                          const SliverGridDelegateWithFixedCrossAxisCount(
                                        crossAxisCount: 2,
                                        mainAxisSpacing: 10,
                                        crossAxisSpacing: 10,
                                        childAspectRatio: 1.6,
                                      ),
                                      itemBuilder: (context, index) {
                                        final card = aiCards[index];
                                        return InkWell(
                                          onTap: card.voidCallback,
                                          child: Container(
                                            padding: const EdgeInsets.only(
                                                top: 8, left: 12),
                                            decoration: BoxDecoration(
                                              color: card.bg_color,
                                              borderRadius: BorderRadius.circular(12),),
                                            child: Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                Container(
                                                  width: 40,
                                                  height: 40,
                                                  decoration: BoxDecoration(
                                                    color: card.container_color,
                                                    borderRadius:
                                                        BorderRadius.circular(25),
                                                  ),
                                                  child: Center(
                                                    child: SvgPicture.asset(
                                                      card.icons,
                                                      color: Colors.white,
                                                    ),
                                                  ),
                                                ),
                                                Gap(2.h),
                                                AppText(
                                                  card.title,
                                                  fontSize: 14,
                                                  fontWeight: FontWeight.w600,
                                                ),
                                                AppText(
                                                  card.tag,
                                                  type: AppTextType.caption,
                                                ),
                                              ],
                                            ),
                                          ),
                                        );
                                      }),
                                ),
                              ],
                            );
                          },
                        ),
                        Gap(2.h),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            const AppText(
                              "Recent Activity",
                              fontWeight: FontWeight.w600,
                              fontSize: 17,
                            ),
                            AppText(
                              "View All",
                              fontWeight: FontWeight.w600,
                              fontSize: 14,
                              color: Colors.indigo.shade900,
                            ),
                          ],
                        ),
                        Gap(1.h),
                        Column(
                          children: [
                            // Card 1: Invite Accepted
                            Container(
                              padding: const EdgeInsets.all(12),
                              margin: const EdgeInsets.only(bottom: 12),
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(12),
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.black.withOpacity(0.2),
                                    blurRadius: 6,
                                    offset: const Offset(2, 3),
                                  ),
                                ],
                              ),
                              child: Row(
                                children: [
                                  const Icon(Icons.check_circle,
                                      color: Colors.green, size: 28),
                                  const SizedBox(width: 12),
                                  Expanded(
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: const [
                                        Text(
                                          "John Dae Accepted Invite",
                                          style: TextStyle(
                                              fontSize: 14,
                                              fontWeight: FontWeight.w600),
                                        ),
                                        SizedBox(height: 4),
                                        Text(
                                          "2 minutes ago",
                                          style: TextStyle(
                                              fontSize: 12, color: Colors.grey),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),

                            // Card 2: Venue Deposit Paid
                            Container(
                              padding: const EdgeInsets.all(12),
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(12),
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.black.withOpacity(0.2),
                                    blurRadius: 6,
                                    offset: const Offset(2, 3),
                                  ),
                                ],
                              ),
                              child: Row(
                                children: [
                                  const Icon(Icons.description,
                                      color: Colors.blue, size: 28),
                                  const SizedBox(width: 12),
                                  Expanded(
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: const [
                                        Text(
                                          "Venue Deposit Paid",
                                          style: TextStyle(
                                              fontSize: 14,
                                              fontWeight: FontWeight.w600),
                                        ),
                                        SizedBox(height: 4),
                                        Text(
                                          "3 hours ago",
                                          style: TextStyle(
                                              fontSize: 12, color: Colors.grey),
                                        ),
                                      ],
                                    ),
                                  ),
                                  const Text(
                                    "-\$1,200",
                                    style: TextStyle(
                                      fontSize: 14,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.red,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Gap(1.h),
                          ],
                        )
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
