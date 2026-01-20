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
import '../../core/widgets/search_widget.dart';
import 'components/guest_reusable_widget.dart';

class GuestList extends StatefulWidget {
  const GuestList({super.key});

  @override
  State<GuestList> createState() => _GuestListState();
}

class _GuestListState extends State<GuestList> {
  final TextEditingController searchController = TextEditingController();

  late List<ProfileStatusCard> allGuests;
  late List<ProfileStatusCard> filteredGuests;

  FilterType selectedFilter = FilterType.all;

  @override
  void initState() {
    super.initState();

    allGuests = [
      ProfileStatusCard(
        name: "Sara Jenkis",
        role: "Sent 2d ago",
        status: "Pending",
        status_icon: Icons.warning,
        statusColor: AppColors.first_tile_color,
        profileImage:  AssetImage(AppAssets.wedding_image2),
        roleIcon: Icons.email_outlined,
      ),
      ProfileStatusCard(
        name: "Tara Jenkis",
        role: "+1 (Partner)",
        status: "Accepted",
        status_icon: Icons.check,
        roleIcon: Icons.person_outline,
        statusColor: AppColors.second_tile_color,
        profileImage:  AssetImage(AppAssets.wedding_image2),
      ),
      ProfileStatusCard(
        name: "Dev Jenkis",
        role: "Out of town",
        status: "Declined",
        status_icon: Icons.cancel_outlined,
        statusColor: AppColors.emergencyColor,
        roleIcon: Icons.cancel_outlined,
        profileImage:  AssetImage(AppAssets.wedding_image2),
      ),
    ];

    filteredGuests = List.from(allGuests);

    searchController.addListener(_onSearchChanged);
  }

  void _onSearchChanged() {
    final query = searchController.text.toLowerCase();

    setState(() {
      if (query.isEmpty) {
        filteredGuests = List.from(allGuests);
      } else {
        filteredGuests = allGuests
            .where((guest) =>
            guest.name.toLowerCase().contains(query))
            .toList();
      }
    });
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
                onBack: () => context.pop(),
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

              Gap(3.w),

              AppText("All Guests (${filteredGuests.length})",
                  type: AppTextType.heading3),
              Gap(1.h),

              Expanded(
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

                    return Padding(
                      padding: const EdgeInsets.only(bottom: 12),
                      child: Row(
                        children: [
                          SizedBox(
                            height: 8.h,
                            width: 20.w,
                            child: Stack(
                              children: [
                                 CircleAvatar(
                                  radius: 32,
                                  backgroundImage: AssetImage(
                                      AppAssets.wedding_image2),
                                ),
                                Positioned(
                                  top: 5.h,
                                  left: 12.w,
                                  child: Container(
                                    height: 20,
                                    width: 20,
                                    decoration: BoxDecoration(
                                      color: guest.statusColor,
                                      borderRadius:
                                      BorderRadius.circular(12),
                                    ),
                                    child: Icon(
                                      guest.status_icon,
                                      size: 14,
                                      color: Colors.white,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Expanded(
                            child: Column(
                              crossAxisAlignment:
                              CrossAxisAlignment.start,
                              children: [
                                Text(
                                  guest.name,
                                  style: const TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                                const SizedBox(height: 4),
                                Row(
                                  children: [
                                    Icon(guest.roleIcon,
                                        size: 14,
                                        color: Colors.grey),
                                    const SizedBox(width: 4),
                                    Text(
                                      guest.role,
                                      style: const TextStyle(
                                        fontSize: 12,
                                        color: Colors.grey,
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                          Container(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 10, vertical: 6),
                            decoration: BoxDecoration(
                              color:
                              guest.statusColor.withOpacity(0.1),
                              borderRadius: BorderRadius.circular(20),
                            ),
                            child: AppText(
                              guest.status,
                              fontSize: 12,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ],
                      ),
                    );
                  },
                ),
              ),

              AppButtonWidget(
                onPressed: () {
                  context.pushNamed(AppRoutes.AddGuest);
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
