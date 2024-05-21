import 'package:get/get.dart';

import '../controller/height_controller.dart';

class HeightBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut<HeightController>(() => HeightController());
  }
}
