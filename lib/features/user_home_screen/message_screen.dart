import 'dart:ui';
import 'package:event_sense_ai/utils/app_assets.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:sizer/sizer.dart';

import '../../core/widgets/apptext.dart';
import 'components/chat_tile_widget.dart';

class MessageScreen extends StatelessWidget {
  const MessageScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 12),
          child: Column(
            children: [
              const Gap(12),

              /// 🔹 Glass Header
              ClipRRect(
                borderRadius: BorderRadius.circular(22),
                child: BackdropFilter(
                  filter: ImageFilter.blur(sigmaX: 18, sigmaY: 18),
                  child: Container(
                    width: double.infinity,
                    padding: const EdgeInsets.symmetric(
                        horizontal: 16, vertical: 16),
                    decoration: BoxDecoration(
                      color: Colors.white.withOpacity(0.85),
                      borderRadius: BorderRadius.circular(22),
                      border: Border.all(
                        color: Colors.grey.withOpacity(0.2),
                      ),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.06),
                          blurRadius: 12,
                          offset: const Offset(0, 6),
                        ),
                      ],
                    ),
                    child: Center(
                      child: AppText(
                        "Messages",
                        fontSize: 20,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ),
                ),
              ),

              const Gap(16),

              /// 🔹 Glass Search Bar
              ClipRRect(
                borderRadius: BorderRadius.circular(22),
                child: BackdropFilter(
                  filter: ImageFilter.blur(sigmaX: 16, sigmaY: 16),
                  child: Container(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    decoration: BoxDecoration(
                      color: Colors.white.withOpacity(0.9),
                      borderRadius: BorderRadius.circular(22),
                      border: Border.all(
                        color: Colors.grey.withOpacity(0.25),
                      ),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.05),
                          blurRadius: 10,
                          offset: const Offset(0, 4),
                        ),
                      ],
                    ),
                    child: const TextField(
                      decoration: InputDecoration(
                        icon: Icon(Icons.search, color: Colors.grey),
                        hintText: "Search",
                        border: InputBorder.none,
                      ),
                    ),
                  ),
                ),
              ),

              const Gap(16),

              /// 🔹 Chat List
              Expanded(
                child: ListView(
                  physics: const BouncingScrollPhysics(),
                  children:  [
                    ChatTile(
                      name: "Martin Randolph",
                      messagePreview: "You: What's man!",
                      time: "9:40 AM",
                      statusIcon: Icons.circle_outlined,
                      profileImage: AppAssets.person_1,
                    ),
                    ChatTile(
                      name: "Andrew Parker",
                      messagePreview: "You: Ok, thanks!",
                      time: "9:25 AM",
                      statusIcon: Icons.done_all,
                      profileImage: AppAssets.person_2,
                    ),
                    ChatTile(
                      name: "Karen Castillo",
                      messagePreview: "You: Ok, See you in To...",
                      time: "Fri",
                      statusIcon: Icons.done_all,
                      profileImage: AppAssets.person_3,
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
