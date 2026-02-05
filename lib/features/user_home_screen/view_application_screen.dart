import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:event_sense_ai/core/controller/submit_application_controller.dart';
import 'package:event_sense_ai/utils/app_assets.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../core/routes/app_routes.dart';
import '../../core/widgets/apptext.dart';
import '../../core/widgets/custom_headerbar.dart';
import 'components/proposal_reusable.dart';

class ViewApplicationScreen extends StatelessWidget {
  ViewApplicationScreen({super.key});
  final controller = Get.find<SubmitApplicationController>();



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.all(7),
          child: Column(
            children: [
             CustomHeaderBar(title: "Vendors Applications",showBackButton: true,onBack: (){
               Navigator.of(context).pop();
             },),
              Expanded(
                child: StreamBuilder<QuerySnapshot<Map<String, dynamic>>>(
                    stream: controller.applicationsStream,
                    builder: (context, applicationSnap) {
                      if (applicationSnap.hasError) {
                        return Center(
                          child: Padding(
                            padding: const EdgeInsets.all(16.0),
                            child: AppText(
                              "Error: ${applicationSnap.error}",
                              color: Colors.red,
                              textAlign: TextAlign.center,
                            ),
                          ),
                        );
                      }

                      if (applicationSnap.connectionState == ConnectionState.waiting) {
                        return const Center(
                          child: CircularProgressIndicator(),
                        );
                      }

                      if (!applicationSnap.hasData || applicationSnap.data!.docs.isEmpty) {
                        return Center(
                          child: AppText("No application found"),
                        );
                      }

                      final data = applicationSnap.data!.docs;
                      return ListView.builder(
                        itemCount: data.length,
                        itemBuilder: (context, index) {
                          final application = data[index].data();
                          return ProposalCard(
                              imagePath: AppAssets.wedding_reception2,
                              status: application["status"] ?? "available",
                              statusIcon: Icons.check_circle,
                              statusColor: Colors.blue,
                              companyName: application["vendorName"] ?? "Vendor",
                              rating: 4.8,
                              reviewCount: 10,
                              price: "\$${application["quotedPrice"]}",
                              onViewProposal: () {
                                Get.toNamed(AppRoutes.proposalDetails,
                                    arguments: application);
                              },
                              onChat: () {
                                Get.toNamed(AppRoutes.chatDetailsScreen,
                                  arguments: {
                                    "applicationId": application["applicationId"],
                                    "vendorId": application["vendorId"],
                                    "vendorName": application["vendorName"],
                                    "vendorImage": application["vendorProfileImage"],
                                  },
                                );
                              });
                        },
                      );
                    }),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
