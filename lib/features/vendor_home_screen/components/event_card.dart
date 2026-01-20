import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

class EventCard extends StatelessWidget {
  final String imagePath;
  final String dateTime;
  final String title;
  final String location;
  final VoidCallback onTap;

  const EventCard({
    super.key,
    required this.imagePath,
    required this.dateTime,
    required this.title,
    required this.location,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Container();
  }
}
