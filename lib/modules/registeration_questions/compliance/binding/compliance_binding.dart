import 'package:get/get.dart';

import '../controller/compliance_controller.dart';

class ComplianceBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut<ComplianceController>(() => ComplianceController());
  }
}
