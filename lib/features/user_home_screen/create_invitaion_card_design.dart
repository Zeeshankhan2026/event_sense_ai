import 'package:event_sense_ai/core/controller/inviation_card_controller.dart';
import 'package:event_sense_ai/core/models/guest_model.dart';
import 'package:event_sense_ai/core/widgets/snackbar_widget.dart';
import 'package:event_sense_ai/utils/app_assets.dart';
import 'package:event_sense_ai/utils/app_colors.dart';
import 'package:event_sense_ai/utils/app_icons.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';
import '../../core/controller/guest_controller.dart';
import '../../core/models/event_model.dart';
import '../../core/widgets/app_buttons.dart';
import '../../core/widgets/app_textfield.dart';
import '../../core/widgets/apptext.dart';
import '../../core/widgets/custom_headerbar.dart';


class CreateInvitaionCardDesign extends StatefulWidget {
  const CreateInvitaionCardDesign({super.key});

  @override
  State<CreateInvitaionCardDesign> createState() =>
      _CreateInvitaionCardDesignState();
}

class _CreateInvitaionCardDesignState extends State<CreateInvitaionCardDesign> {

  final controller = Get.find<InvitationController>();
  final guestController  = Get.find<GuestController>();

  final EventModel eventModel = Get.arguments;
  final List<AI_designs> aiDesign = [
    AI_designs(label: "Floral", Image_url: AppAssets.Floral_image),
    AI_designs(label: "Minimal", Image_url: AppAssets.Minimal_image),
    AI_designs(label: "Retro", Image_url: AppAssets.Retro_image),
  ];

  final eventNameController = TextEditingController();
  final eventLocation = TextEditingController();
  final hostController = TextEditingController();

  String selectedFormat = "PNG";
  final List<String> formats = ["PNG", "PDF", "JPG"];

  late String selectedDate;
  late String selectedTime;

   String designType = "";
   String rsvpLink = "";

  @override
  void initState() {
    super.initState();
    eventNameController.text = eventModel.eventName;
    eventLocation.text = eventModel.eventLocation;
    selectedDate = eventModel.eventStartDate;
    selectedTime = "12:00 PM"; // Default or from model if available
    hostController.text = "The Host Family"; // Simple default
    designType = aiDesign[0].label; // Set a default style
  }

  Future<void> _pickDate() async {
    final now = DateTime.now();
    final picked = await showDatePicker(
      context: context,
      initialDate: now,
      firstDate: now,
      lastDate: DateTime(now.year + 5),
    );
    if (picked != null) {
      setState(() {
        selectedDate = "${picked.day}/${picked.month}/${picked.year}";
      });
    }
  }

  Future<void> _pickTime() async {
    final picked = await showTimePicker(
      context: context,
      initialTime: TimeOfDay.now(),
    );
    if (picked != null) {
      setState(() {
        selectedTime = picked.format(context);
      });
    }
  }

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
              CustomHeaderBar(title: "Send Invitations", showBackButton: true ,onBack: (){
                Get.back();
                controller.generatedImageUrl.value = "";
              },),

