import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:event_sense_ai/core/models/guest_model.dart';
import 'package:firebase_auth/firebase_auth.dart';

class GuestRepository {
  final auth = FirebaseAuth.instance;
  final firestore = FirebaseFirestore.instance;

  Future<bool> isGuestAlreadyAdded(String phoneNumber, String eventId) async {
    try {
      final querySnapshot = await firestore
          .collection("events")
          .doc(auth.currentUser!.uid)
          .collection("currentUserEvents")
          .doc(eventId)
          .collection("Guests")
          .where("guestPhone", isEqualTo: phoneNumber)
          .get();

      return querySnapshot.docs.isNotEmpty;
    } catch (e) {
      print(e.toString());
      return false;
    }
  }

  Future<void> AddGuest(GuestModel guestModel, String eventId) async {
    try {
      await firestore
          .collection("events")
          .doc(auth.currentUser!.uid)
          .collection("currentUserEvents")
          .doc(eventId)
          .collection("Guests")
          .add(guestModel.toJson());
    } catch (e) {
      print(e.toString());
      rethrow; // we used rethrow to just catch the error and send that to ui
    }
  }

  Stream<QuerySnapshot<Map<String, dynamic>>> getAllGuestsStream(String currentEventId) {
    if (currentEventId.isEmpty) {
      throw Exception("Event ID not set");
    }

    return firestore
        .collection("events")
        .doc(auth.currentUser!.uid)
        .collection("currentUserEvents")
        .doc(currentEventId)
        .collection("Guests")
        .snapshots();
  }


}
