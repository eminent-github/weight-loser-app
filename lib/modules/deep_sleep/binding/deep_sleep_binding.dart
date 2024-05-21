import 'package:get/get.dart';
import 'package:weight_loss_app/modules/deep_sleep/controller/deep_sleep_controller.dart';

class DeepSleepBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut<DeepSleepController>(() => DeepSleepController());
  }
}
