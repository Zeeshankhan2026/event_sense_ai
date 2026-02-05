
import 'package:event_sense_ai/core/controller/user_controller.dart';
import 'package:event_sense_ai/core/routes/app_routes.dart';
import 'package:event_sense_ai/utils/app_assets.dart';
import 'package:event_sense_ai/utils/app_colors.dart';
import 'package:event_sense_ai/utils/app_icons.dart';
import 'package:event_sense_ai/utils/app_text.dart';
import 'package:event_sense_ai/utils/app_validator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

import 'package:sizer/sizer.dart';
import '../../../core/widgets/app_buttons.dart';
import '../../../core/widgets/app_textfield.dart';
import '../../../core/widgets/custom_rich_text.dart';

class SignUpScreen extends StatefulWidget {
  SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  bool isvisible = false;
  bool isChecked = false;
  final formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;

    final controller = Get.find<UserController>();
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Column(
          children: [
            Stack(
                children : [
                  SizedBox(
                    height: height*0.31,
                    width: width*1,
                    child: Image.asset(AppAssets.login_screen_banner,fit: BoxFit.cover,),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 48.0, left: 30),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Gap(20),
                        AppText("LOGO", type: AppTextType.appBar,color: AppColors.white,fontSize: 22,),
                        Gap(10),
                        AppText("Sign in to your \nAccount", type: AppTextType.heading1,color: AppColors.white,fontSize: 30,),
                        SizedBox(height: 15,),
                        Row(
                          children: [
                            AppText("Already have an account?",
                              type: AppTextType.caption,color: AppColors.white,fontWeight: FontWeight.w500
                              ),
                            Gap(5),
                            GestureDetector(
                              onTap: (){
                                controller.clearAllFields();
                                Navigator.of(context).pop();
                              },
                              child: Column(
                                children: [
                                  AppText("Login",
                                    type: AppTextType.caption,
                                    fontWeight: FontWeight.w600,
                                    color: AppColors.text_button,),
                                  Container( margin: const EdgeInsets.only(top: 2), height: 2, width: 35, color: AppColors.text_button, ),
                                ],
                              ),
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
              child: Form(
                key: formKey,
                child: Column(
                  children: [
                    Align( alignment: Alignment.centerLeft, child: AppText("Full Name", type: AppTextType.bodyBold, fontSize: 16,color: AppColors.textGrey,), ),
                    const SizedBox(height: 8),
                    AppFormField(
                      validator: (value) => AppValidator.validateName(value),
                      prefic_icons: Icons.person_outline,
                        borderColor: Colors.grey.shade300,
                        focusedBorderColor: Colors.grey.shade300,
                        showBorder: true,
                        title: "Loisbecket",
                        textEditingController: controller.signUpNameC),
                    SizedBox(height: 10,),
                    Align( alignment: Alignment.centerLeft, child: AppText("Email", type: AppTextType.bodyBold, fontSize: 16,color: AppColors.textGrey,), ),
                    const SizedBox(height: 8),
                    AppFormField(
                      validator: (value) => AppValidator.validateEmail(value),
                        prefic_icons: Icons.email_outlined,
                        borderColor: Colors.grey.shade300,
                        focusedBorderColor: Colors.grey.shade300,
                        showBorder: true,
                        title: "Loisbecket@gmail.com",
                        textEditingController: controller.signUpEmailC),
                    SizedBox(height: 10,),
                    Align( alignment: Alignment.centerLeft, child: AppText("Password", type: AppTextType.bodyBold, fontSize: 16,color: AppColors.textGrey,), ),
                    const SizedBox(height: 8),
                    AppFormField(
                      validator: (value) => AppValidator.validatePassword(value),
                      onTap: (){
                        setState(() {
                          isvisible = !isvisible;
                        });
                      },
                        icon: isvisible == true ? Icons.visibility :  Icons.visibility_off,
                        prefic_icons: Icons.lock_outline,
                        isObsecured : isvisible == true ? false : true,
                        borderColor: Colors.grey.shade300,
                        focusedBorderColor: Colors.grey.shade300,
                        showBorder: true,
                        title: "Loisbecket123",
                        textEditingController: controller.signUpPasswordC),
                    Gap(10),
                    Align( alignment: Alignment.centerLeft, child: AppText("Confirm Password", type: AppTextType.bodyBold, fontSize: 16,color: AppColors.textGrey,), ),
                    const SizedBox(height: 8),

                    AppFormField(
                        onTap: (){
                          setState(() {
                            isvisible = !isvisible;
                          });
                        },
                        validator: (value) =>  AppValidator.validateConfirmPassword(value, controller.signUpPasswordC.text),
                        icon: isvisible == true ? Icons.visibility :  Icons.visibility_off,
                        prefic_icons: Icons.lock_outline,
                        isObsecured : isvisible == true ? false : true,
                        borderColor: Colors.grey.shade300,
                        focusedBorderColor: Colors.grey.shade300,
                        showBorder: true,
                        title: "Loisbecket123",
                        textEditingController: controller.signUpConfirmPasswordC),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: [
                            Checkbox(
                              value: isChecked,
                              onChanged: (value) {
                                setState(() {
                                  isChecked = value ?? false; // toggles check / uncheck
                                });
                              },
                            ),
                            AppText(
                              "Remember me",
                              type: AppTextType.caption,
                              color: AppColors.textSecondary,
                            ),
                          ],
                        ),
                      ],
                    ),
                    SizedBox(height: 10,),
                Obx((){
                  return AppButtonWidget(
                      onPressed: controller.isLoading.value ? null :(){
                       if( formKey.currentState!.validate()){
                         controller.signUpUser();
                       }

                      }  ,
                      width: width*0.85,
                      height: height*0.06,
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                      loader: controller.isLoading.value,
                      buttonColor: AppColors.fieldColor,
                      text:   "SignUp");

                }

                ),
                    SizedBox(height: 10 ,),
                    Row(
                      children: [
                        Container(width: 30.w,height: 1,color: Colors.grey.shade300,),
                        SizedBox(width: 5,),
                        AppText("Or Login with", type: AppTextType.captionDark,),
                        SizedBox(width: 5,),
                        Container(width: 30.w,height: 1,color: Colors.grey.shade300,),
                      ],
                    ),
                    SizedBox(height: 5,),
                    Obx((){
                      return AppButtonWidget(
                        width: width*0.85,
                        height: height*0.05,
                        onPressed: controller.isGoogleLoading.value? null : ()async {
                          await controller.createUserWithGoogle();
                        },
                        text: "Google", prefixIcon: SvgPicture.asset(AppIcons.google_icon),
                        buttonColor: Colors.white,
                        loader: controller.isGoogleLoading.value,
                        textColor: AppColors.black,);
                    }
                    ),
                    StyledText(
                      segments: [
                        TextSegment(text: "By signing up you agree to the "),
                        TextSegment(
                          text: "term of services",
                          fontWeight: FontWeight.bold,
                          onTap: () {
                            // Handle tap for Terms of Services
                            print("Terms of Services tapped");
                          },
                        ),
                        TextSegment(text: " and "),
                        TextSegment(
                          text: "data processing agreement",
                          fontWeight: FontWeight.bold,
                          onTap: () {
                            // Handle tap for Data Processing Agreement
                            print("Data Processing Agreement tapped");
                          },
                        ),
                      ],
                      textAlign: TextAlign.center,
                    ),
                    Gap(1.h),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
