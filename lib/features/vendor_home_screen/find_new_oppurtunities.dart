import 'package:event_sense_ai/core/widgets/custom_headerbar.dart';
import 'package:event_sense_ai/core/widgets/search_widget.dart';
import 'package:event_sense_ai/utils/app_assets.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';
import 'package:sizer/sizer.dart';

import '../../core/routes/app_routes.dart';
import '../../core/widgets/app_buttons.dart';
import '../../core/widgets/apptext.dart';
import 'components/new_jobs_widget.dart';

class FindNewOppurtunities extends StatefulWidget {
  const FindNewOppurtunities({super.key});

  @override
  State<FindNewOppurtunities> createState() => _FindNewOppurtunitiesState();
}

class _FindNewOppurtunitiesState extends State<FindNewOppurtunities> {
  final TextEditingController searchController = TextEditingController();

  late List<NewJobsWidget> allJobs;
  late List<NewJobsWidget> filteredJobs;

  bool isAvailable = true;

  @override
  void initState() {
    super.initState();

    allJobs = [
      NewJobsWidget(
        tag: "Wedding",
        title: 'Professional Wedding DJ',
        dateTime: "Nov 12 / 6:00 PM",
        location: "San Francisco, CA",
        budget: "\$15,000 - \$20,000",
        imagePath: AppAssets.wedding_reception2,
      ),
      NewJobsWidget(
        tag: "Wedding",
        title: 'Luxury Wedding Photographer',
        dateTime: "Dec 02 / 5:00 PM",
        location: "Los Angeles, CA",
        budget: "\$10,000 - \$15,000",
        imagePath: AppAssets.wedding_reception2,
      ),
      NewJobsWidget(
        tag: "Corporate",
        title: 'Corporate Event DJ',
        dateTime: "Jan 15 / 7:00 PM",
        location: "New York, NY",
        budget: "\$8,000 - \$12,000",
        imagePath: AppAssets.wedding_reception2,
      ),
      NewJobsWidget(
        tag: "Birthday",
        title: 'Birthday Party DJ',
        dateTime: "Feb 20 / 8:00 PM",
        location: "Chicago, IL",
        budget: "\$4,000 - \$6,000",
        imagePath: AppAssets.wedding_reception2,
      ),
    ];

    filteredJobs = List.from(allJobs);

    searchController.addListener(_onSearchChanged);
  }

