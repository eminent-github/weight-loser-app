import 'dart:convert';
import 'dart:developer';

import 'package:get/get.dart';
import 'package:weight_loss_app/common/api_urls.dart';
import 'package:weight_loss_app/common/app_texts.dart';
import 'package:weight_loss_app/common/questions_page_name.dart';
import 'package:weight_loss_app/modules/registeration_questions/models/get_question_with_answer_model.dart';
import 'package:weight_loss_app/modules/registeration_questions/models/user_info_response_model.dart';
import 'package:weight_loss_app/utils/api_service.dart';
import 'package:weight_loss_app/utils/shared_prefrence.dart';
import 'package:weight_loss_app/widgets/custom_snackbar.dart';

class ReligiousDietController extends GetxController {
  late GetQuestionWithAnswerModel getQuestionWithAnswerModel;
  void toggleSelection(int index) {
    // religiousList[index].isSelected = !religiousList[index].isSelected;
    getQuestionWithAnswerModel.response!.option![index].isSelected =
        !getQuestionWithAnswerModel.response!.option![index].isSelected;
    update();
  }

  @override
  void onInit() {
    getQuestionWithAnswerModel = Get.arguments as GetQuestionWithAnswerModel;
    super.onInit();
  }

  final ApiService apiService = ApiService();
  var isLoading = false.obs;

  Future<bool> religiousChoicePrefrenceAnswerApi(
      int order, int id, String answer) async {
    Map<String, dynamic> bodyData = {
      "answer": answer,
      "order": "$order",
      "qId": "$id",
      "PageName": QuestionPageNames.religiousDietPageName,
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
    }
    return false;
  }
}
