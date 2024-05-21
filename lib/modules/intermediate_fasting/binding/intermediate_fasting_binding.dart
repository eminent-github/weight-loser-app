import 'package:get/get.dart';

import '../controller/intermediate_fasting_controller.dart';

class IntermediateFastingBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => IntermediateFastingController());
  }
}