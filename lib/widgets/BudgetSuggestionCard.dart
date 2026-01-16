import 'package:flutter/material.dart';

class BudgetSuggestionCard extends StatelessWidget {
  final String category;
  final String range;
  final String suggestedAmount;
  final String icon;
  final bool isLocked;
  final Color container_color;
  final Color backgroundColor;
  final Color accentColor;

  const BudgetSuggestionCard({
    Key? key,
    required this.category,
    required this.container_color,
    required this.range,
    required this.suggestedAmount,
    required this.icon,
    this.isLocked = false,
    this.backgroundColor = const Color(0xFFF5F5F5),
    this.accentColor = const Color(0xFF4CAF50), // green
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container();
  }
}
