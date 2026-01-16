import 'package:event_sense_ai/routes/app_routes.dart';
import 'package:event_sense_ai/utils/app_assets.dart';
import 'package:event_sense_ai/utils/app_colors.dart';
import 'package:event_sense_ai/utils/app_icons.dart';
import 'package:event_sense_ai/widgets/InProgressReusableWidget.dart';
import 'package:event_sense_ai/widgets/ai_generate_cards.dart';
import 'package:event_sense_ai/widgets/apptext.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';

class EventDetailsScreen extends StatelessWidget {

   EventDetailsScreen({super.key,});

   List<InfoProgressCard> inprogresscard = [
     /// FIRST CARD — Total Guest
     InfoProgressCard(
       title: "Total Guest",
       icons: AppIcons.people_icon,
       mainValue: "67",
       caption: "100",
       progress: 0.67,
       showSlashWithCaption: true,
       showCaptionBelow: true,
       showProgressPercent: true,
       segments: [
         ProgressSegment(color: Colors.green, flex: 3), // yes
         ProgressSegment(color: Colors.orange, flex: 2), // maybe
         ProgressSegment(color: Colors.red, flex: 1), // not
       ],
     ),

     /// SECOND CARD — Budget Used
     InfoProgressCard(
       title: "Budget Used",
       icons: AppIcons.wallet_icon,
       mainValue: "\$4.76K",
       caption: "of 5000 cap",
       progress: 0.95,
       showCaptionBelow: true,
       showProgressPercent: true, showSlashWithCaption: false,
      
     ),
   ];

   List<AiGenerateCards> ai_generate_card = [
     AiGenerateCards(
         icons: AppIcons.location_icon,
         title: "Find Vendors",
         tag: "AI- Powered Search",
         bg_color: AppColors.primary,
         container_color: Colors.redAccent),
     AiGenerateCards(
         icons: AppIcons.location_icon,
         title: "Find Vendors",
         tag: "AI- Powered Search",
         bg_color: AppColors.primary,
         container_color: Colors.redAccent),
     AiGenerateCards(
         icons: AppIcons.location_icon,
         title: "Find Vendors",
         tag: "AI- Powered Search",
         bg_color: AppColors.primary,
         container_color: Colors.redAccent),
     AiGenerateCards(
         icons: AppIcons.location_icon,
         title: "Find Vendors",
         tag: "AI- Powered Search",
         bg_color: AppColors.primary,
         container_color: Colors.redAccent),
   ];

