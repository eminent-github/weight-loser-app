import 'package:get/get.dart';
import 'package:weight_loss_app/modules/refund/controller/refund_controller.dart';

class RefundBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut<RefundController>(() => RefundController());
  }
}
