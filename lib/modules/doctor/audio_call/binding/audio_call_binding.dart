import 'package:get/get.dart';
import 'package:weight_loss_app/modules/doctor/audio_call/controller/audio_call_controller.dart';

class AudioCallBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut<AudioCallController>(() => AudioCallController());
  }
}
