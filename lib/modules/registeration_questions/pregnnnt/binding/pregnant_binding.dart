import 'package:get/get.dart';

import '../controller/pregnant_controller.dart';

class PregnantBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut<PregnantController>(() => PregnantController());
  }
}
