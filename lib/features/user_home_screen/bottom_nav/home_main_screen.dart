import 'package:event_sense_ai/utils/app_assets.dart';
import 'package:event_sense_ai/utils/app_icons.dart';
import 'package:event_sense_ai/features/user_home_screen/components/event_card.dart';
import 'package:event_sense_ai/features/user_home_screen/components/home_screens_tiles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';
import 'package:sizer/sizer.dart';
import '../../../core/routes/app_routes.dart';
import '../../../core/widgets/IconTextButton.dart';
import '../../../core/widgets/apptext.dart';
import '../../../core/widgets/custom_circle_avator.dart';
import '../../../utils/app_colors.dart';
import '../components/quick_access_card.dart';

class HomeMainScreen extends StatelessWidget {
  HomeMainScreen({super.key});

  final List<EventCard> listEventCard = [
    EventCard(
      title: 'Wedding Reception',
      date: '18 Dec 2025',
      location: 'ABC',
      peoples_image: AppIcons.people_icon,
      wallet: AppIcons.wallet_icon,
      calender_image: AppIcons.calender_icon,
      location_icon: AppIcons.location_icon,
      imagePath: AppAssets.wedding_image,
      attendees: 220,
      cost: 1450,
      countdown: '8 days',
    ),
    EventCard(
      title: 'Wedding Reception',
      date: '18 Dec 2025',
      location: 'ABC',
      peoples_image: AppIcons.people_icon,
      wallet: AppIcons.wallet_icon,
      location_icon: AppIcons.location_icon,
      calender_image: AppIcons.calender_icon,
      imagePath: AppAssets.wedding_image,
      attendees: 220,
      cost: 1450,
      countdown: '8 days',
    ),
    EventCard(
      title: 'Wedding Reception',
      date: '18 Dec 2025',
      location: 'ABC',
      peoples_image: AppIcons.people_icon,
      wallet: AppIcons.wallet_icon,
      location_icon: AppIcons.location_icon,
      calender_image: AppIcons.calender_icon,
      imagePath: AppAssets.wedding_image,
      attendees: 220,
      cost: 1450,
      countdown: '8 days',
    ),
  ];


  final List<IconTextButton> iconTextButton = [
    IconTextButton(
      width: 110,
      height: 70,
      onPressed: (){

      },
      backgroundColor: Color(0xffCDEAF9),
        label: "Draft Invite",
        icon: AppIcons.draft_invite
    ),
    IconTextButton(
        width: 100,
        height: 70,
        onPressed: (){},
        backgroundColor: Color(0xffFBE1CE),
        label: "Find Venue",
        icon: AppIcons.find_venue
    ),
    IconTextButton(
        width: 100,
        height: 70,
        onPressed: (){},
        backgroundColor: Color(0xffD0F1DC),
        label: "Check Budget",
        icon: AppIcons.check_budget
    ),
    IconTextButton(
        width: 100,
        height: 70,
        onPressed: (){

        },
        backgroundColor: Color(0xffEBDBFB),
        label: "Guest List",
        icon: AppIcons.guest_list
    ),
  ];


