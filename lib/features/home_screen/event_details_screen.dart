import 'package:event_sense_ai/utils/app_assets.dart';
import 'package:event_sense_ai/utils/app_colors.dart';
import 'package:event_sense_ai/utils/app_icons.dart';
import 'package:event_sense_ai/widgets/InProgressReusableWidget.dart';
import 'package:event_sense_ai/widgets/apptext.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:gap/gap.dart';

class EventDetailsScreen extends StatelessWidget {
   EventDetailsScreen({super.key});
   
  List<InfoProgressCard> inprogresscard = [
    InfoProgressCard(title: "Total Guest", icons: AppIcons.people_icon, mainValue: "67", caption: "", progress: 35)
   , InfoProgressCard(title: "Budget Used", icons: AppIcons.wallet_icon, mainValue: "\$4.76", caption: "", progress: 5000)

  ];
  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final hieght = MediaQuery.of(context).size.height;
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 12.0),
              child: Row(
                children: [
                  IconButton(onPressed: (){}, icon:Icon( Icons.arrow_back_ios)),
                  AppText("Event Details"),
                ],
              ),
            ),
         Column(
           crossAxisAlignment: CrossAxisAlignment.start,
           children: [
             Gap(12),
             Stack(
               children: [
                 Container(
                   width: width*0.88,
                   height: hieght*0.37,
                   decoration: BoxDecoration(
                       color: Colors.grey,
                       borderRadius: BorderRadius.circular(20),
                       image: DecorationImage(image: AssetImage(AppAssets.wedding_image2),fit: BoxFit.cover)
                   ),
                 ),
                 Positioned(
                     top: hieght*0.23,
                     child: Padding(
                       padding: const EdgeInsets.all(8.0),
                       child: Column(
                         crossAxisAlignment: CrossAxisAlignment.start,
                         children: [
                           Container(
                             padding: EdgeInsets.all(4),
                             width: 90,
                             height: 25,
                             decoration: BoxDecoration(
                               color: Colors.white,
                               borderRadius: BorderRadius.circular(16),
                             ),
                             child: Center(
                               child: Row(
                                 children: [
                                   SvgPicture.asset(AppIcons.calender_icon),
                                   AppText("Nov 12 / 6:00 PM", type: AppTextType.captionDark,fontSize: 8,)
                                 ],
                               ),
                             ),
                           ),
                           Gap(10),
                           AppText("Wedding Receptions", type: AppTextType.heading1,color: AppColors.white,),
                           Gap(10),
                           Row(
                             children: [
                               SvgPicture.asset(AppIcons.location_icon,height: 24,color: AppColors.white,),
                               Gap(10),
                               AppText("Nov 12 / 6:00 PM", type: AppTextType.captionDark,color: AppColors.white,)
                             ],
                           ),
                         ],),
                     )
                 ),

               ],
             ),
             Gap(15),
             AppText("Status", type: AppTextType.heading4,color: AppColors.textGrey1,),
             GridView.builder(
                 gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                     crossAxisCount: 2),
                 itemCount: inprogresscard.length,
                 itemBuilder: (context, index) {
               return Container();
               //   Container(
               //   width: 160,
               //   padding: const EdgeInsets.all(12),
               //   decoration: BoxDecoration(
               //
               //     borderRadius: BorderRadius.circular(12),
               //     boxShadow: [
               //       BoxShadow(
               //         color: Colors.black.withOpacity(0.06),
               //         blurRadius: 6,
               //         offset: const Offset(0, 3),
               //       ),
               //     ],
               //   ),
               //   child: Column(
               //     crossAxisAlignment: CrossAxisAlignment.start,
               //     children: [
               //       Row(
               //         children: [
               //           AppText(title, type: AppTextType.bodyTextBold,),
               //           Spacer(),
               //           SvgPicture.asset(icons),
               //         ],
               //       ),
               //       const SizedBox(height: 8),
               //       Row(
               //         children: [
               //           AppText(mainValue, type: AppTextType.heading2,),
               //           AppText("/", type: AppTextType.heading1,),
               //
               //           AppText("100", type: AppTextType.caption,),
               //         ],
               //       ),
               //       const SizedBox(height: 4),
               //       segments != null
               //           ? Row(
               //         children: segments!
               //             .map((seg) => Expanded(
               //           flex: seg.flex,
               //           child: Container(
               //             height: 8,
               //             margin: const EdgeInsets.only(right: 2),
               //             decoration: BoxDecoration(
               //               color: seg.color,
               //               borderRadius: BorderRadius.circular(4),
               //             ),
               //           ),
               //         ))
               //             .toList(),
               //       )
               //           : ClipRRect(
               //         borderRadius: BorderRadius.circular(4),
               //         child: LinearProgressIndicator(
               //           value: progress,
               //           minHeight: 8,
               //           backgroundColor: Colors.grey.shade300,
               //           valueColor: AlwaysStoppedAnimation<Color>(Colors.blue),
               //         ),
               //       ),
               //     ],
               //   ),
               // );
             })
           ],
         )
          ],
        ),
      ),
    );
  }
}
