import 'package:event_sense_ai/core/controller/event_controller.dart';
import 'package:event_sense_ai/core/controller/guest_controller.dart';
import 'package:event_sense_ai/core/controller/notification_controller.dart';
import 'package:event_sense_ai/core/controller/planner_chat_controller.dart';
import 'package:event_sense_ai/core/controller/vendor_controller.dart';
import 'package:event_sense_ai/core/models/event_model.dart';
import 'package:event_sense_ai/features/auth/vendor_auth_screen/confirm_location.dart';
import 'package:get/get.dart';

import '../controller/inviation_card_controller.dart';
import '../controller/planner_category_controller.dart';
import '../controller/submit_application_controller.dart';
import '../controller/user_controller.dart';
import '../controller/vendor_job_controller.dart';

class GlobalBinding extends Bindings {
  @override
  void dependencies() {
    Get.put<UserController>(UserController(), permanent: true);
    Get.put<VendorController>(VendorController(), permanent: true);
    Get.put<GuestController>(GuestController(), permanent: true);
  }
}

class EventBindings extends GlobalBinding {

  @override
  void dependencies() {
    // TODO: implement dependencies
    super.dependencies();
    Get.put(EventController(), permanent: true);
  }
}

class GuestBindings extends GlobalBinding {

  @override
  void dependencies() {
    // TODO: implement dependencies
    super.dependencies();
    Get.put(GuestController(), permanent:  true);
  }
}
class InvitaioncardBindings extends GlobalBinding {
  @override
  void dependencies() {
    // TODO: implement dependencies
    super.dependencies();
    Get.put(InvitationController(), permanent:  true);
  }
}
class SplashController extends GlobalBinding{
  @override
  void dependencies() {
    // TODO: implement dependencies
    super.dependencies();
    Get.put(SplashController(), permanent:  true);
  }
}

class PlannerCategoryControllerBinding extends GlobalBinding {
  @override
  void dependencies() {
    // TODO: implement dependencies
    super.dependencies();
    Get.put(PlannerCategoryController(), permanent:  true);
  }
}
class VendorJobBinding extends GlobalBinding {
  @override
  void dependencies() {
    // TODO: implement dependencies
    super.dependencies();
    Get.put(VendorJobController(), permanent:  true);
    Get.put(NotificationController(), permanent: true);
  }
}
class SubmitApplicationBinding extends GlobalBinding {
  @override
  void dependencies() {
    // TODO: implement dependencies
    super.dependencies();
    Get.lazyPut(() => SubmitApplicationController());
    Get.lazyPut(() => NotificationController());
  }
}

class ChatBinding extends GlobalBinding {
  @override
  void dependencies() {
    // TODO: implement dependencies
    super.dependencies();
   Get.put(PlannerChatController(), permanent: true);
  }
}