 final List<DashboardTile> dashboardTile = [
   DashboardTile(
     textColor: AppColors.fieldColor,
     width: 110,
     height: 125,
     backgroundColor: Color(0xFF96A2D5).withOpacity(0.3),
     containerColor: Colors.indigo,
     label: "Active events",
     count: 12,
     icon: AppIcons.event_icon,
   ),
   DashboardTile(
     width: 110,
     height: 125,
     textColor: Color(0xFF3C9C5F),
     backgroundColor: Color(0xFF3C9C5F).withOpacity(0.5),
     containerColor: Colors.green,
     label: "Confirm",
     count: 85,
     icon: AppIcons.people_icon,
   ),
   DashboardTile(
     width: 110,
     height: 125,
     textColor: AppColors.primary,
     backgroundColor: Color(0xFF8896B6).withOpacity(0.5),
     containerColor: Color(0xFF8896B6),
     label: "Vendors",
     count: 7,
     icon: AppIcons.star_icon,
   ),
 ];


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Header
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      CustomCircleAvatar(
                        radius: 30,
                        assetImage: AppAssets.person_1,
                      ),
                      const Gap(5),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          AppText("Good Morning, Sophia", fontSize: 18,fontWeight: FontWeight.w700,color: Colors.indigo.shade900,),
                          AppText("You have 3 Active Events Today.", type: AppTextType.caption,fontSize: 9,),
                        ],
                      ),
                    ],
                  ),
                  GestureDetector(
                    onTap: (){
                      context.pushNamed(AppRoutes.NotificationScreen);
                    },
                    child: Stack(
                      children: [
                        Icon(Icons.notifications, size: 30, color: AppColors.fieldColor),
                        Positioned(
                          left: 12,
                          child: Container(
                              height: 20,
                              width: 18,
                              decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  color: Colors.grey
                              ),
                            child: Center(child: AppText("0"),),
                          ),
                        ),
                      ]
                    ),
                  ),
                ],
              ),

              const Gap(20),

              // Dashboard tiles
              SizedBox(
                height: 125,
                width: 100.w,
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: dashboardTile.length,

                    itemBuilder: (context,index)
                    {
                      final dashboard_tile = dashboardTile[index];
                  return Row(
                    children: [
                      GestureDetector(
                        onTap: dashboard_tile.onTap,
                        child: Container(
                          width: 110,
                          height: 125,
                          padding: const EdgeInsets.all(12),
                          decoration: BoxDecoration(
                            color: dashboard_tile.backgroundColor,
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Container(
                                  width: 40,
                                  height: 40,
                                  decoration: BoxDecoration(
                                      color: dashboard_tile.containerColor,
                                      borderRadius: BorderRadius.circular(20)
                                  ),
                                  child: Center(child: SvgPicture.asset(dashboard_tile.icon,width: 28,height: 26,))),
                              AppText(
                                "${dashboard_tile.count}",
                                type: AppTextType.heading1Normal,
                                color: dashboard_tile.textColor,
                              ),
                              AppText(
                                dashboard_tile.label,
                                type: AppTextType.caption,
                                color: AppColors.black,
                                textAlign: TextAlign.center,
                              ),
                            ],
                          ),
                        ),
                      ),
                      Gap(20)
                    ],
                  );
                }),
              ),
              const Gap(10),

              // Upcoming events header
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  AppText("Upcoming Events",
                      fontSize: 18,fontWeight: FontWeight.w600,color: Colors.black87,),
                  AppText("See all",fontSize: 14,
                      fontWeight: FontWeight.w700, color: AppColors.textGrey1),
                ],
              ),
              // Upcoming events list
              Container(
                margin: EdgeInsets.all(4),
                height: 180,
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: listEventCard.length,
                  padding: const EdgeInsets.symmetric(horizontal: 12),
                  itemBuilder: (context, index) {
                    final event = listEventCard[index];

                    return Container(
                      width: 280,
                      margin: const EdgeInsets.only(right: 12),
                      padding: const EdgeInsets.all(12),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(16),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.06),
                            blurRadius: 6,
                            offset: const Offset(0, 3),
                          ),
                        ],
                      ),
                      child: Column(
                        children: [
                          Row(
                            children: [
                              // Thumbnail
                              ClipRRect(
                                borderRadius: BorderRadius.circular(12),
                                child: Image.asset(
                                  event.imagePath,
                                  width: 100,
                                  height: 110,
                                  fit: BoxFit.cover,
                                ),
                              ),
                              const SizedBox(width: 12),

                              // Event details
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    AppText(event.title,type: AppTextType.heading3,),
                                    const SizedBox(height: 4),
                                    Row(
                                      children: [
                                        SvgPicture.asset(event.calender_image),
                                        Gap(4),
                                        AppText(event.date,type: AppTextType.caption,fontWeight: FontWeight.bold,),

                                      ],
                                    ),
                                    const SizedBox(height: 4),
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      children: [
                                        Row(
                                          children: [
                                            SvgPicture.asset(event.location_icon),
                                            Gap(4),
                                            AppText(event.location,type: AppTextType.caption,fontWeight: FontWeight.bold,),

                                          ],
                                        ),
                                        Container(
                                          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                                          decoration: BoxDecoration(
                                            color: AppColors.first_tile_color,
                                            borderRadius: BorderRadius.circular(8),
                                          ),
                                          child: AppText("${event.countdown + "  left"}",type: AppTextType.caption,color: Colors.black,),

                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                          Divider(thickness: 1.5,),
                          const SizedBox(height: 8),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Row(
                                children: [
                                  Row(
                                    children: [
                                      SvgPicture.asset(event.peoples_image,color: Colors.black87,),
                                      Gap(4),
                                      AppText("${event.attendees}",fontSize: 10,fontWeight: FontWeight.w600,),

                                    ],
                                  ),
                                  Gap(25),
                                  Row(
                                    children: [
                                      SvgPicture.asset(event.wallet),
                                      Gap(4),
                                      AppText("\$ ${event.cost}",type: AppTextType.caption,color: AppColors.second_tile_color,fontWeight: FontWeight.bold,),

                                    ],
                                  ),
                                  const SizedBox(width: 6),
                                ],
                              ),
                              const Icon(Icons.arrow_forward_ios,
                                  size: 18, color: Colors.black45),

                            ],
                          ),
                        ],
                      ),
                    );
                  },
                ),
              ),

              AppText("AI Assistant",fontSize: 18,fontWeight: FontWeight.w600,color: Colors.black87,),
              Gap(1.h),
              SizedBox(
                height: 18.h,
                child: GridView(
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    mainAxisSpacing: 8,
                      crossAxisSpacing: 8,
                      childAspectRatio: 3,
                      crossAxisCount: 2),
                  children: [
                InkWell(
                onTap: (){
                  context.pushNamed(AppRoutes.eventDetails);

                },

                  borderRadius: BorderRadius.circular(12),
                  child: Container(
                    padding: const EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      color: AppColors.white,
                      boxShadow: [
                        BoxShadow(
                            color: AppColors.textGrey1,
                            offset: Offset(0.5, 0.7)
                        )
                      ],
                      border: Border.all(color:   Color(0xffCDEAF9)),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Container(
                            width: 40,
                            height: 90,
                            decoration: BoxDecoration(
                                color:  Color(0xffCDEAF9).withOpacity(0.8),
                                borderRadius: BorderRadius.circular(12)
                            ),
                            child: Center(child: SvgPicture.asset(AppIcons.draft_invite))),
                        const SizedBox(width: 8),
                        AppText( "Draft Invite", fontWeight: FontWeight.w600,fontSize: 14,)
                      ],
                    ),
                  ),
                ),
                    InkWell(
                      onTap: (){},

                      borderRadius: BorderRadius.circular(12),
                      child: Container(
                        padding: const EdgeInsets.all(12),
                        decoration: BoxDecoration(
                          color: AppColors.white,
                          boxShadow: [
                            BoxShadow(
                                color: AppColors.textGrey1,
                                offset: Offset(0.5, 0.7)
                            )
                          ],
                          border: Border.all(color:   Color(0xffCDEAF9)),
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Container(
                                width: 40,
                                height: 90,
                                decoration: BoxDecoration(
                                    color:  Color(0xffF97316).withOpacity(0.3),
                                    borderRadius: BorderRadius.circular(12)
                                ),
                                child: Center(child: SvgPicture.asset(AppIcons.find_venue))),
                            const SizedBox(width: 8),
                            AppText( "Find Venue",fontWeight: FontWeight.w600,fontSize: 14,)
                          ],
                        ),
                      ),
                    ),
                    InkWell(
                      onTap: (){
                          context.pushNamed(AppRoutes.eventDetails);
                      },

                      borderRadius: BorderRadius.circular(12),
                      child: Container(
                        padding: const EdgeInsets.all(12),
                        decoration: BoxDecoration(
                          color: AppColors.white,
                          boxShadow: [
                            BoxShadow(
                                color: AppColors.textGrey1,
                                offset: Offset(0.5, 0.7)
                            )
                          ],
                          border: Border.all(color:   Color(0xffCDEAF9)),
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Container(
                                width: 40,
                                height: 90,
                                decoration: BoxDecoration(
                                    color:  Color(0xff22C75E).withOpacity(0.3),
                                    borderRadius: BorderRadius.circular(12)
                                ),
                                child: Center(child: SvgPicture.asset(AppIcons.check_budget))),
                            const SizedBox(width: 8),
                            AppText( "Check Budget", fontWeight: FontWeight.w600,fontSize: 14,)
                          ],
                        ),
                      ),
                    ),
                    InkWell(
                      onTap: (){
                        context.pushNamed(AppRoutes.eventDetails);
                      },

                      borderRadius: BorderRadius.circular(12),
                      child: Container(
                        padding: const EdgeInsets.all(12),
                        decoration: BoxDecoration(
                          color: AppColors.white,
                          boxShadow: [
                            BoxShadow(
                                color: AppColors.textGrey1,
                                offset: Offset(0.5, 0.7)
                            )
                          ],
                          border: Border.all(color:   Color(0xffCDEAF9)),
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Container(
                                width: 40,
                                height: 90,
                                decoration: BoxDecoration(
                                    color:  Color(0xffA855F7).withOpacity(0.3),
                                    borderRadius: BorderRadius.circular(12)
                                ),
                                child: Center(child: SvgPicture.asset(AppIcons.guest_list))),
                            const SizedBox(width: 8),
                            AppText( "Guest List",fontWeight: FontWeight.w600,fontSize: 14,)
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              AppText("Quick Access",fontSize: 18,fontWeight: FontWeight.w600,color: Colors.black87,),


              Gap(8),
              GestureDetector(
                onTap: (){
                  context.pushNamed(AppRoutes.VendersManagement);
                },
                child: QuickAccessCard(
                    title: "Vendors Management",
                    height: 50 , width: 800,
                    bg_color: AppColors.fieldColor,

                    radius: 12,
                    prefix_icon: AppIcons.vendors,
                    suffix_icon: AppIcons.right_arrow),
              ),
              Gap(8),
              GestureDetector(
                onTap: (){
                  context.pushNamed(AppRoutes.guestList);
                },
                child: QuickAccessCard(
                    title: "Guest Management",
                    height: 50 , width: 800,
                    bg_color: AppColors.second_tile_color,
                    text_color: AppColors.second_tile_color,
                    radius: 12,
                    prefix_icon: AppIcons.guests,
                    suffix_icon: AppIcons.right_arrow),
              )

            ],
          ),
        ),
      ),
    );
  }
}
