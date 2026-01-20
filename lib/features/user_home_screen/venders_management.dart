import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';
import 'package:sizer/sizer.dart';

import '../../core/routes/app_routes.dart';
import '../../core/widgets/custom_headerbar.dart';
import '../../core/widgets/search_widget.dart';
import 'components/service_card.dart';

class VendersManagement extends StatefulWidget {
  const VendersManagement({super.key});

  @override
  State<VendersManagement> createState() => _VendersManagementState();
}

class _VendersManagementState extends State<VendersManagement> {
  final TextEditingController searchController = TextEditingController();

  late List<Map<String, dynamic>> allServices;
  late List<Map<String, dynamic>> filteredServices;

  @override
  void initState() {
    super.initState();

    allServices = [
      {
        "title": "Photography",
        "status": "Not Started",
        "estimate": "\$2,500 - \$3,000",
        "action": "Post Job",
        "icon": Icons.camera_alt,
        "color": Colors.grey,
        "onPressed": () {
          context.pushNamed(AppRoutes.UserPostJobScreen);
        }
      },
      {
        "title": "Catering",
        "status": "3 Applications",
        "estimate": "\$5,000",
        "action": "View Application",
        "icon": Icons.restaurant_menu,
        "color": Colors.green,
        "onPressed": () {
          context.pushNamed(AppRoutes.ViewApplicationScreen);
        }
      },
      {
        "title": "DJ and Sound",
        "status": "Vendor Booked",
        "estimate": "\$1,900",
        "action": "View Booking",
        "icon": Icons.music_note,
        "color": Colors.blue,
        "onPressed": () {}
      },
      {
        "title": "Decoration",
        "status": "Not Started",
        "estimate": "\$1,200",
        "action": "Post Job",
        "icon": Icons.celebration,
        "color": Colors.grey,
        "onPressed": () {}
      },
    ];

    filteredServices = List.from(allServices);

    searchController.addListener(_onSearchChanged);
  }

  void _onSearchChanged() {
    final query = searchController.text.toLowerCase();

    setState(() {
      if (query.isEmpty) {
        filteredServices = List.from(allServices);
      } else {
        filteredServices = allServices
            .where((service) =>
            service["title"].toLowerCase().contains(query))
            .toList();
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
            children: [
              CustomHeaderBar(
                title: "Vendor Management",
                showBackButton: true,
                onBack: () => context.pop(),
              ),
              SearchWidget(searchController: searchController),
              Gap(1.h),

              Expanded(
                child: filteredServices.isEmpty
                    ? const Center(
                  child: Text(
                    "No vendor found",
                    style: TextStyle(color: Colors.grey),
                  ),
                )
                    : ListView.builder(
                  padding: EdgeInsets.zero,
                  physics: const BouncingScrollPhysics(),
                  itemCount: filteredServices.length,
                  itemBuilder: (context, index) {
                    final item = filteredServices[index];

                    return Padding(
                      padding: const EdgeInsets.only(bottom: 12),
                      child: ServiceStatusCard(
                        voidCallback: item["onPressed"],
                        title: item["title"],
                        status: item["status"],
                        estimate: item["estimate"],
                        actionLabel: item["action"],
                        icon: item["icon"],
                        statusColor: item["color"],
                      ),
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
}
