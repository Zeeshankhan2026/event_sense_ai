import 'package:event_sense_ai/core/controller/planner_category_controller.dart';
import 'package:event_sense_ai/core/models/event_category_model.dart';
import 'package:event_sense_ai/core/widgets/app_buttons.dart';
import 'package:event_sense_ai/features/user_home_screen/components/job_resuable_cad.dart';
import 'package:event_sense_ai/utils/app_colors.dart';
import 'package:event_sense_ai/utils/app_icons.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';
import '../../core/widgets/apptext.dart';
import '../../core/widgets/custom_headerbar.dart';


class UserPostJobScreen extends StatefulWidget {
  const UserPostJobScreen({super.key});

  @override
  State<UserPostJobScreen> createState() => _UserPostJobScreenState();
}

class _UserPostJobScreenState extends State<UserPostJobScreen> {

  final controller = Get.find<PlannerCategoryController>();

  RangeValues budgetRange = const RangeValues(500, 2900);


  late double selectedBudget;
  late double minBudget;
  late double maxBudget;
  
  // Track initial values to check for changes
  late double _initialBudget;
  String _initialDescription = "";
  String _initialInstructions = "";
  bool _hasChanges = false;

  final args = Get.arguments as Map<String, dynamic>;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    final int recommended = args["categoryBudget"];

    //  enhanced flexible range
    minBudget = (recommended * 0.6).clamp(200, recommended).toDouble();
    maxBudget = (recommended * 1.4).toDouble();

    // default = recommended
    selectedBudget = recommended.toDouble();
    _initialBudget = selectedBudget; // Initialize


    controller.loadCategoryJob(args["eventId"], args["category"]).then((_) {
      if (controller.selectedBudget.value > 0) {
        if (mounted) {
          setState(() {
            selectedBudget = controller.selectedBudget.value;
            _initialBudget = selectedBudget;
            
            _initialDescription = controller.jobDescriptionC.text;
            _initialInstructions = controller.specialInsC.text;
            
            args["categoryBudget"] = selectedBudget.round();
            if (selectedBudget > maxBudget) maxBudget = selectedBudget;
            if (selectedBudget < minBudget) minBudget = selectedBudget;
          });
        }
      } else {
         // Should track initial values even if no previous job (defaults)
         if(mounted) {
            setState(() {
               _initialBudget = selectedBudget;
            });
         }
      }
    });

    // Listen to text changes
    controller.jobDescriptionC.addListener(_checkForChanges);
    controller.specialInsC.addListener(_checkForChanges);
  }

  int? _calculateDivisions() {
    final diff = maxBudget - minBudget;
    if (diff <= 0) return null;
    return (diff ~/ 50).clamp(1, 1000);
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xffF5F5F5),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Gap(2.h),
            CustomHeaderBar(title: "New Request", showBackButton: true,onBack: (){
              Navigator.of(context).pop();
            },),
            Gap(1.h),
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
                      SizedBox(
                        width: 40.w,
                        child: AppText(
                          overflow: TextOverflow.ellipsis,
                          args["eventName"],
                          fontSize: 15,
                          fontWeight: FontWeight.w600,
                          color: Colors.grey.shade900,
                        ),
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
                        args["eventStartDate"],
                        fontSize: 15,
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
                          SizedBox(
                            width: 30.w,
                            child: AppText(
                              args["category"],
                              fontSize: 15,
                              fontWeight: FontWeight.w600,
                              color: Colors.grey.shade900,
                              overflow: TextOverflow.ellipsis,
                            ),
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
                      SizedBox(
                        width: 35.w,
                        child: AppText(
                          overflow: TextOverflow.ellipsis,
                          args["eventLocation"],
                          fontSize: 15,
                          fontWeight: FontWeight.w800,
                          color: Colors.grey.shade900,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            const SizedBox(height: 24),

            // // Requirements
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
                    children: [
                      const Text(
                        "Budget",
                        style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                      ),
                      Text(
                        "\$${selectedBudget.toInt()}",
                        style: const TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w600,
                          color: Colors.green,
                        ),
                      ),

                    ],
                  ),
                  const SizedBox(height: 10),

                  SliderTheme(
                    data: SliderTheme.of(context).copyWith(
                      trackHeight: 6,
                      thumbShape: const RoundSliderThumbShape(enabledThumbRadius: 10),
                      overlayShape: const RoundSliderOverlayShape(overlayRadius: 20),
                      activeTrackColor: AppColors.fieldColor,
                      inactiveTrackColor: Colors.grey.shade300,
                    ),
                    child: Slider(
                      min: minBudget,
                      max: maxBudget,
                      value: selectedBudget.clamp(minBudget, maxBudget),
                      divisions: _calculateDivisions(),
                      label: "\$${selectedBudget.round()}",
                      onChanged: (value) {
                        setState(() {
                          selectedBudget = value;
                          args["categoryBudget"] = value.round();
                          _checkForChanges();
                        });
                      },
                    ),
                  ),

                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 4),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text("\$${minBudget.toInt()}"),
                        Text("\$${maxBudget.toInt()} (recommended)"),
                      ],
                    ),
                  ),
                ],
              ),

            ),
            const SizedBox(height: 24),

            // Job Description

            buildTextField(
              label: "Job Description",
              hint: "Describe what you need...",
              controller: controller.jobDescriptionC,
            ),
            const SizedBox(height: 16),

            // Special Instructions
            buildTextField(
              label: "Special Instruction",
              hint: "Gate codes, parking info, dietary restrictions...",
              controller: controller.specialInsC,
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
                  child: Obx((){
                    return AppButtonWidget(
                        onPressed: (controller.isLoading.value || !_hasChanges) ? null :  () async {
                          final plannerId = FirebaseAuth.instance.currentUser!.uid;

                          controller.postCategoryAsJob(
                              category: EventCategoryModel(
                                  jobDescription: controller.jobDescriptionC.text,
                                  jobInstructions: controller.specialInsC.text,
                                  categoryId: args["category"],
                                  eventId: args["eventId"],
                                  guests: args["guests"],
                                  title: args["eventName"],
                                  eventDate: args["eventStartDate"],
                                  recommendedBudget: args["categoryBudget"],
                                  eventType: args["type"],
                                  status: JobStatus.posted),

                              plannerId: plannerId,
                              city: args["eventLocation"]);

                        },
                        loader: controller.isLoading.value,
                        width: 40.w,
                        height: 6.h,
                        buttonColor: AppColors.fieldColor,
                        radius: 30,
                        text: controller.buttonText.value);
                  }
                  )
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
  
  void _checkForChanges() {
     if (!mounted) return;
     
     final isBudgetChanged = (selectedBudget - _initialBudget).abs() > 1.0; // Tolerance
     final isDescChanged = controller.jobDescriptionC.text != _initialDescription;
     final isInstChanged = controller.specialInsC.text != _initialInstructions;
     
     final hasChanges = isBudgetChanged || isDescChanged || isInstChanged;
     
     if (_hasChanges != hasChanges) {
        setState(() {
           _hasChanges = hasChanges;
        });
     }
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
