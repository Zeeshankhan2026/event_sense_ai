import 'package:event_sense_ai/core/widgets/app_buttons.dart';
import 'package:event_sense_ai/core/widgets/apptext.dart';
import 'package:event_sense_ai/utils/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:sizer/sizer.dart';

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
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.08),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        children: [
          //  IMAGE + OVERLAY
          Stack(
            children: [
              // Background Image
              ClipRRect(
                borderRadius: const BorderRadius.vertical(
                  top: Radius.circular(16),
                ),
                child: Image.asset(
                  imagePath,
                  height: 240,
                  width: double.infinity,
                  fit: BoxFit.cover,
                ),
              ),

              // Dark Overlay
              Positioned.fill(
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: const BorderRadius.vertical(
                      top: Radius.circular(16),
                    ),
                    color: Colors.black.withOpacity(0.4),
                  ),
                ),
              ),

              //  BOTTOM CONTENT ON IMAGE
              Positioned(
                left: 16,
                right: 16,
                bottom: 16,
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    // LEFT SIDE CONTENT
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          // Status
                          Row(
                            children: [
                              Icon(statusIcon, color: statusColor, size: 18),
                              const SizedBox(width: 6),
                              Text(
                                status,
                                style: const TextStyle(
                                  color: Colors.white,
                                  fontSize: 14,
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 6),

                          // Company Name
                          Text(
                            companyName,
                            style: const TextStyle(
                              color: Colors.white,
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const SizedBox(height: 4),

                          // Rating
                          Row(
                            children: [
                              const Icon(
                                Icons.star,
                                color: Colors.amber,
                                size: 16,
                              ),
                              const SizedBox(width: 4),
                              Text(
                                "$rating",
                                style: const TextStyle(color: Colors.white),
                              ),
                              const SizedBox(width: 6),
                              Text(
                                "($reviewCount reviews)",
                                style: const TextStyle(
                                  color: Colors.white70,
                                  fontSize: 12,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),

                    // RIGHT SIDE PRICE
                    Column(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        const Text(
                          "Proposed",
                          style: TextStyle(color: Colors.white70, fontSize: 12),
                        ),
                        Text(
                          price,
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),

          // BOTTOM BUTTONS (OUTSIDE IMAGE)
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                AppButtonWidget(
                  text: "View Proposal",
                  onPressed: onViewProposal,
                  width: 50.w,
                  height: 6.h,
                  buttonColor: AppColors.fieldColor,
                ),
                Container(
                  decoration: BoxDecoration(
                    color: Colors.grey.shade300,
                    shape: BoxShape.circle
                  ),
                  child: IconButton(
                    onPressed: onChat,
                    icon: const Icon(Icons.chat_bubble_outline),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
