import 'dart:developer';

import 'package:flutter/animation.dart';
import 'package:get/get.dart';

class MindSectionActiveGraphController extends GetxController
    with GetSingleTickerProviderStateMixin {
  late AnimationController animationController;

  @override
  void onInit() {
    animationController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 1),
    );
    super.onInit();
  }

  @override
  void onReady() {
    animationController.forward();
    super.onReady();
  }

  @override
  void dispose() {
    animationController.dispose();
    super.dispose();
  }

  int monthsToLoseWeight(
      {required num goalWeight,
      required num currentWeight,
      required double weightPerWeek}) {
    log("cwe: $currentWeight gwe: $goalWeight perWeeke: $weightPerWeek");
    double numbeOfWeeks = (currentWeight - goalWeight) / weightPerWeek;
    // print("numbeOfWeeks : $numbeOfWeeks");
    if (numbeOfWeeks <= 4) {
      return 1;
    }
    return (numbeOfWeeks / 4.34524).round();
  }

  DateTime expectedDate(
      {required num targetWeight,
      required num currentWeight,
      required String weightUnit}) {
    return DateTime.now().add(
      Duration(
        days: daysToLoseWeight(
          currentWeight:
              weightUnit == "kg" ? currentWeight * 2.2 : currentWeight,
          goalWeight: weightUnit == "kg" ? targetWeight * 2.2 : targetWeight,
          weightPerWeek: 1.5,
        ),
      ),
    );
  }

  int daysToLoseWeight(
      {required num goalWeight,
      required num currentWeight,
      required double weightPerWeek}) {
    log("cwe: $currentWeight gwe: $goalWeight perWeek: $weightPerWeek");
    double numbeOfWeeks = (currentWeight - goalWeight) / weightPerWeek;

    print("days------${((numbeOfWeeks / 4.34524) * 30).round()}");
    return ((numbeOfWeeks / 4.34524) * 30).round();
  }
}
