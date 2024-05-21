import 'package:get/get.dart';

import '../controller/activate_mind_plan_controller.dart';

class ActivateMindPlanBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut<ActivateMindPlanController>(() => ActivateMindPlanController());
  }
}
