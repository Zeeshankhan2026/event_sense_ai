import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

import 'components/notification_tile_widget.dart';

class NotificationScreen extends StatefulWidget {
  const NotificationScreen({super.key});

  @override
  State<NotificationScreen> createState() => _NotificationScreenState();
}

class _NotificationScreenState extends State<NotificationScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController _dotController;

  final List<Map<String, dynamic>> newNotifications = [
    {
      "icon": Icons.check_circle,
      "iconColor": Colors.green,
      "title": "Sarah Jenkins Accepted",
      "message": "RSVP confirmed for the main ceremony.",
      "time": "12 min ago",
      "isUnread": true,
    },
    {
      "icon": Icons.hourglass_bottom,
      "iconColor": Colors.red,
      "title": "Over Budget Alert",
      "message": "Catering expense have reached \$400.",
      "time": "15 min ago",
      "isUnread": true,
    },
  ];

  final List<Map<String, dynamic>> earlierNotifications = [
    {
      "icon": Icons.check_circle,
      "iconColor": Colors.green,
      "title": "Sarah Jenkins Accepted",
      "message": "RSVP confirmed for the main ceremony.",
      "time": "1 day ago",
      "isUnread": false,
    },
    {
      "icon": Icons.hourglass_bottom,
      "iconColor": Colors.red,
      "title": "Over Budget Alert",
      "message": "Catering expense have reached \$400.",
      "time": "2 days ago",
      "isUnread": false,
    },
  ];

  @override
  void initState() {
    super.initState();
    _dotController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1200),
    )..repeat(reverse: true);
  }

  @override
  void dispose() {
    _dotController.dispose();
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
              const Gap(12),
              glassHeader("Notifications"),

              const Gap(16),
              Expanded(
                child: ListView(
                  physics: const BouncingScrollPhysics(),
                  children: [
                    sectionTitle("New"),
                    const Gap(8),

                    ...newNotifications.map(
                          (n) => glassTile(
                        child: buildNotificationTile(n),
                      ),
                    ),

                    const Gap(24),

                    sectionTitle("Earlier"),
                    const Gap(8),

                    ...earlierNotifications.map(
                          (n) => glassTile(
                        child: buildNotificationTile(n),
                      ),
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

  /// 🔹 Notification Tile + Unread Dot
  Widget buildNotificationTile(Map<String, dynamic> notification) {
    return Stack(
      children: [
        NotificationTile(
          icon: notification["icon"],
          iconColor: notification["iconColor"],
          title: notification["title"],
          message: notification["message"],
          time: notification["time"],
        ),
        if (notification["isUnread"])
          Positioned(
            right: 8,
            top: 8,
            child: FadeTransition(
              opacity: Tween(begin: 0.4, end: 1.0)
                  .animate(_dotController),
              child: Container(
                width: 10,
                height: 10,
                decoration: const BoxDecoration(
                  color: Color(0xFF007AFF),
                  shape: BoxShape.circle,
                ),
              ),
            ),
          ),
      ],
    );
  }

  Widget glassTile({required Widget child}) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(18),
        child: BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 12, sigmaY: 12),
          child: Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: Colors.white.withOpacity(0.9),
              borderRadius: BorderRadius.circular(18),
              border: Border.all(
                color: Colors.grey.withOpacity(0.2),
              ),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.05),
                  blurRadius: 8,
                  offset: const Offset(0, 4),
                ),
              ],
            ),
            child: child,
          ),
        ),
      ),
    );
  }
  Widget glassHeader(String title) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(22),
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 18, sigmaY: 18),
        child: Container(
          width: double.infinity,
          padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 12),
          decoration: BoxDecoration(
            color: Colors.white.withOpacity(0.85),
            borderRadius: BorderRadius.circular(22),
            border: Border.all(color: Colors.grey.withOpacity(0.2)),
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
                icon: const Icon(Icons.arrow_back_ios_new, size: 20),
                onPressed: () {
                  Navigator.pop(context);
                },
              ),
              Expanded(
                child: Center(
                  child: Text(
                    title,
                    style: const TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ),
              ),
              const SizedBox(width: 40),
            ],
          ),
        ),
      ),
    );
  }


  Widget sectionTitle(String text) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 4),
      child: Text(
        text,
        style: const TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.w700,
        ),
      ),
    );
  }
}
