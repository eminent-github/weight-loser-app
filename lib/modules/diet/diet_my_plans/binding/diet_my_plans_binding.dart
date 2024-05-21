import 'package:get/get.dart';

import '../cintroller/diet_my_plans_controller.dart';

class DietMyPlansBinding implements Bindings {
@override
void dependencies() {
  Get.lazyPut<DietMyPlansController>(() => DietMyPlansController(
     ));
  }
}