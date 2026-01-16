import 'package:event_sense_ai/features/auth_screens/login_screen.dart';
import 'package:event_sense_ai/utils/app_assets.dart';
import 'package:event_sense_ai/utils/app_colors.dart';
import 'package:event_sense_ai/utils/app_icons.dart';
import 'package:event_sense_ai/utils/app_text.dart';
import 'package:event_sense_ai/widgets/app_buttons.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:gap/gap.dart';

class WelcomeScreen  extends StatelessWidget {
  const WelcomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;
    return Scaffold(
      body: Column(
              children: [
      SizedBox(
        width: width*1,
        height: height*0.2,
       child: Image.asset(AppAssets.banner_welcome_screen, fit: BoxFit.cover,),
      ),
      SizedBox(height: 10,),
      Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          AppText("How are you planing?",
             color: Colors.indigo,
            fontSize: 20 ,fontWeight: FontWeight.w700,),
          SizedBox(height: 10,),
         AppText("We'll customize  AI tools based on \n your needs",
         textAlign: TextAlign.center,
         type: AppTextType.body,),
          SizedBox(height: 20,),
          Container(
            width: width*0.95,
            height: height*0.18,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(12),
              border: BoxBorder.all(
                color: AppColors.borderColor,
                width: 1.3,
              )

            ),
            child: Row(
              children: [
                Container(
                  width: width*0.65,
                  height: height*0.19,
                  child: Padding(
                    padding: const EdgeInsets.all(12.0),
                    child: Column(

                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            SvgPicture.asset(AppIcons.welcome_screen_icon_celeb),
                            SizedBox(width: 8,),
                            AppText("For Individuals",type: AppTextType.bodyBold,
                            color: AppColors.black,fontSize: 18,)
                          ],
                        ),
                        Gap(8),
                        AppText("Personal Planner", type: AppTextType.heading1,color: Colors.black,fontSize: 18,),
                        Gap(4),
                        AppText("For birthday,weddings and family gathering", type: AppTextType.captionDark,)
                      ],
                    ),
                  ),
                ),
                Container(
                  width: width*0.28,
                  height: height*0.140,
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(12),
                    child: Image.asset(
                      AppAssets.wellcome_screen_image1,
                      fit: BoxFit.cover, ), ), )
              ],
            ),
          ),
          SizedBox(height: 20,),
          Container(
            width: width*0.95,
            height: height*0.19,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(12),
                border: BoxBorder.all(
                  color: AppColors.borderColor,
                  width: 1.3,
                )

            ),
            child: Row(
              children: [
                SizedBox(
                  width: width*0.65,
                  height: height*0.18,
                  child: Padding(
                    padding: const EdgeInsets.all(12.0),
                    child: Column(

                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            SvgPicture.asset(AppIcons.welcome_screen_icon_bag),
                            SizedBox(width: 8,),
                            AppText("For Business",type: AppTextType.bodyBold,
                              color: AppColors.black,fontSize: 18,)
                          ],
                        ),
                        Gap(8),
                        AppText("Professional Planner", type: AppTextType.heading1,color: Colors.black,fontSize: 18,),
                        Gap(4),
                        AppText("For corporate events, conference and client management ", type: AppTextType.captionDark,)
                      ],
                    ),
                  ),
                ),

            SizedBox(
              width: width*0.280,
              height: height*0.140,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(12), // Apply radius here
                child: Image.asset(
                  AppAssets.wellcome_screen_image2,
                  fit: BoxFit.fill,
                ),
              ),
            )

            ],
            ),
          ),
          SizedBox(height: 30,),

          AppButtonWidget(
            onPressed: (){
              Navigator.of(context).push(MaterialPageRoute(builder: (_) => LoginScreen()));
            },
            text: "Get Started",
            height: height*0.06,
            width: width*0.91,
            buttonColor: AppColors.fieldColor,
          )
        ],
      )
              ],
            )
    );
  }
}
