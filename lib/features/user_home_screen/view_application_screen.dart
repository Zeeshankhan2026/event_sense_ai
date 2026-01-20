import 'package:event_sense_ai/features/user_home_screen/proposal_details.dart';
import 'package:event_sense_ai/utils/app_assets.dart';
import 'package:event_sense_ai/utils/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';
import 'package:sizer/sizer.dart';

import '../../core/widgets/app_buttons.dart';
import '../../core/widgets/apptext.dart';
import '../../core/widgets/custom_headerbar.dart';
import 'components/proposal_reusable.dart';

class ViewApplicationScreen extends StatelessWidget {
  ViewApplicationScreen({super.key});

  List<ProposalCard> proposal_card = [
    ProposalCard(
      imagePath: AppAssets.wedding_reception2,
      status: "Available",
      statusIcon: Icons.check_circle,
      statusColor: Colors.green,
      companyName: "Lamina Catering.Co",
      rating: 4.9,
      reviewCount: 120,
      price: "\$2,500",
      onViewProposal: () {
        print("View Proposal tapped");
      },
      onChat: () {
        print("Chat tapped");
      },
    ),
    ProposalCard(
      imagePath: AppAssets.wedding_reception2,
      status: "Available",
      statusIcon: Icons.check_circle,
      statusColor: Colors.green,
      companyName: "Lamina Catering.Co",
      rating: 4.9,
      reviewCount: 120,
      price: "\$2,500",
      onViewProposal: () {
        print("View Proposal tapped");
      },
      onChat: () {
        print("Chat tapped");
      },
    ),
    ProposalCard(
      imagePath: AppAssets.wedding_reception2,
      status: "Available",
      statusIcon: Icons.check_circle,
      statusColor: Colors.green,
      companyName: "Lamina Catering.Co",
      rating: 4.9,
      reviewCount: 120,
      price: "\$2,500",
      onViewProposal: () {
        print("View Proposal tapped");
      },
      onChat: () {
        print("Chat tapped");
      },
    ),
    ProposalCard(
      imagePath: AppAssets.wedding_reception2,
      status: "Available",
      statusIcon: Icons.check_circle,
      statusColor: Colors.green,
      companyName: "Lamina Catering.Co",
      rating: 4.9,
      reviewCount: 120,
      price: "\$2,500",
      onViewProposal: () {
        print("View Proposal tapped");
      },
      onChat: () {
        print("Chat tapped");
      },
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.all(7),
          child: Column(
            children: [
             CustomHeaderBar(title: "Vendors Applications",showBackButton: true,onBack: (){
               context.pop();
             },),
              Expanded(
                child: SizedBox(
                  width: 100.w,
                  child: ListView.builder(
                    itemCount: proposal_card.length,
                    itemBuilder: (context, index) {
                      final data = proposal_card[index];

                      return Container(
                        margin: EdgeInsets.all(12),
                        child: Column(
                          children: [
                            Container(
                              height: 210, // total card height
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.only(topLeft: Radius.circular(16), topRight: Radius.circular(16)),
                                image: DecorationImage(
                                  image: AssetImage(data.imagePath),
                                  fit: BoxFit.cover,
                                ),
                              ),
                              child: SizedBox(
                                height: 160, // image area height
                                child: Stack(
                                  children: [
                                    Container(
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(16),
                                        color: Colors.black.withOpacity(0.4),
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.all(16),
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Container(
                                            width: 28.w,
                                            padding: EdgeInsets.all(2),
                                            decoration: BoxDecoration(
                                              color: Colors.grey.shade400,
                                              borderRadius: BorderRadius.circular(12)
                                            ),
                                            child: Row(
                                              children: [
                                                Icon(
                                                  data.statusIcon,
                                                  color: data.statusColor,
                                                  size: 18,
                                                ),
                                                const SizedBox(width: 6),
                                                Text(
                                                  data.status,
                                                  style: const TextStyle(
                                                    color: Colors.white,
                                                    fontSize: 14,
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                        
                                        Gap(9.h),
                        
                                         AppText(data.companyName,  color: Colors.white,
                                           fontSize: 20,
                                           fontWeight: FontWeight.bold,),

                        
                                          Row(

                                            children: [
                                              const Icon(
                                                Icons.star,
                                                color: Colors.amber,
                                                size: 16,
                                              ),
                                              const SizedBox(width: 4),
                                              Row(
                                                children: [
                                                  AppText( "${data.rating}",color: Colors.white,),
                                                  const SizedBox(width: 6),
                                                  AppText( "(${data.reviewCount} reviews)",fontSize: 12,color: Colors.white,)
                                                  , SizedBox(width: 6),

                                                ],
                                              ),
                                              Spacer(),
                                              Column(
                                                children: [
                                                  AppText("Proposed", color: Colors.white,
                                                    fontSize: 14,
                                                    fontWeight: FontWeight.w600,),
                                                  AppText(data.price,     color: Colors.white,
                                                    fontSize: 16,
                                                    fontWeight: FontWeight.w600,),
                                                ],
                                              )
                                            ],
                                          ),
                        

                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                        
                            Container(
                              color : Colors.grey.shade100,
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Row(
                                  mainAxisAlignment:
                                  MainAxisAlignment.spaceBetween,
                                  children: [
                                    AppButtonWidget(
                                      onPressed: (){
                                        Navigator.of(context).push(MaterialPageRoute(builder: (_) => ProposalDetails(image_url: data.imagePath, company_name: data.companyName, rating: data.rating.toString(), review: data.reviewCount.toString(), price: data.price)));
                                      },
                                      width: 70.w,
                                      height: 6.h,
                                      buttonColor: AppColors.fieldColor,
                                      text: "View Proposal", fontSize: 16,fontWeight: FontWeight.w600,),
                                    GestureDetector(
                                      onTap: data.onChat,
                                      child: Container(
                                        height: 40,
                                        width: 40,
                                        decoration: BoxDecoration(
                                          color: Colors.grey.shade300,
                                          borderRadius: BorderRadius.circular(12),
                                        ),
                                        child:  Icon(
                                          Icons.chat_bubble_outline,
                                          color: Colors.grey.shade500,
                                          size: 24,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                      );
                    },
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
