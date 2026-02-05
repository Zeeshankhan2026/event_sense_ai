import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:event_sense_ai/core/models/jobs_model.dart';
import 'package:event_sense_ai/core/models/users_model.dart';
import 'package:event_sense_ai/core/repo/user_repository.dart';
import 'package:event_sense_ai/core/repo/vendor_job_repository.dart';
import 'package:event_sense_ai/core/routes/app_routes.dart';
import 'package:event_sense_ai/core/widgets/snackbar_widget.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class UserController extends GetxController {
  late TextEditingController signUpEmailC;
  late TextEditingController signUpNameC;
  late TextEditingController signUpPasswordC;
  late TextEditingController signUpConfirmPasswordC;
  late TextEditingController LocationC;



  ///user add post
  late TextEditingController jobDescriptionsC;
  late TextEditingController specialInsC;
  String eventName = "";
  int  eventBudget = 0;
  String eventBannerImage = "";
  String eventLocation = "";
  String eventStartDate = "";
  String eventCategory = "";
  String status = "";



  RxBool isLoading = false.obs;
  RxBool isGoogleLoading = false.obs;
  RxBool isUserDataLoading = false.obs;
  RxBool isAddingPostLoading = false.obs;
  Rx<UserModel?> user = Rx<UserModel?>(null);

  final UserRepository repo = UserRepository();

  @override
  void onInit() {
    signUpEmailC = TextEditingController();
    signUpNameC = TextEditingController();
    signUpPasswordC = TextEditingController();
    signUpConfirmPasswordC = TextEditingController();
    jobDescriptionsC = TextEditingController();
    specialInsC = TextEditingController();

    fetchUser();
    super.onInit();
  }

  // ================= SIGN UP =================
  Future<void> signUpUser() async {
    try {
      isLoading.value = true;

      final userModel = UserModel(
        name: signUpNameC.text.trim(),
        email: signUpEmailC.text.trim(),
        password: signUpPasswordC.text.trim(),
        confirmPassword: signUpConfirmPasswordC.text.trim(),
        profileImage: '',
      );

      await repo.createUserWithEmail(userModel);

      await Future.delayed(const Duration(seconds: 2));

      Get.offAllNamed(AppRoutes.userSetLocation);
      clearAllFields();
      fetchUser();
    } catch (e) {
      SafeSnackbar.error("Error", e.toString());
      clearAllFields();
    } finally {
      isLoading.value = false;
    }
  }

  // ================= LOGIN =================
  Future<void> logInUser() async {
    try {
      isLoading.value = true;

      await repo.loginUserWithEmail(
        signUpEmailC.text.trim(),
        signUpPasswordC.text.trim(),
      );

      SafeSnackbar.success(
        "Success",
        "Logged in successfully",
      );

      await Future.delayed(const Duration(seconds: 2));
      Get.offAllNamed(AppRoutes.main);
      clearAllFields();
      fetchUser();
    } on FirebaseAuthException catch (e) {
      SafeSnackbar.error(
        "Login Failed",
        e.toString(),
      );
    } catch (e) {
      SafeSnackbar.error(
        "Error",
        e.toString(),
      );
    } finally {
      isLoading.value = false;
    }
  }

  // ================= GOOGLE SIGN IN =================
  Future<void> createUserWithGoogle() async {
    try {
      isGoogleLoading.value = true;

      await repo.createUserGoogle();
      fetchUser();

      await Future.delayed(const Duration(seconds: 2));

      Get.offAllNamed(AppRoutes.main);
      signUpEmailC.clear();
      signUpPasswordC.clear();
    } catch (e) {
      SafeSnackbar.error("Error", e.toString());
    } finally {
      isGoogleLoading.value = false;
    }
  }

///================get user profile ==============//
  Future<void> fetchUserProfile() async {
    try{
      isLoading.value = true;
      final auth = FirebaseAuth.instance.currentUser!.uid;
      await UserRepository().getUserProfile(auth);
    }
    catch (e){
      SafeSnackbar.error("alert", e.toString());
    }
    finally{
      isLoading.value = false;
    }
  }

  //=============update user =======================
  Future<void> updateUserProfile({required String name, required String email, required String location}) async
  { try {
    isUserDataLoading.value = true;
    final uid = FirebaseAuth.instance.currentUser!.uid;
    await FirebaseFirestore.instance.collection('users').doc(uid).update(
        { 'name': name, "email" : email, "userLocations" : location});
    user.value = user.value!.copyWith( name: name, email: email, userLocations: location );
    fetchUser();
    Get.back();
  } catch (e) {
    SafeSnackbar.error("Error", e.toString());
  } finally {
    isUserDataLoading.value = false;
  }
  }

    // ================= FETCH USER =================
    Future<void> fetchUser() async {
      try {
        isUserDataLoading.value = true;

        final uid = FirebaseAuth.instance.currentUser?.uid;
        if (uid == null) return;

        user.value = await repo.getUserProfile(uid);
      } catch (e) {
        // Silently handle if user profile not found (might be a vendor or first-time user)
        debugPrint("Fetch user error: $e");
      } finally {
        isUserDataLoading.value = false;
      }
    }

    // ================= LOGOUT =================
    Future<void> logOutUser() async {
      try {
        isLoading.value = true;

        await repo.logOutUser();

        clearAllFields();
        signUpEmailC.clear();
        Get.offAllNamed(AppRoutes.splash);

      } catch (e) {
        SafeSnackbar.error("Error", e.toString());

      } finally {
        isLoading.value = false;
      }
    }




    void clearAllFields(){
      signUpEmailC.clear();
      signUpNameC.clear();
      signUpPasswordC.clear();
      signUpConfirmPasswordC.clear();
    }
    @override
    void onClose() {
      signUpEmailC.dispose();
      signUpNameC.dispose();
      signUpPasswordC.dispose();
      signUpConfirmPasswordC.dispose();
      super.onClose();
    }


  }

