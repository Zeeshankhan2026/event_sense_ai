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
import '../../../core/widgets/custom_rich_text.dart';

class SignUpScreen extends StatefulWidget {
  SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final name_controller = TextEditingController();
  final email_controller = TextEditingController();
  final password_controller = TextEditingController();
  final confirm_password_controller = TextEditingController();
  bool isvisible = false;
  bool isChecked = false;


  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;
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
                            Column(
                              children: [
                                AppText("Login",
                                  type: AppTextType.caption,
                                  fontWeight: FontWeight.w600,
                                  color: AppColors.text_button,),
                                Container( margin: const EdgeInsets.only(top: 2), height: 2, width: 35, color: AppColors.text_button, ),
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
                  Align( alignment: Alignment.centerLeft, child: AppText("Full Name", type: AppTextType.bodyBold, fontSize: 16,color: AppColors.textGrey,), ),
                  const SizedBox(height: 8),
                  AppFormField(
                    prefic_icons: Icons.person,
                      borderColor: Colors.black,
                      focusedBorderColor: Colors.black,
                      showBorder: false,
                      title: "Loisbecket",
                      textEditingController: name_controller),
                  SizedBox(height: 10,),
                  Align( alignment: Alignment.centerLeft, child: AppText("Email", type: AppTextType.bodyBold, fontSize: 16,color: AppColors.textGrey,), ),
                  const SizedBox(height: 8),
                  AppFormField(
                      prefic_icons: Icons.email,
                      borderColor: Colors.black,
                      focusedBorderColor: Colors.black,
                      showBorder: false,
                      title: "Loisbecket@gmail.com",
                      textEditingController: email_controller),
                  SizedBox(height: 10,),
                  Align( alignment: Alignment.centerLeft, child: AppText("Password", type: AppTextType.bodyBold, fontSize: 16,color: AppColors.textGrey,), ),
                  const SizedBox(height: 8),
                  AppFormField(
                    onTap: (){
                      setState(() {
                        isvisible = !isvisible;
                      });
                    },
                      icon: isvisible == true ? Icons.visibility :  Icons.visibility_off,
                      prefic_icons: Icons.lock,
                      isObsecured : isvisible == true ? false : true,
                      borderColor: Colors.black,
                      focusedBorderColor: Colors.black,
                      showBorder: false,
                      title: "Loisbecket123",
                      textEditingController: password_controller),
                  Gap(10),
                  Align( alignment: Alignment.centerLeft, child: AppText("Confirm Password", type: AppTextType.bodyBold, fontSize: 16,color: AppColors.textGrey,), ),
                  const SizedBox(height: 8),

                  AppFormField(
                      onTap: (){
                        setState(() {
                          isvisible = !isvisible;
                        });
                      },
                      icon: isvisible == true ? Icons.visibility :  Icons.visibility_off,
                      prefic_icons: Icons.lock,
                      isObsecured : isvisible == true ? false : true,
                      borderColor: Colors.black,
                      focusedBorderColor: Colors.black,
                      showBorder: false,
                      title: "Loisbecket123",
                      textEditingController: confirm_password_controller),
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
                  AppButtonWidget(
                      onPressed: (){
                        context.goNamed(AppRoutes.UserSetLocation);
                      },
                      width: width*0.85,
                      height: height*0.06,
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                      buttonColor: AppColors.fieldColor,
                      text: "SignUp"),
                  SizedBox(height: 5 ,),
                  AppText("Or Login with", type: AppTextType.captionDark,),
                  SizedBox(height: 5,),
                  AppButtonWidget(
                    width: width*0.85,
                    height: height*0.05,
                    text: "Google", prefixIcon: SvgPicture.asset(AppIcons.google_icon),
                    buttonColor: Colors.white,
                    textColor: AppColors.black,),
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
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
