import 'package:event_sense_ai/features/user_home_screen/message_details_screen.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../../core/widgets/apptext.dart';

class ChatTile extends StatelessWidget {
  final String name;
  final String messagePreview;
  final String time;
  final IconData statusIcon;
  final String profileImage;
  ChatTile({
    super.key,

    required this.name,
    required this.messagePreview,
    required this.time,
    required this.statusIcon,
    required this.profileImage,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: () {
        Navigator.of(context).push(
          MaterialPageRoute(
            builder: (context) =>
                MessageDetailsScreen(name: name, user_image: profileImage),
          ),
        );
      },
      leading: CircleAvatar(
        radius: 26,
        backgroundImage: AssetImage(profileImage),
      ),
      title: AppText(name, fontSize: 17, fontWeight: FontWeight.w400),
      subtitle: AppText(
        messagePreview,
        fontSize: 14,
        fontWeight: FontWeight.w400,
        color: Colors.grey,
      ),
      trailing: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          AppText(time, fontSize: 12, color: Colors.grey),
          const SizedBox(height: 4),
          Icon(statusIcon, size: 16, color: Colors.grey),
        ],
      ),
    );
  }
}
