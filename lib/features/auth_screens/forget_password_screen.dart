import 'package:event_sense_ai/features/auth_screens/otp_screen.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../routes/app_routes.dart';
import '../../utils/app_assets.dart';
import '../../utils/app_colors.dart';
import '../../utils/app_text.dart';
import '../../widgets/app_buttons.dart';
import '../../widgets/app_textfield.dart';
import '../../widgets/snackbar_widget.dart';

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
                        AppText("LOGO", type: AppTextType.heading2,color: AppColors.white,),                        SizedBox(height: 60,),
                        AppText("Forget Password",type: AppTextType.xlSuperBold,color: AppColors.white,),
                        SizedBox(height: 20,),
                        Row(
                          children: [
                            AppText("Add your email to reset password",
                              type: AppTextType.caption,
                              color: AppColors.white,fontWeight: FontWeight.w500,),
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
                      // context.goNamed('${AppRoutes.otp}');
                      context.pop();
                      // Simple info at top
                      AppSnackbar.show(
                        backgroundColor: AppColors.fieldColor,
                        context,
                        message: "Email reset link has been sent to your email. Check it!",
                        icon: Icons.check,
                        iconBgColor: Colors.green.shade100,
                        iconColor: Colors.green,
                      );

// // Error snackbar at bottom
//                       AppSnackbar.show(
//                         context,
//                         message: "Something went wrong. Try again!",
//                         icon: Icons.error_outline,
//                         iconBgColor: Colors.red.shade100,
//                         iconColor: Colors.red,
//                         backgroundColor: Colors.white,
//                         isTop: false,
//                       );

                    },
                    width: width*0.85,
                    height: height*0.06,
                    buttonColor: AppColors.fieldColor,
                    text: "Send"),
              ],
            ),),
        
        
          ],
        ),
      ),
    );
  }
}
