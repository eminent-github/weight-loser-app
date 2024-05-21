import 'package:get/get.dart';
import 'package:weight_loss_app/modules/cbt/scoring/controller/scoring_controller.dart';

class ScoringBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut<ScoringController>(() => ScoringController());
  }
}
