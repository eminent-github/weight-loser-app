import 'package:get/get.dart';

import '../controller/water_intake_controller.dart';

class WaterIntakeBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut<WaterIntakeController>(() => WaterIntakeController());
  }
}
