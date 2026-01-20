import 'package:event_sense_ai/utils/app_assets.dart';
import 'package:event_sense_ai/utils/app_colors.dart';
import 'package:event_sense_ai/utils/app_icons.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';
import 'package:sizer/sizer.dart';
import '../../core/widgets/app_buttons.dart';
import '../../core/widgets/app_textfield.dart';
import '../../core/widgets/apptext.dart';
import '../../core/widgets/custom_headerbar.dart';
import 'components/date_time_selector.dart';

class CreateInvitaionCardDesign extends StatefulWidget {
  CreateInvitaionCardDesign({super.key});

  @override
  State<CreateInvitaionCardDesign> createState() =>
      _CreateInvitaionCardDesignState();
}

class _CreateInvitaionCardDesignState extends State<CreateInvitaionCardDesign> {
  final List<AI_designs> aiDesign = [
    AI_designs(label: "Floral", Image_url: AppAssets.Floral_image),
    AI_designs(label: "Minimal", Image_url: AppAssets.Minimal_image),
    AI_designs(label: "Retro", Image_url: AppAssets.Retro_image),
    AI_designs(label: "Floral", Image_url: AppAssets.Floral_image),
    AI_designs(label: "Minimal", Image_url: AppAssets.Minimal_image),
    AI_designs(label: "Retro", Image_url: AppAssets.Retro_image),
  ];

  final eventNameController = TextEditingController();
  final eventLocation = TextEditingController();
  final hostController = TextEditingController();

