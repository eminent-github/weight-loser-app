import 'dart:convert';
import 'dart:developer';

import 'package:get/get.dart';
import 'package:weight_loss_app/common/api_urls.dart';
import 'package:weight_loss_app/common/app_texts.dart';
import 'package:weight_loss_app/common/questions_page_name.dart';
import 'package:weight_loss_app/modules/registeration_questions/models/get_question_with_answer_model.dart';
import 'package:weight_loss_app/modules/registeration_questions/models/user_info_response_model.dart';
import 'package:weight_loss_app/modules/registeration_questions/water_intake/binding/water_intake_binding.dart';
import 'package:weight_loss_app/modules/registeration_questions/water_intake/water_intake_page/water_intake_page.dart';
import 'package:weight_loss_app/utils/api_service.dart';
import 'package:weight_loss_app/utils/shared_prefrence.dart';
import 'package:weight_loss_app/widgets/custom_snackbar.dart';

class FavRestaurantsController extends GetxController {
 late Rx<GetQuestionWithAnswerModel> getQuestionWithAnswerModel =
      GetQuestionWithAnswerModel().obs;
  void toggleSelection(int index) {
    getQuestionWithAnswerModel.value.response!.option![index].isSelected =
        !getQuestionWithAnswerModel.value.response!.option![index].isSelected;
    update();
  }

  @override
  void onInit() {
    // getQuestionWithAnswerModel.value =
    //     Get.arguments as GetQuestionWithAnswerModel;
    favRestaurantQusApi();
    super.onInit();
  }

  final ApiService apiService = ApiService();
  var isLoading = false.obs;

  Future<void> favRestaurantQusApi() async {
    isLoading.value = true;
    try {
      var token = await StorageServivce.getToken();
      log("beforeResponse");
      var response = await apiService
          .get("${ApiUrls.getQuestionWithAnswer}?order=14", authToken: token);
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

  Future<void> favRestaurantAnswerApi(int order, int id, String answer) async {
    Map<String, dynamic> bodyData = {
      "answer": answer,
      "order": "$order",
      "qId": "$id",
      "PageName": QuestionPageNames.favRestuarantsPageName,
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
          await waterIntakeQusApi();
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

  Future<void> waterIntakeQusApi() async {
    try {
      var token = await StorageServivce.getToken();
      log("beforeResponse");
      var response = await apiService
          .get("${ApiUrls.getQuestionWithAnswer}?order=15", authToken: token);
      log("afterrResponse");
      if (response.statusCode == 200) {
        var dateObj = jsonDecode(response.body);
        GetQuestionWithAnswerModel getQuestionWithAnswerModel =
            GetQuestionWithAnswerModel.fromJson(dateObj);
        log("targetWeightResponse --------------------------------\n$getQuestionWithAnswerModel");
        isLoading.value = false;

        Get.to(
          const WaterIntakePage(),
          binding: WaterIntakeBinding(),
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
}
