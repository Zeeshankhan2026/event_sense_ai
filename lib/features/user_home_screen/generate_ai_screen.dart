import 'package:event_sense_ai/utils/app_colors.dart';
import 'package:event_sense_ai/utils/app_icons.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';
import 'package:sizer/sizer.dart';
import 'package:fl_chart/fl_chart.dart';

import '../../core/routes/app_routes.dart';
import '../../core/widgets/app_buttons.dart';
import '../../core/widgets/apptext.dart';
import '../../core/widgets/custom_headerbar.dart';
import 'components/event_info_card.dart';

class GenerateAiScreen extends StatelessWidget {
   GenerateAiScreen({super.key});
  final List<EventInfoCard> eventInfoCard = [
    EventInfoCard(
      value: "Dec 15",
      label: "Event Date",
      textColor: AppColors.first_tile_color,
      container_color: AppColors.first_tile_color,
      icon: AppIcons.calender_icon,
    ),
    EventInfoCard(
        textColor: AppColors.second_tile_color,
      container_color: AppColors.second_tile_color,
      value: "150",
      label: "Guests",
        icon: AppIcons.people_icon
    ),
    EventInfoCard(
        textColor: AppColors.text_button.withOpacity(0.7),
      container_color: AppColors.text_button.withOpacity(0.7),
      value: "\$2500k",
      label: "Est. Budget",
        icon: AppIcons.star_icon
    ),
  ];
  @override
  Widget build(BuildContext context) {

    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;
    return Scaffold(
      backgroundColor: AppColors.white,
      body: SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12.0,vertical: 18),
            child: Column(
                    children: [
                      CustomHeaderBar(title: "Vendors Applications",showBackButton: true,onBack: (){
                        context.pop();
                      },),
                      Gap(20),
                      Row(
                        // mainAxisAlignment: MainAxisAlignment.spaceBetween ,
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              AppText("Wedding Events", type: AppTextType.heading4,),
                              AppText("Generate based on your Q4 marketing goals.", type: AppTextType.caption,),
                            ],
                          ),
                          SizedBox(width: 6.w,),
                          Container(
                            padding: EdgeInsets.all(4),
                           width: width*0.193,
                            height: height*0.03,
                            decoration: BoxDecoration(
                              color: AppColors.first_tile_color,
                              borderRadius: BorderRadius.circular(14),
                            ),
                            child: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Container(
                                  width: 16,
                                  height: 16,
                                  decoration: const BoxDecoration(
                                    color: Colors.white,
                                    shape: BoxShape.circle,
                                  ),
                                  child: SvgPicture.asset(AppIcons.checked_mark)
                                ),

                                AppText("98% Match", type: AppTextType.captionDark,fontSize: 8,fontWeight: FontWeight.bold,)
                              ],
                            ),
                          ),

                        ],
                      ),
                      Gap(1.h),
                      SizedBox(
                        height: 14.h,
                        child: ListView.builder(
                          itemCount: eventInfoCard.length,
                            scrollDirection: Axis.horizontal,
                            
                            itemBuilder: (context,index){
                            final data = eventInfoCard[index];
                            return Container(
                              margin: EdgeInsets.symmetric(horizontal: 3.w),
                              width: 100, 
                              padding: const EdgeInsets.all(12), 
                              decoration: BoxDecoration(
                                color: data.backgroundColor, 
                                borderRadius: BorderRadius.circular(12), 
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.black.withOpacity(0.05), 
                                    blurRadius: 4, offset: const Offset(0, 2), 
                                  ), ], ),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Container(
                                    height: 4.h,
                                    width: 8.w,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(4),
                                      color: data.container_color
                                    ),
                                    child: Center(child: SvgPicture.asset(data.icon,height: 20,)),
                                  ),
                                  Gap(1.h),
                                  AppText(data.value, color: data.textColor,type: AppTextType.bodyTextBold,),
                                  AppText(data.label, color: data.textColor.withOpacity(0.6),type: AppTextType.micro,),
                                ], ), );

                        }),
                      ),
                      Gap(2.h),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          AppText("Budget Allocation", type: AppTextType.heading4,),

                          AppText("View Details", type: AppTextType.captionDark,color: Colors.black87,),
                        ],
                      ),
                      Gap(2.h),
      Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16),
          boxShadow: const [
            BoxShadow(
              color: Colors.black12,
              blurRadius: 12,
              offset: Offset(0, 6),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            /// Header
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children:  [
                Text(
                  "Projected Spend Curve",
                  style: TextStyle(fontSize: 14, fontWeight: FontWeight.w600),
                ),
                GestureDetector(
                  onTap: (){
                    context.pushNamed(AppRoutes.BudgetBreakdown);
                  },
                  child: Text(
                    "View Details",
                    style: TextStyle(
                      fontSize: 12,
                      color: Color(0xFF4A5CFB),
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
              ],
            ),

            const SizedBox(height: 8),

            /// Amount
            Row(
              children: const [
                Text(
                  "\$25,000",
                  style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
                ),
                SizedBox(width: 8),
                Text(
                  "+0% over target",
                  style: TextStyle(
                    fontSize: 12,
                    color: Colors.green,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ],
            ),

            const SizedBox(height: 12),

            /// Spend Curve Chart
            SizedBox(
              height: 110,
              child: SpendCurveChart(),
            ),

            const SizedBox(height: 16),

            /// Budget Rows
            const _BudgetRow(
              title: "Venue & Catering",
              value: "\$8000",
              progress: 0.8,
              color: Colors.blue,
            ),
            const _BudgetRow(
              title: "Decor & Product",
              value: "\$10,000",
              progress: 0.6,
              color: Colors.purple,
            ),
            const _BudgetRow(
              title: "Technology",
              value: "\$2000",
              progress: 0.4,
              color: Colors.orange,
            ),

             SizedBox(height: 4.h),

            /// Button
            AppButtonWidget(
              width: 120.w,
              height: 7.h,
              buttonColor: AppColors.fieldColor,
              text: "Approved Blueprint",fontWeight: FontWeight.w500,fontSize: 14,)
          ],
        ),
      )
                    ],
                  ),
          )),
    );
  }
}

