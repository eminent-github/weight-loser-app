import 'package:get/get.dart';
import 'package:weight_loss_app/modules/payment_integration/regular_price/controller/regular_price_controller.dart';

class RegularPriceBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut<RegularPriceController>(() => RegularPriceController());
  }
}
