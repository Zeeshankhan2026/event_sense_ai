import 'package:event_sense_ai/utils/app_assets.dart';
import 'package:event_sense_ai/utils/app_colors.dart';
import 'package:event_sense_ai/utils/app_icons.dart';
import 'package:event_sense_ai/utils/app_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';

import '../../../core/routes/app_routes.dart';
import '../../../core/widgets/app_buttons.dart';
import '../../../core/widgets/app_textfield.dart';

class VendorRegistrationScreen extends StatefulWidget {
  VendorRegistrationScreen({super.key});

  @override
  State<VendorRegistrationScreen> createState() => _VendorRegistrationScreenState();
}

class _VendorRegistrationScreenState extends State<VendorRegistrationScreen> {
  final name_controller = TextEditingController();
  final email_controller = TextEditingController();
  final password_controller = TextEditingController();
  final confirm_password_controller = TextEditingController();
  bool isvisible = false;
  bool ischecked = false;

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: SafeArea(
          child: Column(
            children: [
              Stack(
                  children : [
                    SizedBox(
                      height: height*0.25,
                      width: width*1,
                      child: Image.asset(AppAssets.login_screen_banner,fit: BoxFit.cover,),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 35.0, left: 30),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          AppText("LOGO", type: AppTextType.appBar,color: AppColors.white,fontSize: 22,),
                          Gap(10),
                          AppText("Build Your\nProfile", type: AppTextType.heading1,color: AppColors.white,fontSize: 30,),
                          SizedBox(height: 15,),
                          Row(
                            children: [
                              AppText("Ai Match you Perfect Clients?",
                                  type: AppTextType.caption,color: AppColors.white,fontWeight: FontWeight.w500
                              ),
                              Gap(5),
                              Column(
                                children: [
                                  AppText("SignUP",
                                    type: AppTextType.caption,
                                    fontWeight: FontWeight.w600,
                                    color: AppColors.text_button,),
                                  Container( margin: const EdgeInsets.only(top: 2), height: 2, width: 40, color: AppColors.text_button, ),
                                ],
                              )
                            ],
                          ),
                        ],
                      ),
                    )
                  ]
              ),
              SizedBox(height: 10,),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 18.0),
                child: Column(
                  children: [
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Stack(
                          alignment: Alignment.bottomRight,
                          children: [
                            // Main Circular Placeholder
                            Container(
                              width: 120,
                              height: 120,
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                color: const Color(0xffD9D9D9),
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.black.withOpacity(0.08),
                                    blurRadius: 6,
                                    spreadRadius: 2,
                                    offset: const Offset(0, 4),
                                  ),
                                ],
                              ),
                              child: const Center(
                                child: Icon(Icons.camera_alt_outlined, size: 40, color: Colors.grey),
                              ),
                            ),

                            // Bottom-right Camera Overlay
                            Positioned(
                              bottom: 0,
                              right: 0,
                              child: GestureDetector(
                                onTap: () {
                                  print("Upload image tapped");
                                  // Add image picker logic here
                                },
                                child: Container(
                                  width: 36,
                                  height: 36,
                                  decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                    color: Colors.white,
                                    boxShadow: [
                                      BoxShadow(
                                        color: Colors.black.withOpacity(0.1),
                                        blurRadius: 6,
                                        offset: const Offset(0, 3),
                                      ),
                                    ],
                                  ),
                                  child: const Center(
                                    child: Icon(Icons.camera_alt_outlined, size: 20, color: Colors.grey),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        )

                        ,
                        const SizedBox(height: 12),
                        AppText("Upload Logo", fontWeight: FontWeight.w500,fontSize: 14,color: Colors.grey,)
                      ],
                    ),
          
                    Align( alignment: Alignment.centerLeft, child: AppText("Company Name", type: AppTextType.bodyBold, fontSize: 16,color: AppColors.textGrey,), ),
                    const SizedBox(height: 8),
                    AppFormField(
                        prefic_icons: Icons.person,
                        borderColor: Colors.black,
                        focusedBorderColor: Colors.black,
                        showBorder: false,
                        title: "Add company name",
                        textEditingController: name_controller),
                    SizedBox(height: 10,),
                    Align( alignment: Alignment.centerLeft, child: AppText("Service Category", type: AppTextType.bodyBold, fontSize: 16,color: AppColors.textGrey,), ),
                    const SizedBox(height: 8),
                    AppFormField(
                        prefic_icons: Icons.email,
                        borderColor: Colors.black,
                        focusedBorderColor: Colors.black,
                        showBorder: false,
                        title: "your category",
                        textEditingController: email_controller),
                    SizedBox(height: 10,),
                    Align( alignment: Alignment.centerLeft, child: AppText("Location", type: AppTextType.bodyBold, fontSize: 16,color: AppColors.textGrey,), ),
                    const SizedBox(height: 8),
                    AppFormField(
                        onTap: (){
          
                        },
          
                        isObsecured : isvisible == true ? false : true,
                        borderColor: Colors.black,
                        focusedBorderColor: Colors.black,
                        showBorder: false,
                        title: "your city",
                        textEditingController: password_controller),
                    Gap(10),
                    Align( alignment: Alignment.centerLeft, child: AppText("Email", type: AppTextType.bodyBold, fontSize: 16,color: AppColors.textGrey,), ),
                    const SizedBox(height: 8),
          
                    AppFormField(
                        onTap: (){
                        },
                        isObsecured : isvisible == true ? false : true,
                        borderColor: Colors.black,
                        focusedBorderColor: Colors.black,
                        showBorder: false,
                        title: "Loisbecket123@gmail.com",
                        textEditingController: confirm_password_controller),
                    Gap(10),
                    Align( alignment: Alignment.centerLeft, child: AppText("Phone", type: AppTextType.bodyBold, fontSize: 16,color: AppColors.textGrey,), ),
                    const SizedBox(height: 8),
          
                    AppFormField(
                        onTap: (){
                        },
                        focusedBorderColor: Colors.black,
                        showBorder: false,
                        title: "0336-78323-89",
                        textEditingController: confirm_password_controller),
          
                    SizedBox(height: 10,),
                    AppButtonWidget(
                        onPressed: (){
                          context.goNamed(AppRoutes.VendorSetLocation);
                        },
                        width: width*0.85,
                        height: height*0.06,
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                        buttonColor: AppColors.fieldColor,
                        text: "Save and Continue"),
                    SizedBox(height: 5 ,),
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
