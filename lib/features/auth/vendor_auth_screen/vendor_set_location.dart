import 'package:event_sense_ai/utils/app_assets.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

import '../../../core/routes/app_routes.dart';
import '../../../core/widgets/apptext.dart';

class VendorSetLocation extends StatelessWidget {
  const VendorSetLocation({super.key});

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      body: Stack(
        children: [
          // Background Map (replace with actual map widget if needed)
          SizedBox(
            width: double.infinity,
            height: double.infinity,
            child: Image.asset(
              AppAssets.google_path_images, // Replace with your map image or use GoogleMap widget
              fit: BoxFit.cover,
            ),
          ),

          // Location Prompt Card
          Center(
            child: Container(
              width: 320,
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(16),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.08),
                    blurRadius: 12,
                    spreadRadius: 2,
                    offset: const Offset(0, 6),
                  ),
                ],
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  AppText(  "Where are you now?",fontSize: 18,fontWeight: FontWeight.bold,),
                  const SizedBox(height: 12),
                  AppText("Set your location so we can find you at the right spot and get restaurants around you.",fontSize: 14,color: Colors.grey,)
                ,  const SizedBox(height: 20),
                  ElevatedButton(
                    onPressed: () {
                      Get.toNamed(AppRoutes.vendorConfirmLocation);
                      // Add location picker logic here
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.indigo,
                      padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 14),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                    child:AppText("Set Location",color: Colors.white,)
                  ),
                ],
              ),
            ),
          ),
        ],
      )

    );
  }
}
