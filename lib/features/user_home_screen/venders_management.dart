import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:event_sense_ai/core/controller/event_controller.dart';
import 'package:event_sense_ai/core/models/event_model.dart';
import 'package:event_sense_ai/core/routes/app_routes.dart';
import 'package:event_sense_ai/core/widgets/search_widget.dart';
import 'package:event_sense_ai/features/user_home_screen/components/job_resuable_cad.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';
import '../../core/models/blueprint_model.dart';
import '../../core/repo/vendor_applicatiion_repository.dart';
import '../../core/widgets/custom_headerbar.dart';

class VendersManagement extends StatefulWidget {
  const VendersManagement({super.key});

  @override
  State<VendersManagement> createState() => _VendersManagementState();
}

class _VendersManagementState extends State<VendersManagement> {
  final TextEditingController searchController = TextEditingController();
  final eventController = Get.find<EventController>();

  String searchQuery = "";
   EventModel? eventModel;
  @override
  void initState() {
    super.initState();


    eventModel = Get.arguments;
    /// WhatsApp-style search listener
    searchController.addListener(() {
      setState(() {
        searchQuery = searchController.text.toLowerCase();
      });
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
            children: [
              CustomHeaderBar(
                title: "Vendor Management",
                showBackButton: true,
                onBack: () => Get.back(),
              ),

              Gap(1.h),
              SearchWidget(searchController: searchController),
              Gap(2.h),

              /// ---------------- STREAM + SEARCH ----------------
              Expanded(
                child: StreamBuilder<EventBlueprintModel>(
                  stream: eventController.fetchEventBlueprint(),
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return const Center(
                        child: CircularProgressIndicator(),
                      );
                    }

                    if (!snapshot.hasData) {
                      return const Center(
                        child: Text(
                          "No vendor found",
                          style: TextStyle(color: Colors.grey),
                        ),
                      );
                    }

                    final blueprint = snapshot.data!;

                    ///  WhatsApp-style filtering
                    final filteredCategories = blueprint.categories.where((c) {
                      return c.name.toLowerCase().contains(searchQuery);
                    }).toList();

                    if (filteredCategories.isEmpty) {
                      return const Center(
                        child: Text(
                          "No vendor found",
                          style: TextStyle(color: Colors.grey),
                        ),
                      );
                    }

                    return ListView.builder(
                      itemCount: filteredCategories.length,
                      itemBuilder: (context, index) {
                        final c = filteredCategories[index];
                        final sanitizedCategory = c.name.split('/').first.trim().toLowerCase();

                        return StreamBuilder<QuerySnapshot<Map<String, dynamic>>>(
                          stream: VendorApplicationRepository().fetchCategoryApplications(
                            plannerId: eventModel!.userId,
                            eventId: eventModel!.eventId,
                            categoryId: sanitizedCategory,
                          ),
                          builder: (context, appSnapshot) {
                            final count = appSnapshot.data?.docs.length ?? 0;
                            return Padding(
                              padding: const EdgeInsets.only(bottom: 12),
                              child: JobStatusCard(
                                status: _parseStatus(c.status),
                                title: c.name,
                                estimate: "Rs. ${c.estimatedBudget}",
                                icon: _getCategoryIcon(c.name),
                                applicationsCount: count,
                                onButtonTap: () {
                                  if (_parseStatus(c.status) == JobStatus.application) {
                                    Get.toNamed(AppRoutes.viewApplicationScreen,
                                        arguments: {
                                          "category": sanitizedCategory,
                                          "eventId": eventModel!.eventId,
                                        });
                                  }
                                  else if(_parseStatus(c.status) == JobStatus.booked){
                                    Get.toNamed(AppRoutes.proposalAprovalScreen,
                                        arguments: {
                                          "category": sanitizedCategory,
                                          "eventName": eventModel!.eventName,
                                          "eventLocation": eventModel!.eventLocation,
                                          "eventStartDate": eventModel!.eventStartDate,
                                          "categoryBudget": c.estimatedBudget,
                                          "eventId": eventModel!.eventId,
                                          "eventStatus": eventModel!.status,
                                          "type": eventModel!.eventType,
                                          "guests" : eventModel!.guestCount
                                        });
                                  }
                                  else {
                                    Get.toNamed(AppRoutes.userPostJobScreen,
                                        arguments: {
                                          "category": sanitizedCategory,
                                          "eventName": eventModel!.eventName,
                                          "eventLocation": eventModel!.eventLocation,
                                          "eventStartDate": eventModel!.eventStartDate,
                                          "categoryBudget": c.estimatedBudget,
                                          "eventId": eventModel!.eventId,
                                          "eventStatus": eventModel!.status,
                                          "type": eventModel!.eventType,
                                          "guests" : eventModel!.guestCount
                                        });
                                  }
                                },
                              ),
                            );
                          }
                        );
                      },
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  /// ---------------- ICON MAPPER ----------------
  IconData _getCategoryIcon(String name) {
    switch (name) {
      case "Catering":
        return Icons.restaurant;
      case "Decorations":
        return Icons.celebration;
      case "Photography":
        return Icons.videocam_outlined;
      case "Entertainment":
        return Icons.music_note;
      case "Venue Rental":
        return Icons.location_city;
      default:
        return Icons.category_rounded;
    }
  }

  JobStatus _parseStatus(String status) {
    switch (status.toLowerCase()) {
      case "posted":
        return JobStatus.posted;
      case "applied":
      case "application":
        return JobStatus.application;
      case "booked":
        return JobStatus.booked;
      default:
        return JobStatus.notStarted;
    }
  }
}
