import 'package:get/get.dart';

import '../controller/interval_time_controller.dart';

class IntervalTimeBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut<IntervalTimeController>(() => IntervalTimeController());
  }
}
