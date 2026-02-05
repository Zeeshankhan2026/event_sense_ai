import 'dart:io';
import 'dart:ui';

import 'package:event_sense_ai/core/controller/vendor_controller.dart';
import 'package:event_sense_ai/core/services/image_picker_services.dart';
import 'package:event_sense_ai/utils/app_assets.dart';
import 'package:event_sense_ai/utils/app_colors.dart';
import 'package:event_sense_ai/utils/app_text.dart';
import 'package:event_sense_ai/utils/app_validator.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:sizer/sizer.dart';
import '../../../core/services/location_services.dart';
import '../../../core/widgets/app_buttons.dart';
import '../../../core/widgets/app_textfield.dart';

class VendorRegistrationScreen extends StatefulWidget {
  VendorRegistrationScreen({super.key});

  @override
  State<VendorRegistrationScreen> createState() =>
      _VendorRegistrationScreenState();
}

class _VendorRegistrationScreenState extends State<VendorRegistrationScreen> {
  final formKey = GlobalKey<FormState>();
  bool isvisible = false;
  bool ischecked = false;
  bool showCategoryList = false;
  String? selectedCategory;
  bool isFetchingLocation = false;
  File? selectedImage;

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;
    final vendor_controller = Get.find<VendorController>();
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: SafeArea(
          child: Column(
            children: [
              Stack(
                children: [
                  SizedBox(
                    height: height * 0.25,
                    width: width * 1,
                    child: Image.asset(
                      AppAssets.login_screen_banner,
                      fit: BoxFit.cover,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 35.0, left: 30),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        AppText(
                          "LOGO",
                          type: AppTextType.appBar,
                          color: AppColors.white,
                          fontSize: 22,
                        ),
                        Gap(10),
                        AppText(
                          "Build Your\nProfile",
                          type: AppTextType.heading1,
                          color: AppColors.white,
                          fontSize: 30,
                        ),
                        SizedBox(height: 15),
                        Row(
                          children: [
                            AppText(
                              "Ai Match you Perfect Clients?",
                              type: AppTextType.caption,
                              color: AppColors.white,
                              fontWeight: FontWeight.w500,
                            ),
                            Gap(5),
                            GestureDetector(
                              onTap: (){
                                Get.back();
                              },
                              child: Column(
                                children: [
                                  AppText(
                                    "Log In",
                                    type: AppTextType.caption,
                                    fontWeight: FontWeight.w600,
                                    color: AppColors.text_button,
                                  ),
                                  Container(
                                    margin: const EdgeInsets.only(top: 2),
                                    height: 2,
                                    width: 40,
                                    color: AppColors.text_button,
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              SizedBox(height: 10),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 18.0),
                child: Column(
                  children: [
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
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
                                        null
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
                        const SizedBox(height: 12),
                        AppText(
                          "Upload Logo",
                          fontWeight: FontWeight.w500,
                          fontSize: 14,
                          color: Colors.grey,
                        ),
                      ],
                    ),
                    Form(
                      key: formKey,
                      child: Column(
                        children: [
                          Align(
                            alignment: Alignment.centerLeft,
                            child: AppText(
                              "Company Name",
                              type: AppTextType.bodyBold,
                              fontSize: 16,
                              color: AppColors.textGrey,
                            ),
                          ),
                          const SizedBox(height: 8),
                          AppFormField(
                            validator: (String? value) {
                              if (value!.isEmpty) return "name are required";
                              if (value.length < 3) {
                                return "enter valid company name";
                              }
                              return null;
                            },
                            prefic_icons: Icons.person,
                            borderColor: Colors.grey.shade300,
                            focusedBorderColor: Colors.grey.shade300,
                            showBorder: true,
                            title: "Add company name",
                            textEditingController: vendor_controller.vendorCompanyNameC,
                          ),
                          SizedBox(height: 10),
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
                          value: selectedCategory,
                          items: const [
                            DropdownMenuItem(
                              value: "Decorations",
                              child: Text("Decorations"),
                            ),
                            DropdownMenuItem(
                              value: "Catering",
                              child: Text("Catering"),
                            ),
                            DropdownMenuItem(
                              value: "Photography",
                              child: Text("Photography"),
                            ),
                            DropdownMenuItem(
                              value: "Venue Rental",
                              child: Text("Venue Rental"),
                            ), DropdownMenuItem(
                              value: "Entertainment",
                              child: Text("Entertainment"),
                            ),
                            DropdownMenuItem(
                              value: "Attire",
                              child: Text("Attire"),
                            ),
                            DropdownMenuItem(
                              value: "Audio/Visual Equipment",
                              child: Text("Audio/Visual Equipment"),
                            ),
                            DropdownMenuItem(
                              value: "Markeitng and Promotion",
                              child: Text("Audio/Visual Equipment"),
                            ),
                            DropdownMenuItem(
                              value: "Miscellaneous",
                              child: Text("Miscellaneous"),
                            ),
                          ],
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

                          Gap(10),
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
                            onTap: () async  {
                              setState(() {
                                isFetchingLocation = true;
                              });
                              final cityName =
                                  await LocationServices.fetchCurrentCityWithPermission(context);
                              if (cityName != null) {
                                setState(() {
                                  vendor_controller.vendorLocationC.text = cityName;
                                });
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
                            title: "your city",
                            textEditingController: vendor_controller.vendorLocationC,
                          ),
                          Gap(10),
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
                            onTap: () {},
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

                              return null; // ✅ valid
                            },
                            prefic_icons: Icons.email_outlined,
                            borderColor: Colors.grey.shade300,
                            focusedBorderColor: Colors.grey.shade300,
                            showBorder: true,
                            title: "Loisbecket123@gmail.com",
                            textEditingController: vendor_controller.vendorEmailC,
                          ),

                          Gap(10),
                          Align(
                            alignment: Alignment.centerLeft,
                            child: AppText(
                              "Password",
                              type: AppTextType.bodyBold,
                              fontSize: 16,
                              color: AppColors.textGrey,
                            ),
                          ),
                          const SizedBox(height: 8),
                          AppFormField(
                            validator: (value) => AppValidator.validatePassword(value),
                            onTap: () {
                              setState(() {
                                isvisible = !isvisible;
                              });
                            },
                            prefic_icons: Icons.lock_outline,
                            borderColor: Colors.grey.shade300,
                            focusedBorderColor: Colors.grey.shade300,
                            isObsecured: isvisible == true ? false : true,
                            icon: isvisible == true
                                ? Icons.visibility
                                : Icons.visibility_off,

                            showBorder: true,
                            title: "password",
                            textEditingController: vendor_controller.vendorPasswordC,
                          ),
                          Gap(10),
                          Align(
                            alignment: Alignment.centerLeft,
                            child: AppText(
                              "Phone",
                              type: AppTextType.bodyBold,
                              fontSize: 16,
                              color: AppColors.textGrey,
                            ),
                          ),

                          AppFormField(
                            borderColor: Colors.grey.shade300,
                            focusedBorderColor: Colors.grey.shade300,
                            prefic_icons: Icons.phone_android_outlined,
                            validator: (String? value) {
                              if (value!.isEmpty) return "phone are required";
                              if (value.length != 11) {
                                return "enter a valid phone number of 11 digits";
                              }
                              return null;
                            },
                            showBorder: true,
                            title: "0336-78323-89",
                            textEditingController: vendor_controller.vendorPhoneC,
                          ),
                        ],
                      ),
                    ),

                    SizedBox(height: 10),
                    Obx((){

                      return AppButtonWidget(
                        onPressed: vendor_controller.isloading.value ? null :   () async  {
                          if (formKey.currentState!.validate())  {
                           await  vendor_controller.create_Vendor();
                          }
                          print("Account creation initiated");
                        },
                        width: width * 0.85,
                        height: height * 0.06,
                        loader: vendor_controller.isloading.value,
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                        buttonColor: AppColors.fieldColor,
                        text: "Save and Continue",
                      );
                    }
                    ),
                    SizedBox(height: 5),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
