import 'package:get/get.dart';

import '../controller/age_controller.dart';

class AgeBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut<AgeController>(() => AgeController());
  }
}
