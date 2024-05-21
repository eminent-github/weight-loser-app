import 'package:get/get.dart';
import 'package:weight_loss_app/modules/doctor/messaging/controller/messaging_controller.dart';

class MessagingBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut<MessagingController>(() => MessagingController());
  }
}
