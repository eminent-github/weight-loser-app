import 'package:get/get.dart';

class UserGoalCategoryController extends GetxController {
  int monthsToLoseWeight(
      {required num goalWeight,
      required num currentWeight,
      required double weightPerWeek}) {
    // log("cw: $currentWeight gw: $goalWeight perWeek: $weightPerWeek");
    double numbeOfWeeks = (currentWeight - goalWeight) / weightPerWeek;
    // print("numbeOfWeeks : $numbeOfWeeks");
    if (numbeOfWeeks <= 4) {
      return 1;
    }
    return numbeOfWeeks ~/ 4.34524;
  }
}
