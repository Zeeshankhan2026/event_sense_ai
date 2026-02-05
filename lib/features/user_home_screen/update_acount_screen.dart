import 'dart:io';
import 'dart:ui';
import 'package:event_sense_ai/core/services/image_picker_services.dart';
import 'package:event_sense_ai/core/services/location_services.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';
import '../../core/controller/user_controller.dart';
import '../../core/widgets/app_textfield.dart';
import '../../core/widgets/apptext.dart';
import '../../utils/app_colors.dart';
import '../../utils/app_validator.dart';


class EditAccountScreen extends StatefulWidget {
  const EditAccountScreen({super.key});

  @override
  State<EditAccountScreen> createState() => _EditAccountScreenState();
}

class _EditAccountScreenState extends State<EditAccountScreen> {

  final controller = Get.find<UserController>();
  final nameC = TextEditingController();
  final emailC = TextEditingController();
  final locationC = TextEditingController();
  File? selectedImage;
  bool islocationLoading = false;
  @override
  void initState() {
    super.initState();

    final user = controller.user.value;

    if (user != null) {
      nameC.text = user.name ?? "";
      emailC.text = user.email ?? "";
      locationC.text = user.userLocations ?? "";
    }
  }

  @override
  void dispose() {
    nameC.dispose();
    emailC.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: SafeArea(
          child: Column(
            children: [
              /// 🔹 Glass Top Bar
              Padding(
                padding: const EdgeInsets.all(12),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(22),
                  child: BackdropFilter(
                    filter: ImageFilter.blur(sigmaX: 18, sigmaY: 18),
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 16,
                        vertical: 14,
                      ),
                      decoration: BoxDecoration(
                        color: Colors.white.withOpacity(0.85),
                        borderRadius: BorderRadius.circular(22),
                        border: Border.all(color: Colors.grey.withOpacity(0.2)),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.06),
                            blurRadius: 12,
                            offset: const Offset(0, 6),
                          ),
                        ],
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          TextButton(
                            onPressed: () => Navigator.pop(context),
                            child: Text(
                              "Cancel",
                              style: TextStyle(
                                color: Colors.grey.shade700,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ),
                          const Text(
                            "My Account",
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                          Obx(() {
                            return TextButton(
                              onPressed: controller.isUserDataLoading.value
                                  ? null
                                  : () async {
                                      await controller.updateUserProfile(
                                        name: nameC.text,
                                        email: emailC.text,
                                        location: locationC.text
                                      );
                                    },
                              child: controller.isUserDataLoading.value
                                  ? CircularProgressIndicator()
                                  : Text(
                                      "Save",
                                      style: TextStyle(
                                        color: Color(0xFF007AFF),
                                        fontWeight: FontWeight.w600,
                                      ),
                                    ),
                            );
                          }),
                        ],
                      ),
                    ),
                  ),
                ),
              ),

              const SizedBox(height: 24),

