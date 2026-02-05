import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:event_sense_ai/core/models/event_day_status_model.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import '../models/jobs_model.dart';
import '../repo/vendor_job_repository.dart';

class VendorJobController extends GetxController {
  final VendorJobRepository repo = VendorJobRepository();
  RxList<VendorJobModel> jobs = <VendorJobModel>[].obs;
  final currentVendorId = FirebaseAuth.instance.currentUser!.uid;
  RxBool isStatusLaoding = false.obs;
  Stream<QuerySnapshot<Map<String, dynamic>>> loadJobs(
    String categoryId,
    String city,
  ) {
    return repo.fetchJobsForVendor(categoryId, city);
  }

  Future<void> apply({
    required VendorJobModel job,
    required String vendorId,
    required int price,
  }) async {
    await repo.applyForJob(job: job, vendorId: vendorId, quotedPrice: price);

    Get.back();
    Get.snackbar("Applied", "Application submitted");
  }

  ////========= Load accepted applications =================

  Stream<QuerySnapshot> fetchAcceptedApplication() {
    return repo.loadAcceptedApplication(currentVendorId, "closed");
  }

  Future<void> updateEventDayProgress(
    String vendorName,
    String eventName,
    String eventLocation,
    String plannerId,
    String statusUpdate,
    String title,
    String eventDate,
  ) async {
    try {
      isStatusLaoding.value = true;
      await repo.EventDayStatus(
        EventDayStatusModel(
          title: title,
          eventLocation: eventLocation,
          eventDate: eventDate,
          plannerId: plannerId,
          statusUpdate: statusUpdate,
          vendorName: vendorName,
        ),
      );
    } catch (e) {
      Get.snackbar("error", e.toString());
    } finally {
      isStatusLaoding.value = false;
    }
  }
}
