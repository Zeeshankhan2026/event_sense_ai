import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:event_sense_ai/core/controller/guest_controller.dart';
import 'package:event_sense_ai/utils/app_assets.dart';
import 'package:event_sense_ai/utils/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';
import '../../core/enums/status_enum.dart';
import '../../core/models/guest_model.dart';
import '../../core/routes/app_routes.dart';
import '../../core/widgets/app_buttons.dart';
import '../../core/widgets/apptext.dart';
import '../../core/widgets/custom_headerbar.dart';
import '../../core/widgets/search_widget.dart';
import '../../utils/app_icons.dart';
import 'components/guest_reusable_widget.dart';
import 'components/status_summary_card.dart';


class GuestList extends StatefulWidget {
  const GuestList({super.key});

  @override
  State<GuestList> createState() => _GuestListState();
}

class _GuestListState extends State<GuestList> {
  final TextEditingController searchController = TextEditingController();
  FilterType selectedFilter = FilterType.all;

  final eventId = Get.arguments;
  final guestController = Get.find<GuestController>();

  @override
  void initState() {
    super.initState();
    searchController.addListener(() => setState(() {}));
  }

  void _onFilterSelected(FilterType type) {
    setState(() {
      selectedFilter = type;
    });
  }

  @override
  void dispose() {
    searchController.dispose();
    super.dispose();
  }

  List<String> tiles_list = ["Invite", "Accepted", "Pending", "Declined"];


  Color _getStatusColor(GuestStatus status) {
    switch (status) {
      case GuestStatus.accepted:
        return AppColors.second_tile_color;
      case GuestStatus.rejected:
        return AppColors.accent;
      case GuestStatus.pending:
      default:
        return AppColors.emergencyColor;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,

      backgroundColor: Colors.white,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 12),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              CustomHeaderBar(
                title: "Guest Management",
                showBackButton: true,
                onBack: () => Get.back(),
              ),
              Gap(1.w),
              SearchWidget(searchController: searchController),
              Gap(3.w),
              Wrap(
                spacing: 8,
                children: [
                  _filterChip(
                    label: "All",
                    isSelected: selectedFilter == FilterType.all,
                    onTap: () => _onFilterSelected(FilterType.all),
                    bgColor: Colors.grey.shade300,
                    dotColor: AppColors.black,
                  ),
                  _filterChip(
                    label: "Accepted",
                    isSelected: selectedFilter == FilterType.accepted,
                    onTap: () => _onFilterSelected(FilterType.accepted),
                    bgColor: Colors.green.shade100,
                    dotColor: AppColors.second_tile_color,
                  ),
                  _filterChip(
                    label: "Declined",
                    isSelected: selectedFilter == FilterType.declined,
                    onTap: () => _onFilterSelected(FilterType.declined),
                    bgColor: Colors.red.shade100,
                    dotColor: AppColors.accent,
                  ),
                  _filterChip(
                    label: "Pending",
                    isSelected: selectedFilter == FilterType.pending,
                    onTap: () => _onFilterSelected(FilterType.pending),
                    bgColor: Colors.purple.shade100,
                    dotColor: AppColors.emergencyColor,
                  ),
                ],
              ),
              Gap(2.w),

              StreamBuilder<QuerySnapshot<Map<String, dynamic>>>(
                stream: guestController.FetchGuest(),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const SizedBox(
                        child: Center(child: CircularProgressIndicator()));
                  }
                  if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
                    return const SizedBox(
                        child: Center(child: Text("no data found")));
                  }

                  final allGuests = snapshot.data!.docs.map((doc) => GuestModel.fromJson(doc.data())).toList();

                  final invitedCount = allGuests.length;
                  final acceptedCount = allGuests.where((g) => g.status == GuestStatus.accepted).length;

                  final pendingCount = allGuests.where((g) => g.status == GuestStatus.pending).length;

                  final declinedCount = allGuests.where((g) => g.status == GuestStatus.rejected).length;

