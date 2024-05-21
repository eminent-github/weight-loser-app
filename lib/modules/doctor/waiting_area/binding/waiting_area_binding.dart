import 'package:get/get.dart';
import 'package:weight_loss_app/modules/doctor/waiting_area/controller/waiting_area_controller.dart';

class WaitingAreaBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut<WaitingAreaController>(() => WaitingAreaController());
  }
}