                Gap(1.h),
                AppText(
                  "Digital RSVP",
                  fontSize: 20,
                  fontWeight: FontWeight.w600,
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
                  fontWeight: FontWeight.w400,
                  fontSize: 14,
                ),
                Gap(1.h),
                AppText(
                  "Select Style",
                  fontWeight: FontWeight.w600,
                  fontSize: 20,
                  color: Colors.black,
                ),
                SizedBox(
                  height: 19.h,
                  child: ListView.builder(
                    itemCount: aiDesign.length,
                    scrollDirection: Axis.horizontal,
                    itemBuilder: (context, index) {
                      final data = aiDesign[index];
                      return GestureDetector(
                        onTap: (){
                          setState(() {
                            designType = data.label.toString();
                          });
                          print(designType);
                        },
                        child: Container(
                          padding: EdgeInsets.all(8),
                          margin: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                          decoration: BoxDecoration(
                            color: designType == data.label.toString()
                                ? Colors.grey.shade100
                                : Colors.transparent,
                            borderRadius: BorderRadius.circular(22),
                            border: Border.all(
                              color: designType == data.label.toString()
                                  ? Colors.grey.shade300
                                  : Colors.transparent,
                              width: 2,
                            ),
                          ),
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
                AppFormField(
                  readOnly: true,
                    borderColor: Colors.grey.shade300,
                    showBorder: true,

                    title: "Event name", textEditingController: eventNameController),
                Container(
                  padding: const EdgeInsets.all(16),
                  margin: const EdgeInsets.symmetric(vertical: 12),
                  decoration: BoxDecoration(
                    color: Colors.white,
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          AppText("Event Date", fontWeight: FontWeight.w800,fontSize: 15,color: Colors.black,),
                          Container(
                            width: 34.w,
                              padding: EdgeInsets.all(6),
                              margin: EdgeInsets.only(top: 4),
                              decoration: BoxDecoration(
                                border: BoxBorder.all(color: Colors.grey.shade600),
                                borderRadius: BorderRadius.circular(12)
                              ),
                              child: Row(
                                children: [
                                  AppText(selectedDate, color: Colors.grey),
                                  Spacer(),
                                  InkWell(
                                    onTap: _pickDate,
                                    child: SvgPicture.asset(
                                      AppIcons.calender_icon,
                                      height: 25,
                                      color: Colors.indigo.shade900,
                                    ),
                                  )
                                ],
                              ))
                        ],
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          AppText("Event Time", fontWeight: FontWeight.w800,fontSize: 15,color: Colors.black,),
                          Container(
                              width: 34.w,
                              padding: EdgeInsets.all(6),
                              margin: EdgeInsets.only(top: 4),
                              decoration: BoxDecoration(
                                  border: BoxBorder.all(color: Colors.grey.shade600),
                                  borderRadius: BorderRadius.circular(12)
                              ),
                              child: Row(
                                children: [
                                  AppText(selectedTime, color: Colors.grey),
                                  Spacer(),
                                  InkWell(
                                    onTap: _pickTime,
                                    child: Icon(
                                      Icons.alarm_sharp,
                                      size: 25,
                                      color: Colors.indigo.shade900,
                                    ),
                                  )
                                ],
                              ))
                        ],
                      ),
                    ],
                  )
                ),
                AppText(
                  "Event Location",
                  fontWeight: FontWeight.w700,
                  fontSize: 14,
                ),
                Gap(1.h),
                AppFormField(
                  showBorder: true,
                    readOnly: true,
                    borderColor: Colors.grey.shade300,
                    title: "event location", textEditingController: eventLocation),
                Gap(1.h),
                AppText("Hosts", fontWeight: FontWeight.w700, fontSize: 14),
                Gap(1.h),
               AppFormField(
                   showBorder: true,
                   borderColor: Colors.grey.shade300,

                   title: "host name", textEditingController: hostController),
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
                          Obx((){
                            if (controller.isLoading.value) {
                              return Center(child: const CircularProgressIndicator());
                            }

                            if (controller.generatedImageUrl.isEmpty) {
                              return Center(child: const Text("Click to generate a design"));
                            }


                            return ClipRRect(
                              borderRadius: BorderRadius.circular(12),
                              child: Image.network(
                                controller.generatedImageUrl.value,  // Replace with your image path
                                width: double.infinity,
                                height: 380,
                                fit: BoxFit.cover,
                              ),
                            );
                          }
                          ),
                        ],
                      ),
                    ),
                    Obx(() {
                      // Only show visibility icon when design is generated
                      if (controller.generatedImageUrl.isEmpty) {
                        return const SizedBox.shrink();
                      }
                      
                      return Positioned(
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
                              // Navigate to full-screen preview
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => FullScreenDesignPreview(
                                    imageUrl: controller.generatedImageUrl.value,
                                  ),
                                ),
                              );
                            },
                          ),
                        ),
                      );
                    }),

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
                  onPressed:   () {
                    if (designType.isEmpty) {
                      SafeSnackbar.error("Error", "Please select a design style");
                      return;
                    }
                    if (eventNameController.text.isEmpty) {
                      Get.snackbar("Required", "Event name is required");
                      return;
                    }
                    if (selectedDate.isEmpty) {
                      Get.snackbar("Required", "Please select an event date");
                      return;
                    }
                    if (selectedTime.isEmpty) {
                      Get.snackbar("Required", "Please select an event time");
                      return;
                    }
                    if (eventLocation.text.isEmpty) {
                      Get.snackbar("Required", "Event location is required");
                      return;
                    }
                    if (hostController.text.isEmpty) {
                      Get.snackbar("Required", "Host name is required");
                      return;
                    }

                    controller.generatedImageUrl.isEmpty ?
                    controller.generateInvitation(
                        eventName: eventNameController.text.trim(),
                        hostName: hostController.text.trim(),
                        location: eventLocation.text.trim(),
                        date: selectedDate,
                        time: selectedTime,
                        style: designType,
                        rsvpLink: "fskafhdaskfhdalskhkafdsh33233e4hk") :
                    Get.snackbar("Alert", "Image are generated");
                    // Get.offAllNamed(AppRoutes.main);
                  },
                  width: 80.w,
                  height: 6.h,
                  text: "Create a design",
                  fontWeight: FontWeight.w600,
                  fontSize: 14,
                  buttonColor: Colors.indigo.shade900,
                ),

                Gap(1.h),
                AppText("Send to", fontWeight: FontWeight.w600, fontSize: 16),
                Gap(1.h),
                StreamBuilder(
                  stream: guestController.FetchGuest(),
                  builder: (context, guestsnap){
                    if(guestsnap.connectionState == ConnectionState.waiting){
                      return Center(child: CircularProgressIndicator(),);
                    }
                    if(!guestsnap.hasData || guestsnap.data!.docs.isEmpty){
                      return Center(child: Text("No guest found"),);
                    }
                    List<GuestModel> guest = guestsnap.data!.docs.map((doc)
                    => GuestModel.fromJson(doc.data())).toList();

                    return Column(
                      children: [
                        InkWell(
                          onTap: (){
                            _showGuestBottomSheet(context, guest);
                          },
                          child: Container(
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
                        ),
                        Gap(2.h),
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
                                      "http://192.168.18.223:3000/${guestController.currentEventId}/${guestController.guestId}",
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
                      ],
                    );
                  }
                ),

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
              ],
            ),
          ),
        ),
      ),
    );
  }
  void _showGuestBottomSheet(
      BuildContext context,
      List<GuestModel> guests,
      ) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (_) {
        return SizedBox(
          height: 60.h,
          child: Column(
            children: [
              const SizedBox(height: 12),
              Container(
                width: 40,
                height: 4,
                decoration: BoxDecoration(
                  color: Colors.grey.shade400,
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
              const SizedBox(height: 16),
              AppText(
                "Select Guests",
                fontSize: 18,
                fontWeight: FontWeight.w700,
              ),
              const SizedBox(height: 16),

              ///  Guest List
              Expanded(
                child: ListView.builder(
                  itemCount: guests.length,
                  itemBuilder: (context, index) {
                    final guest = guests[index];

                    return ListTile(
                      onTap : (){
                        guestController.setGuestId(guest.guestId);
                      },
                      leading: CircleAvatar(
                        backgroundColor: Colors.indigo.shade200,
                        child: Text(
                          guest.guestName.isNotEmpty
                              ? guest.guestName[0].toUpperCase()
                              : "?",
                          style: const TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      title: Text(
                        guest.guestName,
                        style: const TextStyle(fontWeight: FontWeight.w600),
                      ),
                      subtitle: Text(guest.guestEmail),
                      trailing: Checkbox(
                        value: false, // baad me state laga sakte ho
                        onChanged: (val) {
                          /// select guest logic yahan aayegi
                        },
                      ),

                    );
                  },
                ),
              ),
            ],
          ),
        );
      },
    );
  }

}

class AI_designs {
  String Image_url;
  String label;

  AI_designs({required this.label, required this.Image_url});
}

// Full-screen preview widget
class FullScreenDesignPreview extends StatelessWidget {
  final String imageUrl;

  const FullScreenDesignPreview({
    super.key,
    required this.imageUrl,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: SafeArea(
        child: Stack(
          children: [
            // Full-screen image
            Center(
              child: InteractiveViewer(
                minScale: 0.5,
                maxScale: 4.0,
                child: Image.network(
                  imageUrl,
                  fit: BoxFit.contain,
                  width: double.infinity,
                  height: double.infinity,
                ),
              ),
            ),
            // Back button
            Positioned(
              top: 16,
              left: 16,
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.black.withOpacity(0.5),
                  borderRadius: BorderRadius.circular(30),
                ),
                child: IconButton(
                  icon: const Icon(
                    Icons.arrow_back,
                    color: Colors.white,
                    size: 24,
                  ),
                  onPressed: () {
                    Navigator.pop(context);
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
