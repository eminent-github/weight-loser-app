import 'package:get/get.dart';

import '../controller/stress_response_for_eating_controller.dart';

class StressResponseForEatingBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut<StressResponseForEatingController>(() => StressResponseForEatingController());
  }
}
