import 'package:get/get.dart';

import '../controller/diet_plan_detail_controller.dart';

class DietPlanDetailBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut<DietPlanDetailController>(() => DietPlanDetailController());
  }
}
