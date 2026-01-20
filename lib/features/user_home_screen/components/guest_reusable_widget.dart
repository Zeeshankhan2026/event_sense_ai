import 'package:flutter/material.dart';

class ProfileStatusCard extends StatelessWidget {
  final String name;
  final String role;
  final String status;
  final Color statusColor;
  final ImageProvider profileImage;
  final IconData roleIcon;
  final IconData status_icon;

  const ProfileStatusCard({
    Key? key,
    required this.name,
    required this.role,
    required this.status,
    required this.statusColor,
    required this.profileImage,
    this.roleIcon = Icons.group,
    this.status_icon = Icons.check,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container();
  }
}
