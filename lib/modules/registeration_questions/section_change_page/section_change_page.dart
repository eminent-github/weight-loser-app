import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:weight_loss_app/common/app_text_styles.dart';
import 'package:weight_loss_app/modules/registeration_questions/food_opinion/binding/food_opinion_binding.dart';
import 'package:weight_loss_app/modules/registeration_questions/sleep_hours/binding/sleep_hours_binding.dart';

import '../exercise/binding/exercise_binding.dart';
import '../exercise/view/exercise_page.dart';
import '../food_opinion/food_opinion_page/food_opinion_page.dart';
import '../sleep_hours/sleep_hours_page/sleep_hours_page.dart';

class SectionChangePage extends StatefulWidget {
  const SectionChangePage({
    super.key,
    required this.pageBackColor,
    required this.module,
  });
  final Color pageBackColor;
  final String module;
  @override
  State<SectionChangePage> createState() => _SectionChangePageState();
}

class _SectionChangePageState extends State<SectionChangePage> {
  @override
  void initState() {
    super.initState();
    Future.delayed(
      const Duration(seconds: 1),
      () {
        switch (widget.module) {
          case "exercise":
            Get.off(
              () => const ExercisePage(),
              binding: ExerciseBinding(),
            );
            break;
          case "sleep":
            Get.off(
              () => const SleepHoursPage(),
              binding: SleepHoursBinding(),
            );
            break;
          case "mind":
            Get.off(
              () => const FoodOpinionPage(),
              binding: FoodOpinionBinding(),
            );
            break;
          default:
            Get.off(() => Scaffold(
                    body: Center(
                  child: Text("No page Found",
                      style: AppTextStyles.formalTextStyle(fontSize: 20)),
                )));
        }
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: widget.pageBackColor,
    );
  }
}