              /// 🔹 Glass Profile Section
              ClipRRect(
                borderRadius: BorderRadius.circular(100),
                child: BackdropFilter(
                  filter: ImageFilter.blur(sigmaX: 15, sigmaY: 15),
                  child: Container(
                    padding: const EdgeInsets.all(8),
                    decoration: BoxDecoration(
                      color: Colors.white.withOpacity(0.8),
                      shape: BoxShape.circle,
                      border: Border.all(color: Colors.grey.withOpacity(0.25)),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.08),
                          blurRadius: 10,
                          offset: const Offset(0, 4),
                        ),
                      ],
                    ),
                    child: Stack(
                      alignment: Alignment.bottomRight,
                      children: [
                    Container(
                    padding: EdgeInsets.all(1),
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      border: Border.all(color: Colors.blue, width: 1),
                    ),
                    child: CircleAvatar(
                      radius: 50,
                      backgroundColor: Colors.grey[200],
                      backgroundImage:
                      selectedImage != null ? FileImage(selectedImage!) :
                      NetworkImage(controller.user.value!.profileImage!)
                    ),

                  ),
                        Positioned(
                          bottom: 2,
                          right: 2,
                          child: Container(
                            width: 32,
                            height: 32,
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color: Colors.white,
                              border: Border.all(
                                color: Colors.grey.withOpacity(0.3),
                              ),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.black.withOpacity(0.1),
                                  blurRadius: 6,
                                  offset: const Offset(0, 3),
                                ),
                              ],
                            ),
                            child:  GestureDetector(
                              onTap: () async{
                                final image = await ImagePickerService.pickImageFromGallery(context);
                                setState(() {
                                  selectedImage = image;
                                });
                              },
                              child: Icon(
                                Icons.add_a_photo,
                                size: 18,
                                color: Colors.grey,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),

              const SizedBox(height: 32),

              /// Glass Input Fields
              ///
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 24),
                child: Column(
                  children: [
                    Align(
                      alignment: Alignment.centerLeft,
                      child: AppText(
                        "Full Name",
                        type: AppTextType.bodyBold,
                        fontSize: 16,
                        color: AppColors.textGrey,
                      ),
                    ),
                    const SizedBox(height: 8),
                    AppFormField(
                      validator: (value) => AppValidator.validateName(value),
                      prefic_icons: Icons.person_outline,
                      borderColor: Colors.grey.shade300,
                      focusedBorderColor: Colors.grey.shade300,
                      showBorder: true,
                      title: "full name",
                      textEditingController: nameC,
                    ),
                    Gap(3.h),
                    Align(
                      alignment: Alignment.centerLeft,
                      child: AppText(
                        "Email",
                        type: AppTextType.bodyBold,
                        fontSize: 16,
                        color: AppColors.textGrey,
                      ),
                    ),
                    const SizedBox(height: 8),
                    AppFormField(
                      validator: (String? value) {
                        final email = value?.trim() ?? '';

                        if (email.isEmpty) {
                          return 'Email is required';
                        }

                        final emailRegex = RegExp(
                          r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$',
                        );

                        if (!emailRegex.hasMatch(email)) {
                          return 'Please enter a valid email address';
                        }

                        return null;
                      },
                      prefic_icons: Icons.person_outline,
                      borderColor: Colors.grey.shade300,
                      focusedBorderColor: Colors.grey.shade300,
                      showBorder: true,
                      title: "email@gmail.com",
                      textEditingController: emailC,
                    ),
                    Gap(3.h),
                    Align(
                      alignment: Alignment.centerLeft,
                      child: AppText(
                        "Location",
                        type: AppTextType.bodyBold,
                        fontSize: 16,
                        color: AppColors.textGrey,
                      ),
                    ),
                    const SizedBox(height: 8),
                    AppFormField(
                      readOnly: true,
                      onTap: () async {
                        setState(() {
                          islocationLoading = true;
                        });
                      final cityName = await   LocationServices.fetchCurrentCityWithPermission(context);
                      if(cityName != null){
                       setState(() {
                         locationC.text = cityName;
                       });
                      }
                      setState(() {
                        islocationLoading = false;
                      });
                      },
                      iconWidget: islocationLoading
                          ?  Container(
                        padding: EdgeInsets.all(12),
                        width: 15,
                        height: 15,
                        child: CircularProgressIndicator(
                          strokeWidth: 2,
                        ),
                      )
                          : const Icon(Icons.location_on_outlined),
                      icon: Icons.person_outline,
                      borderColor: Colors.grey.shade300,
                      focusedBorderColor: Colors.grey.shade300,
                      showBorder: true,
                      title: "Location ABD",
                      textEditingController: locationC,
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  /// 🔹 Reusable Glass TextField
  Widget buildGlassField(String label, String initialValue) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: const TextStyle(fontWeight: FontWeight.w600, fontSize: 14),
        ),
        const SizedBox(height: 6),
        ClipRRect(
          borderRadius: BorderRadius.circular(14),
          child: BackdropFilter(
            filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
            child: TextFormField(
              controller: nameC,
              initialValue: initialValue,
              decoration: InputDecoration(
                filled: true,
                fillColor: Colors.white.withOpacity(0.85),
                contentPadding: const EdgeInsets.symmetric(
                  horizontal: 14,
                  vertical: 16,
                ),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(14),
                  borderSide: BorderSide.none,
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(14),
                  borderSide: BorderSide(color: Colors.grey.withOpacity(0.2)),
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