   bool is_visible = false;

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final hieght = MediaQuery.of(context).size.height;
    return Scaffold(
      backgroundColor: AppColors.white,
      body: SingleChildScrollView(
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 18.0),
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 12.0),
                  child: Row(
                    children: [
                      IconButton(onPressed: (){
                        context.goNamed(AppRoutes.main);
                      }, icon:Icon( Icons.arrow_back_ios)),
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
                                 width: 100,
                                 height: 25,
                                 decoration: BoxDecoration(
                                   color: Colors.white,
                                   borderRadius: BorderRadius.circular(16),
                                 ),
                                 child: Center(
                                   child: Row(
                                     children: [
                                       SvgPicture.asset(AppIcons.calender_icon),
                                       AppText("Nov 12 / 6:00 PM", type: AppTextType.caption,fontSize: 8,fontWeight: FontWeight.w700,)
                                     ],
                                   ),
                                 ),
                               ),
                               Gap(10),
                               AppText("Wedding Receptions", type: AppTextType.xlNormal, color: AppColors.white,),
                               Row(
                                 children: [
                                   SvgPicture.asset(AppIcons.location_icon,height: 24,color: AppColors.white,),
                                   Gap(5),
                                   AppText("Nov 12 / 6:00 PM", type: AppTextType.captionDark,color: AppColors.white,fontWeight: FontWeight.w700,)
                                 ],
                               ),
                             ],),
                         )
                     ),
        
                   ],
                 ),
                 Gap(15),
                 AppText("Status", type: AppTextType.heading4,color: AppColors.textGrey1,),
                 Gap(15),
                 SizedBox(
                   height: 140,
                   child: GridView.builder(
                     gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                       crossAxisCount: 2,
                       mainAxisSpacing: 20,
                       crossAxisSpacing: 20,
                       childAspectRatio: 1,
                     ),
                     itemCount: inprogresscard.length,
                     itemBuilder: (context, index) {
                       final data = inprogresscard[index];
        
                       return Container(
                         height: 100,
                         padding: const EdgeInsets.all(12),
                         decoration: BoxDecoration(
                           color: Colors.white,
                           borderRadius: BorderRadius.circular(12),
                           boxShadow: [
                             BoxShadow(
                               color: AppColors.textGrey1,
                               offset: const Offset(0.5, 0.7),
                             ),
                           ],
                         ),
                         child: Column(
                           crossAxisAlignment: CrossAxisAlignment.start,
                           children: [
                             Row(
                               children: [
                                 AppText(data.title, type: AppTextType.caption),
                                 const Spacer(),
                                 SvgPicture.asset(data.icons),
                               ],
                             ),
        
                             const SizedBox(height: 8),
        
                             Row(
        
                               children: [
                                 AppText(data.mainValue, type: AppTextType.heading2),
        
                                 if (data.showSlashWithCaption ?? false)
                                   Row(
                                     children: [
                                       AppText("/", type: AppTextType.heading1),
                                       AppText(data.caption, type: AppTextType.caption),
                                     ],
                                   ),
                               ],
                             ),
        
                             if (data.showCaptionBelow) ...[
                               const SizedBox(height: 4),
                               AppText(
                                 data.caption,
                                 type: AppTextType.caption,
                               ),
                             ],
        
                             const SizedBox(height: 8),
                             if (data.segments != null)
                               Row(
                                 children: data.segments!
                                     .map((seg) => Expanded(
                                   flex: seg.flex,
                                   child: Container(
                                     height: 8,
                                     margin: const EdgeInsets.only(right: 2),
                                     decoration: BoxDecoration(
                                       color: seg.color,
                                       borderRadius: BorderRadius.circular(4),
                                     ),
                                   ),
                                 ))
                                     .toList(),
                               )
                             else if (data.progress != null)
                               ClipRRect(
                                 borderRadius: BorderRadius.circular(4),
                                 child: Column(
                                   crossAxisAlignment: CrossAxisAlignment.start,
                                   children: [
                                     LinearProgressIndicator(
                                       value: data.progress,
                                       minHeight: 8,
                                       backgroundColor: Colors.grey.shade300,
                                       valueColor:
                                       const AlwaysStoppedAnimation<Color>(Colors.blue),
                                     ),
                                     if (data.showProgressPercent)
                                       Padding(
                                         padding: const EdgeInsets.only(top: 4),
                                         child: AppText(
                                           "${(data.progress * 100).toInt()}%",
                                           type: AppTextType.caption,
                                         ),
                                       ),
                                   ],
                                 ),
                               ),
                           ],
                         ),
                       );
                     },
                   )
                 ),
                  Gap(12),
                 AppText("AI Generates", type: AppTextType.heading1,color: AppColors.textGrey1,),
                 SizedBox(
                   // child: GridView.builder(
                   //   itemCount: ai_generate_card.length,
                   //     gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                   //       crossAxisCount: 2,
                   //       mainAxisSpacing: 10,
                   //       crossAxisSpacing: 10,
                   //       childAspectRatio: 2,
                   //     ),
                   //     itemBuilder: (context , index){
                   //     final event = ai_generate_card[index];
                   //   return Container(
                   //     padding: EdgeInsets.only(top: 8, left: 4),
                   //  decoration: BoxDecoration(
                   //    color: event.bg_color,
                   //    borderRadius: BorderRadius.circular(12),
                   //  ),
                   //     child: Column(
                   //       crossAxisAlignment: CrossAxisAlignment.start,
                   //       children: [
                   //         Container(
                   //           width: 40,
                   //           height: 40,
                   //           decoration: BoxDecoration(
                   //             color: event.container_color,
                   //             borderRadius: BorderRadius.circular(25),
                   //           ),
                   //           child: Center(child: SvgPicture.asset(event.icons),),
                   //         ),
                   //         AppText(event.title, type: AppTextType.captionDark,),
                   //         AppText(event.tag, type: AppTextType.captionDark,),
                   //       ],
                   //     ),
                   //   );
                   //
                   // }),
                 )
               ],
             )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
