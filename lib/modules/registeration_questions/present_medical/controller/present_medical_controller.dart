import 'dart:convert';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:weight_loss_app/common/api_urls.dart';
import 'package:weight_loss_app/common/app_texts.dart';
import 'package:weight_loss_app/common/questions_page_name.dart';
import 'package:weight_loss_app/modules/registeration_questions/gurantee/binding/guarantee_binding.dart';
import 'package:weight_loss_app/modules/registeration_questions/gurantee/gurantee_page/guarantee_page.dart';
import 'package:weight_loss_app/modules/registeration_questions/models/get_question_with_answer_model.dart';
import 'package:weight_loss_app/modules/registeration_questions/models/user_info_response_model.dart';
import 'package:weight_loss_app/modules/registeration_questions/stopping_point/binding/stopping_point_binding.dart';
import 'package:weight_loss_app/modules/registeration_questions/stopping_point/stopping_point_page/stopping_point_page.dart';
import 'package:weight_loss_app/utils/api_service.dart';
import 'package:weight_loss_app/utils/shared_prefrence.dart';
import 'package:weight_loss_app/widgets/custom_snackbar.dart';

class PresentMedicalController extends GetxController {
  late GetQuestionWithAnswerModel getQuestionWithAnswerModel;

  void toggleSelection(int index) {
    if (index == 5) {
      // If the fourth item is clicked, unselect all items
      for (var item in getQuestionWithAnswerModel.response!.option!) {
        item.isSelected = false;
      }
      getQuestionWithAnswerModel.response!.option![5].isSelected = true;
    } else {
      getQuestionWithAnswerModel.response!.option![5].isSelected = false;
      getQuestionWithAnswerModel.response!.option![index].isSelected =
          !(getQuestionWithAnswerModel.response!.option![index].isSelected);
    }
    update();
  }

  @override
  void onInit() {
    getQuestionWithAnswerModel = Get.arguments as GetQuestionWithAnswerModel;
    super.onInit();
  }

  final ApiService apiService = ApiService();
  var isLoading = false.obs;
  Future<void> presentMedicalAnswerApi(BuildContext context, int order, int id,
      String answer, bool isStoppingAnswer) async {
    Map<String, dynamic> bodyData = {
      "answer": answer,
      "order": "$order",
      "qId": "$id",
      "PageName": QuestionPageNames.presentMedicalPageName,
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
          if (isStoppingAnswer) {
            Get.to(const StoppingPointPage(), binding: StoppingPointBinding());
          } else {
            Get.to(const GuaranteePage(), binding: GuaranteeBinding());
            // Navigator.push(
            //   context,
            //   PageRouteBuilder(
            //       pageBuilder: (context, animation, secondaryAnimation) =>
            //           const SectionChangePage(
            //             pageBackColor: AppColors.dietModuleColor,
            //             module: "diet",
            //           ),
            //       transitionsBuilder:
            //           (context, animation, secondaryAnimation, child) {
            //         return bottomSlideTransition(animation, child);
            //       },
            //       transitionDuration: const Duration(milliseconds: 800)),
            // );
          }
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
