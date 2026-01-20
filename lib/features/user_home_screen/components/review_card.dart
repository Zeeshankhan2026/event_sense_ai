import 'package:flutter/material.dart';

class ReviewCard extends StatelessWidget {
  final String userName;
  final String userImage;
  final double rating;
  final String timeAgo;
  final String reviewText;
  final VoidCallback? onMenuTap;

  const ReviewCard({
    super.key,
    required this.userName,
    required this.userImage,
    required this.rating,
    required this.timeAgo,
    required this.reviewText,
    this.onMenuTap,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // HEADER
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // PROFILE IMAGE
              CircleAvatar(
                radius: 22,
                backgroundImage: AssetImage(userImage),
              ),

              const SizedBox(width: 12),

              // NAME + STARS + TIME
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      userName,
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Row(
                      children: [
                        _buildStars(rating),
                        const SizedBox(width: 8),
                        Text(
                          timeAgo,
                          style: TextStyle(
                            fontSize: 12,
                            color: Colors.grey.shade600,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),

              // MENU
              GestureDetector(
                onTap: onMenuTap,
                child: const Icon(Icons.more_vert),
              ),
            ],
          ),

          const SizedBox(height: 12),

          // REVIEW TEXT
          Text(
            reviewText,
            style: TextStyle(
              fontSize: 14,
              color: Colors.grey.shade800,
              height: 1.4,
            ),
          ),

          const SizedBox(height: 12),

          const Divider(height: 1),
        ],
      ),
    );
  }

  /// STAR BUILDER
  Widget _buildStars(double rating) {
    return Row(
      children: List.generate(5, (index) {
        return Icon(
          index < rating.floor()
              ? Icons.star
              : Icons.star_border,
          color: Colors.amber,
          size: 16,
        );
      }),
    );
  }
}
