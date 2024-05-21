import 'dart:async';
import 'dart:convert';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:weight_loss_app/common/api_urls.dart';
import 'package:weight_loss_app/common/app_texts.dart';
import 'package:weight_loss_app/common/questions_page_name.dart';
import 'package:weight_loss_app/modules/registeration_questions/models/get_question_with_answer_model.dart';
import 'package:weight_loss_app/modules/registeration_questions/models/user_info_response_model.dart';
import 'package:weight_loss_app/modules/registeration_questions/sleep_section_graph/binding/sleep_section_graph_binding.dart';
import 'package:weight_loss_app/modules/registeration_questions/sleep_section_graph/sleep_section_graph_page/sleep_section_graph_page.dart';
import 'package:weight_loss_app/utils/api_service.dart';
import 'package:weight_loss_app/utils/shared_prefrence.dart';
import 'package:weight_loss_app/widgets/custom_snackbar.dart';

class SleepHoursController extends GetxController {
  late Rx<GetQuestionWithAnswerModel> getQuestionWithAnswerModel =
      GetQuestionWithAnswerModel().obs;
  var startTime = TimeOfDay.now().obs;
  var endTime = TimeOfDay.now().obs;

  // @override
  // void onInit() {
  //   Timer.periodic(const Duration(seconds: 1), (timer) {
  //     currentTime.value = TimeOfDay.fromDateTime(DateTime.now());
  //   });
  //   super.onInit();
  // }

  Future<void> startSelectedTime(BuildContext context) async {
    final TimeOfDay? pickedTime = await showTimePicker(
      context: context,
      initialTime: TimeOfDay.now(),
      builder: (BuildContext context, Widget? child) {
        return MediaQuery(
          data: MediaQuery.of(context).copyWith(alwaysUse24HourFormat: false),
          child: child!,
        );
      },
    );

    if (pickedTime != null) {
      startTime.value = pickedTime;
    }
    log('selected startTime: ${startTime.value.format(Get.context!)}');
  }

  Future<void> endSelectedTime(BuildContext context) async {
    final TimeOfDay? pickedTime = await showTimePicker(
      context: context,
      initialTime: TimeOfDay.now(),
      builder: (BuildContext context, Widget? child) {
        return MediaQuery(
          data: MediaQuery.of(context).copyWith(alwaysUse24HourFormat: false),
          child: child!,
        );
      },
    );

    if (pickedTime != null) {
      endTime.value = pickedTime;
    }
    log('selected endTime: ${endTime.value.format(Get.context!)}');
  }

  String getStartAMPM() {
    return startTime.value.period == DayPeriod.am ? 'AM' : 'PM';
  }

  String getEndAMPM() {
    return endTime.value.period == DayPeriod.am ? 'AM' : 'PM';
  }

  @override
  void onInit() {
    // getQuestionWithAnswerModel.value =
    //     Get.arguments as GetQuestionWithAnswerModel;
    sleepingHoursQusApi();
    super.onInit();
  }

  final ApiService apiService = ApiService();
  var isLoading = false.obs;

  Future<void> sleepingHoursQusApi() async {
    isLoading.value = true;
    try {
      var token = await StorageServivce.getToken();
      log("beforeResponse");
      var response = await apiService
          .get("${ApiUrls.getQuestionWithAnswer}?order=21", authToken: token);
      log("afterrResponse");
      if (response.statusCode == 200) {
        var dateObj = jsonDecode(response.body);
        getQuestionWithAnswerModel.value =
            GetQuestionWithAnswerModel.fromJson(dateObj);
        log("targetWeightResponse --------------------------------\n$getQuestionWithAnswerModel");
        isLoading.value = false;
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

  Future<void> sleepingHoursAnswerApi(int order, int id, String answer) async {
    Map<String, dynamic> bodyData = {
      "answer": answer,
      "order": "$order",
      "qId": "$id",
      "PageName": QuestionPageNames.sleepHoursPageName,
    };
    try {
      isLoading.value = true;
      var token = await StorageServivce.getToken();

      log("beforeResponse");
      var response = await apiService.post(
          ApiUrls.postQuestionsAnswerEndPoint, jsonEncode(bodyData),
          authToken: token);
      log("afterrResponse");
      if (response.statusCode == 200) {
        var dateObj = jsonDecode(response.body);
        var result = UserInfoResponseModel.fromJson(dateObj);
        isLoading.value = false;
        log("targetWeightResponse --------------------------------\n$dateObj");
        if (result.responseDto!.status == true) {
          // await favExerciseQusApi();
          Get.to(
            SleepSectionGraphPage(
              targetWeight: await StorageServivce.getTargetWeight() ?? 0,
              currentWeight: await StorageServivce.getCurrentWeight() ?? 0,
              weightUnit: await StorageServivce.getWeightUnit() ?? "",
            ),
            binding: SleepSectionGraphBinding(),
          );
        } else {
          customSnackbar(
              title: AppTexts.error, message: result.responseDto!.message);
        }
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
}
