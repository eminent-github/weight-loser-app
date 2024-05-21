import 'package:get/get.dart';

import '../controller/diet_section_graph_controller.dart';

class DietSectionGraphBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut<DietSectionGraphController>(() => DietSectionGraphController());
  }
}
