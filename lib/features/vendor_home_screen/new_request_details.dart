import 'package:event_sense_ai/utils/app_assets.dart';
import 'package:event_sense_ai/utils/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:go_router/go_router.dart';
import 'package:sizer/sizer.dart';

import '../../core/widgets/app_buttons.dart';
import '../../core/widgets/apptext.dart';
import '../../core/widgets/custom_headerbar.dart';
import 'components/event_info_card.dart';

class NewRequestDetails extends StatelessWidget {
  const NewRequestDetails({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.symmetric( vertical: 6,horizontal: 10),
            child: Column(
              children: [
                CustomHeaderBar(title: "Booking Details",showBackButton: true,onBack: (){
                  Navigator.of(context).pop();
                },),
                Gap(2.w),
                Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Container(
                      width: 64,
                      height: 64,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: Colors.green.shade100,
                      ),
                      child: const Center(
                        child: Icon(Icons.check, size: 32, color: Colors.green),
                      ),
                    ),
                    const SizedBox(height: 16),
                    AppText(
                      "You're Booked",
                      fontSize: 30,
                      fontWeight: FontWeight.w700,
                    ),
                    const SizedBox(height: 8),
                    AppText(
                      "Booking #4920 confirmed via AI Match.",
                      fontSize: 14,
                      fontWeight: FontWeight.w400,
                      color: Colors.grey,
                    ),
          
                  ],
                ),
                Gap(2.h),
                Stack(
                  children: [
                    Container(
                      width: 95.w,
                      height: 30.h,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(20),
                          topRight: Radius.circular(20),
                        ),
                          image: DecorationImage(image: AssetImage(AppAssets.wedding_reception2),fit: BoxFit.cover)
                      ),
                    ),
                    Positioned(
                        top: 25.h,
                        left: 3.w,
                        child: AppText("Wedding Receptions", fontSize: 24,fontWeight: FontWeight.w700,color: Colors.white,))
                  ],
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      AppText("Agreed Price", fontWeight: FontWeight.w500,fontSize: 20,),
                      AppText("\$4,500", fontWeight: FontWeight.w700,fontSize: 24,color: Colors.indigo.shade900,),
                    ],
                  ),
                ),
                Container(
                  margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: AppColors.first_tile_color.withOpacity(0.5),// Light purple background
                    borderRadius: BorderRadius.circular(12),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.08),
                        blurRadius: 8,
                        spreadRadius: 2,
                        offset: const Offset(0, 4),
                      ),
                    ],
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children:  [
                          Icon(Icons.auto_awesome, color: Colors.indigo.shade900, size: 20),
                          SizedBox(width: 6),
                        AppText("Scope", fontWeight: FontWeight.w600,fontSize: 20,color: Colors.indigo.shade900,)
                        ],
                      ),
                      const SizedBox(height: 8),
                      AppText("Photography, 2 Radiographers, Raw Footage delivery, 4hr coverage.",fontSize: 14,fontWeight: FontWeight.w500,)
                    ],
                  ),
                ),
          
                Divider(color: Colors.grey.shade300,),
                Gap(1.h),
                Container(
                  margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(12),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.08),
                        blurRadius: 8,
                        spreadRadius: 2,
                        offset: const Offset(0, 4),
                      ),
                    ],
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      EventInfoTile(
                        label: "Date",
                        value: "Oct 24, 2024",
                        icon: Icons.calendar_today,
                      ),
                      EventInfoTile(
                        label: "Time",
                        value: "7:00 PM - 11:00 PM",
                        icon: Icons.access_time,
                      ),
                      EventInfoTile(
                        label: "Location",
                        value: "Moscone Centre SF",
                        icon: Icons.location_on,
                      ),
                    ],
                  ),
                ),

                Gap(2.h),
                AppButtonWidget(
                  onPressed: (){},
                  width: 90.w,
                  height: 6.h,
                  buttonColor: AppColors.fieldColor,
                  text: "View Payment Status",fontSize: 16,fontWeight: FontWeight.w600,),
                Gap(1.h),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
