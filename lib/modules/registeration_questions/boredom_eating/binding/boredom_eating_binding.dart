import 'package:get/get.dart';

import '../controller/boredom_eating_controller.dart';

class BoredomEatingBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut<BoredomEatingController>(() => BoredomEatingController());
  }
}
