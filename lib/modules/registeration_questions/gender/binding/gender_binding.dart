import 'package:get/get.dart';

import '../controller/gender_controller.dart';

class GenderBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut<GenderController>(
      () => GenderController(),
    );
  }
}
