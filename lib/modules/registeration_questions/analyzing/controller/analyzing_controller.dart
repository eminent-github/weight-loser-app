import 'package:get/get.dart';
import 'package:weight_loss_app/common/app_assets.dart';
import 'package:weight_loss_app/common/app_colors.dart';
import 'package:weight_loss_app/common/app_texts.dart';
import 'package:weight_loss_app/modules/registeration_questions/analyzing/modalclass/progress_modal_class.dart';

class AnalyzingController extends GetxController {
  RxInt currentIndex = 0.obs;

  @override
  void onInit() {
    super.onInit();

    startDelayedRendering();
  }

  void startDelayedRendering() {
    if (currentIndex.value == 0) {
      currentIndex++;
      Future.delayed(const Duration(seconds: 1), () {
        startDelayedRendering();
      });
    } else {
      if (currentIndex < progressLinear.length) {
        currentIndex++;
        Future.delayed(const Duration(seconds: 1), () {
          startDelayedRendering();
        });
      }
    }
  }

  List<ProgressModalClass> progressLinear = [
    ProgressModalClass(
      iconImage: AppAssets.anaPerson,
      progressText: "Personal Data",
      colorProgress: AppColors.analyzingLinearProgressBiologicalColor,
      percentage: 1,
      text: "100%",
    ),
    ProgressModalClass(
        iconImage: AppAssets.anaDiet,
        progressText: AppTexts.analyzingLinearProgressTextDiet,
        colorProgress: AppColors.analyzingLinearProgressDietColor,
        text: "100%",
        percentage: 1),
    ProgressModalClass(
        iconImage: AppAssets.anaExercise,
        progressText: AppTexts.analyzingLinearProgressTextExercise,
        colorProgress: AppColors.analyzingLinearProgressExerciseColor,
        text: "100%",
        percentage: 1),
    ProgressModalClass(
        iconImage: AppAssets.anaSleep,
        progressText: AppTexts.analyzingLinearProgressTextSleep,
        colorProgress: AppColors.analyzingLinearProgressMindColor,
        text: "100%",
        percentage: 1),
    ProgressModalClass(
        iconImage: AppAssets.anaMind,
        progressText: AppTexts.analyzingLinearProgressTextMind,
        colorProgress: AppColors.analyzingLinearProgressSleepColor,
        text: "100%",
        percentage: 1),
  ];
}
