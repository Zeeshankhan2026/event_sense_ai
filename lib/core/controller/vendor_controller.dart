import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:event_sense_ai/core/models/vendor_model.dart';
import 'package:event_sense_ai/core/repo/vendor_repository.dart';
import 'package:event_sense_ai/core/widgets/snackbar_widget.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:event_sense_ai/core/routes/app_routes.dart';

class VendorController extends GetxController {
  late TextEditingController _vendorCompanyNameC;
  late TextEditingController _vendorServiceCategoryC;
  late TextEditingController _vendorLocationC;
  late TextEditingController _vendorEmailC;
  late TextEditingController _vendorPasswordC;
  late TextEditingController _vendorPhoneC;
  late String _profileImage;
  RxBool isloading = false.obs;
  RxBool isGoogleLoading = false.obs;
  RxBool isDataLoading = false.obs;

  TextEditingController get vendorCompanyNameC => _vendorCompanyNameC;
  TextEditingController get vendorServiceCategoryC => _vendorServiceCategoryC;
  TextEditingController get vendorLocationC => _vendorLocationC;
  TextEditingController get vendorEmailC => _vendorEmailC;
  TextEditingController get vendorPasswordC => _vendorPasswordC;
  TextEditingController get vendorPhoneC => _vendorPhoneC;
  String get profileImage => _profileImage;
  Rx<VendorModel?> vendor = Rx<VendorModel?>(null);

  @override
  void onInit() {
    // TODO: implement onInit
    _vendorCompanyNameC = TextEditingController();
    _vendorServiceCategoryC = TextEditingController();
    _vendorLocationC = TextEditingController();
    _vendorEmailC = TextEditingController();
    _vendorPasswordC = TextEditingController();
    _vendorPhoneC = TextEditingController();
    _profileImage = "";
    fetchVendor();
    super.onInit();
  }

  Future<void> create_Vendor() async {
    try {
      isloading.value = true;
      VendorModel vendorModel = VendorModel(
        companyName: _vendorCompanyNameC.text.trim(),
        serviceCategory: _vendorServiceCategoryC.text.trim(),
        location: _vendorLocationC.text.trim(),
        email: _vendorEmailC.text.trim(),
        password: _vendorPasswordC.text.trim(),
        profileImage: "",
        phone: _vendorPhoneC.text.trim(),
      );

      await VendorRepository().createVendor(vendorModel);
      await Future.delayed(Duration(seconds: 2)); // Wait for snackbar
      await fetchVendor();
      Get.offAllNamed(AppRoutes.vendorPortfolio);
      clearAllVendorField();
    } catch (e) {
      SafeSnackbar.error("Error", e.toString());
      clearAllVendorField();
    } finally {
      isloading.value = false;
    }
  }

  Future<void> loginVendor() async {
    try {
      isloading.value = true;
      await VendorRepository().LoginVendorWithEmail(
        _vendorEmailC.text.trim(),
        _vendorPasswordC.text.trim(),
      );
      await Future.delayed(Duration(seconds: 2));
      await fetchVendor();
      clearVendorFields(); // optional
      Get.offAllNamed(AppRoutes.vendorHomeScreen);
    } catch (e) {
      SafeSnackbar.error("Error", e.toString());
      clearVendorFields(); // optional
    } finally {
      isloading.value = false;
    }
  }

  Future<void> logoutVendor() async {
    try {
      isloading.value = true;
      await VendorRepository().VendorLogout();
      Get.offAllNamed(AppRoutes.splash);
      clearAllVendorField();
    } catch (e) {
      SafeSnackbar.error("Error", e.toString());
      clearAllVendorField();
    } finally {
      isloading.value = false;
    }
  }

  Future<void> createVendorWithGoogle() async {
    try {
      isGoogleLoading.value = true;
      await VendorRepository().createVendorGoogle();
      await fetchVendor();
      clearAllVendorField();
      Get.offAllNamed(AppRoutes.vendorHomeScreen);
    } catch (e) {
      SafeSnackbar.error("Error", e.toString());
    } finally {
      isGoogleLoading.value = false;
    }
  }

  Future<void> fetchVendor() async {
    final auth = FirebaseAuth.instance;
    if (auth.currentUser == null) return;

    try {
      // isDataLoading.value  = true;
      final data = await VendorRepository().getVendorProfile(
        auth.currentUser!.uid,
      );
      vendor.value = data;

      if (data != null) {
        _vendorCompanyNameC.text = data.companyName ?? "";
        _vendorServiceCategoryC.text = data.serviceCategory ?? "";
        _vendorLocationC.text = data.location ?? "";
        _vendorEmailC.text = data.email ?? "";
        // _vendorPasswordC.text = data.password ?? ""; // Usually don't populate password back
        _vendorPhoneC.text = data.phone ?? "";
        _profileImage = data.profileImage ?? "";
      }
    } catch (e) {
      if (!e.toString().contains("User not found")) {
        SafeSnackbar.error("error", e.toString());
      }
    }
  }

  Future<void> updateVendor() async {
    try {
      isloading.value = true;
      final auth = FirebaseAuth.instance;
      await VendorRepository().updateVendor(
        name: _vendorCompanyNameC.text,
        category: _vendorServiceCategoryC.text,
        location: _vendorLocationC.text,
        phone: _vendorPhoneC.text,
        userId: auth.currentUser!.uid,
      );
      SafeSnackbar.success("Success", "changes save successfully");
      Future.delayed(Duration(seconds: 2));
      Get.back();

      // Optimistic Update: Update local state immediately
      if (vendor.value != null) {
        vendor.value = VendorModel(
          companyName: _vendorCompanyNameC.text,
          serviceCategory: _vendorServiceCategoryC.text,
          location: _vendorLocationC.text,
          phone: _vendorPhoneC.text,
          email: vendor.value!.email,
          password: vendor.value!.password,
          profileImage: vendor.value!.profileImage,
          vendor_uid: vendor.value!.vendor_uid,
        );
      }

      await fetchVendor();
    } catch (e) {
      SafeSnackbar.error("error", e.toString());
    } finally {
      isloading.value = false;
    }
  }

  @override
  void onClose() {
    _vendorPhoneC.dispose();
    _vendorPasswordC.dispose();
    _vendorEmailC.dispose();
    _vendorLocationC.dispose();
    _vendorServiceCategoryC.dispose();
    _vendorCompanyNameC.dispose();
    super.onClose();
  }


  void clearVendorFields() {
    _vendorEmailC.clear();
    _vendorPasswordC.clear();
  }

  void clearAllVendorField() {
    _vendorPasswordC.clear();
    _vendorEmailC.clear();
    _vendorLocationC.clear();
    _vendorCompanyNameC.clear();
    _vendorPhoneC.clear();
  }
}
