import 'dart:convert';
import 'dart:developer';

import 'package:get/get.dart';
import 'package:weight_loss_app/common/api_urls.dart';
import 'package:weight_loss_app/common/app_texts.dart';
import 'package:weight_loss_app/common/questions_page_name.dart';
import 'package:weight_loss_app/modules/registeration_questions/models/get_question_with_answer_model.dart';
import 'package:weight_loss_app/modules/registeration_questions/models/user_info_response_model.dart';
import 'package:weight_loss_app/modules/registeration_questions/religious_diet/binding/religious_binding.dart';
import 'package:weight_loss_app/modules/registeration_questions/religious_diet/view/religious_page.dart';
import 'package:weight_loss_app/utils/api_service.dart';
import 'package:weight_loss_app/utils/shared_prefrence.dart';
import 'package:weight_loss_app/widgets/custom_snackbar.dart';

class DragCuisineController extends GetxController {
  List<Option>? cuisineDragList;

  getDragList(List<Option> dcuisineDragList) {
    cuisineDragList = dcuisineDragList;
  }

  void reorder(int oldIndex, int newIndex) {
    if (newIndex > oldIndex) {
      newIndex -= 1;
    }
    final item = cuisineDragList!.removeAt(oldIndex);
    cuisineDragList!.insert(newIndex, item);
    update();
  }

  final ApiService apiService = ApiService();
  var isLoading = false.obs;
  Future<void> religiousDietQusApi() async {
    try {
      var token = await StorageServivce.getToken();
      log("beforeResponse");
      var response = await apiService
          .get("${ApiUrls.getQuestionWithAnswer}?order=13", authToken: token);
      log("afterrResponse${response.body}");
      if (response.statusCode == 200) {
        var dateObj = jsonDecode(response.body);
        GetQuestionWithAnswerModel getQuestionWithAnswerModel =
            GetQuestionWithAnswerModel.fromJson(dateObj);
        isLoading.value = false;

        Get.to(
          const ReligiousDietPage(),
          binding: ReligiousDietBinding(),
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

  Future<void> cuisinePrefrenceAnswerApi(
    int order,
    int id,
    String answer,
  ) async {
    Map<String, dynamic> bodyData = {
      "answer": answer,
      "order": "$order",
      "qId": "$id",
      "PageName": QuestionPageNames.cuisinePrefPageName,
    };
    try {
      isLoading.value = true;
      var token = await StorageServivce.getToken();
      log("beforeResponse");
      var response = await apiService.post(
          ApiUrls.postQuestionsAnswerEndPoint, jsonEncode(bodyData),
          authToken: token);
      log("afterrResponse${response.body}");
      if (response.statusCode == 200) {
        var dateObj = jsonDecode(response.body);
        var result = UserInfoResponseModel.fromJson(dateObj);

        if (result.responseDto!.status == true) {
          religiousDietQusApi();
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
