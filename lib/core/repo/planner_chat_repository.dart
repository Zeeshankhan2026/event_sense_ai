import 'package:cloud_firestore/cloud_firestore.dart';

class PlannerChatRepository {
  final FirebaseFirestore _db = FirebaseFirestore.instance;

  ///  SEND message (planner → vendor)
  Future<void> sendPlannerMessage({
    required String applicationId,
    required String plannerId,
    required String vendorId,
    required String message,
  }) async {
    final chatRef = _db.collection("chats").doc(applicationId);

    /// ensure chat document exists
    await chatRef.set({
      "applicationId": applicationId,
      "plannerId": plannerId,
      "vendorId": vendorId,
      "lastMessage": message,
      "lastMessageAt": Timestamp.now(),
    }, SetOptions(merge: true));

    /// add message
    await chatRef.collection("messages").add({
      "senderId": plannerId,
      "message": message,
      "createdAt": Timestamp.now(),
    });
  }

  ///  FETCH messages (realtime)
  Stream<QuerySnapshot> fetchMessages(String applicationId) {
    return _db
        .collection("chats")
        .doc(applicationId)
        .collection("messages")
        .orderBy("createdAt", descending: false)
        .snapshots();
  }
}
