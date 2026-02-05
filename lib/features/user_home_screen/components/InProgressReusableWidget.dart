import 'package:event_sense_ai/core/widgets/apptext.dart';
import 'package:flutter/material.dart';



class TotalGuestsCard extends StatelessWidget {
  final int total;
  final int max;
  final double yesPercent;
  final double maybePercent;
  final double noPercent;

  const TotalGuestsCard({
    super.key,
    required this.total,
    required this.max,
    required this.yesPercent,
    required this.maybePercent,
    required this.noPercent,
  });

  @override
  Widget build(BuildContext context) {
    return DashboardStatCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          /// Header
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              AppText("Total Guests",  fontSize: 14,
                fontWeight: FontWeight.w500,
                color: Colors.grey,),
              const Icon(Icons.group_outlined, size: 20),
            ],
          ),

          const SizedBox(height: 12),

          /// Count
          RichText(
            text: TextSpan(
              children: [
                TextSpan(
                  text: '$total',
                  style: const TextStyle(
                    fontSize: 26,
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                  ),
                ),
                TextSpan(
                  text: ' / $max',
                  style: const TextStyle(
                    fontSize: 14,
                    color: Colors.grey,
                  ),
                ),
              ],
            ),
          ),

          const SizedBox(height: 34),

          /// Progress Bar
          ClipRRect(
            borderRadius: BorderRadius.circular(6),
            child: Row(
              children: [
                _bar(yesPercent, Colors.green),
                _bar(maybePercent, Colors.orange),
                _bar(noPercent, Colors.grey.shade300),
              ],
            ),
          ),

          const SizedBox(height: 10),

          /// Legend
          Row(
            children: const [
              _LegendDot(label: 'Yes', color: Colors.green),
              SizedBox(width: 6),
              _LegendDot(label: 'Maybe', color: Colors.orange),
              SizedBox(width: 6),
              _LegendDot(label: 'No', color: Colors.grey),
            ],
          ),
        ],
      ),
    );
  }

  Widget _bar(double value, Color color) {
    return Expanded(
      flex: (value * 100).toInt(),
      child: Container(height: 8, color: color),
    );
  }
}

class _LegendDot extends StatelessWidget {
  final String label;
  final Color color;

  const _LegendDot({
    required this.label,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        CircleAvatar(radius: 4, backgroundColor: color),
        const SizedBox(width: 6),
        Text(
          label,
          style: const TextStyle(fontSize: 12, color: Colors.grey),
        ),
      ],
    );
  }
}
class DashboardStatCard extends StatelessWidget {
  final Widget child;

  const DashboardStatCard({
    super.key,
    required this.child,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: const Color(0xffEAEAEA)),
      ),
      child: child,
    );
  }
}
