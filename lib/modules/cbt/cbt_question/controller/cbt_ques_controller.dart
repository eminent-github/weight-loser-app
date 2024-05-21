import 'dart:convert';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:weight_loss_app/common/api_urls.dart';
import 'package:weight_loss_app/common/app_texts.dart';
import 'package:weight_loss_app/modules/cbt/cbt_applause_done/binding/cbt_done_binding.dart';
import 'package:weight_loss_app/modules/cbt/cbt_applause_done/view/cbt_done_page.dart';
import 'package:weight_loss_app/modules/cbt/cbt_explain/cbt_explain_page.dart';
import 'package:weight_loss_app/modules/cbt/model/cbt_questions_model.dart';
import 'package:weight_loss_app/modules/registeration_questions/models/user_info_response_model.dart';
import 'package:weight_loss_app/utils/api_service.dart';
import 'package:weight_loss_app/utils/shared_prefrence.dart';
import 'package:weight_loss_app/widgets/custom_snackbar.dart';

class CbtQuestionController extends GetxController {
  var selectedIndex = RxInt(-1);
  var isAnswerSelected = false.obs;
  var currentStep = 0.obs;

  void nextStep(
    BuildContext context,
    int questionsLength, {
    required int id,
    required int order,
    required String answer,
    required String type,
    required CBTQuestionsModel cbtQuestionsModel,
  }) async {
    log("id:$id answer:$answer");

    bool isAnswered =
        await cbtAnswerApi(order, id, answer, context, questionsLength, type);
    if (isAnswered) {
      isAnswerSelected.value = true;
      Future.delayed(
        const Duration(milliseconds: 1500),
        () async {
          isAnswerSelected.value = false;
          await Get.to(
            () => CbtExplainPage(
              cbtQuestionsModel: cbtQuestionsModel,
              answer: answer,
            ),
          );
          selectedIndex.value = -1;
          if (currentStep.value < questionsLength - 1) {
            currentStep.value++;
          } else {
            Get.off(() => CbtDonePage(totalOptions: questionsLength),
                binding: CbtDoneBinding());
          }
        },
      );
    }
  }

  final ApiService apiService = ApiService();
  var isLoading = false.obs;
  Future<bool> cbtAnswerApi(int order, int id, String answer,
      BuildContext context, int questionsList, String type) async {
    log("questionsLength: $questionsList , currentStep.value: ${currentStep.value}");
    Map<String, dynamic> bodyData = {
      "CbtId": id,
      "answer": answer,
      "cbtCatagory": currentStep.value == questionsList - 1 ? type : "null",
      "Order": order,
    };
    try {
      isLoading.value = true;
      var token = await StorageServivce.getToken();
      log("beforeResponse");
      var response = await apiService.post(
        ApiUrls.cbtAnsEndPoint,
        jsonEncode(bodyData),
        authToken: token,
      );
      log("statsus code :${response.statusCode}  body : ${response.body}");
      if (response.statusCode == 200) {
        var dateObj = jsonDecode(response.body);
        var result = UserInfoResponseModel.fromJson(dateObj);
        isLoading.value = false;
        log("targetWeightResponse --------------------------------\n$dateObj");
        if (result.responseDto!.status == true) {
          return true;
        } else {
          customSnackbar(
              title: AppTexts.error, message: result.responseDto!.message);
          return false;
        }
      } else {
        isLoading.value = false;
        customSnackbar(
            title: AppTexts.error, message: AppTexts.userAPiExceptionResponse);
        return false;
      }
    } catch (e) {
      isLoading.value = false;
      // print(e);
      customSnackbar(title: AppTexts.error, message: "Api Exception");
      return false;
    }
  }
}
