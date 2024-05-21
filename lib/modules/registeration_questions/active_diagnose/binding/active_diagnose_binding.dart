import 'package:get/get.dart';

import '../controller/active_diagnose_controller.dart';

class ActiveDiagnoseBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut<ActiveDiagnoseController>(() => ActiveDiagnoseController());
  }
}
