import 'package:event_sense_ai/utils/app_colors.dart';
import 'package:event_sense_ai/utils/app_icons.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';
import 'package:sizer/sizer.dart';

import '../../core/widgets/app_buttons.dart';
import '../../core/widgets/apptext.dart';
import '../../core/widgets/custom_headerbar.dart';
import 'components/BudgetSuggestionCard.dart';

class BudgetBreakdown extends StatelessWidget {
   BudgetBreakdown({super.key});
  final List<BudgetSuggestionCard> budgetBreakdown = [
    BudgetSuggestionCard(
        category: "Catering",
        range: "\$4k - \$6k",
        container_color: AppColors.first_tile_color.withOpacity(0.6),
        suggestedAmount: "\$4.500",
        icon: AppIcons.catering_icon
    ),
    BudgetSuggestionCard(
        category: "Decor",
        range: "\$4k - \$6k",
        container_color: AppColors.second_tile_color.withOpacity(0.6),
        suggestedAmount: "\$1500",
        icon: AppIcons.decore_icon),
    BudgetSuggestionCard(
        category: "Tech",
        range: "\$4k - \$6k",
        container_color: AppColors.third_tile_color.withOpacity(0.6),
        suggestedAmount: "\$451",
        icon: AppIcons.decore_icon),
    BudgetSuggestionCard(

        category: "Photography",
        range: "\$4k - \$6k",
        container_color: AppColors.third_tile_color.withOpacity(0.6),
        suggestedAmount: "\$321",
        icon: AppIcons.decore_icon),
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                CustomHeaderBar(title: "AI Budget Breakdown",showBackButton: true,onBack: (){
                  context.pop();
                },),
                Gap(2.w),
                Container(
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: const Color(0xFFF4F6FF),
                    borderRadius: BorderRadius.circular(14),
                    border: Border.all(
                      color: const Color(0xFF4A6CFF),
                      width: 1.2,
                    ),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      /// Title
                     AppText( "Total Estimated Budget",fontSize: 13,
                       fontWeight: FontWeight.w500,
                       color: Colors.black54,),
                      Gap(1.h),
                      AppText( "Budget",fontSize: 15,
                        fontWeight: FontWeight.w700,
                        color: Colors.black87,),
                      Gap(1.h),
                      /// Total Amount
                      AppText("\$15000", type: AppTextType.heading4,fontSize: 24,),
                      Gap(2.h),
                      /// Bottom Row
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          _BudgetInfo(
                            icon: Icons.account_balance_wallet_outlined,
                            label: "Allocated",
                            value: "20,000",
                            valueColor: Colors.green,
                          ),
                          _BudgetInfo(
                            icon: Icons.hourglass_bottom,
                            label: "Remaining",
                            value: "45,000",
                            valueColor: Colors.red,
                          ),
                        ],
                      ),

                    ],
                  ),
                ),
                Gap(1.h),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    AppText( "Distribution",fontSize: 14, fontWeight: FontWeight.w600,color: Colors.grey,),
                    AppText(  "100% Allocated",fontSize: 14, color: Colors.grey,fontWeight: FontWeight.w600,)
                  ],
                ),
                const SizedBox(height: 8),
                ClipRRect(
                  borderRadius: BorderRadius.circular(8),
                  child: Row(
                    children: [
                      _segment(0.2, Colors.indigo),       // 20%
                      _segment(0.15, Colors.purple.shade200), // 15%
                      _segment(0.25, Colors.blue),        // 25%
                      _segment(0.2, Colors.pinkAccent),   // 20%
                      _segment(0.15, Colors.orange),      // 15%
                      _segment(0.05, Colors.grey.shade400), // 5%
                    ],
                  ),
                ),
                Gap(1.h),
                AppText('Categories Breakdown', fontSize: 20,fontWeight: FontWeight.w600,),
                Gap(1.h),


                Expanded(
                  child: ListView.builder(
                    itemCount: budgetBreakdown.length,
                      itemBuilder: (context,index) {
                      final data = budgetBreakdown[index];
                    return   Container(
                      padding: const EdgeInsets.all(14),
                      decoration: BoxDecoration(
                        color: data.backgroundColor,
                        borderRadius: BorderRadius.circular(12),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.05),
                            blurRadius: 6,
                            offset: const Offset(0, 3),
                          ),
                        ],
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          // Top row: icon + category + lock
                          Row(
                            children: [
                              Row(
                                children: [
                                  Container(
                                    width :16.w,
                                      height: 6.h,
                                      decoration: BoxDecoration(
                                        color: data.container_color,
                                        borderRadius: BorderRadius.circular(12),
                                      ),
                                      child: Center(child: SvgPicture.asset(data.icon,))),
                                  const SizedBox(width: 8),
                                  Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Row(
                                        children: [
                                          Column(
                                            crossAxisAlignment: CrossAxisAlignment.start,
                                            children: [
                                              AppText(data.category,color: Colors.indigo.shade900,fontWeight: FontWeight.w600,fontSize: 16,),
                                              Text(
                                                "Range: ${data.range}",
                                                style: const TextStyle(fontSize: 12, color: Colors.black54),
                                              ),
                                            ],
                                          ),
                                          Gap(35.w),
                                          const Icon(Icons.lock_outline, size: 20, color: Colors.grey),
                                        ],
                                      )
                                    ],
                                  )
                                ],
                              ),


                            ],
                          ),
                          const SizedBox(height: 6),
                          // Suggested label
                         AppText("Suggested Amount",fontSize: 10,fontWeight: FontWeight.w700,color: data.container_color,),
                          const SizedBox(height: 6),

                          // Suggested amount box
                          Container(
                            width: 100.w,
                            height: 5.h,
                            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
                            decoration: BoxDecoration(
                              color: Colors.grey.shade200,
                              borderRadius: BorderRadius.circular(8),
                            ),
                            child: AppText(data.suggestedAmount)
                          ),


                        ],
                      ),
                    );
                  }),
                ),
                Gap(1.h),
                Row(
                  children: [
                    Expanded(
                        child: AppButtonWidget(
                          width: 100.w,
                          height: 5.h,
                          buttonColor: Color(0xFF2F3C7E),
                          text: "Approved Budget", fontSize: 14,fontWeight: FontWeight.w500,)
                    ),
                    const SizedBox(width: 12),
                    Container(
                      width: 15.w,
                      height: 5.h,
                      decoration: BoxDecoration(
                        color: Colors.transparent,

                        border: BoxBorder.all(
                          width: 1,color: Colors.grey.shade400
                        ),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: IconButton(
                        icon: const Icon(Icons.refresh, color: Colors.black38),
                        onPressed: () {
                          print("Refresh tapped");
                        },
                      ),
                    ),
                  ],
                ),
                Gap(1.h),
              ],
            ),
          )
      ),
    );
  }
  Widget _segment(double flex, Color color) {
    return Expanded(
      flex: (flex * 100).toInt(),
      child: Container(
        height: 10,
        color: color,
      ),
    );
  }

}
class _BudgetInfo extends StatelessWidget {
  final IconData icon;
  final String label;
  final String value;
  final Color valueColor;

  const _BudgetInfo({
    required this.icon,
    required this.label,
    required this.value,
    required this.valueColor,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Gap(2.h),
        Row(
          children: [
            Icon(icon,size: 18,),
            AppText(label, color: Colors.grey.shade600,fontSize: 14,fontWeight: FontWeight.w800,),

          ],
        ),
        AppText("\$${value.toString()}",color: valueColor,fontSize: 24,fontWeight: FontWeight.w600,)
      ],
    );
  }
}
