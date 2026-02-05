import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:sizer/sizer.dart';

class NewOppurtunityJobCard extends StatelessWidget {
  final String category;
  final String title;
  final String date;
  final String location;
  final String budget;
  final String imageUrl;
  final VoidCallback onApply;

  const NewOppurtunityJobCard({
    super.key,
    required this.category,
    required this.title,
    required this.date,
    required this.location,
    required this.budget,
    required this.imageUrl,
    required this.onApply,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin:  const EdgeInsets.only(top: 4) ,
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(14),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.08),
            blurRadius: 20,
            spreadRadius: 2,
            offset: const Offset(0, 10),
          ),
        ],
      ),
      child: Column(
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              /// Left Image
              ClipRRect(
                borderRadius: BorderRadius.circular(10),
                child: Image.asset(
                  imageUrl,
                  height: 90,
                  width: 90,
                  fit: BoxFit.cover,
                ),
              ),

              const Gap(12),

              /// Right Content
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    /// Category Chip
                    Container(
                      padding:
                      const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                      decoration: BoxDecoration(
                        color: Colors.pink.shade50,
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Text(
                        category,
                        style: TextStyle(
                          color: Colors.pink.shade600,
                          fontSize: 12,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),

                    const Gap(6),

                    /// Title
                    Text(
                      title,
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                      ),
                    ),

                    const Gap(6),

                    /// Date Row
                    Row(
                      children: [
                        const Icon(Icons.calendar_today,
                            size: 14, color: Colors.grey),
                        const Gap(6),
                        Text(
                          date,
                          style: const TextStyle(
                            fontSize: 13,
                            color: Colors.grey,
                          ),
                        ),
                      ],
                    ),

                    const Gap(4),

                    /// Location Row
                    Row(
                      children: [
                        const Icon(Icons.location_on,
                            size: 14, color: Colors.grey),
                        const Gap(6),
                        Text(
                          location,
                          style: const TextStyle(
                            fontSize: 13,
                            color: Colors.grey,
                          ),
                        ),
                      ],
                    ),

                    const Gap(10),



                  ],
                ),
              ),
            ],
          ),
          Divider(),
          /// Bottom Row
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              /// Budget
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                   Text(
                    "Budget",
                    style: TextStyle(
                      fontSize: 13,
                      fontWeight: FontWeight.bold,
                      color: Colors.indigo.shade900,
                    ),
                  ),
                  Gap(6),
                  Text(
                    "\$: ${budget}",
                    style: const TextStyle(
                      fontSize: 16,

                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ],
              ),

              /// Apply Button
              SizedBox(
                height: 36,
                width: 35.w,
                child: ElevatedButton(
                  onPressed: onApply,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF1C2C5B),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  child: const Text("Apply", style: TextStyle(color: Colors.white),),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
