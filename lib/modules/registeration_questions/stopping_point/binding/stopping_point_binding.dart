import 'package:get/get.dart';

import '../controller/stopping_point_controller.dart';

class StoppingPointBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut<StoppingPointController>(() => StoppingPointController());
  }
}
