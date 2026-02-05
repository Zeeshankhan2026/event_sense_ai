import 'package:flutter/material.dart';

import 'InProgressReusableWidget.dart';
class BudgetUsedCard extends StatelessWidget {
  final double  used;
  final double total;

  const BudgetUsedCard({
    super.key,
    required this.used,
    required this.total,
  });

  @override
  Widget build(BuildContext context) {
    final percent = (used / total).clamp(0, 1);

    return DashboardStatCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          /// Header
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: const [
              Text(
                'Budgets Used',
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w500,
                  color: Colors.grey,
                ),
              ),
              Icon(Icons.account_balance_wallet_outlined, size: 20),
            ],
          ),

          const SizedBox(height: 12),

          /// Amount
          Text(
            '\$${(used / 1000).toStringAsFixed(1)}k',
            style: const TextStyle(
              fontSize: 26,
              fontWeight: FontWeight.bold,
            ),
          ),

          const SizedBox(height: 4),

          Text(
            'of \$${total.toStringAsFixed(0)} cap',
            style: const TextStyle(fontSize: 12, color: Colors.grey),
          ),

          const SizedBox(height: 14),

          /// Progress
          ClipRRect(
            borderRadius: BorderRadius.circular(6),
            child: LinearProgressIndicator(
              value: 200,
              minHeight: 8,
              backgroundColor: Colors.grey.shade200,
              valueColor:
              const AlwaysStoppedAnimation<Color>(Color(0xff1E2A5A)),
            ),
          ),

          const SizedBox(height: 8),

          /// Percentage
          Align(
            alignment: Alignment.centerRight,
            child: Text(
              '${(percent * 100).toInt()}%',
              style: const TextStyle(fontSize: 12, color: Colors.grey),
            ),
          ),
        ],
      ),
    );
  }
}
