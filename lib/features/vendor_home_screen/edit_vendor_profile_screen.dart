import 'dart:ui';
import 'package:event_sense_ai/core/controller/vendor_controller.dart';
import 'package:event_sense_ai/core/models/users_model.dart';
import 'package:event_sense_ai/core/models/vendor_model.dart';
import 'package:event_sense_ai/core/widgets/custom_circle_avator.dart';
import 'package:event_sense_ai/utils/app_assets.dart';
import 'package:event_sense_ai/utils/app_icons.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:sizer/sizer.dart';

import '../../core/services/location_services.dart';
import '../../core/widgets/app_textfield.dart';
import '../../core/widgets/apptext.dart';
import '../../utils/app_colors.dart';
import '../../utils/app_validator.dart';

class EditVendorAccountScreen extends StatefulWidget {
   EditVendorAccountScreen({super.key});

  @override
  State<EditVendorAccountScreen> createState() => _EditVendorAccountScreenState();
}

class _EditVendorAccountScreenState extends State<EditVendorAccountScreen> {
   final companyNameController = TextEditingController();
   final locationController = TextEditingController();
   final phoneController = TextEditingController();
   final controller = Get.find<VendorController>();

  final VendorModel vendorModel = Get.arguments as  VendorModel;
   final vendor_controller = Get.find<VendorController>();
   String? selectedCategory;

   bool isFetchingLocation = false;

   @override
  void initState() {
    super.initState();
    companyNameController.text = vendorModel.companyName ?? "";
    locationController.text = vendorModel.location ?? "";
    phoneController.text = vendorModel.phone ?? "";
    selectedCategory = vendorModel.serviceCategory;
  }

