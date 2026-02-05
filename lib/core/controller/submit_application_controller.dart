import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:event_sense_ai/core/controller/vendor_controller.dart';
import 'package:event_sense_ai/core/repo/vendor_applicatiion_repository.dart';
import 'package:event_sense_ai/core/widgets/snackbar_widget.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import '../models/jobs_model.dart';


class SubmitApplicationController extends GetxController {
  late VendorJobModel job;
  RxBool isLoading = false.obs;
  final customQuote = TextEditingController(text: "0.00");
  final proposalMessage = TextEditingController();
  RxString estimatedTimeSetup = "1 hour".obs;
  final repo = VendorApplicationRepository();

  late Stream<QuerySnapshot<Map<String, dynamic>>> applicationsStream;
  @override
  void onInit() {
    super.onInit();

    // Initialize stream with an empty one to prevent LateInitializationError
    applicationsStream = const Stream.empty();

    if (Get.arguments is VendorJobModel) {
      job = Get.arguments as VendorJobModel;
    } else if (Get.arguments is Map) {
      final args = Get.arguments as Map;
      final eventId = args['eventId']?.toString() ?? "";
      final category = args['category']?.toString() ?? "";
      final plannerId = FirebaseAuth.instance.currentUser?.uid ?? "";

      loadApplications(
        plannerId: plannerId,
        eventId: eventId,
        categoryId: category,
      );
    }
  }

  ///===============submit applications=================
  Future<void> submitApplication() async {
    final vendorController = Get.find<VendorController>();
    // Try to get ID from model, but fallback to FirebaseAuth for robustness
    final vendorId =
        vendorController.vendor.value?.vendor_uid ??
        FirebaseAuth.instance.currentUser?.uid;

    if (vendorId == null) {
      SafeSnackbar.error("Error", "User not logged in or profile not loaded");
      return;
    }

    if (customQuote.text.trim().isEmpty ||
        double.tryParse(customQuote.text.replaceAll("\$", "").trim()) == null) {
      SafeSnackbar.error("Error", "Please enter a valid numeric quote");
      return;
    }

    if (proposalMessage.text.trim().isEmpty) {
      SafeSnackbar.error("Error", "Please enter a proposal message");
      return;
    }

    try {
      isLoading.value = true;
      double quote = double.parse(customQuote.text.replaceAll("\$", "").trim());

      await repo.vendorSubmitApplication(
        vendorId: vendorId,
        jobId: job.jobId, // Use the correct ID from the model
        quotedPrice: quote,
        setupTime: estimatedTimeSetup.value,
        proposalMessage: proposalMessage.text.trim(),
        jobDetails: job,
        vendorName: vendorController.vendor.value?.companyName,
        vendorProfileImage: vendorController.vendor.value?.profileImage,
      );

      SafeSnackbar.success("Success", "Application submitted successfully!");
      Get.back(); // Go back after success
    } catch (e) {
      SafeSnackbar.error("Error", "Failed to submit application: $e");
    } finally {
      isLoading.value = false;
    }
  }

  void loadApplications({
    required String plannerId,
    required String eventId,
    required String categoryId,
  }) {
    applicationsStream = repo.fetchCategoryApplications(
      plannerId: plannerId,
      eventId: eventId,
      categoryId: categoryId.trim().toLowerCase(),
    );
  }

  ////=========  accepted applications =================
  Future<void> AcceptApplication({
    required String applicationId,
    required String status,
    required String plannerId,
    required String eventId,
    required String categoryId,
    required String vendorId,
    String? jobId,
  }) async {
    try {
      isLoading.value = true;
      await repo.AcceptApplicationStatus(
        applicationId: applicationId,
        status: status,
        plannerId: plannerId,
        eventId: eventId,
        categoryId: categoryId,
      );

      final targetJobId = jobId ?? (Get.arguments is VendorJobModel
              ? (Get.arguments as VendorJobModel).jobId
              : null);

      if (targetJobId != null) {
        await FirebaseFirestore.instance.collection("vendor_jobs").doc(targetJobId).set({"status": "closed",
          "vendorId" : vendorId}, SetOptions(merge: true));
      }

      Get.snackbar("Accepted", "Application has been accepted");
    } catch (e) {
      Get.snackbar("error", e.toString());
    } finally {
      isLoading.value = false;
    }
  }

  ////=========  reject applications =================
  Future<void> rejectApplication(String applicationId, String status) async {
    try {
      isLoading.value = true;
      await repo.AcceptApplicationStatus(
        applicationId: applicationId,
        status: status,
      );
      Get.snackbar("Rejected", "Application has been rejected");
    } catch (e) {
      Get.snackbar("error", e.toString());
    } finally {
      isLoading.value = false;
    }
  }

///==========notification triggered =============////


}
