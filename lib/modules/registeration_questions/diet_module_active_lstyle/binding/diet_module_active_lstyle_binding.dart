import 'package:get/get.dart';

import '../controller/diet_module_active_lstyle_controller.dart';

class DietModuleActiveStyleBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut<DietModuleActiveStyleController>(
        () => DietModuleActiveStyleController());
  }
}
