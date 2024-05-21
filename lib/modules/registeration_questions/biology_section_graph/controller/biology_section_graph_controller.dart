import 'dart:convert';
import 'dart:developer';

import 'package:flutter/animation.dart';
import 'package:get/get.dart';
import 'package:weight_loss_app/common/api_urls.dart';
import 'package:weight_loss_app/common/app_texts.dart';
import 'package:weight_loss_app/modules/registeration_questions/active_diagnose/active_diagnose_page/active_diagnose_page.dart';
import 'package:weight_loss_app/modules/registeration_questions/active_diagnose/binding/active_diagnose_binding.dart';
import 'package:weight_loss_app/modules/registeration_questions/models/get_question_with_answer_model.dart';
import 'package:weight_loss_app/utils/api_service.dart';
import 'package:weight_loss_app/utils/shared_prefrence.dart';
import 'package:weight_loss_app/widgets/custom_snackbar.dart';

class BiologySectionGraphController extends GetxController
    with GetSingleTickerProviderStateMixin {
  late AnimationController animationController;

  var userName = ''.obs;

  @override
  void onInit() {
    animationController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 1),
    );

    getUserName();
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

  getUserName() async {
    userName.value = await StorageServivce.getUserName() ?? 'unknown';
  }

  final ApiService apiService = ApiService();
  var isLoading = false.obs;
  Future<void> activeDiagnoseQusApi() async {
    try {
      isLoading.value = true;
      var token = await StorageServivce.getToken();
      log("beforeResponse");
      var response = await apiService
          .get("${ApiUrls.getQuestionWithAnswer}?order=9", authToken: token);
      log("afterrResponse");
      if (response.statusCode == 200) {
        var dateObj = jsonDecode(response.body);
        GetQuestionWithAnswerModel getQuestionWithAnswerModel =
            GetQuestionWithAnswerModel.fromJson(dateObj);
        log("targetWeightResponse --------------------------------\n$getQuestionWithAnswerModel");
        isLoading.value = false;
        Get.to(
          ActiveDiagnosePage(
            getQuestionWithAnswerModel: getQuestionWithAnswerModel,
          ),
          binding: ActiveDiagnoseBinding(),
        );
      } else {
        isLoading.value = false;
        customSnackbar(
            title: AppTexts.error, message: AppTexts.userAPiExceptionResponse);
      }
    } catch (e) {
      isLoading.value = false;
      // print(e);
      customSnackbar(title: AppTexts.error, message: "Api Exception");
    }
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

  int monthsToLoseWeight(
      {required num goalWeight,
      required num currentWeight,
      required double weightPerWeek}) {
    log("cwe: $currentWeight gwe: $goalWeight perWeek: $weightPerWeek");
    double numbeOfWeeks = (currentWeight - goalWeight) / weightPerWeek;
    print("numbeOfWeeks : $numbeOfWeeks");
    if (numbeOfWeeks <= 4) {
      return 1;
    }
    print("numbeOfmonths : ${(numbeOfWeeks / 4.34524)}");
    return (numbeOfWeeks / 4.34524).round();
  }

  int daysToLoseWeight(
      {required num goalWeight,
      required num currentWeight,
      required double weightPerWeek}) {
    log("cwe: $currentWeight gwe: $goalWeight perWeek: $weightPerWeek");
    double numbeOfWeeks = (currentWeight - goalWeight) / weightPerWeek;

    return ((numbeOfWeeks / 4.34524) * 30).round();
  }
}
