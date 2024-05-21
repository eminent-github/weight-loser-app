import 'package:get/get.dart';

import '../controller/mind_my_plans_controller.dart';

class MindMyPlansBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut<MindMyPlansController>(() => MindMyPlansController());
  }
}
