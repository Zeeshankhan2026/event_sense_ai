import 'dart:developer';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:event_sense_ai/core/controller/event_controller.dart';
import 'package:event_sense_ai/core/repo/event_repository.dart';
import 'package:event_sense_ai/core/widgets/custom_headerbar.dart';
import 'package:event_sense_ai/utils/app_assets.dart';
import 'package:event_sense_ai/utils/app_icons.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:go_router/go_router.dart';
import 'package:sizer/sizer.dart';

import '../../../core/routes/app_routes.dart';
import '../../../core/widgets/app_buttons.dart';
import '../../../core/widgets/search_widget.dart';
import '../../../utils/app_colors.dart';
import '../components/event_screen_card.dart';

class EventScreen extends StatefulWidget {
  const EventScreen({super.key});

  @override
  State<EventScreen> createState() => _EventScreenState();
}

class _EventScreenState extends State<EventScreen>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;
  final TextEditingController searchController = TextEditingController();

  late List<Map<String, dynamic>> allEventsData = [];
  final controller = Get.find<EventController>();

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);
    _tabController.addListener(() {
      setState(() {}); // Rebuild to filter based on tab
    });
    searchController.addListener(() {
      setState(() {}); // Rebuild to filter based on search
    });
  }

  @override
  void dispose() {
    _tabController.dispose();
    searchController.dispose();
    super.dispose();
  }

  List<Map<String, dynamic>> _filterEvents(
      List<QueryDocumentSnapshot<Map<String, dynamic>>> docs) {

    final query = searchController.text.toLowerCase();

    return docs
        .map((doc) => {...doc.data(), "id": doc.id})
        .where((event) {

      final status = (event["status"] ?? "").toString().toLowerCase();
      bool matchesTab = false;

      // IN PROGRESS TAB
      if (_tabController.index == 0) {
        matchesTab = status == "approved" ||
            status == "pending" ||
            status == "in_progress";
      }

      //  COMPLETED TAB
      else if (_tabController.index == 1) {
        matchesTab = status == "completed";
      }

      // CANCELED TAB
      else if (_tabController.index == 2) {
        matchesTab = status == "canceled";
      }

      if (!matchesTab) return false;

      // SEARCH FILTER
      if (query.isEmpty) return true;

      final name = (event["eventName"] ?? "").toString().toLowerCase();
      final type = (event["eventType"] ?? "").toString().toLowerCase();
      final location =
      (event["eventLocation"] ?? "").toString().toLowerCase();

      return name.contains(query) ||
          type.contains(query) ||
          location.contains(query);
    }).toList();
  }


  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;

    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 4),
          child: Column(
            children: [
              Gap(5.h),

              ///  SEARCH
              SearchWidget(searchController: searchController),

              Gap(2.h),
              _tabBar(),

              Expanded(
                child: StreamBuilder<QuerySnapshot<Map<String, dynamic>>>(
                  stream: controller.allEventsStream(),
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return const Center(child: CircularProgressIndicator());
                    }

                    if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
                      return const Center(
                        child: Text(
                          "No events found",
                          style: TextStyle(color: Colors.grey),
                        ),
                      );
                    }

                    final filteredDocs = _filterEvents(snapshot.data!.docs);

                    if (filteredDocs.isEmpty) {
                      return const Center(
                        child: Text(
                          "No events found",
                          style: TextStyle(color: Colors.grey),
                        ),
                      );
                    }

                    return TabBarView(
                      controller: _tabController,
                      physics: const NeverScrollableScrollPhysics(), // Managed by tab controller
                      children: [
                        _buildEventList(filteredDocs),
                        _buildEventList(filteredDocs), // Same list, filteredDocs already considers tab
                        _buildEventList(filteredDocs),
                      ],
                    );
                  },
                ),
              ),
              
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 8.0),
                child: AppButtonWidget(
                  prefixIcon: const Icon(Icons.add, color: Colors.white, size: 30),
                  onPressed: () {
                    Get.toNamed(AppRoutes.createEvent);
                  },
                  width: width * 0.85,
                  height: height * 0.06,
                  buttonColor: AppColors.fieldColor,
                  text: "Add Event",
                ),
              ),
              Gap(1.h),
            ],
          ),
        ),
      ),
    );
  }

  Widget  _buildEventList(List<Map<String, dynamic>> events) {
    return ListView.builder(
      padding: const EdgeInsets.all(16),
      itemCount: events.length,
      itemBuilder: (context, index) {
        final event = events[index];

        return GestureDetector(
          onTap: () {
            // Check status to decide where to go
            if (event["status"] == "Approved") {
              Get.toNamed(AppRoutes.eventDetails, arguments: event["id"]);
            } else {
              Get.toNamed(AppRoutes.generateAiScreen, arguments: event["id"]);
            }
          },
          child: EventScreenCard(
            imageUrl: event["eventBannerImage"] ?? AppAssets.wedding_image, // Use banner or fallback
            location_icon: AppIcons.location_icon,
            wallet_icon: AppIcons.wallet_icon,
            title: event["eventName"] ?? "Event Name",
            description: event["eventDescriptions"] ?? "Event Description",
            daysLeft: calculateDaysLeft(event["eventStartDate"]),
            people: AppIcons.people_icon,
            price: (event["eventBudget"] ?? 0).toString(),
            date: event["eventStartDate"] ?? "Date",
            location: event["eventLocation"] ?? "Location",
            attendence: (event["guestCount"] ?? "0").toString(),
          ),
        );
      },
    );
  }

  Widget _tabBar() {
    return TabBar(
      controller: _tabController,
      indicatorColor: Colors.blue,
      labelColor: Colors.blue,
      unselectedLabelColor: Colors.grey,
      tabs: const [
        Tab(text: "In Progress"),
        Tab(text: "Completed"),
        Tab(text: "Canceled"),
      ],
    );
  }
  String calculateDaysLeft(dynamic startDate) {
    if (startDate == null) return "Date nahi hai";

    DateTime eventDate;

    // 🔹 Firestore Timestamp
    if (startDate is Timestamp) {
      eventDate = startDate.toDate();
    }

    // 🔹 String format: dd/MM/yyyy
    else if (startDate is String) {
      try {
        final parts = startDate.split('/');
        if (parts.length != 3) return "Invalid date";

        final day = int.parse(parts[0]);
        final month = int.parse(parts[1]);
        final year = int.parse(parts[2]);

        eventDate = DateTime(year, month, day);
      } catch (e) {
        return "Invalid date";
      }
    } else {
      return "Invalid date";
    }

    //  Sirf date compare (time ignore)
    final now = DateTime.now();
    final todayDate = DateTime(now.year, now.month, now.day);
    final eventOnlyDate =
    DateTime(eventDate.year, eventDate.month, eventDate.day);

    final difference = eventOnlyDate.difference(todayDate).inDays;

    if (difference < 0) {
      return "Event passed";
    } else if (difference == 0) {
      return "Today";
    } else {
      return "$difference days left";
    }
  }



}
