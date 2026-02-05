import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:event_sense_ai/core/models/event_model.dart';
import 'package:event_sense_ai/core/repo/event_repository.dart';
import 'package:event_sense_ai/core/routes/app_routes.dart';
import 'package:event_sense_ai/core/services/generate_ai_blueprint.dart';
import 'package:event_sense_ai/core/widgets/snackbar_widget.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

import '../models/blueprint_model.dart';
import '../models/budget_category.dart';

class EventController extends GetxController {
  late TextEditingController _eventNameController;
  late TextEditingController _eventDescriptionController;
  late TextEditingController _locationController;
  late TextEditingController _guestContrller;
  late TextEditingController _maxBudgetController;

  final _eventType = "".obs;
  final _startDate = "".obs;
  final _endDate = "".obs;
  final _eventBudget = 1000.0.obs;
  final _maxBudget = 10000.0.obs;
  late String _eventBannerImage;
  final _isLoading = false.obs;
  final _currentEventId = "".obs;


  final RxList<BudgetCategory> categories = <BudgetCategory>[].obs;
  final RxDouble totalBudget = 0.0.obs;

  final firestore = FirebaseFirestore.instance;
  final auth = FirebaseAuth.instance;

  String get currentEventId => _currentEventId.value;
  set currentEventId(String value) => _currentEventId.value = value;

  void setEventId(String event_Id) {
    currentEventId = event_Id;
  }

  // ---------------- GETTERS ----------------

  TextEditingController get eventNameController => _eventNameController;
  TextEditingController get eventDescriptionController => _eventDescriptionController;
  TextEditingController get locationController => _locationController;
  TextEditingController get guestController => _guestContrller;
  TextEditingController get maxBudgetController => _maxBudgetController;

  RxBool get isLoading => _isLoading;

  String get eventType => _eventType.value;
  set eventType(String value) => _eventType.value = value;

  String get startDate => _startDate.value;
  set startDate(String value) => _startDate.value = value;

  String get endDate => _endDate.value;
  set endDate(String value) => _endDate.value = value;

  RxDouble get eventBudget => _eventBudget;
  RxDouble get maxBudget => _maxBudget;

  // ---------------- INIT ----------------

  @override
  void onInit() {
    _eventNameController = TextEditingController();
    _guestContrller = TextEditingController();
    _locationController = TextEditingController();
    _eventDescriptionController = TextEditingController();
    _maxBudgetController = TextEditingController(text: "10000");
    _eventBannerImage = "";

    _maxBudgetController.addListener(() {
      final val = double.tryParse(_maxBudgetController.text);
      if (val != null && val > 0) {
        _maxBudget.value = val;
        if (_eventBudget.value > val) {
          _eventBudget.value = val;
        }
      }
    });

    super.onInit();
  }

  // ---------------- CREATE EVENT ----------------

  Future createEvent() async {
    final user = auth.currentUser;

    EventModel eventModel = EventModel(
      eventLocation: _locationController.text,
      eventBudget: _eventBudget.value,
      eventEndDate: _endDate.value,
      eventStartDate: _startDate.value,
      eventName: _eventNameController.text,
      eventType: _eventType.value,
      guestCount: _guestContrller.text,
      userId: user!.uid,
      status: "Not Approved",
      eventDescriptions: _eventDescriptionController.text,
      eventId: '',
    );

    try {
      _isLoading.value = true;
      final eventId = await EventRepository().createEvent(eventModel);
      _currentEventId.value = eventId;

      await generateAiBlueprint(eventId);

      SafeSnackbar.success("Success", "Event created successfully");
      clearAllField();
    } catch (e) {
      SafeSnackbar.error("Error", e.toString());
    } finally {
      _isLoading.value = false;
    }
  }

  // ---------------- AI BLUEPRINT ----------------

  Future generateAiBlueprint(String eventId) async {
    final userId = auth.currentUser!.uid;

    try {
      final aiData = await AiBlueprintService.generateBlueprint(
        eventType: _eventType.value,
        budget: _eventBudget.value,
        date: _startDate.value,
        city: _locationController.text,
      );

      if (!aiData.containsKey("categories")) {
        throw Exception("Invalid AI response");
      }

      await firestore
          .collection('events')
          .doc(userId)
          .collection('currentUserEvents')
          .doc(eventId)
          .collection('blueprint')
          .doc('data')
          .set(aiData);

      SafeSnackbar.success("Blueprint Generated", "AI blueprint ready");

      Get.toNamed(AppRoutes.generateAiScreen, arguments: eventId);
    } catch (e) {
      SafeSnackbar.error("AI Error", e.toString());
      rethrow;
    }
  }

  // ---------------- STREAMS ----------------

