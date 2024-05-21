// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';
import 'dart:developer';

import 'package:get/get.dart';
import 'package:weight_loss_app/common/api_urls.dart';
import 'package:weight_loss_app/common/app_assets.dart';
import 'package:weight_loss_app/common/app_texts.dart';
import 'package:weight_loss_app/common/questions_page_name.dart';
import 'package:weight_loss_app/modules/registeration_questions/diet_section_graph/binding/diet_section_graph_binding.dart';
import 'package:weight_loss_app/modules/registeration_questions/diet_section_graph/diet_section_graph_page/diet_section_graph_page.dart';
import 'package:weight_loss_app/modules/registeration_questions/models/get_question_with_answer_model.dart';
import 'package:weight_loss_app/modules/registeration_questions/models/user_info_response_model.dart';
import 'package:weight_loss_app/utils/api_service.dart';
import 'package:weight_loss_app/utils/shared_prefrence.dart';
import 'package:weight_loss_app/widgets/custom_snackbar.dart';

class WaterIntakeController extends GetxController {
  var selectedIndex = 0.obs;
  Rx<GetQuestionWithAnswerModel> getQuestionWithAnswerModel =
      GetQuestionWithAnswerModel().obs;

  final ApiService apiService = ApiService();
  var isLoading = false.obs;

  @override
  void onInit() {
    getQuestionWithAnswerModel.value =
        Get.arguments as GetQuestionWithAnswerModel;
    super.onInit();
  }

  List<WaterIntakeModel> waterIntakeList = <WaterIntakeModel>[
    WaterIntakeModel(
        imageUrl: AppAssets.moreThan8GlassImgUrl, title: "More than 8 Glasses"),
    WaterIntakeModel(
      imageUrl: AppAssets.lessThan8GlassImgUrl,
      title: "Less than 8 Glasses",
    ),
    WaterIntakeModel(
      imageUrl: AppAssets.questioMarkImgUrl,
      title: "Never Counted",
    ),
  ];

  Future<void> waterIntakeAnswerApi(int order, int id, String answer) async {
    Map<String, dynamic> bodyData = {
      "answer": answer,
      "order": "$order",
      "qId": "$id",
      "PageName": QuestionPageNames.waterIntakePageName,
    };
    try {
      isLoading.value = true;
      var token = await StorageServivce.getToken();
      log("beforeResponse");
      var response = await apiService.post(
          ApiUrls.postQuestionsAnswerEndPoint, jsonEncode(bodyData),
          authToken: token);
      log("response code : ${response.statusCode}afterrResponse: ${response.body}");
      if (response.statusCode == 200) {
        var dateObj = jsonDecode(response.body);
        var result = UserInfoResponseModel.fromJson(dateObj);
        isLoading.value = false;
        log("targetWeightResponse --------------------------------\n$dateObj");
        if (result.responseDto!.status == true) {
          print("----------------------------");
          Get.to(
            DietSectionGraphPage(
              targetWeight: await StorageServivce.getTargetWeight() ?? 0,
              currentWeight: await StorageServivce.getCurrentWeight() ?? 0,
              weightUnit: await StorageServivce.getWeightUnit() ?? "",
            ),
            binding: DietSectionGraphBinding(),
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

class WaterIntakeModel {
  String title;
  String imageUrl;
  WaterIntakeModel({
    required this.title,
    required this.imageUrl,
  });
}
