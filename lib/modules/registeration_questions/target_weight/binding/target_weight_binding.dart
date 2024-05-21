import 'package:get/get.dart';

import '../controller/target_weight_controller.dart';

class TargetWeightBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut<TargetWeightController>(
      () => TargetWeightController(),
    );
  }
}
