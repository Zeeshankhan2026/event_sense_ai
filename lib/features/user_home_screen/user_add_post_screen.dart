import 'package:event_sense_ai/utils/app_colors.dart';
import 'package:event_sense_ai/utils/app_icons.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';
import 'package:sizer/sizer.dart';

import '../../core/widgets/apptext.dart';
import '../../core/widgets/custom_headerbar.dart';

class UserPostJobScreen extends StatefulWidget {
  const UserPostJobScreen({super.key});

  @override
  State<UserPostJobScreen> createState() => _UserPostJobScreenState();
}

class _UserPostJobScreenState extends State<UserPostJobScreen> {
  RangeValues budgetRange = const RangeValues(500, 2900);
  final TextEditingController jobDescriptionController =
      TextEditingController();
  final TextEditingController specialInstructionController =
      TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xffF5F5F5),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            CustomHeaderBar(title: "New Request", showBackButton: true,onBack: (){
              context.pop();
            },),
            // Event Details
            Container(
              height: 20.h,
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: AppColors.first_tile_color.withOpacity(0.04),
                borderRadius: BorderRadius.circular(16),
                border: BoxBorder.all(color: Colors.greenAccent),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.05),
                    blurRadius: 8,
                    offset: const Offset(0, 4),
                  ),
                ],
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      AppText(
                        "Event Name",
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                        color: Colors.grey.shade500,
                      ),
                      SizedBox(height: 4),
                      AppText(
                        "Wedding 2025",
                        fontSize: 18,
                        fontWeight: FontWeight.w600,
                        color: Colors.grey.shade900,
                      ),
                      Spacer(),
                      AppText(
                        "Date",
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                        color: Colors.grey.shade500,
                      ),
                      SizedBox(height: 4),
                      AppText(
                        "Oct 24, 2024",
                        fontSize: 18,
                        fontWeight: FontWeight.w600,
                        color: Colors.grey.shade900,
                      ),
                    ],
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      AppText(
                        "Category",
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                        color: Colors.grey.shade500,
                      ),
                      SizedBox(height: 4),
                      Row(
                        children: [
                          SvgPicture.asset(
                            AppIcons.catering_icon,
                            color: Colors.yellowAccent,
                            height: 18,
                          ),
                          Gap(1.w),
                          AppText(
                            "Catering",
                            fontSize: 18,
                            fontWeight: FontWeight.w600,
                            color: Colors.grey.shade900,
                          ),
                        ],
                      ),
                      Spacer(),
                      AppText(
                        "City",
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                        color: Colors.grey.shade500,
                      ),
                      SizedBox(height: 4),
                      AppText(
                        "San Francisco",
                        fontSize: 18,
                        fontWeight: FontWeight.w600,
                        color: Colors.grey.shade900,
                      ),
                    ],
                  ),
                ],
              ),
            ),
            const SizedBox(height: 24),

            // Requirements
            const Text(
              "Requirements",
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 16),
            Container(
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(16),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.05),
                    blurRadius: 8,
                    offset: const Offset(0, 4),
                  ),
                ],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: const [
                      Text(
                        "Budget Range",
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text(
                        "\$500 - \$2,000",
                        style: TextStyle(fontSize: 14, color: Colors.grey),
                      ),
                    ],
                  ),
                  const SizedBox(height: 16),
                  RangeSlider(
                    values: budgetRange,
                    min: 500,
                    max: 2900,
                    divisions: 48,
                    labels: RangeLabels(
                      "\$${budgetRange.start.round()}",
                      "\$${budgetRange.end.round()}",
                    ),
                    onChanged: (values) {
                      setState(() {
                        budgetRange = values;
                      });
                    },
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: const [
                      Text(
                        "\$1K",
                        style: TextStyle(fontSize: 12, color: Colors.grey),
                      ),
                      Text(
                        "\$2K",
                        style: TextStyle(fontSize: 12, color: Colors.grey),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            const SizedBox(height: 24),

            // Job Description
            buildTextField(
              label: "Job Description",
              hint: "Describe what you need...",
              controller: jobDescriptionController,
            ),
            const SizedBox(height: 16),

            // Special Instructions
            buildTextField(
              label: "Special Instruction",
              hint: "Gate codes, parking info, dietary restrictions...",
              controller: specialInstructionController,
            ),
            const SizedBox(height: 32),

            // Buttons
            Row(
              children: [
                Expanded(
                  child: OutlinedButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    child: const Text("Cancel"),
                  ),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: ElevatedButton(
                    onPressed: () {
                      // Post job logic
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.indigo.shade900,
                      padding: const EdgeInsets.symmetric(vertical: 14),
                    ),
                    child: const Text(
                      "Post Job",
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget buildEventDetail(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        children: [
          Text(
            "$label: ",
            style: const TextStyle(fontWeight: FontWeight.w600, fontSize: 14),
          ),
          Text(value, style: const TextStyle(fontSize: 14)),
        ],
      ),
    );
  }

  Widget buildTextField({
    required String label,
    required String hint,
    required TextEditingController controller,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: const TextStyle(fontWeight: FontWeight.w600, fontSize: 14),
        ),
        const SizedBox(height: 6),
        TextFormField(
          controller: controller,
          maxLines: 3,
          decoration: InputDecoration(
            hintText: hint,
            filled: true,
            fillColor: Colors.white,
            contentPadding: const EdgeInsets.all(12),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
              borderSide: BorderSide.none,
            ),
          ),
        ),
      ],
    );
  }
}
