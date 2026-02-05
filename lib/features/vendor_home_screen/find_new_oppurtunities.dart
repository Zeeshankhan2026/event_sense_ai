import 'package:event_sense_ai/core/controller/vendor_controller.dart';
import 'package:event_sense_ai/core/controller/vendor_job_controller.dart';
import 'package:event_sense_ai/core/models/jobs_model.dart';
import 'package:event_sense_ai/core/widgets/custom_headerbar.dart';
import 'package:event_sense_ai/core/widgets/search_widget.dart';
import 'package:event_sense_ai/utils/app_assets.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
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
  final VendorController vendorController = Get.find<VendorController>();
  final VendorJobController jobController = Get.find<VendorJobController>();

  late Stream<QuerySnapshot<Map<String, dynamic>>> _jobsStream;
  String _searchQuery = "";

  bool isAvailable = true;

  @override
  void initState() {
    super.initState();
    final vendor = vendorController.vendor.value!;
    _jobsStream = jobController.loadJobs(
      vendor.serviceCategory!.trim().toLowerCase(),
      vendor.location!.trim().toLowerCase(),
    );

    searchController.addListener(_onSearchChanged);
  }

  void _onSearchChanged() {
    setState(() {
      _searchQuery = searchController.text.toLowerCase().trim();
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
                // subtitle: "Your AI-Curated job feed",
                showBackButton: true,
                onBack: () => Navigator.of(context).pop(),
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
                child: StreamBuilder<QuerySnapshot<Map<String, dynamic>>>(
                  stream: _jobsStream,
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return const Center(child: CircularProgressIndicator());
                    }

                    if (snapshot.hasError) {
                      return Center(child: Text("Error: ${snapshot.error}"));
                    }

                    if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
                      return const Center(
                        child: Text(
                          "No new opportunities found",
                          style: TextStyle(color: Colors.grey),
                        ),
                      );
                    }

                    // Map Firestore docs to Model and apply search filter
                    final allJobs = snapshot.data!.docs.map((doc) {
                      return VendorJobModel.fromMap(doc.data());
                    }).toList();

                    final filteredJobs = _searchQuery.isEmpty
                        ? allJobs
                        : allJobs.where((job) {
                            return job.title.toLowerCase().contains(
                                  _searchQuery,
                                ) ||
                                job.city.toLowerCase().contains(_searchQuery);
                          }).toList();

                    if (filteredJobs.isEmpty) {
                      return const Center(
                        child: Text(
                          "No matching jobs found",
                          style: TextStyle(color: Colors.grey),
                        ),
                      );
                    }

                    return ListView.builder(
                      physics: const BouncingScrollPhysics(),
                      itemCount: filteredJobs.length,
                      itemBuilder: (context, index) {
                        final data = filteredJobs[index];

                        return NewOppurtunityJobCard(
                          category: data.eventType,
                          title: data.title,
                          date: data.eventDate,
                          location: data.city,
                          budget: data.budget.toString(),
                          imageUrl: AppAssets.wedding_reception2,
                          onApply: () {
                            Get.toNamed(AppRoutes.submitApplications,
                              arguments: data,
                            );
                          },
                        );
                      },
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
                  border: Border.all(color: Colors.grey.shade300),
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