class SpendCurveChart extends StatelessWidget {
  const SpendCurveChart({super.key});

  @override
  Widget build(BuildContext context) {
    return LineChart(
      LineChartData(
        gridData: const FlGridData(show: false),
        titlesData: const FlTitlesData(show: false),
        borderData: FlBorderData(show: false),
        lineTouchData: const LineTouchData(enabled: false),
        minX: 0,
        maxX: 6,
        minY: 0,
        maxY: 6,
        lineBarsData: [
          LineChartBarData(
            spots: const [
              FlSpot(0, 3),
              FlSpot(1, 2),
              FlSpot(2, 4),
              FlSpot(3, 3),
              FlSpot(4, 4),
              FlSpot(5, 3),
              FlSpot(6, 5),
            ],
            isCurved: true,
            barWidth: 0,
            dotData: const FlDotData(show: false),
            belowBarData: BarAreaData(
              show: true,
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [
                  const Color(0xFF6A5AE0).withOpacity(0.6),
                  const Color(0xFF6A5AE0).withOpacity(0.0),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _BudgetRow extends StatelessWidget {
  final String title;
  final String value;
  final double progress;
  final Color color;

  const _BudgetRow({
    required this.title,
    required this.value,
    required this.progress,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(title, style: const TextStyle(fontSize: 12)),
              Text(value,
                  style: const TextStyle(
                      fontSize: 12, fontWeight: FontWeight.w500)),
            ],
          ),
          const SizedBox(height: 6),
          ClipRRect(
            borderRadius: BorderRadius.circular(6),
            child: LinearProgressIndicator(
              value: progress,
              minHeight: 6,
              backgroundColor: Colors.grey.shade200,
              valueColor: AlwaysStoppedAnimation(color),
            ),
          ),
        ],
      ),
    );
  }
}