  void _onSearchChanged() {
    final query = searchController.text.toLowerCase();

    setState(() {
      if (query.isEmpty) {
        filteredJobs = List.from(allJobs);
      } else {
        filteredJobs = allJobs.where((job) {
          return job.title.toLowerCase().contains(query) ||
              job.tag.toLowerCase().contains(query);
        }).toList();
      }
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
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              CustomHeaderBar(
                title: "New Opportunities",
                subtitle: "Your AI-Curated job feed",
                showBackButton: true,
                onBack: () => context.pop(),
              ),

              Gap(1.h),
              SearchWidget(searchController: searchController),
              Gap(1.h),

              AppText(
                "Best matches for you",
                fontSize: 20,
                fontWeight: FontWeight.w600,
                color: Colors.black54,
              ),

              Gap(2.h),

              Expanded(
                child: filteredJobs.isEmpty
                    ? const Center(
                  child: Text(
                    "No job found",
                    style: TextStyle(color: Colors.grey),
                  ),
                )
                    : ListView.builder(
                  physics: const BouncingScrollPhysics(),
                  itemCount: filteredJobs.length,
                  itemBuilder: (context, index) {
                    final data = filteredJobs[index];

                    return Container(
                      height: 28.h,
                      margin: const EdgeInsets.all(8),
                      padding: const EdgeInsets.all(8),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(12),
                        border:
                        Border.all(color: Colors.grey.shade300),
                        boxShadow: [
                          BoxShadow(
                            color:
                            Colors.black.withOpacity(0.08),
                            blurRadius: 12,
                            spreadRadius: 2,
                            offset: const Offset(0, 6),
                          ),
                        ],
                      ),
                      child: Column(
                        crossAxisAlignment:
                        CrossAxisAlignment.start,
                        children: [
                          /// TOP
                          Row(
                            children: [
                              ClipRRect(
                                borderRadius:
                                BorderRadius.circular(14),
                                child: Image.asset(
                                  data.imagePath,
                                  height: 12.h,
                                  width: 30.w,
                                  fit: BoxFit.cover,
                                ),
                              ),
                              const SizedBox(width: 12),
                              Expanded(
                                child: Column(
                                  crossAxisAlignment:
                                  CrossAxisAlignment.start,
                                  children: [
                                    Container(
                                      padding:
                                      const EdgeInsets.symmetric(
                                        horizontal: 10,
                                        vertical: 4,
                                      ),
                                      decoration: BoxDecoration(
                                        color:
                                        const Color(0xffFDECEC),
                                        borderRadius:
                                        BorderRadius.circular(
                                            20),
                                      ),
                                      child: AppText(
                                        data.tag,
                                        fontSize: 10,
                                        fontWeight:
                                        FontWeight.w500,
                                        color:
                                        Colors.redAccent,
                                      ),
                                    ),
                                    const SizedBox(height: 6),
                                    AppText(
                                      data.title,
                                      fontSize: 16,
                                      fontWeight:
                                      FontWeight.w600,
                                    ),
                                    const SizedBox(height: 8),
                                    Row(
                                      children: [
                                        const Icon(
                                          Icons
                                              .calendar_month_outlined,
                                          size: 16,
                                          color:
                                          Colors.blueGrey,
                                        ),
                                        const SizedBox(width: 6),
                                        AppText(
                                          data.dateTime,
                                          fontSize: 12,
                                          color: Colors.grey,
                                        ),
                                      ],
                                    ),
                                    const SizedBox(height: 4),
                                    Row(
                                      children: [
                                        const Icon(
                                          Icons
                                              .location_on_outlined,
                                          size: 16,
                                          color:
                                          Colors.blueGrey,
                                        ),
                                        const SizedBox(width: 6),
                                        AppText(
                                          data.location,
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

                          Gap(2.h),
                          Divider(color: Colors.grey.shade300),
                          Gap(1.h),

                          /// BOTTOM
                          Row(
                            mainAxisAlignment:
                            MainAxisAlignment.spaceBetween,
                            children: [
                              Column(
                                crossAxisAlignment:
                                CrossAxisAlignment.start,
                                children: [
                                  AppText(
                                    "Budget",
                                    fontSize: 17,
                                    fontWeight:
                                    FontWeight.w700,
                                    color: Colors
                                        .indigo.shade900,
                                  ),
                                  const SizedBox(height: 4),
                                  AppText(
                                    data.budget,
                                    fontSize: 16,
                                    fontWeight:
                                    FontWeight.w600,
                                  ),
                                ],
                              ),
                              AppButtonWidget(
                                width: 20.w,
                                height: 5.h,
                                buttonColor:
                                Colors.indigo.shade400,
                                text: "Apply",
                                onPressed: () {
                                  context.pushNamed(
                                      AppRoutes
                                          .SubmitApplications);
                                },
                              ),
                            ],
                          ),
                        ],
                      ),
                    );
                  },
                ),
              ),

              Gap(1.h),

              /// -------- AVAILABILITY --------
              AppText(
                "Availability",
                fontSize: 20,
                fontWeight: FontWeight.w600,
              ),

              Container(
                width: 100.w,
                height: 6.h,
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(12),
                  border:
                  Border.all(color: Colors.grey.shade300),
                ),
                child: Row(
                  children: [
                    _availabilityButton(
                      label: "Yes Available",
                      selected: isAvailable,
                      onTap: () {
                        setState(() => isAvailable = true);
                      },
                    ),
                    _availabilityButton(
                      label: "No",
                      selected: !isAvailable,
                      onTap: () {
                        setState(() => isAvailable = false);
                      },
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

/// -------- Availability Button --------
Widget _availabilityButton({
  required String label,
  required bool selected,
  required VoidCallback onTap,
}) {
  return InkWell(
    splashColor: Colors.transparent,
    onTap: onTap,
    child: Container(
      margin: const EdgeInsets.only(left: 12),
      height: 5.h,
      width: 40.w,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        color: selected ? Colors.indigo : Colors.grey.shade50,
        border: Border.all(color: Colors.grey.shade300),
      ),
      child: Center(
        child: AppText(
          label,
          fontSize: 16,
          fontWeight: FontWeight.w600,
          color: selected ? Colors.white : Colors.grey,
        ),
      ),
    ),
  );
}
