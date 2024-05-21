import 'dart:convert';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:weight_loss_app/common/api_urls.dart';
import 'package:weight_loss_app/common/app_texts.dart';
import 'package:weight_loss_app/common/questions_page_name.dart';
import 'package:weight_loss_app/modules/registeration_questions/models/get_question_with_answer_model.dart';
import 'package:weight_loss_app/modules/registeration_questions/models/user_info_response_model.dart';
import 'package:weight_loss_app/modules/registeration_questions/present_medical/binding/present_medical_binding.dart';
import 'package:weight_loss_app/modules/registeration_questions/present_medical/present_medical_page/present_medical_page.dart';
import 'package:weight_loss_app/modules/registeration_questions/stopping_point/binding/stopping_point_binding.dart';
import 'package:weight_loss_app/modules/registeration_questions/stopping_point/stopping_point_page/stopping_point_page.dart';
import 'package:weight_loss_app/utils/api_service.dart';
import 'package:weight_loss_app/utils/shared_prefrence.dart';
import 'package:weight_loss_app/widgets/custom_snackbar.dart';

class ActiveDiagnoseController extends GetxController {
  var selectedIndex = 1.obs;
  var isYesSelected = false.obs;

  final ApiService apiService = ApiService();
  var isLoading = false.obs;
  Future<void> presentMedicalQusApi(BuildContext context) async {
    try {
      isLoading.value = true;
      var token = await StorageServivce.getToken();
      log("beforeResponse");
      var response = await apiService
          .get("${ApiUrls.getQuestionWithAnswer}?order=10", authToken: token);
      log("afterrResponse");
      if (response.statusCode == 200) {
        var dateObj = jsonDecode(response.body);
        GetQuestionWithAnswerModel getQuestionWithAnswerModel =
            GetQuestionWithAnswerModel.fromJson(dateObj);
        log("targetWeightResponse --------------------------------\n$getQuestionWithAnswerModel");
        isLoading.value = false;

        Get.to(
          const PresentMedicalPage(),
          binding: PresentMedicalBinding(),
          arguments: getQuestionWithAnswerModel,
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

  Future<void> activeDiagnoseAnswerApi(
      BuildContext context, int order, int id, String answer) async {
    Map<String, dynamic> bodyData = {
      "answer": answer,
      "order": "$order",
      "qId": "$id",
      "PageName": QuestionPageNames.activeDiagnosePageName,
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
        log("targetWeightResponse --------------------------------\n$dateObj");
        if (result.responseDto!.status == true) {
          if (isYesSelected.value == true) {
            isLoading.value = false;
            Get.to(const StoppingPointPage(), binding: StoppingPointBinding());
          } else {
            await presentMedicalQusApi(context);
          }
        } else {
          isLoading.value = false;
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
