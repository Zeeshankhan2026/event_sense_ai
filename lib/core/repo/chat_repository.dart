import 'package:cloud_firestore/cloud_firestore.dart';

class ChatRepository {
  final FirebaseFirestore _db = FirebaseFirestore.instance;


  String buildRoomId({
    required String plannerId,
    required String vendorId,
    required String applicationId,
  }) {
    final a = plannerId.compareTo(vendorId) < 0 ? plannerId : vendorId;
    final b = plannerId.compareTo(vendorId) < 0 ? vendorId : plannerId;
    return "${a}_${b}_$applicationId";
  }


  Future<String> getOrCreateRoom({
    required String plannerId,
    required String vendorId,
    required String applicationId,
    required String vendorName,
    required String vendorProfileImage,
  }) async {
    final roomId = buildRoomId(
      plannerId: plannerId,
      vendorId: vendorId,
      applicationId: applicationId,
    );

    final roomRef = _db.collection("chatRoom").doc(roomId);

    await _db.runTransaction((tx) async {
      final snap = await tx.get(roomRef);
      if (!snap.exists) {
        tx.set(roomRef, {
          "roomId": roomId,
          "plannerId": plannerId,
          "vendorId": vendorId,
          "applicationId": applicationId,
          "participants": [plannerId, vendorId],
          "vendorName": vendorName,
          "vendorProfileImage": vendorProfileImage,
          "lastMessage": "",
          "lastMessageAt": FieldValue.serverTimestamp(),
          "lastMessageSenderId": "",
          "createdAt": FieldValue.serverTimestamp(),
        });
      }
    });

    return roomId;
  }

  Stream<QuerySnapshot<Map<String, dynamic>>> messagesStream(String roomId) {
    return _db
        .collection("chatRoom")
        .doc(roomId)
        .collection("messages")
        .orderBy("createdAt", descending: false)
        .snapshots();
  }

  Future<void> sendMessage({
    required String roomId,
    required String senderId,
    required String receiverId,
    required String text,
  }) async {
    final roomRef = _db.collection("chatRoom").doc(roomId);
    final msgRef = roomRef.collection("messages").doc();

    await _db.runTransaction((tx) async {
      tx.set(msgRef, {
        "senderId": senderId,
        "receiverId": receiverId,
        "text": text.trim(),
        "createdAt": FieldValue.serverTimestamp(),
      });

      tx.update(roomRef, {
        "lastMessage": text.trim(),
        "lastMessageAt": FieldValue.serverTimestamp(),
        "lastMessageSenderId": senderId,
      });
    });
  }
}
