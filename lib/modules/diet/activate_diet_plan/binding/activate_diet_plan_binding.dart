import 'package:get/get.dart';

import '../controller/activate_diet_plan_controller.dart';

class ActivateDietPlanBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut<ActivateDietPlanController>(() => ActivateDietPlanController());
  }
}
