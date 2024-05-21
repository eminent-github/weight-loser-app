import 'package:get/get.dart';
import 'package:weight_loss_app/modules/doctor/video_call/controller/video_call_controller.dart';

class VideoCallBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut<VideoCallController>(() => VideoCallController());
  }
}
