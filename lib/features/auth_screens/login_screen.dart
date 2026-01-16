import 'package:event_sense_ai/features/auth_screens/forget_password_screen.dart';
import 'package:event_sense_ai/features/auth_screens/signup_screen.dart';
import 'package:event_sense_ai/utils/app_assets.dart';
import 'package:event_sense_ai/utils/app_colors.dart';
import 'package:event_sense_ai/utils/app_text.dart';
import 'package:event_sense_ai/widgets/app_buttons.dart';
import 'package:event_sense_ai/widgets/app_textfield.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';

import '../../routes/app_routes.dart';
import '../../utils/app_icons.dart';
import '../../widgets/custom_rich_text.dart';

class LoginScreen extends StatefulWidget {
   LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {


  final email_controller = TextEditingController();
  final password_controller = TextEditingController();
  bool isvisible = false;
  bool ischecked = false;

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;
    return Scaffold(
      backgroundColor: AppColors.white,
      body: SingleChildScrollView(
        child: Column(
          children: [
            Stack(
              children : [
                SizedBox(
                  height: height*0.33,
                  width: width*1,
                  child: Image.asset(AppAssets.login_screen_banner,fit: BoxFit.cover,),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 48.0, left: 30),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Gap(30),
                      AppText("LOGO", type: AppTextType.heading2,color: AppColors.white,),
                      Gap(20),
                      AppText("Login in to your \nAccount", type: AppTextType.xlSuperBold,color: AppColors.white,),
                      SizedBox(height: 10,),
                      Row(
                        children: [
                          AppText("Don't have an account?",
                            type: AppTextType.caption,
                            color: AppColors.white,),
                          SizedBox(width: 5,),
                          GestureDetector(
                            onTap: (){
                              context.goNamed('${AppRoutes.signup}');

                            },
                            child: Column(
                              children: [
                                AppText("SignUp",
                                  type: AppTextType.caption,
                                  color: AppColors.text_button,),
                                Container( margin: const EdgeInsets.only(top: 2), height: 2, width: 45, color: AppColors.text_button, ),
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
            SizedBox(height: 30,),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 18.0),
              child: Column(
                children: [
                  Align( alignment: Alignment.centerLeft, child: AppText("Email", type: AppTextType.captionDark,), ),
                  const SizedBox(height: 8),
                  AppFormField(

                           borderColor: Colors.black,
                      focusedBorderColor: Colors.black,
                      showBorder: false,
                      title: "email@gmail.com",
                      textEditingController: email_controller),
                  const SizedBox(height: 18),
                  Align( alignment: Alignment.centerLeft, child: AppText("Password", type: AppTextType.captionDark,), ),
                  const SizedBox(height: 8),
                  AppFormField(
                    onTap: (){
                      setState(() {
                        isvisible = !isvisible;
                      });
                    },
                      isObsecured :isvisible == true ?  false : true,
                    icon: isvisible == true ? Icons.visibility :  Icons.visibility_off,
                      borderColor: Colors.black,
                      focusedBorderColor: Colors.black,
                      showBorder: false,
                      title: "password",
                      textEditingController: password_controller),
                  SizedBox(height: 20,),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          Checkbox(value: ischecked, onChanged: (value){

                          }),
                          AppText("Remember me", type: AppTextType.caption,color: AppColors.textSecondary,)
                        ],
                      ),
                      AppButtonWidget(
                        onPressed: (){
                          context.goNamed('${AppRoutes.forgotPassword}');
                        },
                        fontSize: 12,
                        fontWeight: FontWeight.w600,

                        text: "Forget Password?", buttonColor: Colors.transparent,textColor: AppColors.textGrey1,)
                    ],
                  ),
                  SizedBox(height: 30,),
                  AppButtonWidget(
                    onPressed: (){
                      context.goNamed(AppRoutes.main);
                    },
                    width: width*0.85,
                      height: height*0.06,
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                      buttonColor: AppColors.fieldColor,
                      text: "Login"),
                  SizedBox(height: 20,),
                  AppText("Or Login with", type: AppTextType.captionDark,),
                  SizedBox(height: 20,),
                 AppButtonWidget(
                   width: width*0.85,
                   height: height*0.06,
                   text: "Google", prefixIcon: SvgPicture.asset(AppIcons.google_icon),
                   buttonColor: AppColors.button_color,
                   textColor: AppColors.black,),

                  SizedBox(height: 20,),
                  StyledText(
                    segments: [
                      TextSegment(text: "By signing up you agree to the "),
                      TextSegment(
                        text: "term of services",
                        fontWeight: FontWeight.bold, // 👈 bold
                        onTap: () {
                          // Handle tap for Terms of Services
                          print("Terms of Services tapped");
                        },
                      ),
                      TextSegment(text: " and "),
                      TextSegment(
                        text: "data processing agreement",
                        fontWeight: FontWeight.bold, // 👈 bold
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
