import 'package:event_sense_ai/core/controller/vendor_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:shimmer/shimmer.dart';
import '../../core/routes/app_routes.dart';
import '../../core/widgets/app_buttons.dart';
import '../../core/widgets/custom_circle_avator.dart';
import '../../core/widgets/custom_dialog.dart';
import '../../utils/app_colors.dart';
import '../../utils/app_icons.dart';
import '../../utils/app_text.dart';
import '../user_home_screen/components/custom_action_card.dart';

class VendorProfileScreeen extends StatelessWidget {
   VendorProfileScreeen({super.key});

  final controller = Get.find<VendorController>();


  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;

    return Scaffold(
      backgroundColor: AppColors.white,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 18.0, vertical: 12),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              IconButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                icon: Icon(Icons.arrow_back_ios),
              ),
              Gap(10),
              Obx((){
                if(controller.isDataLoading.value){
                  return Shimmer(
                    period: Duration(seconds: 4),
                      gradient: LinearGradient(
                      colors: [
                        Colors.grey,
                        Colors.blueGrey,
                        Colors.grey.shade700,
                      ]),
                      child: Row(
                    children: [
                      CustomCircleAvatar(assetImage: AppIcons.profile_icon),
                      Gap(20),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          AppText(
                            "",
                            type: AppTextType.heading3,
                            color: AppColors.black,
                          ),
                          AppText(
                            "",
                            type: AppTextType.captionPrimary,
                            color: Colors.grey,
                          ),
                        ],
                      ),
                    ],
                  ));

                }
                final data = controller.vendor.value;
                    if(data == null) return Text("no data found");

                return controller.isDataLoading.value ?
                SizedBox(width: 60,height: 60,child: CircularProgressIndicator(),):  Row(
                  children: [
                    CustomCircleAvatar(
                        assetImage: AppIcons.profile_icon,
                        imageUrl: data.profileImage),
                    Gap(20),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        AppText(
                         data.companyName ?? "",
                          type: AppTextType.heading3,
                          color: AppColors.black,
                        ),
                        AppText(
                          data.email ?? "",
                          type: AppTextType.captionPrimary,
                          color: Colors.grey,
                        ),
                      ],
                    ),
                  ],
                );
              }
              ),
              Gap(22),
              AppText("General", type: AppTextType.micro),
              Padding(
                padding: EdgeInsets.only(left: 4),
                child: Column(
                  children: [
                    Gap(22),

                    GestureDetector(
                      onTap: () {
                        Get.toNamed(AppRoutes.vendorAccountScreen,
                            arguments: controller.vendor.value);
                      },
                      child: CustomActionCard(
                        fontsize: 15,
                        textColor: AppColors.textGrey1,
                        width: width * 0.95,
                        height: height * 0.068,
                        bgColor: AppColors.secondary,
                        startIcon: SvgPicture.asset(AppIcons.profile_icon),
                        title: "Account",
                        endIcon: SvgPicture.asset(AppIcons.right_arrow),
                      ),
                    ),
                    Gap(22),
                    GestureDetector(
                      onTap: () {
                       Get.toNamed(AppRoutes.vendorNotificationScreen);
                      },
                      child: CustomActionCard(
                        fontsize: 15,
                        textColor: AppColors.textGrey1,
                        width: width * 0.95,
                        height: height * 0.068,
                        bgColor: AppColors.secondary,
                        startIcon: SvgPicture.asset(AppIcons.nofication_icon),
                        title: "Notification",
                        endIcon: SvgPicture.asset(AppIcons.right_arrow),
                      ),
                    ),
                  ],
                ),
              ),
              Gap(42),
              AppText("Bottom Section", type: AppTextType.micro),
              Padding(
                padding: EdgeInsets.only(left: 4),
                child: Column(
                  children: [
                    Gap(22),
                    CustomActionCard(
                      fontsize: 15,

                      textColor: AppColors.textGrey1,
                      width: width * 0.95,
                      height: height * 0.068,
                      bgColor: AppColors.secondary,
                      startIcon: SvgPicture.asset(AppIcons.document_icon),
                      title: "Privacy Policy",
                      endIcon: SvgPicture.asset(AppIcons.right_arrow),
                    ),
                    Gap(22),
                    CustomActionCard(
                      fontsize: 15,

                      textColor: AppColors.textGrey1,
                      width: width * 0.95,
                      height: height * 0.068,
                      bgColor: AppColors.secondary,
                      startIcon: SvgPicture.asset(AppIcons.document_icon),
                      title: "Terms Conditions",
                      endIcon: SvgPicture.asset(AppIcons.right_arrow),
                    ),
                  ],
                ),
              ),
              Gap(42),
              Obx((){
                return AppButtonWidget(
                  suffixIcon: controller.isloading.value ?  SizedBox(
                    width: 22,
                    height: 22,
                    child: CircularProgressIndicator(
                      strokeWidth: 2,
                      color: Colors.white,
                    ),
                  ) : Icon(
                    Icons.logout,
                    color: AppColors.white,
                    size: 20,
                  ),
                  fontSize: 18,
                  radius: (32),
                  onPressed: () {
                    CustomPlatformWidget.showDefaultDialog(
                      confirmText : "Log out",
                      confirmColor: Colors.indigo,
                      cancelText: "Cancel",
                      cancelColor: Colors.redAccent,
                      onConfirm: controller.isloading.value ? null :  () async {
                      await   controller.logoutVendor();
                      },
                      context: context,

                      title: "Log Out",
                      message: "Are  you sure want to log out application?",
                    );
                  },
                  width: width * 0.85,
                  height: height * 0.06,
                  buttonColor: AppColors.fieldColor,
                  text: "LogOut",
                );
              }
              ),
            ],
          ),
        ),
      ),
    );
  }
}
