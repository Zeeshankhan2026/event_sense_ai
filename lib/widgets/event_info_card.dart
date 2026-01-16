import 'package:flutter/material.dart';

class EventInfoCard extends StatelessWidget {
  final String value;
  final String label;
  final String icon;
  final Color backgroundColor;
  final Color container_color;
  final Color textColor;

  const EventInfoCard({
    Key? key,
    required this.value,
    required this.container_color,
    required this.label,
    required this.icon,
    this.backgroundColor = const Color(0xFFF5F5F5),
    this.textColor = Colors.black,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container();
  }
}
