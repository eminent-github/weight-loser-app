import 'package:get/get.dart';
import 'package:weight_loss_app/modules/diet_scanner/controller/diet_scanner_controller.dart';

class DietScannerBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut<DietScannerController>(() => DietScannerController());
  }
}
