import 'package:event_sense_ai/features/auth_screens/profile_screen.dart';
import 'package:flutter/material.dart';
import 'package:pinput/pinput.dart';

import '../../utils/app_assets.dart';
import '../../utils/app_colors.dart';
import '../../utils/app_text.dart';
import '../../widgets/app_buttons.dart';

class OtpScreen extends StatelessWidget {
   OtpScreen({super.key});
  final otp_controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;
     final defaultPinTheme = PinTheme(
       width: 60,
       height: 60,
       textStyle: TextStyle( fontSize: 20, color: Colors.black, fontWeight: FontWeight.w600, ),
       decoration: BoxDecoration(
         border: Border.all(color: Colors.grey),
         borderRadius: BorderRadius.circular(12), ), );

    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
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
                      AppText("Enter OTP", type: AppTextType.heading1,color: AppColors.white,fontSize: 30,),
                      SizedBox(height: 40,),
                      Row(
                        children: [
                          AppText("We have sent a 4 digit code to email",
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
          Pinput(
            length: 4,
            controller: otp_controller,
            defaultPinTheme: defaultPinTheme,
            focusedPinTheme: defaultPinTheme.copyWith(
            decoration: BoxDecoration( border: Border.all(color: Colors.blue),
            borderRadius: BorderRadius.circular(12), ),
          )),
          SizedBox(height: 30,),
          AppButtonWidget(
              onPressed: (){
                Navigator.of(context).push(MaterialPageRoute(builder: (context) => ProfileScreen()));
              },
              width: width*0.85,
              height: height*0.06,
              buttonColor: AppColors.fieldColor,
              text: "Confirm Code"),
          SizedBox(height: 10,),

          AppText("Enter the code in 60 secs",
            type: AppTextType.caption,
            color: AppColors.black,fontSize: 16,),
        ]


      ),
    );
  }
}
