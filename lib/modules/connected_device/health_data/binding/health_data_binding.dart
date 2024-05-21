import 'package:get/get.dart';
import 'package:weight_loss_app/modules/connected_device/health_data/controller/health_data_controller.dart';

class HealthDataBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut<HealthDataController>(() => HealthDataController());
  }
}
