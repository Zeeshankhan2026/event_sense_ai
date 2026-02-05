import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:event_sense_ai/core/models/event_model.dart';
import 'package:firebase_auth/firebase_auth.dart';

class EventRepository {

  final firestore = FirebaseFirestore.instance;
  final auth = FirebaseAuth.instance;


  Future<String> createEvent(EventModel eventModel) async {
    try{
  final doc_ref =   await firestore.collection("events").doc(auth.currentUser!.uid)
      .collection("currentUserEvents").add({
        ...eventModel.ToJson(),
        "createdAt": FieldValue.serverTimestamp(),
      });
        final docId = doc_ref.id;
        return  docId;
    }
    catch (e){
      rethrow;

    }
  }

  Future<List<EventModel>> fetchEvents() async {
    try {
      final snapshot = await firestore
          .collection("events")
          .doc(auth.currentUser!.uid)
          .collection("currentUserEvents")
          .get();

      return snapshot.docs.map((doc) => EventModel.fromJson(doc.data(), doc.id)).toList();

    } catch (e) {
      print("Fetch events error: $e");
      rethrow;
    }
  }

  Stream<QuerySnapshot<Map<String, dynamic>>> getAllEventsStream() {
    return firestore
        .collection("events")
        .doc(auth.currentUser!.uid)
        .collection("currentUserEvents")
        .orderBy("createdAt", descending: true)
        .snapshots();
  }
}