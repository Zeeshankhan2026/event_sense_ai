import 'package:event_sense_ai/utils/app_assets.dart';
import 'package:event_sense_ai/utils/app_icons.dart';
import 'package:event_sense_ai/widgets/IconTextButton.dart';
import 'package:event_sense_ai/widgets/app_buttons.dart';
import 'package:event_sense_ai/widgets/apptext.dart';
import 'package:event_sense_ai/widgets/custom_circle_avator.dart';
import 'package:event_sense_ai/widgets/event_card.dart';
import 'package:event_sense_ai/widgets/home_screens_tiles.dart';
import 'package:event_sense_ai/widgets/quick_access_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:gap/gap.dart';
import '../../utils/app_colors.dart';

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
  final List<IconTextButton> icontextbutton = [
    IconTextButton(
      width: 100,
      height: 70,
      onPressed: (){},
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
        onPressed: (){},
        backgroundColor: Color(0xffEBDBFB),
        label: "Guest List",
        icon: AppIcons.guest_list
    ),
  ];
  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;

    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;
    return Scaffold(
      backgroundColor: AppColors.white,
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
                        assetImage: AppAssets.person_image,
                      ),
                      const Gap(5),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          AppText("Good Morning, Sophia", type: AppTextType.heading4),
                          AppText("You have 3 Active Events Today.", type: AppTextType.microDark),
                        ],
                      ),
                    ],
                  ),
                  Icon(Icons.notifications, size: 30, color: AppColors.fieldColor),
                ],
              ),

              const Gap(20),

              // Dashboard tiles
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  DashboardTile(
                    size: 115,
                    backgroundColor: AppColors.first_tile_color,
                    label: "Active events",
                    count: 12,
                    icon: AppIcons.event_icon,
                  ),
                  DashboardTile(
                    size: 115,
                    backgroundColor: AppColors.second_tile_color,
                    label: "Confirm",
                    count: 85,
                    icon: AppIcons.people_icon,
                  ),
                  DashboardTile(
                    size: 115,
                    backgroundColor: AppColors.third_tile_color,
                    label: "Vendors",
                    count: 7,
                    icon: AppIcons.star_icon,
                  ),
                ],
              ),

              const Gap(10),

              // Upcoming events header
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  AppText("Upcoming Events",
                      type: AppTextType.heading3, color: AppColors.textGrey1),
                  AppText("See all",
                      type: AppTextType.captionDark, color: AppColors.textGrey1),
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
                                        AppText(event.date,type: AppTextType.captionDark,),

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
                                            AppText(event.location,type: AppTextType.captionDark,),

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
                                      SvgPicture.asset(event.peoples_image),
                                      Gap(4),
                                      AppText("${event.attendees}",type: AppTextType.captionDark,),

                                    ],
                                  ),
                                  Gap(25),
                                  Row(
                                    children: [
                                      SvgPicture.asset(event.wallet),
                                      Gap(4),
                                      AppText("\$ ${event.cost}",type: AppTextType.captionDark,color: AppColors.second_tile_color,),

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
              AppText("AI Assistant",type: AppTextType.heading4,color: AppColors.textGrey1,),
              GridView.builder(
                itemCount: icontextbutton.length,
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2, // number of columns
                  crossAxisSpacing: 12,
                  mainAxisSpacing: 12,
                  childAspectRatio: 2.5, // square tiles
                ),
                itemBuilder: (context, index) {
                  return InkWell(
                    onTap: icontextbutton[index].onPressed,
                    borderRadius: BorderRadius.circular(12),
                    child: Container(
                      width:  icontextbutton[index].width,
                      height:  icontextbutton[index].height,
                      padding: const EdgeInsets.all(12),
                      decoration: BoxDecoration(
                        color: AppColors.white,
                        boxShadow: [
                          BoxShadow(
                              color: AppColors.textGrey1,
                              offset: Offset(0.5, 0.7)
                          )
                        ],
                        border: Border.all(color:  icontextbutton[index].borderColor),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Container(
                              width: 50,
                              height: 90,
                              decoration: BoxDecoration(
                                  color:  icontextbutton[index].backgroundColor,
                                  borderRadius: BorderRadius.circular(12)
                              ),
                              child: Center(child: SvgPicture.asset( icontextbutton[index].icon))),
                          const SizedBox(width: 8),
                          AppText( icontextbutton[index].label, type: AppTextType.captionPrimary,color: AppColors.black,)
                        ],
                      ),
                    ),
                  );
                },
              ),
              AppText("Quick Access", type: AppTextType.heading4,color: AppColors.textGrey1,),


              Gap(8),
              QuickAccessCard(
                  title: "Vendors Management",
                  height: 50 , width: 800,
                  bg_color: AppColors.fieldColor,

                  radius: 12,
                  prefix_icon: AppIcons.vendors,
                  suffix_icon: AppIcons.right_arrow),
              Gap(8),
              QuickAccessCard(
                  title: "Guest Management",
                  height: 50 , width: 800,
                  bg_color: Colors.grey,
                  text_color: AppColors.second_tile_color,
                  radius: 12,
                  prefix_icon: AppIcons.guests,
                  suffix_icon: AppIcons.right_arrow)

            ],
          ),
        ),
      ),
    );
  }
}
