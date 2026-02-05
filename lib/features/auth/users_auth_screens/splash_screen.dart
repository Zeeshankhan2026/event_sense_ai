import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:go_router/go_router.dart';

import '../../../core/controller/splash_controller.dart';
import '../../../core/routes/app_routes.dart';
import '../../../core/widgets/apptext.dart';

class SplashScreen extends StatelessWidget {
   SplashScreen({super.key});

  final SplashController controller = Get.put(SplashController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: CircularProgressIndicator(),
      ),
    );
  }
}
