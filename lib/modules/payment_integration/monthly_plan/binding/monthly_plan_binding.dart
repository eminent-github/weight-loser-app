import 'package:get/get.dart';
import 'package:weight_loss_app/modules/payment_integration/monthly_plan/controller/monthly_plan_controller.dart';
import 'package:weight_loss_app/modules/payment_integration/payment_plans/models/payment_plans_model.dart';

class MonthlyPlanBinding implements Bindings {
  final PackagesList monthlyPackage;
  const MonthlyPlanBinding({
    required this.monthlyPackage,
  });
  @override
  void dependencies() {
    Get.lazyPut<MonthlyPlanController>(
        () => MonthlyPlanController()..getPaymentData(monthlyPackage));
  }
}
