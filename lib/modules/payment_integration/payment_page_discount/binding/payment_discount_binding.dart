import 'package:get/get.dart';

import '../controller/payment_discount_controller.dart';

class PaymentDiscountBinding extends Bindings {
  final bool isLogin;

  PaymentDiscountBinding({required this.isLogin});
  @override
  void dependencies() {
    Get.lazyPut(() => PaymentDiscountController()..discountCheck(isLogin));
  }
}
