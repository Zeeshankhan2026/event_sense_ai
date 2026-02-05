import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class InvitationRepository {

  final auth = FirebaseAuth.instance;
  final firestore = FirebaseFirestore.instance;

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