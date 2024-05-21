import 'package:get/get.dart';

import '../controller/section_break_controller.dart';

class SectionBreakBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut<SectionBreakController>(
      () => SectionBreakController(),
    );
  }
}
