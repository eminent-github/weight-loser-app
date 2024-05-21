import 'package:get/get.dart';

import '../controller/meditation_interval_controller.dart';

class MeditationIntervalBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut<MeditationIntervalController>(
        () => MeditationIntervalController());
  }
}
