import 'package:event_sense_ai/utils/app_colors.dart';
import 'package:event_sense_ai/utils/app_icons.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:gap/gap.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:go_router/go_router.dart';
import 'package:sizer/sizer.dart';

import '../../core/routes/app_routes.dart';
import '../../core/widgets/app_buttons.dart';
import '../../core/widgets/apptext.dart';
import '../../core/widgets/custom_headerbar.dart';
import 'components/event_type_widget.dart';

class CreateEventScreen extends StatefulWidget {
  CreateEventScreen({super.key});

  @override
  State<CreateEventScreen> createState() => _CreateEventScreenState();
}

class _CreateEventScreenState extends State<CreateEventScreen> {
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

  double _value = 10000;

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: AppColors.white,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 18.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
               CustomHeaderBar(title: "Create New Event", showBackButton: true,onBack: (){
                 context.pop();
               },),
                Gap(12),

                DottedBorder(
                  borderType: BorderType.RRect,
                  radius: const Radius.circular(20),
                  dashPattern: const [8, 6], // dot length, space
                  color: Colors.black54,
                  strokeWidth: 1.2,
                  child: Container(
                    height: 200,
                    width: 600,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        IconButton(
                          onPressed: () {},
                          icon: const Icon(Icons.add),
                          color: AppColors.fieldColor,
                          iconSize: 65,
                        ),
                        AppText(
                          "Add a cover photo",
                          type: AppTextType.captionDark,
                        ),
                      ],
                    ),
                  ),
                ),
                Gap(12),
                AppText(
                  "Basics Information",
                  type: AppTextType.heading2,
                  fontWeight: FontWeight.w700,
                ),
                Gap(8),
                AppText(
                  "Event Name",
                  type: AppTextType.captionDark,
                  fontWeight: FontWeight.w700,
                  color: Colors.black54,
                ),
                Gap(8),
                Container(
                  padding: EdgeInsets.all(4),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(22),
                    border: BoxBorder.all(
                      color: Colors.grey.shade300,
                      width: 0.8,
                    ),
                  ),
                  child: TextField(
                    decoration: InputDecoration(
                      hintText: "Type your event name",
                      hintStyle: const TextStyle(
                        fontSize: 14,
                        color: Colors.grey,
                      ),
                      contentPadding: const EdgeInsets.symmetric(
                        horizontal: 16,
                        vertical: 14,
                      ),
                      filled: true,
                      fillColor: Colors.white,
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                        borderSide: BorderSide.none,
                      ),
                    ),
                    style: const TextStyle(fontSize: 14),
                  ),
                ),
                Gap(8),
                AppText(
                  "Event Type",
                  type: AppTextType.captionDark,
                  fontWeight: FontWeight.w600,
                ),
                Gap(8),
                Container(
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
                Gap(10),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        AppText(
                          "Select Date",
                          type: AppTextType.caption,
                          color: Colors.black54,
                          fontWeight: FontWeight.bold,
                        ),
                        Gap(8),
                        Container(
                          padding: EdgeInsets.all(8),
                          decoration: BoxDecoration(
                            border: BoxBorder.all(color: Colors.grey.shade300),
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: Row(
                            children: [
                              AppText(
                                "Choose event date",
                                type: AppTextType.caption,
                              ),
                              Gap(8),
                              Icon(Icons.calendar_today_outlined),
                            ],
                          ),
                        ),
                      ],
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        AppText(
                          "End Date",
                          type: AppTextType.caption,
                          color: Colors.black54,
                          fontWeight: FontWeight.bold,
                        ),
                        Gap(8),
                        Container(
                          padding: EdgeInsets.all(8),
                          decoration: BoxDecoration(
                            border: BoxBorder.all(color: Colors.grey.shade300),
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: Row(
                            children: [
                              AppText(
                                "Choose event date",
                                type: AppTextType.caption,
                              ),
                              Gap(8),
                              Icon(Icons.alarm, color: Colors.grey),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
                Gap(8),
                AppText(
                  "Event Location",
                  type: AppTextType.captionDark,
                  fontWeight: FontWeight.bold,
                ),
                Container(
                  width: width * 1,
                  padding: EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    border: BoxBorder.all(color: Colors.grey.shade300),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      AppText("Event Location ", type: AppTextType.caption),
                      Gap(8),
                      Icon(Icons.location_on_outlined, color: Colors.grey),
                    ],
                  ),
                ),
                Gap(8),
                AppText(
                  "Guest Count",
                  type: AppTextType.captionDark,
                  fontWeight: FontWeight.bold,
                ),
                Container(
                  width: width * 1,
                  padding: EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    border: BoxBorder.all(color: Colors.grey.shade300),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      AppText("0", type: AppTextType.caption),
                      Gap(8),
                      Icon(Icons.people_outline, color: Colors.grey),
                    ],
                  ),
                ),
                Gap(9),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    AppText("Estimated Budget", type: AppTextType.heading3),
                    GestureDetector(
                      onTap: () {},
                      child: Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 8,
                          vertical: 2,
                        ),
                        decoration: BoxDecoration(
                          color: AppColors.first_tile_color, // light purple
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: const [
                            AppText( "USD",fontSize: 14,
                                fontWeight: FontWeight.w600,
                                color: Color(0xFF2F3C7E), ),
                            SizedBox(width: 2),
                            Icon(
                              Icons.keyboard_arrow_down,
                              size: 20,
                              color: Color(0xFF2F3C7E),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
                Gap(10),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    AppText("\$${_value.toStringAsFixed(0)}",
                      type: AppTextType.heading2,fontWeight: FontWeight.bold,),
                    SliderTheme(
                      data: SliderTheme.of(context).copyWith(
                        activeTrackColor: Color(0xff96A2D5),
                        inactiveTrackColor: Color(0xff96A2D5).withOpacity(0.3),
                        thumbColor: Colors.lightBlue,
                        overlayColor: Colors.lightBlue.withOpacity(0.2),
                        thumbShape: const RoundSliderThumbShape(
                          enabledThumbRadius: 10,
                        ),
                        trackHeight: 6,
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          SliderTheme(
                            data: SliderTheme.of(context).copyWith(
                              activeTickMarkColor: Color(0xff253EA77A),
                              inactiveTickMarkColor: Color(0xff253EA77A).withOpacity(0.4),
                              trackHeight: 8,
                              thumbColor: Colors.lightBlue,
                              overlayColor: Colors.lightBlue.withOpacity(0.2),
                              overlayShape: SliderComponentShape.noOverlay,
                              thumbShape: const RoundSliderThumbShape(
                                enabledThumbRadius: 10,
                              ),
                            ),
                            child: Slider(
                              value: _value,
                              min: 1000,
                              max: 100000,
                              divisions: 99,
                              label: "\$${_value.toStringAsFixed(0)}",
                              onChanged: (val) {
                                setState(() {
                                  _value = val;
                                });
                              },
                            ),
                          ),

                          /// ⬇ Reduced spacing explicitly

                          Padding(
                            padding: const EdgeInsets.symmetric(  horizontal: 12.0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: const [
                                AppText("\$1K",fontSize: 13, fontWeight: FontWeight.w700,color: Colors.black87,),
                                AppText("\$100K",fontSize: 13, fontWeight: FontWeight.w700,color: Colors.black87,),

                              ],
                            ),
                          ),
                        ],
                      )

                    ),
                    Gap(12),
                    AppButtonWidget(
                      onPressed: (){
                        context.pushNamed(AppRoutes.generateAiScreen);
                      },
                      width: 100.w,
                      height: 6.h,
                      buttonColor: AppColors.fieldColor,
                      fontWeight: FontWeight.w600,
                      text: "Generate Blueprint",
                      prefixIcon: SvgPicture.asset(AppIcons.star_icon),),
                    Gap(39),
                      ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
