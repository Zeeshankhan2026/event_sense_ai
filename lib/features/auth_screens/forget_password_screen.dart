import 'package:event_sense_ai/features/auth_screens/otp_screen.dart';
import 'package:flutter/material.dart';

import '../../utils/app_assets.dart';
import '../../utils/app_colors.dart';
import '../../utils/app_text.dart';
import '../../widgets/app_buttons.dart';
import '../../widgets/app_textfield.dart';

class ForgetPasswordScreen extends StatelessWidget {
    ForgetPasswordScreen({super.key});

  final email_controller = TextEditingController();
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
                    padding: const EdgeInsets.only(top: 48.0, left: 20),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        AppText("LOGO", type: AppTextType.appBar,color: AppColors.white,fontSize: 22,),
                        SizedBox(height: 60,),
                        AppText("Forget Password", type: AppTextType.heading1,color: AppColors.white,fontSize: 30,),
                        SizedBox(height: 40,),
                        Row(
                          children: [
                            AppText("Add your email to reset password",
                              type: AppTextType.caption,
                              color: AppColors.white,fontSize: 18,),
                          ],
                        ),
                      ],
                    ),
                  )
                ]
            ),
            SizedBox(height: 30,),
            Padding(padding: EdgeInsets.symmetric(horizontal: 20),
            child:  Column(
              children: [
                ClipRRect(
            borderRadius : BorderRadius.circular(12),
                  child: Image.asset(AppAssets.forget_password),
                ),
                SizedBox(height: 20,),
                AppFormField(

                    borderColor: Colors.black,
                    focusedBorderColor: Colors.black,
                    showBorder: false,
                    title: "email@gmail.com",
                    textEditingController: email_controller),
                SizedBox(height: 30,),
                AppButtonWidget(
                    onPressed: (){
                      Navigator.of(context).push(MaterialPageRoute(builder: (_) => OtpScreen()));
                    },
                    width: width*0.85,
                    height: height*0.06,
                    buttonColor: AppColors.fieldColor,
                    text: "Confirm Email"),
              ],
            ),),
        
        
          ],
        ),
      ),
    );
  }
}
