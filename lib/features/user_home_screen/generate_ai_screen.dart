import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:event_sense_ai/core/controller/event_controller.dart';
import 'package:event_sense_ai/utils/app_colors.dart';
import 'package:event_sense_ai/utils/app_icons.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:go_router/go_router.dart';
import 'package:sizer/sizer.dart';
import 'package:fl_chart/fl_chart.dart';

import '../../core/routes/app_routes.dart';
import '../../core/widgets/app_buttons.dart';
import '../../core/widgets/apptext.dart';
import '../../core/widgets/custom_headerbar.dart';
import 'components/event_info_card.dart';

class GenerateAiScreen extends StatelessWidget {
  String? eventId;
   GenerateAiScreen({this.eventId, super.key});

   final controller = Get.find<EventController>();
    final firestore = FirebaseFirestore.instance;
  @override
  Widget build(BuildContext context) {
    // Retrieve eventId from arguments if not provided via constructor
    final String? effectiveEventId = eventId ?? Get.arguments as String?;

    if (effectiveEventId == null || effectiveEventId.isEmpty) {
      return Scaffold(
        body: Center(
          child: AppText("Error: No Event ID provided"),
        ),
      );
    }

    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;
    return Scaffold(
      backgroundColor: AppColors.white,
      body: SingleChildScrollView(
        child: SafeArea(
            child: StreamBuilder<DocumentSnapshot<Map<String, dynamic>>>(
              stream: controller.eventStream(effectiveEventId),
              builder: (context, eventSnapshot) {
                if(!eventSnapshot.hasData){
                  return Center(child: CircularProgressIndicator(),);
                }
                final Eventdata = eventSnapshot.data!.data();
                if(Eventdata == null){
                  return Center(child: AppText("No event found for ID: $effectiveEventId"));
                }
                final formatedDate = controller.formatEventDate(Eventdata["eventStartDate"]);
                final formateBudget = controller.formatBudget(Eventdata["eventBudget"]);
        
        
                return StreamBuilder<DocumentSnapshot<Map<String, dynamic>>>(
                    stream: controller.blueprintStream(effectiveEventId),
                    builder: (context, bluePrintSnap) {
                      if(!bluePrintSnap.hasData || bluePrintSnap.data!.data() == null){
                        return const Center(
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              CircularProgressIndicator(),
                              SizedBox(height: 12),
                              Text("Generating AI Blueprint…"),
                            ],
                          ),
                        );
                      }
                      final blueprintData = bluePrintSnap.data!.data();
        
                      return Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 12.0,vertical: 18),
                        child: Column(
                          children: [
                            CustomHeaderBar(title: "AI BluePrints",showBackButton: true,onBack: (){
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
                                child: Row(
                                  children: [
                                    EventInfoCard(
                                      value: formatedDate,
                                      label: "Date",
                                      textColor: AppColors.first_tile_color,
                                      container_color: AppColors.first_tile_color,
                                      icon: AppIcons.calender_icon,
                                    ),
                                    EventInfoCard(
                                        textColor: AppColors.second_tile_color,
                                        container_color: AppColors.second_tile_color,
                                        value: Eventdata["guestCount"],
                                        label: "Guests",
                                        icon: AppIcons.people_icon
                                    ),
                                    EventInfoCard(
                                        textColor: AppColors.text_button.withOpacity(0.7),
                                        container_color: AppColors.text_button.withOpacity(0.7),
                                        value: "\$$formateBudget",
                                        label: "Est. Budget",
                                        icon: AppIcons.star_icon
                                    ),
                                  ],
                                )
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
                                          Get.toNamed(AppRoutes.budgetBreakdown, arguments: effectiveEventId);
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
                                    children:  [
                                      Text(
                                        "\$${(Eventdata["eventBudget"] as num).round()}",
                                        style: const TextStyle(
                                          fontSize: 22,
                                          fontWeight: FontWeight.bold,
                                        ),
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
                                  
                                  /// Dynamic Budget Rows
                                  ...((blueprintData!["categories"] as List? ?? []).asMap().entries.map((entry) {
                                    final int index = entry.key;
                                    final Map<String, dynamic> category = entry.value as Map<String, dynamic>;
                                    
                                    // Define a list of colors to cycle through
                                    final List<Color> cycleColors = [
                                      Colors.blue,
                                      Colors.purple,
                                      Colors.orange,
                                      Colors.green,
                                      Colors.red,
                                      Colors.indigo,
                                    ];
                                    
                                    final String catName = category["name"]?.toString() ?? "Venue & Catering";
                                    final num catBudget = category["estimated_budget"] ?? 0;
                                    final double totalBudget = (Eventdata!["eventBudget"] as num).toDouble();
                                    final double progress = totalBudget > 0 ? (catBudget.toDouble() / totalBudget).clamp(0.0, 1.0) : 0.0;
                                    
                                    return _BudgetRow(
                                      title: catName,
                                      value: "\$${catBudget.toString()}",
                                      progress: progress,
                                      color: cycleColors[index % cycleColors.length],
                                    );
                                  }).toList()),
        
                                  SizedBox(height: 4.h),
        
                                  /// Button
                                  Obx((){
                                    return AppButtonWidget(
                                      width: 120.w,
                                      height: 7.h,
                                      loader: controller.isLoading.value,
                                      onPressed: controller.isLoading.value ? null :  () async{
                                        await controller.UpdateEventStatus(effectiveEventId);
                                        Get.offAllNamed(AppRoutes.main);
                                      },
                                      buttonColor: AppColors.fieldColor,
                                      text: "Approved Blueprint",
                                      fontWeight: FontWeight.w500,
                                      fontSize: 14,);

                      }

                                  )
                                ],
                              ),
                            )
                          ],
                        ),
                      );
                    });
        
              },
            )),
      ),
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
