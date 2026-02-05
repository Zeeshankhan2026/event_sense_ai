import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:event_sense_ai/core/repo/inviation_repo.dart';
import 'package:event_sense_ai/core/widgets/snackbar_widget.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';

import '../services/generate_ai_invitaioncard.dart';

class InvitationController extends GetxController {
  final isLoading = false.obs;
  final generatedImageUrl = "".obs;
  final guestLoading = false.obs;
  final InvitationCardDesign _service = InvitationCardDesign();



  Future<void> generateInvitation({
    required String eventName,
    required String hostName,
    required String location,
    required String date,
    required String time,
    required String style,
    required String rsvpLink,
  }) async {
    try {
      isLoading.value = true;

      final imageUrl = await _service.generateInvitationImage(
        eventName: eventName,
        hostName: hostName,
        location: location,
        date: date,
        time: time,
        style: style,
        rsvpLink: rsvpLink,
      );

      generatedImageUrl.value = imageUrl;
    } catch (e) {
      SafeSnackbar.error("Error", e.toString().replaceAll("Exception: ", ""),);
    } finally {
      isLoading.value = false;
    }
  }

  // Future getAllGuest() async {
  //
  //   try{
  //     isLoading.value = true;
  //      InvitationRepository().getAllGuestsStream(currentEventId);
  //   }
  //   catch (e){
  //
  //   }
  //   finally {
  //
  //   }
  // }
}