   @override
  Widget build(BuildContext context) {

    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: SafeArea(
          child: Column(
            children: [
              /// Glass Top Bar
              Padding(
                padding: const EdgeInsets.all(12),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(22),
                  child: BackdropFilter(
                    filter: ImageFilter.blur(sigmaX: 18, sigmaY: 18),
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 16, vertical: 14),
                      decoration: BoxDecoration(
                        color: Colors.white.withOpacity(0.85),
                        borderRadius: BorderRadius.circular(22),
                        border: Border.all(
                          color: Colors.grey.withOpacity(0.2),
                        ),
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
                                  fontWeight: FontWeight.w500),
                            ),
                          ),
                          const Text(
                            "My Account",
                            style: TextStyle(
                                fontSize: 18, fontWeight: FontWeight.w700),
                          ),
                          TextButton(
                            onPressed: () {
                              controller.vendorCompanyNameC.text = companyNameController.text;
                              controller.vendorServiceCategoryC.text = selectedCategory!;
                              controller.vendorLocationC.text = locationController.text;
                              controller.vendorPhoneC.text = phoneController.text;
                              controller.updateVendor();
                            },
                            child: Obx(() => controller.isloading.value
                                ? const CircularProgressIndicator()
                                : Text(
                                    "Save",
                                    style: TextStyle(
                                        color: Color(0xFF007AFF),
                                        fontWeight: FontWeight.w600),
                                  )),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),

              const SizedBox(height: 24),

              /// Glass Profile Section
              ClipRRect(
                borderRadius: BorderRadius.circular(100),
                child: BackdropFilter(
                  filter: ImageFilter.blur(sigmaX: 15, sigmaY: 15),
                  child: Container(
                    padding: const EdgeInsets.all(8),
                    decoration: BoxDecoration(
                      color: Colors.white.withOpacity(0.8),
                      shape: BoxShape.circle,
                      border: Border.all(
                          color: Colors.grey.withOpacity(0.25)),
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
                        CustomCircleAvatar(
                          assetImage: AppIcons.profile_icon,
                          imageUrl: vendorModel.profileImage,),
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
                                  color: Colors.grey.withOpacity(0.3)),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.black.withOpacity(0.1),
                                  blurRadius: 6,
                                  offset: const Offset(0, 3),
                                ),
                              ],
                            ),
                            child: const Icon(
                              Icons.camera_alt_outlined,
                              size: 18,
                              color: Colors.grey,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),

              const SizedBox(height: 32),

              ///  Glass Input Fields
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 24),
                child: Column(
                  children: [
                    Gap(2.h),
                    Align( alignment: Alignment.centerLeft, child: AppText("Company Name", type: AppTextType.bodyBold, fontSize: 16,color: AppColors.textGrey,), ),
                    const SizedBox(height: 8),
                    AppFormField(
                      validator:(value) =>  AppValidator.validateName(value),
                      prefic_icons: Icons.person_outline,
                      borderColor: Colors.grey.shade300,
                      focusedBorderColor: Colors.grey.shade300,
                      showBorder: true,
                      title: "add company name",
                      textEditingController: companyNameController,

                    ),
                    Gap(2.h),
                    Align(
                      alignment: Alignment.centerLeft,
                      child: AppText(
                        "Service Category",
                        type: AppTextType.bodyBold,
                        fontSize: 16,
                        color: AppColors.textGrey,
                      ),
                    ),
                    const SizedBox(height: 8),
                    DropdownButtonFormField<String>(
                      decoration: InputDecoration(
                        fillColor: Colors.grey.shade100,
                        filled: true,
                        enabledBorder: OutlineInputBorder(borderSide: BorderSide(color: Colors.grey.shade300,width: 2)),
                        focusedBorder: OutlineInputBorder(borderSide: BorderSide(color: Colors.grey.shade200)),
                        border: OutlineInputBorder(borderSide: BorderSide(color: Colors.grey.shade100)),
                      ),
                      value: _isValidCategory(selectedCategory) ? selectedCategory : null,
                      hint: const Text("Select your category"),
                      items: _dropdownItems,
                      onChanged: (value) {
                        setState(() {
                          selectedCategory = value;
                          vendor_controller.vendorServiceCategoryC.text = value!;
                        });
                      },
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return "Category is required";
                        }
                        return null;
                      },
                    ),
                    Gap(2.h),
                    Align( alignment: Alignment.centerLeft, child: AppText("Location", type: AppTextType.bodyBold, fontSize: 16,color: AppColors.textGrey,), ),
                    const SizedBox(height: 8),
                    AppFormField(
                      readOnly: true,
                      onTap: () async {
                        setState(() {
                          isFetchingLocation = true;
                        });

                        final cityName =
                        await LocationServices.fetchCurrentCityWithPermission(context);

                        if (cityName != null) {
                          locationController.text = cityName;
                        }

                        setState(() {
                          isFetchingLocation = false;
                        });
                      },
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
                      borderColor: Colors.grey.shade300,
                      focusedBorderColor: Colors.grey.shade300,
                      showBorder: true,
                      title: "Location ABD",
                      textEditingController: locationController,
                    ),

                    Gap(2.h),
                    Align( alignment: Alignment.centerLeft, child: AppText("Phone", type: AppTextType.bodyBold, fontSize: 16,color: AppColors.textGrey,), ),
                    const SizedBox(height: 8),
                    AppFormField(
                      validator:(value) =>  AppValidator.validateName(value),
                      prefic_icons: Icons.phone_android_outlined,
                      borderColor: Colors.grey.shade300,
                      focusedBorderColor: Colors.grey.shade300,
                      showBorder: true,
                      title: "phone",
                      textEditingController: phoneController,
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
        Text(label,
            style: const TextStyle(
                fontWeight: FontWeight.w600, fontSize: 14)),
        const SizedBox(height: 6),
        ClipRRect(
          borderRadius: BorderRadius.circular(14),
          child: BackdropFilter(
            filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
            child: TextFormField(
              initialValue: initialValue,
              decoration: InputDecoration(
                filled: true,
                fillColor: Colors.white.withOpacity(0.85),
                contentPadding: const EdgeInsets.symmetric(
                    horizontal: 14, vertical: 16),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(14),
                  borderSide: BorderSide.none,
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(14),
                  borderSide: BorderSide(
                      color: Colors.grey.withOpacity(0.2)),
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
  bool _isValidCategory(String? category) {
    if (category == null) return false;
    return _dropdownItems.any((item) => item.value == category);
  }

  final List<DropdownMenuItem<String>> _dropdownItems = const [
    DropdownMenuItem(value: "Decorations", child: Text("Decorations")),
    DropdownMenuItem(value: "Catering", child: Text("Catering")),
    DropdownMenuItem(value: "Photography", child: Text("Photography")),
    DropdownMenuItem(value: "Venue Rental", child: Text("Venue Rental")),
    DropdownMenuItem(value: "Entertainment", child: Text("Entertainment")),
    DropdownMenuItem(value: "Attire", child: Text("Attire")),
    DropdownMenuItem(value: "Audio/Visual Equipment", child: Text("Audio/Visual Equipment")),
    DropdownMenuItem(value: "Marketing and Promotion", child: Text("Marketing and Promotion")),
    DropdownMenuItem(value: "Miscellaneous", child: Text("Miscellaneous")),
  ];
}
