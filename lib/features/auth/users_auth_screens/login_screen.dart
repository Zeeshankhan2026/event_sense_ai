
import 'package:event_sense_ai/core/controller/user_controller.dart';
import 'package:event_sense_ai/utils/app_assets.dart';
import 'package:event_sense_ai/utils/app_colors.dart';
import 'package:event_sense_ai/utils/app_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:go_router/go_router.dart';
import 'package:sizer/sizer.dart';
import '../../../core/routes/app_routes.dart';
import '../../../core/widgets/app_buttons.dart';
import '../../../core/widgets/app_textfield.dart';
import '../../../core/widgets/custom_rich_text.dart';
import '../../../utils/app_icons.dart';


class LoginScreen extends StatefulWidget {
  LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  bool isvisible = false;
  bool isChecked = false;

  final formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;
     final controller = Get.find<UserController>();
    return Scaffold(
      backgroundColor: AppColors.white,
      body: SingleChildScrollView(
        child: Column(
          children: [
            Stack(
              children: [
                SizedBox(
                  height: height * 0.33,
                  width: width * 1,
                  child: Image.asset(
                    AppAssets.login_screen_banner,
                    fit: BoxFit.cover,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 48.0, left: 30),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Gap(30),
                      AppText(
                        "LOGO",
                        type: AppTextType.heading2,
                        color: AppColors.white,
                      ),
                      Gap(20),
                      AppText(
                        "Login in to your \nAccount",
                        type: AppTextType.xlSuperBold,
                        color: AppColors.white,
                      ),
                      SizedBox(height: 10),
                      Row(
                        children: [
                          AppText(
                            "Don't have an account?",
                            type: AppTextType.caption,
                            color: AppColors.white,
                          ),
                          SizedBox(width: 5),
                          GestureDetector(
                            onTap: () {
                              controller.clearAllFields();
                              Get.toNamed(AppRoutes.signup);
                            },
                            child: Column(
                              children: [
                                AppText(
                                  "Sign Up",
                                  type: AppTextType.caption,
                                  color: AppColors.text_button,
                                ),
                                Container(
                                  margin: const EdgeInsets.only(top: 2),
                                  height: 2,
                                  width: 45,
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
            SizedBox(height: 30),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 18.0),
              child: Form(
                key: formKey,
                child: Column(
                  children: [
                    Align(
                      alignment: Alignment.centerLeft,
                      child: AppText("Email", type: AppTextType.captionDark),
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
                      textEditingController: controller.signUpEmailC,
                    ),
                    const SizedBox(height: 18),
                    Align(
                      alignment: Alignment.centerLeft,
                      child: AppText("Password", type: AppTextType.captionDark),
                    ),
                    const SizedBox(height: 8),
                    AppFormField(
                      validator: (String? value) {
                        if (value!.isEmpty) return "password are required";
                        if (value.length < 6) {
                          return "enter a password more then 6 characters";
                        }
                        return null;
                      },
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
                      textEditingController: controller.signUpPasswordC,
                    ),
                    SizedBox(height: 20),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: [
                            Checkbox(
                              value: isChecked,
                              onChanged: (value) {
                                setState(() {
                                  isChecked =
                                      value ?? false; // toggles check / uncheck
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

                        AppButtonWidget(
                          onPressed: () {
                            Get.toNamed('${AppRoutes.forgotPassword}');
                          },
                          fontSize: 12,
                          fontWeight: FontWeight.w600,

                          text: "Forget Password?",
                          buttonColor: Colors.transparent,
                          textColor: AppColors.textGrey1,
                        ),
                      ],
                    ),
                    SizedBox(height: 30),
                  Obx((){
                    return AppButtonWidget(
                          onPressed:  controller.isLoading.value ? null : () async {
                            if(formKey.currentState!.validate())  {
                             await  controller.logInUser();
                            }
                          },
                      width: width * 0.85,
                      height: height * 0.06,
                      fontSize: 16,
                      loader: controller.isLoading.value,
                      fontWeight: FontWeight.w600,
                      buttonColor: AppColors.fieldColor,
                      text:  "Login",
                    );
                  }
                  ),





                  SizedBox(height: 20),
                    Row(
                      children: [
                        Container(
                          width: 30.w,
                          height: 1,
                          color: Colors.grey.shade300,
                        ),
                        SizedBox(width: 5),
                        AppText("Or Login with", type: AppTextType.captionDark),
                        SizedBox(width: 5),
                        Container(
                          width: 30.w,
                          height: 1,
                          color: Colors.grey.shade300,
                        ),
                      ],
                    ),
                    SizedBox(height: 20),
                  Obx((){
                    return AppButtonWidget(
                      onPressed: controller.isGoogleLoading.value ? null :  ()async  {
                          await controller.createUserWithGoogle();
                      },
                      borderColor: Colors.grey.shade200,
                      width: width * 0.85,
                      height: height * 0.06,
                      loader: controller.isGoogleLoading .value,
                      text: "Google",
                      prefixIcon: SvgPicture.asset(AppIcons.google_icon),
                      buttonColor: AppColors.button_color,
                      textColor: AppColors.black,
                    );
                  }
                  ),

                    SizedBox(height: 20),
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
