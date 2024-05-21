import 'package:get/get.dart';

import '../controller/sleep_hours_controller.dart';

class SleepHoursBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut<SleepHoursController>(() => SleepHoursController());
  }
}