  Stream<DocumentSnapshot<Map<String, dynamic>>> eventStream(String eventId) {
    return firestore
        .collection("events")
        .doc(auth.currentUser!.uid)
        .collection("currentUserEvents")
        .doc(eventId)
        .snapshots();
  }

  Stream<DocumentSnapshot<Map<String, dynamic>>> blueprintStream(
    String eventId,
  ) {
    return firestore
        .collection("events")
        .doc(auth.currentUser!.uid)
        .collection("currentUserEvents")
        .doc(eventId)
        .collection("blueprint")
        .doc("data")
        .snapshots();
  }

  // ---------------- BUDGET LOGIC ----------------

  double get allocatedBudget =>
      categories.fold(0.0, (sum, c) => sum + c.allocated);

  double get remainingBudget =>
      (totalBudget.value - allocatedBudget).clamp(0.0, double.infinity);

  void loadFromBlueprint({
    required List rawCategories,
    required double eventBudget,
  }) {
    totalBudget.value = eventBudget;
    categories.assignAll(
      rawCategories.map((e) => BudgetCategory.fromMap(e)).toList(),
    );
  }

  /// MAIN FIX — validation here
  void updateCategoryBudget(int index, double newValue) {
    final double currentAllocated =
        allocatedBudget - categories[index].allocated;

    final double newTotal = currentAllocated + newValue;

    // if (newTotal > totalBudget.value) {
    //   SafeSnackbar.error("Budget Exceeded", "Total allocated budget cannot exceed event budget",);
    //   return;
    // }

    categories[index].allocated = newValue;
    categories.refresh();
  }

  /// Save with safety
  Future<bool> saveBudget(String userId, String eventId) async {
    if (allocatedBudget.round() > totalBudget.value.round()) {
      SafeSnackbar.error(
        "Budget Exceeded",
        "Fix category budgets before saving",
      );
      return false; //  hard stop
    }

    try {
      isLoading.value = true;

      await firestore
          .collection("events")
          .doc(userId)
          .collection("currentUserEvents")
          .doc(eventId)
          .collection("blueprint")
          .doc("data")
          .update({
        "categories": categories.map((e) => e.toMap()).toList(),
      });

      SafeSnackbar.success("Saved", "Budget updated successfully");
      return true; // success
    } catch (e) {
      SafeSnackbar.error("Error", e.toString());
      return false; //  THIS WAS MISSING
    } finally {
      isLoading.value = false;
    }
  }


  // ---------------- STATUS ----------------

  Future<void> UpdateEventStatus(String id) async {
    try {
      isLoading.value = true;
      await firestore
          .collection("events")
          .doc(auth.currentUser!.uid)
          .collection("currentUserEvents")
          .doc(id)
          .update({"status": "Approved"});
      // Get.offAllNamed(AppRoutes.main);
    } catch (e) {
      SafeSnackbar.error("Error", e.toString());
    } finally {
      isLoading.value = false;
    }
  }

  Stream<QuerySnapshot<Map<String, dynamic>>> allEventsStream() {
    return EventRepository().getAllEventsStream();
  }

  ///===========fetch event categories  ===============
  Stream<EventBlueprintModel> fetchEventBlueprint() {
    return firestore
        .collection("events")
        .doc(auth.currentUser!.uid)
        .collection("currentUserEvents")
        .doc(currentEventId)
        .collection("blueprint")
        .doc("data")
        .snapshots()
        .map((snapshot) {
      if (!snapshot.exists || snapshot.data() == null) {
        return EventBlueprintModel(
          categories: [],
          timeline: [],
          vendorCategories: [],
        );
      }

      return EventBlueprintModel.fromMap(
        snapshot.data() as Map<String, dynamic>,
      );
    });
  }


  /// Refresh = re-balance automatically
  void refreshAllocation() {
    if (categories.isEmpty) return;
    final double equalShare = totalBudget.value / categories.length;
    for (final cat in categories) {
      cat.allocated = equalShare;
    }
    categories.refresh();
  }

  // ---------------- UTILS ----------------

  String formatEventDate(String rawDate) {
    final parsedDate = DateFormat('d/M/yyyy').parse(rawDate);
    return DateFormat('MMM d').format(parsedDate);
  }

  String formatBudget(num budget) {
    if (budget >= 1000) {
      return '${(budget / 1000).toStringAsFixed(1)}k';
    }
    return budget.toStringAsFixed(0);
  }

  void clearAllField() {
    _eventNameController.clear();
    _eventDescriptionController.clear();
    _locationController.clear();
    _guestContrller.clear();
    _maxBudgetController.text = "10000";
    _eventType.value = "";
    _startDate.value = "";
    _endDate.value = "";
    _eventBudget.value = 1000;
  }
}
