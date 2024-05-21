import 'package:get/get.dart';

import '../controller/mind_section_active_graph_controller.dart';

class MindSectionActiveGraphBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut<MindSectionActiveGraphController>(
        () => MindSectionActiveGraphController());
  }
}
