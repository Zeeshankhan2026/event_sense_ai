import 'package:event_sense_ai/utils/app_assets.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:go_router/go_router.dart';

import '../../../core/routes/app_routes.dart';
import '../../../core/widgets/apptext.dart';

class VendorConfirmLocation  extends StatelessWidget {
  const VendorConfirmLocation({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          // Map Background (replace with GoogleMap widget if needed)
          SizedBox(
            width: double.infinity,
            height: double.infinity,
            child: Image.asset(
              AppAssets.google_path_images, // Replace with your map image or use GoogleMap
              fit: BoxFit.cover,
            ),
          ),

          // Red Location Pin
          const Positioned(
            top: 200,
            left: 160,
            child: Icon(Icons.location_pin, size: 48, color: Colors.red),
          ),

          // Bottom Sheet UI
          Positioned(
            bottom: 0,
            left: 0,
            right: 0,
            child: Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: const BorderRadius.vertical(top: Radius.circular(20)),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.08),
                    blurRadius: 12,
                    spreadRadius: 2,
                    offset: const Offset(0, -4),
                  ),
                ],
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  AppText("Choose your Services Location",fontSize: 20,fontWeight: FontWeight.w600,
                  ),
                  const SizedBox(height: 12),
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 14),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(8),
                      border: Border.all(color: Colors.grey.shade300),
                    ),
                    child: Row(
                      children: [
                        Icon(Icons.search_outlined, color: Colors.grey,),
                        SizedBox(width: 8,),
                        AppText("25 Home, Olasa Street,Riyadh",fontWeight: FontWeight.w400,fontSize: 15,color: Colors.grey,),
                      ],
                    )
                  ),
                  const SizedBox(height: 16),
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed: () {
                       Get.toNamed(AppRoutes.vendorPortfolio);
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.indigo,
                        padding: const EdgeInsets.symmetric(vertical: 14),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                      ),
                      child: const Text(
                        "Confirm Location",
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
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
