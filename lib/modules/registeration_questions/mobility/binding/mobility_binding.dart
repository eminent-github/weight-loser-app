import 'package:get/get.dart';

import '../controller/mobility_controller.dart';

class MobilityBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut<MobilityController>(() => MobilityController());
  }
}
