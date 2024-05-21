import 'package:get/get.dart';
import 'package:weight_loss_app/modules/ultimate_selfie/screen/comparision/controller/comparision_controller.dart';

class ComparisionBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut<ComparisionController>(() => ComparisionController());
  }
}
