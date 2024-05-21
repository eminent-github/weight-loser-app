import 'package:get/get.dart';

import '../controller/ready_time_controller.dart';

class ReadyTimeBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut<ReadyTimeController>(() => ReadyTimeController());
  }
}
