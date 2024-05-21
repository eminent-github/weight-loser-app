import 'package:get/get.dart';

import '../controller/mind_section_controller.dart';

class MindSectionBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => MindSectionController());
  }
}