import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:event_sense_ai/core/models/event_day_status_model.dart';

import '../models/event_category_model.dart';
import '../models/jobs_model.dart';

class VendorJobRepository {
  final FirebaseFirestore firestore = FirebaseFirestore.instance;
  late String JobId;
  /// Planner → post job
  /// Planner → post / update job
  Future<void> postJob({
    required EventCategoryModel category,
    required String plannerId,
    required String city,
  }) async {

    ///  unique job id (same category = same job)
    JobId = _generateJobId(category.eventId, category.categoryId);

    final doc = firestore.collection("vendor_jobs").doc(JobId);

    await doc.set(
      {
        "jobId": JobId,
        "eventId": category.eventId,
        "categoryId": category.categoryId.trim().toLowerCase(),
        "guests" : category.guests,
        "plannerId": plannerId,
        "title": category.title,
        "budget": category.recommendedBudget,
        "city": city.trim().toLowerCase(),
        "status": category.status!.name,
        "jobDescription": category.jobDescription,
        "jobInstructions": category.jobInstructions,
        "eventDate" : category.eventDate,
        "eventType" : category.eventType,
        "updatedAt": Timestamp.now(),
      },
      SetOptions(merge: true), // important
    );

    /// Update category status in blueprint
    try {
      final blueprintRef = firestore
          .collection('events')
          .doc(plannerId)
          .collection('currentUserEvents')
          .doc(category.eventId)
          .collection('blueprint')
          .doc('data');

      final blueprintSnapshot = await blueprintRef.get();
      if (blueprintSnapshot.exists) {
        final data = blueprintSnapshot.data()!;
        List<dynamic> categories = data['categories'] ?? [];

        final updatedCategories = categories.map((cat) {
          final String catName = cat['name']?.toString() ?? "";
          // Match by name - either exact or starts with (to handle truncated names from UI)
          if (catName == category.categoryId || 
              catName.toLowerCase().startsWith(category.categoryId.toLowerCase()) ||
              category.categoryId.toLowerCase().startsWith(catName.toLowerCase())) { 
            return {
              ...cat,
              'status': 'posted', // Mark as posted
              'estimated_budget': category.recommendedBudget, // Sync budget
              'jobDescription': category.jobDescription,
              'jobInstructions': category.jobInstructions,
            };
          }
          return cat;
        }).toList();

        await blueprintRef.update({'categories': updatedCategories});
      }
    } catch (e) {
      print("Error updating blueprint status: $e");
    }
  }


  /// Vendor → fetch jobs
  Stream<QuerySnapshot<Map<String, dynamic>>>  fetchJobsForVendor(
      String categoryId, String city) {

   return firestore
       .collection("vendor_jobs")
       // The category status is "posted", so we should query for that.
       // Also ensure city is lowercase as it is saved in lowercase.
       .where("categoryId", isEqualTo: categoryId.trim().toLowerCase())
       .where("city", isEqualTo: city.trim().toLowerCase())
       .where("status", isEqualTo: "posted") 
       .snapshots();

  }

  /// Vendor → apply
  Future<void> applyForJob({
    required VendorJobModel job,
    required String vendorId,
    required int quotedPrice,
  }) async {
    await firestore.collection("vendor_applications").add({
      "eventId": job.eventId,
      "categoryId": job.categoryId,
      "plannerId": job.plannerId,
      "vendorId": vendorId,
      "quotedPrice": quotedPrice,
      "status": "applied",
      "createdAt": Timestamp.now(),
    });

    /// update category status
    // Sanitize categoryId to avoid slashes in document path
    final sanitizedCatId = job.categoryId.trim().toLowerCase().replaceAll("/", "_");

    await firestore
        .collection("event_categories")
        .doc(job.eventId)
        .collection("categories")
        .doc(sanitizedCatId)
        .update({"status": "applied"});
  }

  Future<DocumentSnapshot<Map<String, dynamic>>> getJobByCategory({
    required String eventId,
    required String categoryId,
  }) async {
    final jobId = _generateJobId(eventId, categoryId);

    return await FirebaseFirestore.instance
        .collection("vendor_jobs")
        .doc(jobId)
        .get();
  }
Future<String?> fetchCategoryStatus() async {
  try{
    final docs =  await FirebaseFirestore.instance.collection("vendor_jobs").doc(JobId).get();

    if(!docs.exists) return null;
    return docs.data()?["status"] as String;
  }
  catch(e){
    rethrow;
  }
}
  String _generateJobId(String eventId, String categoryId) {
    // Sanitize categoryId to avoid slashes which cause Firestore "even number of segments" error
    final sanitizedCatId = categoryId.trim().toLowerCase().replaceAll("/", "_");
    return "${eventId}_$sanitizedCatId";
  }

  ////========= Load accepted applications =================
  Stream<QuerySnapshot> loadAcceptedApplication(
      String vendorId,
      String status,
      ) {
    return  FirebaseFirestore.instance
        .collection("vendor_jobs")
        .where("vendorId", isEqualTo: vendorId)
        .where("status", isEqualTo: status)
        .snapshots();
  }

  Future<void> EventDayStatus(EventDayStatusModel eventDayStatusModel) async {
    // Create a unique document ID based on plannerId and vendorName
    // This ensures the same document is updated instead of creating new ones
    final docId = "${eventDayStatusModel.plannerId}_${eventDayStatusModel.vendorName.replaceAll(' ', '_')}";
    
    final docRef = firestore.collection("event_day_progress").doc(docId);
    
    // Use SetOptions(merge: true) to update existing document or create if doesn't exist
    await docRef.set(
      {
        ...eventDayStatusModel.toJson(),
        "updatedAt": Timestamp.now(), // Track when status was last updated
        "createdAt": FieldValue.serverTimestamp(), // Track when entry was first created
      },
      SetOptions(merge: true),
    );
  }
}
