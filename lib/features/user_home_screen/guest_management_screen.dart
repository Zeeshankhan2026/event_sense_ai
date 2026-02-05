import 'package:event_sense_ai/core/widgets/custom_headerbar.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';
import '../../core/routes/app_routes.dart';
import '../../core/widgets/app_buttons.dart';
import '../../core/widgets/search_widget.dart';
import '../../utils/app_colors.dart';


class GuestManagementScreen extends StatelessWidget {
   GuestManagementScreen({super.key});
  final searchController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
          child: Column(children: [
            CustomHeaderBar(title: "Guest Management",
              showBackButton: true,
              onBack: (){
              Navigator.of(context).pop();
            },),
            Gap(1.w),
            SearchWidget(searchController: searchController),
            Gap(3.w),
            AppButtonWidget(
              onPressed: () {
                Get.toNamed(AppRoutes.addGuest);
              },
              prefixIcon:
              const Icon(Icons.add, color: Colors.white),
              width: 120.w,
              height: 7.h,
              buttonColor: AppColors.fieldColor,
              text: "Add Guest",
              fontWeight: FontWeight.w500,
              fontSize: 14,
            ),
            Gap(1.h),
          ]),
        ),
      ),
    );
  }
}
