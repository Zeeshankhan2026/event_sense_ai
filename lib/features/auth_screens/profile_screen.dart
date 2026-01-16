import 'package:event_sense_ai/features/home_screen/Bottom_Nav.dart';
import 'package:event_sense_ai/utils/app_assets.dart';
import 'package:event_sense_ai/utils/app_colors.dart';
import 'package:event_sense_ai/utils/app_icons.dart';
import 'package:event_sense_ai/utils/app_text.dart';
import 'package:event_sense_ai/widgets/app_buttons.dart';
import 'package:event_sense_ai/widgets/custom_action_card.dart';
import 'package:event_sense_ai/widgets/custom_circle_avator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:gap/gap.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;
    return Scaffold(
      backgroundColor: AppColors.white,
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 18.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Gap(90),
            Row(
              children: [
              CustomCircleAvatar(assetImage: AppIcons.profile_icon),
                Gap(20),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    AppText("Denial Jones", type: AppTextType.heading3, color: AppColors.black,),
                    AppText("DenialJones@gmail.com", type: AppTextType.captionPrimary,color: Colors.grey,)
                  ],
                ),
                
              ],
            ),
            Gap(22),
            AppText("General",type: AppTextType.micro,),
            Padding(padding: EdgeInsets.only(left: 4),
            child: Column(
              children: [
                Gap(22),

                CustomActionCard(
                    fontsize: 15,
                    textColor: AppColors.textGrey1,
                    width: width*0.95,
                    height: height*0.068,
                    bgColor: AppColors.secondary,
                    startIcon: SvgPicture.asset(AppIcons.profile_icon,),
                    title: "Account",
                    endIcon: SvgPicture.asset(AppIcons.right_arrow,),
                    onPressed: (){}),
                Gap(22),
                CustomActionCard(
                    fontsize: 15,
                    textColor: AppColors.textGrey1,
                    width: width*0.95,
                    height: height*0.068,
                    bgColor: AppColors.secondary,
                    startIcon:SvgPicture.asset(AppIcons.nofication_icon),
                    title: "Notification",
                    endIcon: SvgPicture.asset(AppIcons.right_arrow,),
                    onPressed: (){}),
              ],
            ),),
            Gap(42),
            AppText("Bottom Section",type: AppTextType.micro,),
            Padding(padding: EdgeInsets.only(left: 4),
              child: Column(
                children: [
                  Gap(22),
                  CustomActionCard(
                      fontsize: 15,

                    textColor: AppColors.textGrey1,
                      width: width*0.95,
                      height: height*0.068,
                      bgColor: AppColors.secondary,
                      startIcon:SvgPicture.asset(AppIcons.document_icon),
                      title: "Privacy Policy",
                      endIcon: SvgPicture.asset(AppIcons.right_arrow,),
                      onPressed: (){}),
                  Gap(22),
                  CustomActionCard(
                      fontsize: 15,

                      textColor: AppColors.textGrey1,
                      width: width*0.95,
                      height: height*0.068,
                      bgColor: AppColors.secondary,
                      startIcon: SvgPicture.asset(AppIcons.document_icon),
                      title: "Terms Conditions",
                      endIcon: SvgPicture.asset(AppIcons.right_arrow,),
                      onPressed: (){}),
                ],
              ),),
            Gap(42),
            AppButtonWidget(
              suffixIcon: Icon(Icons.logout, color: AppColors.white,size: 30,),
              fontSize: 22,
              radius: (32),
                onPressed: (){
                },
                width: width*0.85,
                height: height*0.06,
                buttonColor: AppColors.fieldColor,
                text: "LogOut"),
          ],
        ),
      ),
    );
  }
}
