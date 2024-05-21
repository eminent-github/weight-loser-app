import 'dart:developer';

import 'package:get/get.dart';
import 'package:weight_loss_app/utils/shared_prefrence.dart';

class GuaranteeController extends GetxController {
  var targetWeight = 0.obs;
  var currentWeight = 0.obs;
  var weightUnit = "".obs;

  @override
  void onInit() {
    getTargetAndCurrentWeight();
    super.onInit();
  }

  getTargetAndCurrentWeight() async {
    targetWeight.value = (await StorageServivce.getTargetWeight()) ?? 0;
    currentWeight.value = (await StorageServivce.getCurrentWeight()) ?? 0;
    weightUnit.value = (await StorageServivce.getWeightUnit()) ?? "";
  }

  int daysToLoseWeight(
      {required num goalWeight,
      required num currentWeight,
      required double weightPerWeek}) {
    log("cwe: $currentWeight gwe: $goalWeight perWeeke: $weightPerWeek");
    double numbeOfWeeks = (currentWeight - goalWeight) / weightPerWeek;

    return ((numbeOfWeeks / 4.34524) * 30).round();
  }
}
