import 'package:event_sense_ai/utils/app_colors.dart';
import 'package:event_sense_ai/utils/app_icons.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';
import 'package:sizer/sizer.dart';

import '../../core/widgets/app_buttons.dart';
import '../../core/widgets/app_textfield.dart';
import '../../core/widgets/apptext.dart';
import '../../core/widgets/custom_headerbar.dart';

class AddGuest extends StatefulWidget {
   AddGuest({super.key});

  @override
  State<AddGuest> createState() => _AddGuestState();
}

class _AddGuestState extends State<AddGuest> {
  final guest_name_controller = TextEditingController();

  final guest_email_controller = TextEditingController();

  final guest_phone_controller = TextEditingController();

   String selectedCategory = "Family";

   final List<String> categories = [
     "Family",
     "Friends",
     "Office",
     "Relative",
   ];
 bool isGuestPartner = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 12),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                CustomHeaderBar(title: "Vendors Applications",showBackButton: true,onBack: (){
                  context.pop();
                },),
                Gap(1.w),
                Container(
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: const Color(0xFFEAF2FF),
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(color: const Color(0xFF4D8DFF)),
                  ),
                  child: Row(
                    children: [
                      SvgPicture.asset(AppIcons.scan_icon,color: Colors.indigo,),
                      const SizedBox(width: 10),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: const [
                            AppText( 'AI Guest Scan',fontWeight: FontWeight.bold),
                            SizedBox(height: 4),
                            AppText( "12 guests haven’t opened their invite yet 'Consider sending a reminder",fontWeight: FontWeight.bold),
          
                          ],
                        ),
                      ),
                      Container(
                          height: 5.h,
                          width: 12.w,
                          decoration: BoxDecoration(
                            color: AppColors.fieldColor,
                            borderRadius: BorderRadius.circular(22)
                          ),
                          child: IconButton(onPressed: (){}, icon: Icon(Icons.arrow_forward_rounded,color: Colors.white,size: 20,))),
                    ],
                  ),
                ),
                Align( alignment: Alignment.centerLeft, child: AppText("Name", type: AppTextType.bodyBold, fontSize: 16,color: AppColors.textGrey,), ),
                AppFormField(
                    prefic_icons: Icons.email,
                    borderColor: Colors.black,
                    focusedBorderColor: Colors.black,
                    showBorder: false,
                    title: "Add Name",
                    textEditingController: guest_name_controller),
                Gap(1.h),
                Align( alignment: Alignment.centerLeft, child: AppText("Email", type: AppTextType.bodyBold, fontSize: 16,color: AppColors.textGrey,), ),
                AppFormField(
                    prefic_icons: Icons.email,
                    borderColor: Colors.black,
                    focusedBorderColor: Colors.black,
                    showBorder: false,
                    title: "Loisbecket@gmail.com",
                    textEditingController: guest_name_controller),
                Gap(1.h),
                Align( alignment: Alignment.centerLeft, child: AppText("Phone", type: AppTextType.bodyBold, fontSize: 16,color: AppColors.textGrey,), ),
          
                AppFormField(
                    prefic_icons: Icons.email,
                    borderColor: Colors.black,
                    focusedBorderColor: Colors.black,
                    showBorder: false,
                    title: "123-456-789",
                    textEditingController: guest_name_controller),
                Gap(2.h),
                AppText("Guest Category", type: AppTextType.captionDark,fontWeight: FontWeight.bold,),
                Gap(1.h),
                GestureDetector(
                  onTap: (){
                    print("working");
                  },
                  child: Container(
                    padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                    decoration: BoxDecoration(
                      color: Colors.grey.shade100,
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: PopupMenuButton<String>(
                      onSelected: (value) {
                        setState(() {
                          selectedCategory = value;
                        });
                      },
                      itemBuilder: (context) {
                        return categories
                            .map(
                              (category) => PopupMenuItem<String>(
                            value: category,
                            child: Text(category),
                          ),
                        )
                            .toList();
                      },
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          AppText(
                            selectedCategory,
                            type: AppTextType.captionDark,
                            fontWeight: FontWeight.bold,
                          ),
                          const SizedBox(width: 4),
                          const Icon(Icons.arrow_drop_down_sharp),
                        ],
                      ),
                    ),
                  )
                ),
                Gap(2.h),
                AppText("Allow +1", type: AppTextType.captionDark,fontWeight: FontWeight.bold,),
                Gap(1.h),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                  decoration: BoxDecoration(
                    color: Colors.grey.shade100,
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child:  Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        AppText(
                          "Guest can bring partner",
                          type: AppTextType.captionDark,
                          fontWeight: FontWeight.bold,
                        ),
                        const SizedBox(width: 4),
                         Switch(
                           inactiveTrackColor: Colors.grey.shade300,
                             activeTrackColor: Colors.grey,
                             value: isGuestPartner, onChanged: (value){
                           setState(() {
                             isGuestPartner = !isGuestPartner;
                           });
                         }),
                      ],
                    ),
                  ),
                Gap(2.h),
                Align(
                  alignment: Alignment.center,
                    child: AppText("Or Import From",
                      fontWeight: FontWeight.w600,fontSize: 16,color: AppColors.textGrey1,)),
                Gap(1.h),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    // App-based Contacts
                    Container(
                      width: 140,
                      padding: const EdgeInsets.symmetric(vertical: 16),
                      decoration: BoxDecoration(
                        color: const Color(0xFFE3F2FD), // light blue
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Column(
                        children: [
                          Icon(Icons.contact_page, size: 32, color: Colors.blue),
                          const SizedBox(height: 8),
                          AppText(   "Contacts", fontSize: 14,
                            fontWeight: FontWeight.w600,
                            color: Colors.blue,)
                        ],
                      ),
                    ),
          
                    const SizedBox(width: 16),
          
                    // CSV Contacts
                    Container(
                      width: 140,
                      padding: const EdgeInsets.symmetric(vertical: 16),
                      decoration: BoxDecoration(
                        color: const Color(0xFFE8F5E9), // light green
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Column(
                        children: [
                          Icon(Icons.email_rounded, size: 32, color: Colors.green),
                          const SizedBox(height: 8),
                         AppText("Email", fontSize: 14,
                           fontWeight: FontWeight.w600,
                           color: Colors.green,)
                        ],
                      ),
                    ),
                  ],
                ),
                Gap(3.h),
                AppButtonWidget(
                  onPressed: (){
          
                  },
                  prefixIcon: Icon(Icons.add,color: Colors.white,),
                  width: 120.w,
                  height: 7.h,
                  buttonColor: AppColors.fieldColor,
                  text: "Add Guest",fontWeight: FontWeight.w500,fontSize: 14,),
          Gap(1.h),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