  String selectedFormat = "PNG";
  final List<String> formats = ["PNG", "PDF", "JPG"];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 12, vertical: 8),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
              CustomHeaderBar(title: "Send Invitations", showBackButton: true, subtitle: "Create a beautiful invites with AI" ,onBack: (){
                context.pop();
              },),

                Gap(1.h),
                AppText(
                  "Digital RSVP",
                  fontSize: 20,
                  fontWeight: FontWeight.w600,
                ),

                Container(
                  padding: const EdgeInsets.all(16),
                  margin: const EdgeInsets.symmetric(vertical: 12),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(16),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.08),
                        blurRadius: 12,
                        spreadRadius: 2,
                        offset: const Offset(0, 6),
                      ),
                    ],
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      AppText(
                        "Public Link",
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                      ),
                      const SizedBox(height: 8),
                      Row(
                        children: [
                          Expanded(
                            child: AppText(
                              color: AppColors.first_tile_color,
                              "eventapp.com/rsvp/josh-bday-24",
                              fontWeight: FontWeight.w600,
                              fontSize: 16,
                            ),
                          ),
                          const SizedBox(width: 8),
                          IconButton(
                            icon: const Icon(
                              Icons.copy,
                              size: 20,
                              color: Colors.grey,
                            ),
                            onPressed: () {
                              print("Copy link tapped");
                            },
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                Gap(1.h),
                AppText("Send to", fontWeight: FontWeight.w600, fontSize: 16),
                Gap(1.h),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 6),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(16),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.08),
                        blurRadius: 12,
                        spreadRadius: 2,
                        offset: const Offset(0, 6),
                      ),
                    ],
                  ),
                  child: Row(
                    children: [
                      Expanded(
                        child: AppText(
                          color: AppColors.first_tile_color,
                          "All Guest(87",
                          fontWeight: FontWeight.w600,
                          fontSize: 16,
                        ),
                      ),
                      const SizedBox(width: 8),
                      IconButton(
                        icon: const Icon(
                          Icons.arrow_drop_down,
                          size: 20,
                          color: Colors.grey,
                        ),
                        onPressed: () {
                          print("Copy link tapped");
                        },
                      ),
                    ],
                  ),
                ),
                Gap(2.h),
                AppButtonWidget(
                  prefixIcon: Icon(Icons.email_outlined, color: Colors.white),
                  onPressed: () {},
                  width: 80.w,
                  height: 6.h,
                  text: "Compose Email",
                  fontWeight: FontWeight.w600,
                  fontSize: 14,
                  buttonColor: Colors.indigo.shade900,
                ),
                Gap(1.h),
                Row(
                  children: [
                    SvgPicture.asset(
                      AppIcons.star_icon,
                      color: Colors.indigoAccent,
                      width: 2.w,
                      height: 3.h,
                    ),
                    SizedBox(width: 8),
                    AppText(
                      "Ai Design Studio",
                      fontWeight: FontWeight.w600,
                      fontSize: 20,
                    ),
                  ],
                ),
                AppText(
                  "Generate a custom visual invitation to share on social media.",
                  color: Colors.grey,
                  fontWeight: FontWeight.w600,
                  fontSize: 15,
                ),
                Gap(1.h),
                AppText(
                  "Select Style",
                  fontWeight: FontWeight.w600,
                  fontSize: 20,
                  color: Colors.grey.shade500,
                ),
                SizedBox(
                  height: 17.h,
                  child: ListView.builder(
                    itemCount: aiDesign.length,
                    scrollDirection: Axis.horizontal,
                    itemBuilder: (context, index) {
                      final data = aiDesign[index];
                      return Container(
                        // padding: EdgeInsets.all(16),
                        margin: EdgeInsets.all(10),
                        child: Column(
                          children: [
                            ClipRRect(
                              borderRadius: BorderRadius.circular(20),
                              child: Image.asset(data.Image_url),
                            ),
                            Gap(1.h),
                            AppText(
                              data.label,
                              fontSize: 16,
                              fontWeight: FontWeight.w600,
                            ),
                          ],
                        ),
                      );
                    },
                  ),
                ),
                AppText(
                  "Event Name",
                  fontWeight: FontWeight.w700,
                  fontSize: 14,
                ),
                Gap(1.h),
                Container(
                  // padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                  // margin: const EdgeInsets.symmetric(vertical: 12),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(color: Colors.grey.shade300, width: 1),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.08),
                        blurRadius: 12,
                        spreadRadius: 2,
                        offset: const Offset(0, 6),
                      ),
                    ],
                  ),
                  child: Center(
                    child: AppFormField(
                      title: "enter name",
                      textEditingController: eventNameController,
                    ),
                  ),
                ),
                Gap(1.h),
                Container(
                  padding: const EdgeInsets.all(16),
                  margin: const EdgeInsets.symmetric(vertical: 12),
                  decoration: BoxDecoration(
                    color: Colors.white,
                  ),
                  child: DateTimeSelector(
                    onDateSelected: (date) {
                      print("Selected date: $date");
                    },
                    onTimeSelected: (time) {
                      print("Selected time: $time");
                    },
                  ),
                )
                ,
                AppText(
                  "Event Location",
                  fontWeight: FontWeight.w700,
                  fontSize: 14,
                ),
                Gap(1.h),
                Container(
                  // padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                  // margin: const EdgeInsets.symmetric(vertical: 12),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(color: Colors.grey.shade300, width: 1),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.08),
                        blurRadius: 12,
                        spreadRadius: 2,
                        offset: const Offset(0, 6),
                      ),
                    ],
                  ),
                  child: Center(
                    child: AppFormField(
                      icon: Icons.location_on_outlined,
                      title: "Event Location",
                      textEditingController: eventLocation,
                    ),
                  ),
                ),
                Gap(1.h),
                AppText("hosts", fontWeight: FontWeight.w700, fontSize: 14),
                Gap(1.h),
                Container(
                  // padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                  // margin: const EdgeInsets.symmetric(vertical: 12),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(color: Colors.grey.shade300, width: 1),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.08),
                        blurRadius: 12,
                        spreadRadius: 2,
                        offset: const Offset(0, 6),
                      ),
                    ],
                  ),
                  child: Center(
                    child: AppFormField(
                      title: "Sara and Isra",
                      textEditingController: hostController,
                    ),
                  ),
                ),
                Gap(2.h),
                Stack(
                  children: [
                    Container(
                      padding: const EdgeInsets.all(16),
                      margin: const EdgeInsets.symmetric(vertical: 12),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(16),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.1),
                            blurRadius: 12,
                            spreadRadius: 2,
                            offset: const Offset(0, 6),
                          ),
                        ],
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          // Invitation Image
                          ClipRRect(
                            borderRadius: BorderRadius.circular(12),
                            child: Image.asset(
                              AppAssets
                                  .Invitaion_design, // Replace with your image path
                              width: double.infinity,
                              height: 380,
                              fit: BoxFit.cover,
                            ),
                          ),
                        ],
                      ),
                    ),
                    Positioned(
                      top: 4.h,
                      left: 75.w,
                      child: Container(
                        width: 40,
                        height: 40,
                        decoration: BoxDecoration(
                          color: Colors.grey.shade600,
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: IconButton(
                          icon: const Icon(
                            Icons.remove_red_eye,
                            color: Colors.white,
                          ),
                          onPressed: () {
                            print("Preview design tapped");
                            // You can navigate to a full-screen preview or show a dialog
                          },
                        ),
                      ),
                    ),

                  ],
                ),
                Gap(2.h),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: formats.map((format) {
                    final bool isSelected = selectedFormat == format;
                    return GestureDetector(
                      onTap: () {
                        setState(() {
                          selectedFormat = format;
                        });
                      },
                      child: Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 24,
                          vertical: 12,
                        ),
                        decoration: BoxDecoration(
                          color: isSelected
                              ? Colors.grey.shade300
                              : Colors.white,
                          borderRadius: BorderRadius.circular(12),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withOpacity(0.08),
                              blurRadius: 10,
                              spreadRadius: 2,
                              offset: const Offset(0, 4),
                            ),
                          ],
                          border: Border.all(
                            color: isSelected
                                ? Colors.blue
                                : Colors.grey.shade300,
                            width: 1,
                          ),
                        ),
                        child: Text(
                          format,
                          style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w600,
                            color: isSelected
                                ? Colors.blue.shade700
                                : Colors.black87,
                          ),
                        ),
                      ),
                    );
                  }).toList(),
                ),
                Gap(2.h),
                AppButtonWidget(
                  onPressed: () {},
                  width: 80.w,
                  height: 6.h,
                  text: "Preview & Send",
                  fontWeight: FontWeight.w600,
                  fontSize: 14,
                  buttonColor: Colors.indigo.shade900,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class AI_designs {
  String Image_url;
  String label;

  AI_designs({required this.label, required this.Image_url});
}
