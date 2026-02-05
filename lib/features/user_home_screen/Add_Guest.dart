import 'package:event_sense_ai/core/controller/guest_controller.dart';
import 'package:event_sense_ai/utils/app_colors.dart';
import 'package:event_sense_ai/utils/app_icons.dart';
import 'package:event_sense_ai/utils/app_validator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_contacts/flutter_contacts.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
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


  final eventId = Get.arguments;

   final controller = Get.find<GuestController>();
   final List<String> categories = [
     "Family",
     "Friends",
     "Office",
     "Relative",
   ];
 bool isGuestPartner = false;
 final formKey  = GlobalKey<FormState>();

  Future<Map<String, String>?> pickContactFromPhone(BuildContext context) async {
    try {
      final permissionGranted = await FlutterContacts.requestPermission();
      if (!permissionGranted) return null;

      final contacts = await FlutterContacts.getContacts(
        withProperties: true,
        withPhoto: false,
        withAccounts: true,
        sorted: true,
      );

      if (contacts.isEmpty) {
        debugPrint("No contacts found");
        return null;
      }

      return await showModalBottomSheet<Map<String, String>>(
        context: context,
        builder: (_) {
          return ListView(
            children: contacts
                .where((c) => c.phones.isNotEmpty)
                .map((c) => ListTile(
              leading: CircleAvatar(
                child: Text(
                  c.displayName.isNotEmpty
                      ? c.displayName[0].toUpperCase()
                      : "?",
                ),
              ),
              title: Text(c.displayName),
              subtitle: Text(c.phones.first.number),
              onTap: () {
                Navigator.pop(context, {
                  "name": c.displayName,
                  "phone": c.phones.first.number,
                });
              },
            ))
                .toList(),
          );
        },
      );
    } catch (e) {
      debugPrint("Contact picker error: $e");
      return null;
    }
  }


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
                CustomHeaderBar(title: "Add Guest",showBackButton: true,onBack: (){
                  Get.back();
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
              Form(
                key: formKey,
                  child: Column(
                    children: [
                      Align( alignment: Alignment.centerLeft, child: AppText("Name", type: AppTextType.bodyBold, fontSize: 16,color: AppColors.textGrey,), ),
                      AppFormField(
                          prefic_icons: Icons.person_outline,
                          borderColor: Colors.grey.shade300,
                          focusedBorderColor: Colors.grey.shade300,
                          showBorder: true,
                          title: "Add Name",
                          textEditingController: controller.guestName),
                      Gap(1.h),
                      Align( alignment: Alignment.centerLeft, child: AppText("Email", type: AppTextType.bodyBold, fontSize: 16,color: AppColors.textGrey,), ),
                      AppFormField(
                          prefic_icons: Icons.email_outlined,
                          borderColor: Colors.grey.shade300,
                          focusedBorderColor: Colors.grey.shade300,
                          showBorder: true,
                          title: "Loisbecket@gmail.com",
                          textEditingController: controller.guestEmail),
                      Gap(1.h),
                      Align( alignment: Alignment.centerLeft, child: AppText("Phone", type: AppTextType.bodyBold, fontSize: 16,color: AppColors.textGrey,), ),

                      AppFormField(
                          prefic_icons: Icons.phone_android,
                          borderColor: Colors.grey.shade300,
                          focusedBorderColor: Colors.grey.shade300,
                          showBorder: true,
                          title: "123-456-789",
                          textEditingController: controller.guestPhone),
                      Gap(2.h),
                      Align(
                        alignment: Alignment.centerLeft,
                          child: AppText("Guest Category", type: AppTextType.captionDark,fontWeight: FontWeight.bold,)),
                      Gap(1.h),
                    ],
                  )),
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
                          controller.guestCategory.value = value;
                        });
                      },
                      itemBuilder: (context) {
                        return categories
                            .map((category) => PopupMenuItem<String>(
                            value: category,
                            child: Text(category),),).toList();
                      },
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          AppText(
                            controller.guestCategory.value,
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
                        const AppText(
                          "Guest can bring partner",
                          type: AppTextType.captionDark,
                          fontWeight: FontWeight.bold,
                        ),
                        const SizedBox(width: 4),
                         Obx(() => Switch(
                           inactiveTrackColor: Colors.grey.shade300,
                             activeTrackColor: Colors.grey,
                             value: controller.bringPartner.value,
                             onChanged: (value){
                               controller.bringPartner.value = value;
                         })),
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
                    InkWell(
                      onTap: () async {
                        final data = await pickContactFromPhone(context);

                        if (data != null) {
                          controller.guestName.text = data["name"]!;
                          controller.guestPhone.text = data["phone"]!;
                        }
                      },
                      child: Container(
                        width: 90.w,
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
                    ),


                  ],
                ),
                Gap(3.h),
                Obx((){
                  return AppButtonWidget(
                    onPressed: controller.isLoading.value ? null :  () async {
                      if(formKey.currentState!.validate()){
                        print("working");
                        await controller.AddGuest().then((value) {

                        });
                      }

                    },
                    prefixIcon: Icon(Icons.add,color: Colors.white,),
                    width: 120.w,
                    height: 7.h,
                    loader: controller.isLoading.value,
                    buttonColor: AppColors.fieldColor,
                    text: "Add Guest",fontWeight: FontWeight.w500,fontSize: 14,);
                }
                ),
          Gap(1.h),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
