import 'dart:io';

import 'package:event_sense_ai/core/controller/event_controller.dart';
import 'package:event_sense_ai/core/services/image_picker_services.dart';
import 'package:event_sense_ai/core/widgets/app_textfield.dart';
import 'package:event_sense_ai/core/widgets/snackbar_widget.dart';
import 'package:event_sense_ai/features/user_home_screen/components/create_event_date_selector.dart';
import 'package:event_sense_ai/utils/app_colors.dart';
import 'package:event_sense_ai/utils/app_icons.dart';
import 'package:event_sense_ai/utils/app_validator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:gap/gap.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';
import '../../core/services/location_services.dart';
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
    EventTypeWidget(title: "Corporate", icons: AppIcons.corporatetype_event_icon,),
    EventTypeWidget(title: "Conference", icons: AppIcons.conference_type_icon),
    EventTypeWidget(title: "Party", icons: AppIcons.partytype_icon),
    EventTypeWidget(title: "Concert", icons: AppIcons.concerttype_icon),
    EventTypeWidget(title: "Other", icons: AppIcons.othertype_icon),
  ];

  final locationController = TextEditingController();
  final guestController = TextEditingController();
  String? eventType;
  final controller = Get.put(EventController());
  bool isFetchingLocation = false;
  File? selectedImage;

  @override
  Widget build(BuildContext context) {

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
                 Navigator.of(context).pop();
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
                      image: selectedImage != null ? DecorationImage(image: FileImage(selectedImage!), fit: BoxFit.cover): null
                    ) ,
                    child: selectedImage == null ?  Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        IconButton(
                          onPressed: () async  {
                         final image = await    ImagePickerService.pickImageFromGallery(context);
                         setState(() {
                           selectedImage = image;
                         });
                          },
                          icon: const Icon(Icons.add),
                          color: AppColors.fieldColor,
                          iconSize: 65,
                        ),
                        AppText(
                          "Add a cover photo",
                          type: AppTextType.captionDark,
                        ),
                      ],
                    ) : null,
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
                AppFormField(
                  validator:(value) => AppValidator.validateName(value),

                  borderColor: Colors.grey.shade300,
                  focusedBorderColor: Colors.grey.shade300,

                  showBorder: true,
                  title: "Add Event Name",
                  textEditingController: controller.eventNameController,
                ),
                Gap(8),
                AppText(
                  "Event Description",
                  type: AppTextType.captionDark,
                  fontWeight: FontWeight.w700,
                  color: Colors.black54,
                ),
                Gap(8),
                AppFormField(
                  validator:(value) => AppValidator.validateName(value),

                  borderColor: Colors.grey.shade300,
                  focusedBorderColor: Colors.grey.shade300,

                  showBorder: true,
                  title: "Described events",
                  textEditingController: controller.eventDescriptionController,
                ),

                Gap(8),
                AppText(
                  "Event Type",
                  type: AppTextType.captionDark,
                  fontWeight: FontWeight.w600,
                ),
                Gap(8),
                Obx(() {
                  controller.eventType; // Explicitly access for Obx registration
                  return SizedBox(
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
                        final isSelected = controller.eventType == event_type_list[index].title;
                        return InkWell(
                          onTap: () {
                            controller.eventType = event_type_list[index].title;
                          },
                          child: Container(
                            width: 140,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(6),
                              color: isSelected ? AppColors.fieldColor.withOpacity(0.1) : Colors.transparent,
                              border: Border.all(
                                color: isSelected ? AppColors.fieldColor : Colors.grey.shade300,
                                width: isSelected ? 1.5 : 0.7,
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
                                    // colorFilter: isSelected ? ColorFilter.mode(AppColors.fieldColor, BlendMode.srcIn) : null,
                                  ),
                                  AppText(
                                    event_type_list[index].title,
                                    fontSize: 12,
                                    fontWeight: isSelected ? FontWeight.bold : FontWeight.w400,
                                    color: isSelected ? AppColors.fieldColor : Colors.black,
                                  ),
                                ],
                              ),
                            ),
                          ),
                        );
                      },
                    ),
                  );
                }),
                Container(
                  padding: const EdgeInsets.all(4),
                  margin: const EdgeInsets.symmetric(vertical: 2),
                  decoration: BoxDecoration(
                    color: Colors.white,
                  ),
                  child: CreateEventDateSelector(
                    onDateSelected: (date) {
                      controller.startDate = date;
                      print("Selected date: $date");
                    },
                    onTimeSelected: (date) {
                      controller.endDate = date;
                      print("Selected time: $date");
                    },
                  ),
                ),
                Gap(8),
                AppText(
                  "Event Location",
                  type: AppTextType.captionDark,
                  fontWeight: FontWeight.bold,
                ),
                Gap(3),
                AppFormField(
                  readOnly: true,
                  onTap: () async {
                    setState(() {
                      isFetchingLocation = true;
                    });
                    final cityName =
                        await LocationServices.fetchCurrentCityWithPermission(context);

                    if (cityName != null) {
                      setState(() {
                        controller.locationController.text = cityName;
                      });
                    }
                    setState(() {
                      isFetchingLocation = false;
                    });
                  },
                    showBorder: true,
                    iconWidget: isFetchingLocation
                        ?  Container(
                      padding: EdgeInsets.all(12),
                      width: 15,
                      height: 15,
                      child: CircularProgressIndicator(
                        strokeWidth: 2,
                      ),
                    )
                        : const Icon(Icons.location_on_outlined),
                    icon: Icons.location_on_outlined,
                    title: "event location",
                    textEditingController: controller.locationController),
                Gap(8),
                AppText(
                  "Guest Count",
                  type: AppTextType.captionDark,
                  fontWeight: FontWeight.bold,
                ),
                AppFormField(
                    showBorder: true,
                    icon: Icons.people_outline,
                    title: "0",
                    textEditingController: controller.guestController),
                Gap(9),
                Gap(10),
                AppText("Maximum Budget Limit", type: AppTextType.captionDark, fontWeight: FontWeight.bold),
                Gap(4),
                AppFormField(
                  showBorder: true,
                  textInputType: TextInputType.number,
                  title: "10000",
                  textEditingController: controller.maxBudgetController,
                ),
                Gap(12),
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
                            AppText(
                              "USD",
                              fontSize: 14,
                              fontWeight: FontWeight.w600,
                              color: Color(0xFF2F3C7E),
                            ),
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
                Obx(() {
                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      AppText(
                        "\$${controller.eventBudget.toStringAsFixed(0)}",
                        type: AppTextType.heading2,
                        fontWeight: FontWeight.bold,
                      ),
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
                                  value: controller.eventBudget.value.clamp(0.0, controller.maxBudget.value),
                                  min: 0,
                                  max: controller.maxBudget.value,
                                  divisions: controller.maxBudget.value > 0 ? (controller.maxBudget.value / 100).round() : 1,
                                  label: "\$${controller.eventBudget.toStringAsFixed(0)}",
                                  onChanged: (val) {
                                    controller.eventBudget.value = val;
                                  },
                                ),
                              ),

                              /// ⬇ Reduced spacing explicitly

                              Padding(
                                padding: const EdgeInsets.symmetric(horizontal: 12.0),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    const AppText(
                                      "\$0",
                                      fontSize: 13,
                                      fontWeight: FontWeight.w700,
                                      color: Colors.black87,
                                    ),
                                    AppText(
                                      "\$${(controller.maxBudget.value / 1000).toStringAsFixed(0)}K",
                                      fontSize: 13,
                                      fontWeight: FontWeight.w700,
                                      color: Colors.black87,
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          )),
                      Gap(12),
                    ],
                  );
                }),
                Obx(() {
                  return AppButtonWidget(
                    onPressed: controller.isLoading.value ? null : () async{
                      if (controller.eventNameController.text.isEmpty) {
                        SafeSnackbar.error("Required", "Event name is required");
                        return;
                      }
                      if (controller.eventDescriptionController.text.isEmpty) {
                        SafeSnackbar.error("Required", "Event description is required");
                        return;
                      }
                      if (controller.eventType.isEmpty) {
                        SafeSnackbar.error("Required", "Please select an event type");
                        return;
                      }
                      if (controller.startDate.isEmpty) {
                        SafeSnackbar.error("Required", "Start date is required");
                        return;
                      }
                      if (controller.endDate.isEmpty) {
                        SafeSnackbar.error("Required", "End date is required");
                        return;
                      }
                      if (controller.locationController.text.isEmpty) {
                        SafeSnackbar.error("Required", "Event location is required");
                        return;
                      }
                      if (controller.guestController.text.isEmpty) {
                        SafeSnackbar.error("Required", "Guest count is required");
                        return;
                      }

                      await controller.createEvent();
                    },
                    width: 100.w,
                    height: 6.h,
                    loader: controller.isLoading.value,
                    buttonColor: AppColors.fieldColor,
                    fontWeight: FontWeight.w600,
                    text: "Generate Blueprint",
                    prefixIcon: SvgPicture.asset(AppIcons.star_icon),
                  );
                }),
                Gap(10),
                AppText(
                  "Our AI will customize suggestion based on your Budget",
                  fontSize: 12,
                  fontWeight: FontWeight.w600,
                  color: Colors.grey,
                ),
                Gap(10),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
