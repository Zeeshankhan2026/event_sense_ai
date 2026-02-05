import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:event_sense_ai/core/enums/status_enum.dart';
import 'package:event_sense_ai/core/models/guest_model.dart';
import 'package:event_sense_ai/core/repo/guest_repository.dart';
import 'package:event_sense_ai/core/widgets/snackbar_widget.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

class GuestController extends GetxController {
  late TextEditingController _guestName;
  late TextEditingController _guestEmail;
  late TextEditingController _guestPhone;
   final RxString _guestCategory = "family".obs;
  late RxBool bringPartner = false.obs;
  late String _status;
  //this is eventId by which we fetch and add guest to the specific events
  final RxString currentEventId = "".obs;
  final RxString guestId = "".obs;

  TextEditingController get guestName => _guestName;
  TextEditingController get guestEmail => _guestEmail;
  TextEditingController get guestPhone => _guestPhone;
  RxString get guestCategory => _guestCategory;
  String get status => _status;
  late RxBool isLoading = false.obs;

  void setEventId(String event_Id) {
    currentEventId.value = event_Id;
  }
  void setGuestId(String guest_id){
    guestId.value = guest_id;
  }
  @override
  void onInit() {
    // TODO: implement onInit
    _guestName = TextEditingController();
    _guestPhone = TextEditingController();
    _guestEmail = TextEditingController();
    super.onInit();
  }

  Future<void> AddGuest() async {
    GuestModel guestModel = GuestModel(
      guestName: guestName.text,
      guestEmail: guestEmail.text,
      guestPhone: guestPhone.text,
      guestCategory: guestCategory.value,
      bringPartner: bringPartner.value,
      eventId: currentEventId.value,
      guestId: DateTime.now().millisecondsSinceEpoch.toString(),
      status: GuestStatus.pending,
    );
    try {
      isLoading.value = true;
      bool isAdded = await GuestRepository()
          .isGuestAlreadyAdded(guestPhone.text, currentEventId.value);
      if (isAdded) {
        SafeSnackbar.info(
          "Already Added",
          "This guest is already added to the event",
        );
        return;
      }

      await GuestRepository().AddGuest(guestModel, currentEventId.value);

      clearAllFields();
      SafeSnackbar.success(
        "Success",
        "Guest added successfully",
      );

    } catch (e) {
    
      SafeSnackbar.error("error", e.toString());
    }
    finally {
      isLoading.value = false;
    }
  }

  Stream<QuerySnapshot<Map<String, dynamic>>> FetchGuest() {
    try {
      return GuestRepository().getAllGuestsStream(currentEventId.value);
    } catch (e) {
      SafeSnackbar.error("error", e.toString());
      return const Stream.empty();
    }
  }
  void clearAllFields() {
    guestName.clear();
    guestEmail.clear();
    guestPhone.clear();
    bringPartner.value = false;
    guestCategory.value = "family";
  }
}
