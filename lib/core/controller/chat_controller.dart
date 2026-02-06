import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import '../repo/chat_repository.dart';

class ChatController extends GetxController {
  final ChatRepository repo;
  ChatController(this.repo);

  final RxString roomId = "".obs;
  final RxBool isLoading = true.obs;

  late final String plannerId;
  late final String vendorId;
  late final String applicationId;
  late final String vendorName;
  late final String vendorProfileImage;

  String get myId => FirebaseAuth.instance.currentUser!.uid;
  String get otherId => myId == plannerId ? vendorId : plannerId;

  @override
  void onInit() {
    super.onInit();
    final Map<String, dynamic> args = Get.arguments as Map<String, dynamic>;

    plannerId = args["plannerId"];
    vendorId = args["vendorId"];
    applicationId = args["applicationId"];
    vendorName = args["vendorName"] ?? "Vendor";
    vendorProfileImage = args["profileImage"] ?? "";

    _initRoom();
  }

  Future<void> _initRoom() async {
    isLoading.value = true;
    final id = await repo.getOrCreateRoom(
      plannerId: plannerId,
      vendorId: vendorId,
      applicationId: applicationId,
      vendorName: vendorName,
      vendorProfileImage: vendorProfileImage,
    );
    roomId.value = id;
    isLoading.value = false;
  }

  Future<void> send(String text) async {
    if (text.trim().isEmpty) return;
    if (roomId.value.isEmpty) return;

    await repo.sendMessage(
      roomId: roomId.value,
      senderId: myId,
      receiverId: otherId,
      text: text,
    );
  }
}
