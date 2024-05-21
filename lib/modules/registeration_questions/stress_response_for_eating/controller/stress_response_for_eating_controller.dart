import 'dart:convert';
import 'dart:developer';

import 'package:get/get.dart';
import 'package:weight_loss_app/common/api_urls.dart';
import 'package:weight_loss_app/common/app_texts.dart';
import 'package:weight_loss_app/common/questions_page_name.dart';
import 'package:weight_loss_app/modules/registeration_questions/habit_loop/binding/habit_loop_binding.dart';
import 'package:weight_loss_app/modules/registeration_questions/habit_loop/view/habit_loop_page.dart';
import 'package:weight_loss_app/modules/registeration_questions/models/get_question_with_answer_model.dart';
import 'package:weight_loss_app/modules/registeration_questions/models/user_info_response_model.dart';
import 'package:weight_loss_app/utils/api_service.dart';
import 'package:weight_loss_app/utils/shared_prefrence.dart';
import 'package:weight_loss_app/widgets/custom_snackbar.dart';

class StressResponseForEatingController extends GetxController {
  late Rx<GetQuestionWithAnswerModel> getQuestionWithAnswerModel =
      GetQuestionWithAnswerModel().obs;
  var selectedIndex = 0.obs;
  // List<String> watchingTvRoutineList = <String>[
  //   "Increased with TV/Mobile",
  //   "Decreased with TV/Mobile",
  //   "Not sure",
  // ];
  @override
  void onInit() {
    getQuestionWithAnswerModel.value =
        Get.arguments as GetQuestionWithAnswerModel;
    super.onInit();
  }

  final ApiService apiService = ApiService();
  var isLoading = false.obs;

  Future<void> stressRespondForEatingAnswerApi(
      int order, int id, String answer) async {
    Map<String, dynamic> bodyData = {
      "answer": answer,
      "order": "$order",
      "qId": "$id",
      "PageName": QuestionPageNames.stressReponseForEatingPageName,
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
        if (result.responseDto!.status == true) {
          activatePlanApi();
          Get.to(() => const HabitLoopPage(), binding: HabitLoopBinding());
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

  Future<void> activatePlanApi() async {
    try {
      var token = await StorageServivce.getToken();
      log("beforeResponse");
      var response =
          await apiService.get(ApiUrls.dynamicActivatePlan, authToken: token);
      log("afterrResponse");
      isLoading.value = false;
      if (response.statusCode == 200) {
        log("status code ${response.statusCode}body ${jsonDecode(response.body)}");
      } else {
        log("status code ${response.statusCode}body ${jsonDecode(response.body)}");
      }
    } catch (e) {
      log("$e");
    }
  }
}
