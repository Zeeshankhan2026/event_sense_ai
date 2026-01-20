import 'package:event_sense_ai/utils/app_assets.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:sizer/sizer.dart';

import '../../core/routes/app_routes.dart';
import '../../core/widgets/apptext.dart';
import '../../core/widgets/custom_headerbar.dart';

class ProposalApprovalScreen extends StatelessWidget {
  const ProposalApprovalScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF7F8FC),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [

              CustomHeaderBar(title: "Vendors Applications",showBackButton: true,onBack: (){
                context.pop();
              },),
              const SizedBox(height: 24),

              // VENDOR INFO
              Row(
                children: [
                  CircleAvatar(
                    radius: 26,
                    backgroundImage: AssetImage(
                      AppAssets.wedding_reception2, // replace
                    ),
                  ),
                  const SizedBox(width: 12),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: const [
                      AppText("Catering and Dalish", fontSize: 16,
                        fontWeight: FontWeight.w600,),
                      SizedBox(height: 4),
                      Row(
                        children: [
                          Icon(Icons.location_on_outlined, size: 14, color: Colors.grey),
                          SizedBox(width: 4),
                          AppText("San Francisco", fontSize: 13, color: Colors.grey)
                        ],
                      ),
                    ],
                  ),
                ],
              ),

              const SizedBox(height: 24),

              // INVOICE STATUS
             AppText("Invoice Status", fontSize: 16, fontWeight: FontWeight.w600),

              const SizedBox(height: 12),

              // INVOICE CARD
              Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(14),
                  border: Border.all(color: Colors.grey.shade200),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // TOP ROW
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: const [
                           AppText("Total Due",   fontSize: 13,
                             color: Colors.grey,),
                            SizedBox(height: 4),
                            AppText("\$ 4,500",  fontSize: 22,
                                fontWeight: FontWeight.bold,
                                color: Color(0xFF1D2A5B)),
                            SizedBox(height: 4),
                            AppText( "Invoice #INV-2024-001",  fontSize: 12,
                              color: Color(0xFF1D2A5B))
                          ],
                        ),
                        Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 12,
                            vertical: 6,
                          ),
                          decoration: BoxDecoration(
                            color: Colors.red.shade100,
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child: const Text(
                            "Pending",
                            style: TextStyle(
                              fontSize: 12,
                              color: Colors.red,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                      ],
                    ),

                    const SizedBox(height: 20),

                    // STATUS ICONS
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        _StatusItem(
                          icon: Icons.check,
                          label: "Received",
                          isActive: true,
                        ),
                        Container(
                          width: 20.w,
                          height: 1,
                          color: Colors.grey.shade200,
                        ),
                        _StatusItem(
                          icon: Icons.arrow_upward,
                          label: "Approval",
                          isActive: true,
                        ),
                        Container(
                          width: 20.w,
                          height: 1,
                          color: Colors.grey.shade200,
                        ),
                        _StatusItem(
                          icon: Icons.attach_money,
                          label: "Paid",
                          isActive: false,
                        ),
                      ],
                    ),

                    const SizedBox(height: 20),

                    // DUE DATE
                    const Text(
                      "Due Date",
                      style: TextStyle(fontSize: 13, color: Colors.grey),
                    ),
                    const SizedBox(height: 4),
                    const Text(
                      "Dec 30, 2025",
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ],
                ),
              ),

              const Spacer(),

              // APPROVED BUTTON
              SizedBox(
                width: double.infinity,
                height: 48,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF1D2A5B),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  onPressed: () {
                    context.pushNamed(AppRoutes.UserReviewScreen);
                  },
                  child: const AppText("Approved Order",fontSize: 16,fontWeight: FontWeight.w600,color: Colors.white,)
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// STATUS ITEM WIDGET
class _StatusItem extends StatelessWidget {
  final IconData icon;
  final String label;
  final bool isActive;

  const _StatusItem({
    required this.icon,
    required this.label,
    required this.isActive,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          width: 44,
          height: 44,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: isActive ? const Color(0xFF1D2A5B) : Colors.grey.shade200,
          ),
          child: Icon(icon, color: isActive ? Colors.white : Colors.grey),
        ),
        const SizedBox(height: 6),
        Text(
          label,
          style: TextStyle(
            fontSize: 12,
            color: isActive ? Colors.black : Colors.grey,
          ),
        ),
      ],
    );
  }
}
