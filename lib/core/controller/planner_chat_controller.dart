import 'package:get/get.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import '../repo/planner_chat_repository.dart';

class PlannerChatController extends GetxController {
  final PlannerChatRepository _repo = PlannerChatRepository();

  final TextEditingController messageController = TextEditingController();
  RxList messages = [].obs;

  late String applicationId;
  late String vendorId;
  late String plannerId;

  @override
  void onInit() {
    super.onInit();

    final args = Get.arguments;

    applicationId = args["applicationId"];
    vendorId = args["vendorId"];
    plannerId = FirebaseAuth.instance.currentUser!.uid;

    listenMessages();
  }

  void listenMessages() {
    _repo.fetchMessages(applicationId).listen((snapshot) {
      messages.value = snapshot.docs;
    });
  }

  Future<void> sendMessage() async {
    final text = messageController.text.trim();
    if (text.isEmpty) return;

    await _repo.sendPlannerMessage(
      applicationId: applicationId,
      plannerId: plannerId,
      vendorId: vendorId,
      message: text,
    );

    messageController.clear();
  }
}
