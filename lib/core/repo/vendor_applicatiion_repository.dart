import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import '../models/jobs_model.dart';

class VendorApplicationRepository {
  final FirebaseFirestore firestore = FirebaseFirestore.instance;

  ////========= vendor submit applications =================
  Future<void> vendorSubmitApplication({
    required String vendorId,
    required String jobId,
    required double quotedPrice,
    required String setupTime,
    required String proposalMessage,
    required VendorJobModel jobDetails,
    String? vendorName,
    String? vendorProfileImage,
  }) async {
    try {
      // Prevent duplicate
      final existing = await firestore
          .collection("vendor_applications")
          .where("vendorId", isEqualTo: vendorId)
          .where("jobId", isEqualTo: jobId)
          .limit(1)
          .get();

      if (existing.docs.isNotEmpty) {
        throw "You have already applied for this job.";
      }

      // Generate docId ONCE
      final docRef = firestore.collection("vendor_applications").doc();

      await docRef.set({
        "applicationId": docRef.id, //  VERY IMPORTANT
        "vendorId": vendorId,
        "vendorName": vendorName,
        "vendorProfileImage": vendorProfileImage,
        "jobId": jobId,
        "quotedPrice": quotedPrice,
        "setupTime": setupTime,
        "eventName" : jobDetails.title,
        "eventLocation" : jobDetails.city,
        "eventDate" : jobDetails.eventDate,
        "proposalMessage": proposalMessage,
        "eventId": jobDetails.eventId,
        "categoryId": jobDetails.categoryId,
        "plannerId": jobDetails.plannerId,
        "status": "pending",
        "guest": jobDetails.guest,
        "eventImage" : jobDetails.eventImage,
        "createdAt": Timestamp.now(),
      });

      // Blueprint update (unchanged)
      final blueprintRef = firestore
          .collection('events')
          .doc(jobDetails.plannerId)
          .collection('currentUserEvents')
          .doc(jobDetails.eventId)
          .collection('blueprint')
          .doc('data');

      final snapshot = await blueprintRef.get();
      if (!snapshot.exists) throw "Blueprint not found";

      final categories = List<Map<String, dynamic>>.from(
        snapshot.data()!['categories'] ?? [],
      );

      final updatedCategories = categories.map((cat) {
        final catName = (cat['name'] ?? "").toString().toLowerCase();
        final target = jobDetails.categoryId.toLowerCase();

        if (catName == target ||
            catName.startsWith(target) ||
            target.startsWith(catName)) {
          return {...cat, "status": "application"};
        }
        return cat;
      }).toList();

      await blueprintRef.update({"categories": updatedCategories});
    } catch (e) {
      rethrow;
    }
  }

  ////========= fetch category applications =================
  Stream<QuerySnapshot<Map<String, dynamic>>> fetchCategoryApplications({
    required String plannerId,
    required String eventId,
    required String categoryId,
  }) {
    return FirebaseFirestore.instance
        .collection("vendor_applications")
        .where("plannerId", isEqualTo: plannerId)
        .where("eventId", isEqualTo: eventId)
        .where("categoryId", isEqualTo: categoryId)
        .snapshots();
  }

  ////========= Load accepted applications status =================
  Future<void> AcceptApplicationStatus({
    required String applicationId,
    required String status, // "accepted" | "rejected"
    String? plannerId,
    String? eventId,
    String? categoryId,
  }) async {
    try {
      await firestore
          .collection("vendor_applications")
          .doc(applicationId)
          .update({"status": status, "decisionAt": Timestamp.now()});

      if (status == "accepted" &&
          plannerId != null &&
          eventId != null &&
          categoryId != null) {
        final blueprintRef = firestore
            .collection('events')
            .doc(plannerId)
            .collection('currentUserEvents')
            .doc(eventId)
            .collection('blueprint')
            .doc('data');

        final snapshot = await blueprintRef.get();
        if (snapshot.exists) {
          final categories = List<Map<String, dynamic>>.from(
            snapshot.data()!['categories'] ?? [],
          );

          final updatedCategories = categories.map((cat) {
            final catName = (cat['name'] ?? "").toString().toLowerCase();
            final target = categoryId.toLowerCase();

            if (catName == target ||
                catName.startsWith(target) ||
                target.startsWith(catName)) {
              return {...cat, "status": "booked"};
            }
            return cat;
          }).toList();

          await blueprintRef.update({"categories": updatedCategories});
        }
        await AwesomeNotifications().createNotification(
          content: NotificationContent(
            id: DateTime.now().millisecondsSinceEpoch.remainder(100000),
            channelKey: 'application_status',
            title: "Application accepted",
            body: "Your application has been accepted",
            payload: {
              "applicationId": applicationId,
              "eventId": eventId,
            },
          ),
        );
      }
    } catch (e) {
      rethrow;
    }
  }


}
