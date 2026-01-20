import 'package:event_sense_ai/utils/app_assets.dart';
import 'package:event_sense_ai/utils/app_colors.dart';
import 'package:event_sense_ai/utils/app_icons.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';
import 'package:sizer/sizer.dart';

import '../../core/routes/app_routes.dart';
import '../../core/widgets/apptext.dart';
import '../../core/widgets/custom_headerbar.dart';
import 'components/InProgressReusableWidget.dart';
import 'components/ai_generate_cards.dart';

class EventDetailsScreen extends StatefulWidget {

   EventDetailsScreen({super.key,});

  @override
  State<EventDetailsScreen> createState() => _EventDetailsScreenState();
}

class _EventDetailsScreenState extends State<EventDetailsScreen> {
   List<InfoProgressCard> inProgressCard = [
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

   late List<AiGenerateCards> aiGenerateCard = [
     AiGenerateCards(
       voidCallback: (){
         context.pushNamed(AppRoutes.VendersManagement);
       },
         icons: AppIcons.vender_icon,
         title: "Find Vendors",
         tag: "AI- Powered Search",
         bg_color: Colors.blueAccent.shade100.withOpacity(0.6),
         container_color: Colors.blueAccent.shade100,
     ),
     AiGenerateCards(
         voidCallback: (){
           context.pushNamed(AppRoutes.InviteGuest);
         },
         icons: AppIcons.invitaion_icon,
         title: "Invitation",
         tag: "Design and send",
         bg_color: Colors.greenAccent.withOpacity(0.1),
         container_color:Colors.green),
     AiGenerateCards(
         voidCallback: (){
           context.pushNamed(AppRoutes.guestList);
         },
         icons: AppIcons.guest_list,
         title: "Guest List ",
         tag: "85 / 150 Confirmed Guests",
         bg_color: Color(0xffFBE1CE).withOpacity(0.1),
         container_color: Color(0xffFBE1CE)),
     AiGenerateCards(
         voidCallback: (){
           context.pushNamed(AppRoutes.CheckBudget);
         },
         icons: AppIcons.budget_allocation,
         title: "Budget Allocation",
         tag: "AI- Budget setup",
         bg_color:Color(0xffEAB30840).withOpacity(0.1),
         container_color: Color(0xffEAB30840).withOpacity(0.3)),
   ];

   bool isVisible = false;

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
                CustomHeaderBar(
                  showBackButton: true,
                  onBack: (){
                    context.pop();
                  },
                    title: "Event Details"),
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
                   height: 20.h,
                   child: GridView.builder(
                     physics: NeverScrollableScrollPhysics(),
                     gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                       crossAxisCount: 2,
                       mainAxisSpacing: 20,
                       crossAxisSpacing: 20,
                       childAspectRatio: 1,
                     ),
                     itemCount: inProgressCard.length,
                     itemBuilder: (context, index) {
                       final data = inProgressCard[index];

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
                                 SvgPicture.asset(data.icons,color: Colors.black87,),
                               ],
                             ),

                             const SizedBox(height: 8),

                             Row(

                               children: [
                                 AppText(data.mainValue, fontSize: 24,fontWeight: FontWeight.w700,),

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

                 AppText("Ai Generates", fontSize: 18, fontWeight: FontWeight.w600,color: AppColors.textGrey1,),
                 SizedBox(
                   height: 27.h,
                   child: GridView.builder(
                     physics: NeverScrollableScrollPhysics(),
                     itemCount: aiGenerateCard.length,
                       gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                         crossAxisCount: 2,
                         mainAxisSpacing: 10,
                         crossAxisSpacing: 10,
                         childAspectRatio: 1.6,
                       ),
                       itemBuilder: (context , index){
                       final event = aiGenerateCard[index];
                     return InkWell(
                       onTap: event.voidCallback,
                       child: Container(
                         padding: EdgeInsets.only(top: 8, left: 4),
                                           decoration: BoxDecoration(
                        color: event.bg_color,
                        borderRadius: BorderRadius.circular(12),
                                           ),
                         child: Column(
                           crossAxisAlignment: CrossAxisAlignment.start,
                           children: [
                             Container(
                               width: 40,
                               height: 40,
                               decoration: BoxDecoration(
                                 color: event.container_color,
                                 borderRadius: BorderRadius.circular(25),
                               ),
                               child: Center(child: SvgPicture.asset(event.icons, color: Colors.white,),),
                             ),
                             Gap(2.h),
                             AppText(event.title, fontSize: 14,fontWeight: FontWeight.w600,),
                             AppText(event.tag, type: AppTextType.caption,),
                           ],
                         ),
                       ),
                     );

                   }),
                 ),
                 Row(
                   mainAxisAlignment: MainAxisAlignment.spaceBetween,
                   children: [
                     AppText("Recent Activity", fontWeight: FontWeight.w600,fontSize: 17,),
                     AppText("View All", fontWeight: FontWeight.w600,fontSize: 14,color: Colors.indigo.shade900,),
                   ],
                 ),
                 Gap(1.h),
                 Column(
                   children: [
                     // Card 1: Invite Accepted
                     Container(
                       padding: const EdgeInsets.all(12),
                       margin: const EdgeInsets.only(bottom: 12),
                       decoration: BoxDecoration(
                         color: Colors.white,
                         borderRadius: BorderRadius.circular(12),
                         boxShadow: [
                           BoxShadow(
                             color: Colors.black.withOpacity(0.05),
                             blurRadius: 6,
                             offset: const Offset(0, 3),
                           ),
                         ],
                       ),
                       child: Row(
                         children: [
                           const Icon(Icons.check_circle, color: Colors.green, size: 28),
                           const SizedBox(width: 12),
                           Expanded(
                             child: Column(
                               crossAxisAlignment: CrossAxisAlignment.start,
                               children: const [
                                 Text(
                                   "John Dae Accepted Invite",
                                   style: TextStyle(fontSize: 14, fontWeight: FontWeight.w600),
                                 ),
                                 SizedBox(height: 4),
                                 Text(
                                   "2 minutes ago",
                                   style: TextStyle(fontSize: 12, color: Colors.grey),
                                 ),
                               ],
                             ),
                           ),
                         ],
                       ),
                     ),

                     // Card 2: Venue Deposit Paid
                     Container(
                       padding: const EdgeInsets.all(12),
                       decoration: BoxDecoration(
                         color: Colors.white,
                         borderRadius: BorderRadius.circular(12),
                         boxShadow: [
                           BoxShadow(
                             color: Colors.black.withOpacity(0.05),
                             blurRadius: 6,
                             offset: const Offset(0, 3),
                           ),
                         ],
                       ),
                       child: Row(
                         children: [
                           const Icon(Icons.description, color: Colors.blue, size: 28),
                           const SizedBox(width: 12),
                           Expanded(
                             child: Column(
                               crossAxisAlignment: CrossAxisAlignment.start,
                               children: const [
                                 Text(
                                   "Venue Deposit Paid",
                                   style: TextStyle(fontSize: 14, fontWeight: FontWeight.w600),
                                 ),
                                 SizedBox(height: 4),
                                 Text(
                                   "3 hours ago",
                                   style: TextStyle(fontSize: 12, color: Colors.grey),
                                 ),
                               ],
                             ),
                           ),
                           const Text(
                             "-\$1,200",
                             style: TextStyle(
                               fontSize: 14,
                               fontWeight: FontWeight.bold,
                               color: Colors.red,
                             ),
                           ),
                         ],
                       ),
                     ),
                   ],
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
