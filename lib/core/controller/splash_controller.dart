import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import '../routes/app_routes.dart';

class SplashController extends GetxController {

  @override
  void onReady() {
    super.onReady();
    _handleNavigation();
  }

  Future<void> _handleNavigation() async {
    final user = FirebaseAuth.instance.currentUser;

    if (user == null) {
      // User not logged in
      Get.offAllNamed(AppRoutes.welcome_screen);
      return;
    }

    final snap = await FirebaseFirestore.instance
        .collection('users')
        .doc(user.uid)
        .get();

    final role = snap.data()?['role'];

    if (role == 'planner') {
      Get.offAllNamed(AppRoutes.main);
    } else if (role == 'vendor') {
      Get.offAllNamed(AppRoutes.vendorHomeScreen);
    } else {
      Get.offAllNamed(AppRoutes.login);
    }
  }
}
