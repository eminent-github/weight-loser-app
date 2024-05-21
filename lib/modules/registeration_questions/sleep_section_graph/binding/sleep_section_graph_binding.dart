import 'package:get/get.dart';

import '../controller/sleep_section_graph_controller.dart';

class SleepSectionGraphBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut<SleepSectionGraphController>(
        () => SleepSectionGraphController());
  }
}
