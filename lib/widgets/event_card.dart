import 'package:flutter/material.dart';

class EventCard extends StatelessWidget {
  final String title;
  final String date;
  final String location;
  final String imagePath;
  final String calender_image;
  final String location_icon;
  final String peoples_image;
  final String wallet;
  final int attendees;
  final double cost;
  final String countdown;
  final VoidCallback? onTap;

  const EventCard({
    Key? key,
    required this.title,
    required this.peoples_image,
    required this.wallet,
    required this.calender_image,
    required this.location_icon,
    required this.date,
    required this.location,
    required this.imagePath,
    required this.attendees,
    required this.cost,
    required this.countdown,
    this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;

    return GestureDetector(
      onTap: onTap,
      child: Container(
        margin: const EdgeInsets.symmetric(vertical: 8),
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: cs.surface,
          borderRadius: BorderRadius.circular(16),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.06),
              blurRadius: 6,
              offset: const Offset(0, 3),
            ),
          ],
        ),
        child: Row(
          children: [
            // Thumbnail
            ClipRRect(
              borderRadius: BorderRadius.circular(12),
              child: Image.asset(
                imagePath,
                width: 80,
                height: 80,
                fit: BoxFit.cover,
              ),
            ),
            const SizedBox(width: 12),

            // Event details
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(title,
                      style: const TextStyle(
                          fontSize: 16, fontWeight: FontWeight.bold)),
                  const SizedBox(height: 4),
                  Text('$date • $location',
                      style: const TextStyle(
                          fontSize: 13, color: Colors.black54)),
                  const SizedBox(height: 8),
                  Row(
                    children: [
                      _infoChip('${attendees} Attendees'),
                      const SizedBox(width: 6),
                      _infoChip('\$${cost.toStringAsFixed(0)}'),
                      const SizedBox(width: 6),
                      _infoChip('$countdown left'),
                    ],
                  ),
                ],
              ),
            ),

            // Arrow icon
            const Icon(Icons.arrow_forward_ios, size: 18, color: Colors.black45),
          ],
        ),
      ),
    );
  }

  Widget _infoChip(String text) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      decoration: BoxDecoration(
        color: Colors.grey.shade200,
        borderRadius: BorderRadius.circular(8),
      ),
      child: Text(text,
          style: const TextStyle(fontSize: 11, color: Colors.black87)),
    );
  }
}
