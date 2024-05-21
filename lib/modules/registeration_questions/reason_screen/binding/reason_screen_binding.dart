import 'package:get/get.dart';

import '../controller/reason_screen_controller.dart';

class ReasonScreenBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut<ReasonScreenController>(
      () => ReasonScreenController(),
    );
  }
}
