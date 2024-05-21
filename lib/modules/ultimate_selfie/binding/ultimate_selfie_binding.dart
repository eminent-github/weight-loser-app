import 'package:get/get.dart';
import 'package:weight_loss_app/modules/ultimate_selfie/controller/ultimate_selfie_controller.dart';

class UltimateSelfieBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut<UltimateSelfieController>(() => UltimateSelfieController());
  }
}
