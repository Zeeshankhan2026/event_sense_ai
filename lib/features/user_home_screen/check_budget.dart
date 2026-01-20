import 'package:event_sense_ai/utils/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';
import 'package:sizer/sizer.dart';

import '../../core/routes/app_routes.dart';
import '../../core/widgets/app_buttons.dart';
import '../../core/widgets/apptext.dart';
import '../../utils/app_icons.dart';
import 'components/event_type_widget.dart';

class CheckBudget extends StatefulWidget {
  CheckBudget({super.key});

  @override
  State<CheckBudget> createState() => _CheckBudgetState();
}

class _CheckBudgetState extends State<CheckBudget> {
  final List<EventTypeWidget> event_type_list = [
    EventTypeWidget(title: "Wedding", icons: AppIcons.weddingtype_icon),
    EventTypeWidget(
      title: "Corporate",
      icons: AppIcons.corporatetype_event_icon,
    ),
    EventTypeWidget(title: "Conference", icons: AppIcons.conference_type_icon),
    EventTypeWidget(title: "Party", icons: AppIcons.partytype_icon),
    EventTypeWidget(title: "Concert", icons: AppIcons.concerttype_icon),
    EventTypeWidget(title: "Other", icons: AppIcons.othertype_icon),
  ];

  String selected = "50-150";

  final List<String> options = ["< 50", "50-150", "150-300", "300+"];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 12),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  IconButton(
                    onPressed: () {
                      context.pop();
                    },
                    icon: Icon(Icons.arrow_back_ios),
                  ),
                  AppText(
                    "Budget Setup",
                    fontWeight: FontWeight.w600,
                    fontSize: 20,
                  ),
                ],
              ),
              AppText(
                "Let's Plan your Finances",
                fontWeight: FontWeight.w700,
                fontSize: 20,
                color: Colors.indigo.shade900,
              ),
              AppText(
                "Ai will optimize your spending based on\n these details",
                color: AppColors.textGrey1,
                fontWeight: FontWeight.w500,
                fontSize: 13,
              ),
              Gap(1.h),
              AppText(
                "Budget Setup",
                color: AppColors.black,
                fontWeight: FontWeight.w600,
                fontSize: 16,
              ),
              Gap(1.h),
              Container(
                width: 100.w,
                height: 8.h,
                padding: const EdgeInsets.symmetric(
                  horizontal: 16,
                  vertical: 12,
                ),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(12),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.12),
                      blurRadius: 6,
                      offset: const Offset(0, 4),
                    ),
                  ],
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: const [
                    AppText( "\$",  fontSize: 20,
                      color: Colors.grey,
                      fontWeight: FontWeight.w500,),
                    SizedBox(width: 4),
                    AppText( "15,000",fontSize: 20,
                      color: Colors.black,
                      fontWeight: FontWeight.bold,)
                  ],
                ),
              ),
              Gap(2.h),
              AppText(
                "Event Type",
                color: AppColors.black,
                fontWeight: FontWeight.w600,
                fontSize: 16,
              ),
              Gap(1.h),
              SizedBox(
                width: 700,
                height: 170,
                child: GridView.builder(
                  physics: NeverScrollableScrollPhysics(),
                  itemCount: event_type_list.length,
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 3,
                    mainAxisSpacing: 4,
                    childAspectRatio: 1.6,
                    crossAxisSpacing: 4,
                  ),
                  itemBuilder: (context, index) {
                    return Container(
                      width: 140,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(6),
                        border: BoxBorder.all(
                          color: Colors.grey.shade300,
                          width: 0.7,
                        ),
                      ),
                      child: Center(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            SvgPicture.asset(
                              event_type_list[index].icons,
                              height: 40,
                            ),
                            AppText(
                              event_type_list[index].title,
                              fontSize: 12,
                              fontWeight: FontWeight.w400,
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                ),
              ),
              Gap(2.h),
              AppText(
                "Guest Count",
                color: AppColors.black,
                fontWeight: FontWeight.w600,
                fontSize: 16,
              ),
              Gap(1.h),
              Align(
                alignment: Alignment.center,
                child: Container(
                  padding: EdgeInsets.symmetric(horizontal: 12,vertical: 4),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(12),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.12),
                        blurRadius: 6,
                        offset: const Offset(0, 4),
                      ),
                    ],
                  ),
                  child: Wrap(
                    spacing: 12,
                    children: options.map((option) {
                      final bool isSelected = selected == option;
                      return GestureDetector(
                        onTap: () {
                          setState(() {
                            selected = option;
                          });
                        },
                        child: Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 16,
                            vertical: 10,
                          ),
                          decoration: BoxDecoration(
                            color: isSelected
                                ? const Color(0xFF2F3C7E)
                                : Colors.white,
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child: AppText(  option,fontSize: 13,
                            fontWeight: FontWeight.w500,
                            color: isSelected ? Colors.white : Colors.black87,)
                        ),
                      );
                    }).toList(),
                  ),
                ),
              ),
              Gap(4.h),

              AppButtonWidget(
                onPressed: () {
                  context.pushNamed(AppRoutes.BudgetBreakdown);
                },
                width: 100.w,
                height: 6.h,
                buttonColor: AppColors.fieldColor,
                fontWeight: FontWeight.w600,
                text: "Generate Blueprint",
                prefixIcon: SvgPicture.asset(AppIcons.star_icon),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
