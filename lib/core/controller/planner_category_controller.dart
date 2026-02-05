import 'package:get/get.dart';

import '../models/event_category_model.dart';
import 'package:flutter/material.dart';

import '../repo/vendor_job_repository.dart';
class PlannerCategoryController extends GetxController {
  final VendorJobRepository repo = VendorJobRepository();

  final TextEditingController jobDescriptionC = TextEditingController();
  final TextEditingController specialInsC = TextEditingController();
  RxDouble selectedBudget = 0.0.obs;

  RxString buttonText = "Post Job".obs;
  RxBool isLoading = false.obs;

  ///  Call when category screen opens
  Future<void> loadCategoryJob(String eventId, String categoryId) async {
    final doc = await repo.getJobByCategory(
      eventId: eventId,
      categoryId: categoryId,
    );

    if (doc.exists) {
      final data = doc.data()!;
      buttonText.value = "Update";

      jobDescriptionC.text = data["jobDescription"] ?? data["job_descriptions"] ?? "";
      specialInsC.text = data["jobInstructions"] ?? data["SpecialIns"] ?? "";

      selectedBudget.value = (data["budget"] ?? 0).toDouble();
    } else {
      buttonText.value = "Post Job";
      jobDescriptionC.clear();
      specialInsC.clear();
      selectedBudget.value = 0.0;
    }
  }

  ///  Post / Update Job
  Future<void> postCategoryAsJob({
    required EventCategoryModel category,
    required String plannerId,
    required String city,
  }) async {
    try {
      isLoading.value = true;

      await repo.postJob(
        category: category.copyWith(
          jobDescription: jobDescriptionC.text,
          jobInstructions: specialInsC.text,
        ),
        plannerId: plannerId,
        city: city,
      );

      /// Clear for next category
      jobDescriptionC.clear();
      specialInsC.clear();
      buttonText.value = "Post Job";

      ///  Navigate after success
      Get.back();

      Get.snackbar("Success", "Job posted successfully");
    } catch (e) {
      Get.snackbar("Error", e.toString());
    } finally {
      isLoading.value = false;
    }
  }

}
