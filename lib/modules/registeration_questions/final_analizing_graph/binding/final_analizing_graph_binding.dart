import 'package:get/get.dart';

import '../controller/final_analizing_graph_controller.dart';

class FinalAnalizingGraphBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut<FinalAnalizingGraphController>(
        () => FinalAnalizingGraphController());
  }
}
