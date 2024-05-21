import 'package:get/get.dart';

import '../controller/doctors_list_controller.dart';

class DoctorsListBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut<DoctorsListController>(() => DoctorsListController());
  }
}
