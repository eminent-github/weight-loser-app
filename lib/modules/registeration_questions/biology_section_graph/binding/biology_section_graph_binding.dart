import 'package:get/get.dart';

import '../controller/biology_section_graph_controller.dart';

class BiologySectionGraphBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut<BiologySectionGraphController>(() => BiologySectionGraphController());
  }
}
