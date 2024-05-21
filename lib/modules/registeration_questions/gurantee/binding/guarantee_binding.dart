import 'package:get/get.dart';

import '../contoller/guarantee_controller.dart';

class GuaranteeBinding implements Bindings {
  
  @override
  void dependencies() {
    Get.lazyPut<GuaranteeController>(
      () => GuaranteeController(
        
      ),
    );
  }
}