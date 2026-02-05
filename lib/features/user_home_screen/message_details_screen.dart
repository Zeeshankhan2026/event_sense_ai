import 'dart:ui';
import 'package:event_sense_ai/utils/app_assets.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

import '../../core/controller/planner_chat_controller.dart';
import '../../core/widgets/apptext.dart';

class MessageDetailsScreen extends StatelessWidget {
  MessageDetailsScreen(
      {super.key,});

  final messageTextController = TextEditingController();
  final application = Get.arguments as Map<String ,dynamic>;
  final controller = Get.find<PlannerChatController>();

  final active_eventdata = Get.arguments as Map<String,dynamic>;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Padding(
              padding: const EdgeInsets.all(12),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(22),
                child: BackdropFilter(
                  filter: ImageFilter.blur(sigmaX: 18, sigmaY: 18),
                  child: Container(
                    height: 70,
                    padding: const EdgeInsets.symmetric(horizontal: 12),
                    decoration: BoxDecoration(
                      color: Colors.white.withOpacity(0.7),
                      borderRadius: BorderRadius.circular(22),
                      border: Border.all(
                        color: Colors.grey.withOpacity(0.15),
                      ),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.06),
                          blurRadius: 12,
                          offset: const Offset(0, 6),
                        ),
                      ],
                    ),
                    child: Row(
                      children: [
                        IconButton(
                          icon: const Icon(Icons.arrow_back_ios,
                              color: Colors.black87),
                          onPressed: () => Navigator.pop(context),
                        ),

                        /// Profile
                        Stack(
                          children: [
                            CircleAvatar(
                              radius: 20,
                              backgroundImage: AssetImage(AppAssets.person_1),
                            ),
                            Positioned(
                              bottom: 0,
                              right: 0,
                              child: Container(
                                width: 10,
                                height: 10,
                                decoration: BoxDecoration(
                                  color: Colors.green,
                                  shape: BoxShape.circle,
                                  border: Border.all(
                                      color: Colors.white, width: 1.5),
                                ),
                              ),
                            ),
                          ],
                        ),

                        const Gap(12),

                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            AppText(
                             application["vendorName"],
                              fontSize: 17,
                              fontWeight: FontWeight.w700,
                              color: Colors.black87,
                            ),
                            const Gap(2),
                            AppText(
                              "Active 1h ago",
                              fontSize: 12,
                              color: Colors.grey.shade600,
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
            Expanded(
              child: Obx(() {
                if (controller.messages.isEmpty) {
                  return const Center(
                    child: AppText("Start the conversation"),
                  );
                }

                return ListView.builder(
                  padding: const EdgeInsets.symmetric(horizontal: 14),
                  itemCount: controller.messages.length,
                  itemBuilder: (context, index) {
                    final doc = controller.messages[index];
                    final data = doc.data() as Map<String, dynamic>;

                    final isMe =
                        data["senderId"] == controller.plannerId;

                    return Align(
                      alignment:
                      isMe ? Alignment.centerRight : Alignment.centerLeft,
                      child: Container(
                        margin: const EdgeInsets.symmetric(vertical: 4),
                        padding: const EdgeInsets.all(10),
                        constraints: BoxConstraints(
                          maxWidth: MediaQuery.of(context).size.width * 0.7,
                        ),
                        decoration: BoxDecoration(
                          color: isMe
                              ? const Color(0xFF007AFF)
                              : Colors.grey.shade200,
                          borderRadius: BorderRadius.circular(14),
                        ),
                        child: AppText(
                          data["message"] ?? "",
                          color: isMe ? Colors.white : Colors.black87,
                          fontSize: 14,
                        ),
                      ),
                    );
                  },
                );
              }),
            ),

            ///  Glass Input Bar (White)
            Padding(
              padding: const EdgeInsets.all(14),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(30),
                child: BackdropFilter(
                  filter: ImageFilter.blur(sigmaX: 20, sigmaY: 20),
                  child: Container(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 16, vertical: 10),
                    decoration: BoxDecoration(
                      color: Colors.white.withOpacity(0.85),
                      borderRadius: BorderRadius.circular(30),
                      border: Border.all(
                        color: Colors.grey.withOpacity(0.2),
                      ),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.05),
                          blurRadius: 12,
                          offset: const Offset(0, 4),
                        ),
                      ],
                    ),
                    child: Row(
                      children: [
                        Icon(Icons.emoji_emotions_outlined,
                            color: Colors.grey.shade700),

                        const Gap(10),

                        Expanded(
                          child: TextField(
                            controller: controller.messageController,
                            style: const TextStyle(
                                color: Colors.black87),
                            decoration: InputDecoration(
                              hintText: "Message...",
                              hintStyle: TextStyle(
                                  color: Colors.grey.shade500),
                              border: InputBorder.none,
                              isDense: true,
                            ),
                          ),
                        ),

                        Icon(Icons.link,
                            color: Colors.grey.shade700),

                        const Gap(10),

                        /// Send Button
                        Container(
                          height: 42,
                          width: 42,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            gradient: const LinearGradient(
                              colors: [
                                Color(0xFF4FACFE),
                                Color(0xFF007AFF),
                              ],
                            ),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.blue.withOpacity(0.35),
                                blurRadius: 8,
                                offset: const Offset(0, 4),
                              ),
                            ],
                          ),
                          child: IconButton(
                            icon: const Icon(Icons.send,
                                color: Colors.white, size: 20),
                            onPressed: () async  {
                              await controller.sendMessage();
                            },
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
