import 'package:event_sense_ai/features/user_home_screen/components/chat_tile_widget.dart';
import 'package:event_sense_ai/utils/app_assets.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:go_router/go_router.dart';

import '../../core/widgets/custom_headerbar.dart';
import '../../core/widgets/search_widget.dart';

class VendorMessageScreen extends StatefulWidget {
  const VendorMessageScreen({super.key});

  @override
  State<VendorMessageScreen> createState() => _VendorMessageScreenState();
}

class _VendorMessageScreenState extends State<VendorMessageScreen> {
  final TextEditingController searchController = TextEditingController();

  late List<Map<String, dynamic>> allChats;
  late List<Map<String, dynamic>> filteredChats;

  @override
  void initState() {
    super.initState();

    allChats = [
      {
        "name": "Martin Randolph",
        "message": "You: What's man!",
        "time": "9:40 AM",
        "icon": Icons.circle_outlined,
        "image": AppAssets.person_1,
      },
      {
        "name": "Andrew Parker",
        "message": "You: Ok, thanks!",
        "time": "9:25 AM",
        "icon": Icons.done_all,
        "image": AppAssets.person_2,
      },
      {
        "name": "Karen Castillo",
        "message": "You: Ok, See you in To...",
        "time": "Fri",
        "icon": Icons.done_all,
        "image": AppAssets.person_3,
      },
    ];

    filteredChats = List.from(allChats);

    searchController.addListener(_onSearchChanged);
  }

  void _onSearchChanged() {
    final query = searchController.text.toLowerCase();

    setState(() {
      if (query.isEmpty) {
        filteredChats = List.from(allChats);
      } else {
        filteredChats = allChats.where((chat) {
          return chat["name"].toLowerCase().contains(query) ||
              chat["message"].toLowerCase().contains(query);
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
          padding: const EdgeInsets.symmetric(horizontal: 12),
          child: Column(
            children: [
              CustomHeaderBar(
                title: "Messages",
                showBackButton: true,
                onBack: () => Navigator.of(context).pop(),
              ),

              const Gap(16),

              /// 🔍 Search
              SearchWidget(searchController: searchController),

              const Gap(16),

              /// 💬 Chat List
              Expanded(
                child: filteredChats.isEmpty
                    ? const Center(
                  child: Text(
                    "No chats found",
                    style: TextStyle(color: Colors.grey),
                  ),
                )
                    : ListView.builder(
                  physics: const BouncingScrollPhysics(),
                  itemCount: filteredChats.length,
                  itemBuilder: (context, index) {
                    final chat = filteredChats[index];

                    return ChatTile(
                      name: chat["name"],
                      messagePreview: chat["message"],
                      time: chat["time"],
                      statusIcon: chat["icon"],
                      profileImage: chat["image"],
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
