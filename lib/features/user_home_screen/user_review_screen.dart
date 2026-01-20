import 'package:event_sense_ai/core/routes/app_routes.dart';
import 'package:event_sense_ai/utils/app_assets.dart';
import 'package:event_sense_ai/utils/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:sizer/sizer.dart';

import '../../core/widgets/app_buttons.dart';
import '../../core/widgets/apptext.dart';

class UserReviewScreen extends StatelessWidget {
  const UserReviewScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF7F8FC),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              // HEADER
              Row(
                children: const [
                  Icon(Icons.close, size: 20),
                  SizedBox(width: 12),
                  Text(
                    "Review Vendor",
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
                  ),
                ],
              ),

              const SizedBox(height: 24),

              // VENDOR IMAGE
              CircleAvatar(
                radius: 36,
                backgroundImage: AssetImage(
                  AppAssets.wedding_reception2, // replace
                ),
              ),

              const SizedBox(height: 12),

              // VENDOR NAME
              AppText(
                "Apex Catering",
                fontSize: 18,
                fontWeight: FontWeight.w600,
              ),

              const SizedBox(height: 4),

              // VENDOR LOCATION
              AppText(
                "Catering Services · London, UK",
                fontSize: 13,
                color: Colors.grey,
              ),

              const SizedBox(height: 20),

              const Divider(),

              const SizedBox(height: 20),

              // QUESTION 1
              AppText(
                "How was their services?",
                fontSize: 20,
                fontWeight: FontWeight.w600,
              ),

              const SizedBox(height: 12),

              // STAR RATING
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: List.generate(
                  5,
                  (index) => const Icon(
                    Icons.star_border,
                    size: 32,
                    color: Colors.grey,
                  ),
                ),
              ),

              const SizedBox(height: 24),

              // QUESTION 2
              Padding(
                padding: const EdgeInsets.only(left: 18.0),
                child: Align(
                  alignment: Alignment.centerLeft,
                  child: AppText(
                    "Would you hire them again?",
                    fontSize: 15,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ),

              const SizedBox(height: 12),

              // YES / NO BUTTONS
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  _OptionButton(
                    icon: Icons.thumb_up_alt_outlined,
                    label: "Yes",
                    isSelected: false,
                  ),
                  const SizedBox(width: 12),
                  _OptionButton(
                    icon: Icons.thumb_down_alt_outlined,
                    label: "No",
                    isSelected: false,
                  ),
                ],
              ),

              const SizedBox(height: 24),

              // WRITE REVIEW
              Align(
                alignment: Alignment.centerLeft,
                child: AppText(
                  "Write a Review",
                  fontSize: 15,
                  fontWeight: FontWeight.w600,
                ),
              ),

              const SizedBox(height: 8),

              // TEXT FIELD
              Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(10),
                  border: Border.all(color: Colors.grey.shade300),
                ),
                child: const TextField(
                  maxLines: 4,
                  decoration: InputDecoration(
                    border: InputBorder.none,
                    hintText:
                        "Share details about communications, quality and timeliness",
                    hintStyle: TextStyle(fontSize: 13),
                  ),
                ),
              ),

              const Spacer(),

              // SUBMIT BUTTON
              AppButtonWidget(
                onPressed: (){
                  context.goNamed(AppRoutes.VendersManagement);
                },
                text: "Submit  Review",
                width: 80.w,
                height: 6.h,
                buttonColor: AppColors.fieldColor,
                fontSize: 16,
                fontWeight: FontWeight.w600,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// YES / NO BUTTON WIDGET
class _OptionButton extends StatelessWidget {
  final IconData icon;
  final String label;
  final bool isSelected;

  const _OptionButton({
    required this.icon,
    required this.label,
    required this.isSelected,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 40.w,
      height: 10.h,
      decoration: BoxDecoration(
        color: isSelected ? const Color(0xFF1D2A5B) : Colors.grey.shade200,
        borderRadius: BorderRadius.circular(10),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(icon, size: 18, color: isSelected ? Colors.white : Colors.black),
          const SizedBox(width: 6),
          Text(
            label,
            style: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w500,
              color: isSelected ? Colors.white : Colors.black,
            ),
          ),
        ],
      ),
    );
  }
}