                  final query = searchController.text.toLowerCase();
                  final filteredGuests = allGuests.where((guest) {
                    final matchesSearch =
                        guest.guestName.toLowerCase().contains(query);
                    bool matchesFilter = true;
                    if (selectedFilter == FilterType.accepted) {
                      matchesFilter = guest.status == GuestStatus.accepted;
                    } else if (selectedFilter == FilterType.declined) {
                      matchesFilter = guest.status == GuestStatus.rejected;
                    } else if (selectedFilter == FilterType.pending) {
                      matchesFilter = guest.status == GuestStatus.pending;
                    }
                    return matchesSearch && matchesFilter;
                  }).toList();

                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          StatusSummaryCard(
                            value: invitedCount.toString(),
                            label: "Invited",
                            valueColor: Colors.black,
                          ),
                          StatusSummaryCard(
                            value: acceptedCount.toString(),
                            label: "Accepted",
                            valueColor: Colors.green,
                          ),
                          StatusSummaryCard(
                            value: pendingCount.toString(),
                            label: "Pending",
                            valueColor: Colors.red,
                          ),
                          StatusSummaryCard(
                            value: declinedCount.toString(),
                            label: "Declined",
                            valueColor: Colors.purple,
                          ),
                        ],
                      ),
                      Gap(1.h),
                      Container(
                        padding: const EdgeInsets.all(12),
                        decoration: BoxDecoration(
                          color: const Color(0xFFEAF2FF),
                          borderRadius: BorderRadius.circular(12),
                          border: Border.all(color: const Color(0xFF4D8DFF)),
                        ),
                        child: Row(
                          children: [
                            SvgPicture.asset(
                              AppIcons.light_icon,
                              color: Colors.indigo,
                            ),
                            const SizedBox(width: 10),
                            SizedBox(
                              width: 60.w,
                              height: 8.h,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  const AppText('AI Guest Scan',
                                      fontWeight: FontWeight.bold,fontSize: 14,),

                                  AppText(
                                      "$pendingCount guests haven’t opened their invite yet. "
                                          "Consider sending a reminder.",
                                      fontWeight: FontWeight.w500,fontSize: 13,),
                                ],
                              ),
                            ),
                            Gap(1.h),
                            Container(
                                height: 5.h,
                                width: 12.w,
                                decoration: BoxDecoration(
                                    color: AppColors.fieldColor,
                                    borderRadius: BorderRadius.circular(22)),
                                child: IconButton(
                                    onPressed: () {},
                                    icon: const Icon(
                                      Icons.arrow_forward_rounded,
                                      color: Colors.white,
                                      size: 20,
                                    ))),
                          ],
                        ),
                      ),
                      Gap(1.h),
                      AppText("All Guests (${filteredGuests.length})",
                          type: AppTextType.heading3),
                      Gap(1.h),
                      SizedBox(
                        height: 28.h,
                        width: 80.w,
                        child: filteredGuests.isEmpty
                            ? const Center(
                                child: Text(
                                  "No guest found",
                                  style: TextStyle(color: Colors.grey),
                                ),
                              )
                            : ListView.builder(
                                itemCount: filteredGuests.length,
                                itemBuilder: (context, index) {
                                  final guest = filteredGuests[index];
                                  return GuestReusableWidget(
                                    name: guest.guestName,
                                    role: guest.guestCategory,
                                    status:
                                        guest.status.name.capitalizeFirst!,
                                    statusColor:
                                        _getStatusColor(guest.status),
                                    profileImage: AssetImage(
                                        AppAssets.wedding_image2),
                                  );
                                },
                              ),
                      ),
                    ],
                  );
                },
              ),
              Spacer(),
              AppButtonWidget(
                onPressed: () {
                  Get.toNamed(AppRoutes.addGuest, arguments: {
                    "eventId" : eventId is Map ? eventId["eventId"] : eventId,
                  });
                },
                prefixIcon:
                const Icon(Icons.add, color: Colors.white),
                width: 120.w,
                height: 7.h,
                buttonColor: AppColors.fieldColor,
                text: "Add Guest",
                fontWeight: FontWeight.w500,
                fontSize: 14,
              ),
              Gap(1.h),
            ],
          ),
        ),
      ),
    );
  }
}

Widget _filterChip({
  required String label,
  required bool isSelected,
  required VoidCallback onTap,
  required Color bgColor,
  required Color dotColor,
}) {
  return InkWell(
    borderRadius: BorderRadius.circular(20),
    onTap: onTap,
    child: Container(
      width: 21.w,
      height: 3.h,
      decoration: BoxDecoration(
        color: isSelected ? Colors.black : bgColor,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            width: 2.w,
            height: 1.h,
            decoration: BoxDecoration(
              color: isSelected ? Colors.white : dotColor,
              shape: BoxShape.circle,
            ),
          ),
          Gap(2.w),
          Text(
            label,
            style: TextStyle(
              fontSize: 10,
              fontWeight: FontWeight.w500,
              color: isSelected ? Colors.white : Colors.black,
            ),
          ),
        ],
      ),
    ),
  );
}

enum FilterType { all, accepted, declined, pending }
