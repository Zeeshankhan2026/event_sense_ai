import 'dart:developer';

import 'package:event_sense_ai/features/home_screen/create_event_screen.dart';
import 'package:event_sense_ai/utils/app_assets.dart';
import 'package:event_sense_ai/utils/app_icons.dart';
import 'package:event_sense_ai/widgets/event_screen_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';

import '../../routes/app_routes.dart';
import '../../utils/app_colors.dart';
import '../../utils/app_text.dart';
import '../../widgets/app_buttons.dart';
import 'event_details_screen.dart';

class EventScreen extends StatefulWidget {
  const EventScreen({super.key});

  @override
  State<EventScreen> createState() => _EventScreenState();
}

class _EventScreenState extends State<EventScreen> with SingleTickerProviderStateMixin {

  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }
   List<EventScreenCard> List_EventScreenCard = [
     EventScreenCard(
         price: "1450",
         imageUrl: AppAssets.wedding_image,
         title: "Wedding Receptions",
         description: "Loulund Falls is a seasonal outdoor wedding venue located just minutes outside downtown Salt Lake City, Utah",
         daysLeft: "08 days left",
         people: AppIcons.people_icon,
          attendence: "220",
         wallet_icon: AppIcons.wallet_icon ,
         location_icon : AppIcons.location_icon,
         date: "08 Aug", location: "ABC"
     ),
     EventScreenCard(
         price: "1450",
         imageUrl: AppAssets.wedding_image,
         title: "Wedding Receptions",
         description: "Loulund Falls is a seasonal outdoor wedding venue located just minutes outside downtown Salt Lake City, Utah",
         daysLeft: "08 days left",
         people: AppIcons.people_icon,
         attendence: "220",
         wallet_icon: AppIcons.wallet_icon ,
         location_icon : AppIcons.location_icon,
         date: "08 Aug", location: "ABC"
     ),
     EventScreenCard(
         price: "1450",
         imageUrl: AppAssets.wedding_image,
         title: "Wedding Receptions",
         description: "Loulund Falls is a seasonal outdoor wedding venue located just minutes outside downtown Salt Lake City, Utah",
         daysLeft: "08 days left",
         people: AppIcons.people_icon,
         attendence: "220",
         wallet_icon: AppIcons.wallet_icon ,
         location_icon : AppIcons.location_icon,
         date: "08 Aug", location: "ABC"
     ),
   ];

  Widget _infoItem(IconData icon, String text, {Color color = Colors.black}) {
    return Row(
      children: [
        Icon(icon, size: 14, color: color),
        const SizedBox(width: 4),
        Text(
          text,
          style: TextStyle(
            fontSize: 11,
            color: color,
            fontWeight: FontWeight.w500,
          ),
        ),
      ],
    );
  }

  Widget _statusItem() {
    return Row(
      children: const [
        Icon(Icons.location_on, size: 14, color: Colors.green),
        SizedBox(width: 4),
        Text(
          "ABC",
          style: TextStyle(
            fontSize: 11,
            color: Colors.green,
            fontWeight: FontWeight.w500,
          ),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {

    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;

    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(

        child: Column(
          children: [
            Gap(10),
            _searchBar(),
            _tabBar(),
            Expanded(
              child: TabBarView(
                controller: _tabController,
                children: [
                  Column(
                    children: [
                      Expanded(
                        child: ListView.builder(
                          padding: const EdgeInsets.all(16),
                          itemCount: List_EventScreenCard.length,
                          itemBuilder: (context, index) {
                            final event = List_EventScreenCard[index];

                            return GestureDetector(
                              onTap: (){
                                context.pushNamed(
                                 AppRoutes.eventDetails,
                                );
                              },
                              child: Container(

                                margin: const EdgeInsets.only(bottom: 16),
                                padding: const EdgeInsets.all(12),
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(16),
                                  boxShadow: [
                                    BoxShadow(
                                        color: AppColors.textGrey1,
                                        offset: Offset(0.5, 0.7)
                                    )
                                  ],
                                ),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    /// TOP CONTENT
                                    Row(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        /// IMAGE
                                        ClipRRect(
                                          borderRadius: BorderRadius.circular(12),
                                          child: Image.asset(
                                            event.imageUrl.toString(), // <-- dynamic
                                            height: 72,
                                            width: 72,
                                            fit: BoxFit.cover,
                                          ),
                                        ),
                                        const SizedBox(width: 12),

                                        /// TEXT CONTENT
                                        Expanded(
                                          child: Stack(
                                            children: [
                                              Column(
                                                crossAxisAlignment: CrossAxisAlignment.start,
                                                children: [
                                                  Text(
                                                    event.title.toString(),
                                                    style: const TextStyle(
                                                      fontSize: 14,
                                                      fontWeight: FontWeight.w600,
                                                    ),
                                                  ),
                                                  const SizedBox(height: 4),
                                                  Text(
                                                    event.description.toString(),
                                                    maxLines: 2,
                                                    overflow: TextOverflow.ellipsis,
                                                    style: const TextStyle(
                                                      fontSize: 11,
                                                      color: Colors.grey,
                                                    ),
                                                  ),
                                                ],
                                              ),

                                              /// BADGE
                                              Positioned(
                                                top: 0,
                                                right: 0,
                                                child: Container(
                                                  padding: const EdgeInsets.symmetric(
                                                    horizontal: 8,
                                                    vertical: 4,
                                                  ),
                                                  decoration: BoxDecoration(
                                                    color: const Color(0xffE8EDFF),
                                                    borderRadius: BorderRadius.circular(12),
                                                  ),
                                                  child: Text(
                                                    event.daysLeft.toString(),
                                                    style: const TextStyle(
                                                      fontSize: 10,
                                                      fontWeight: FontWeight.w600,
                                                      color: Color(0xff4C63FF),
                                                    ),
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ],
                                    ),

                                    const SizedBox(height: 12),

                                    Divider(color: Colors.grey.shade300, height: 1),

                                    const SizedBox(height: 10),

                                    /// BOTTOM ROW
                                    Row(
                                      children: [
                                        _infoItem(Icons.group, event.attendence.toString()),
                                        const SizedBox(width: 12),
                                        _infoItem(
                                          Icons.attach_money,
                                          event.price.toString(),
                                          color: Colors.green,
                                        ),
                                        const SizedBox(width: 12),
                                        _infoItem(Icons.calendar_today, event.date),
                                        const SizedBox(width: 12),

                                        const Spacer(),
                                        const Icon(
                                          Icons.arrow_forward_ios,
                                          size: 14,
                                          color: Colors.black54,
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                            );
                          },
                        ),
                      ),
                      SizedBox(height: 10,),
                      AppButtonWidget(
                        prefixIcon: Icon(Icons.add,color: Colors.white,size: 35,),
                          onPressed: (){
                          log("message");
                            context.pushNamed(AppRoutes.createEvent);

                          },
                          width: width*0.85,
                          height: height*0.06,
                          buttonColor: AppColors.fieldColor,
                          text: "Add Event"),
                    ],
                  ),

                  const Center(child: Text("Completed Events")),
                  const Center(child: Text("Canceled Events")),
                ],
              ),
            ),


          ],
        ),
      ),
    );
  }

  Widget _searchBar() {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Container(
        height: 48,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(24),
        ),
        child: const TextField(
          decoration: InputDecoration(
            hintText: "Search Here...",
            prefixIcon: Icon(Icons.search),
            border: InputBorder.none,
            contentPadding: EdgeInsets.symmetric(vertical: 14),
          ),
        ),
      ),
    );
  }

  Widget _tabBar() {
    return TabBar(
      controller: _tabController,
      indicatorColor: Colors.blue,
      labelColor: Colors.blue,
      unselectedLabelColor: Colors.grey,
      labelStyle: const TextStyle(fontWeight: FontWeight.w600),
      tabs: const [
        Tab(text: "Process"),
        Tab(text: "Completed"),
        Tab(text: "Canceled"),
      ],
    );
  }
}

