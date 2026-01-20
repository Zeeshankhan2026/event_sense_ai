import 'package:flutter/material.dart';

class ProposalCard extends StatelessWidget {
  final String imagePath;
  final String status;
  final IconData statusIcon;
  final Color statusColor;
  final String companyName;
  final double rating;
  final int reviewCount;
  final String price;
  final VoidCallback onViewProposal;
  final VoidCallback onChat;

  const ProposalCard({
    super.key,
    required this.imagePath,
    required this.status,
    required this.statusIcon,
    required this.statusColor,
    required this.companyName,
    required this.rating,
    required this.reviewCount,
    required this.price,
    required this.onViewProposal,
    required this.onChat,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 220,
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16),
        image: DecorationImage(
          image: AssetImage(imagePath),
          fit: BoxFit.cover,
        ),
      ),
      child: Stack(
        children: [
          // Overlay
          Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(16),
              color: Colors.black.withOpacity(0.4),
            ),
          ),

          // Content
          Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Status
                Row(
                  children: [
                    Icon(statusIcon, color: statusColor, size: 18),
                    const SizedBox(width: 6),
                    Text(status,
                        style: const TextStyle(color: Colors.white, fontSize: 14)),
                  ],
                ),
                const Spacer(),

                // Company Name
                Text(
                  companyName,
                  style: const TextStyle(
                      color: Colors.white,
                      fontSize: 20,
                      fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 6),

                // Rating
                Row(
                  children: [
                    const Icon(Icons.star, color: Colors.amber, size: 16),
                    const SizedBox(width: 4),
                    Text("$rating", style: const TextStyle(color: Colors.white)),
                    const SizedBox(width: 6),
                    Text("($reviewCount reviews)",
                        style: const TextStyle(color: Colors.white70, fontSize: 12)),
                  ],
                ),
                const SizedBox(height: 6),

                // Price
                Text(price,
                    style: const TextStyle(
                        color: Colors.white,
                        fontSize: 16,
                        fontWeight: FontWeight.w600)),

                const SizedBox(height: 12),

                // Buttons
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    ElevatedButton(
                      onPressed: onViewProposal,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.white,
                        foregroundColor: Colors.black,
                        padding: const EdgeInsets.symmetric(
                            horizontal: 20, vertical: 10),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                      ),
                      child: const Text("View Proposal"),
                    ),
                    GestureDetector(
                      onTap: onChat,
                      child: const Icon(Icons.chat_bubble_outline,
                          color: Colors.white, size: 24),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
