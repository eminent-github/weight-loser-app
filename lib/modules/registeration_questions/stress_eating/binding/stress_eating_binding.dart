import 'package:get/get.dart';

import '../controller/stress_eating_controller.dart';

class StressEatingBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut<StressEatingController>(() => StressEatingController());
  }
}
