import 'dart:convert';
import 'dart:developer';

import 'package:get/get.dart';
import 'package:weight_loss_app/common/api_urls.dart';
import 'package:weight_loss_app/common/app_texts.dart';
import 'package:weight_loss_app/common/questions_page_name.dart';
import 'package:weight_loss_app/modules/registeration_questions/models/user_info_response_model.dart';
import 'package:weight_loss_app/utils/api_service.dart';
import 'package:weight_loss_app/utils/shared_prefrence.dart';
import 'package:weight_loss_app/widgets/custom_snackbar.dart';

class TargetWeightController extends GetxController {
  var sliderValue = 90.0.obs;
  double bmi(double height, bool isKg) {
    log("height: $height ");
    if (!isKg) {
      double heightInInches = (height / 2.54);
      return sliderValue.value / (heightInInches * heightInInches) * 703;
    } else {
      double heightInMeters = height / 100;
      return ((sliderValue.value) * 0.453592) /
          (heightInMeters * heightInMeters);
    }
  }

  final ApiService apiService = ApiService();
  var isLoading = false.obs;
  Future<bool> targetWeightApi(bool isKg) async {
    var weight = isKg
        ? ((sliderValue.value) * 0.453592).round()
        : sliderValue.value.round();
    var unit = isKg ? "kg" : "lb";
    print("$weight$unit");
    Map<String, dynamic> bodyData = {
      "targetWeight": weight.toString(),
      "WeightUnit": unit,
      "PageName": QuestionPageNames.targetWeightPageName,
    };
    try {
      isLoading.value = true;
      var token = await StorageServivce.getToken();
      await StorageServivce.saveTargetWeight(weight);
      log("beforeResponse");
      var response = await apiService.formDataPatch(
          ApiUrls.targetWeightEndPoint, bodyData,
          authToken: token);
      log("afterrResponse");
      log(response.statusCode.toString());
      if (response.statusCode == 200) {
        var dateObj = jsonDecode(response.body);
        var result = UserInfoResponseModel.fromJson(dateObj);
        log("targetWeightResponse --------------------------------\n$dateObj");
        isLoading.value = false;
        if (result.responseDto!.message == AppTexts.userSuccessResponse) {
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
      print(e);
      customSnackbar(title: AppTexts.error, message: "Api Exception");
      return false;
    }
  }
}
