import 'package:get/get.dart';

import '../controller/present_medical_controller.dart';

class PresentMedicalBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut<PresentMedicalController>(() => PresentMedicalController());
  }
}
