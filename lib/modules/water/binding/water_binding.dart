import 'package:get/get.dart';

import '../controller/water_controller.dart';

class WaterBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => WaterController());
  }
}