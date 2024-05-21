import 'dart:convert';
import 'dart:developer';

import 'package:get/get.dart';
import 'package:weight_loss_app/common/api_urls.dart';
import 'package:weight_loss_app/common/app_texts.dart';
import 'package:weight_loss_app/common/questions_page_name.dart';
import 'package:weight_loss_app/modules/registeration_questions/models/user_info_response_model.dart';
import 'package:weight_loss_app/modules/registeration_questions/target_weight/binding/target_weight_binding.dart';
import 'package:weight_loss_app/modules/registeration_questions/target_weight/target_weight_page/target_weight_page.dart';
import 'package:weight_loss_app/utils/api_service.dart';
import 'package:weight_loss_app/utils/shared_prefrence.dart';
import 'package:weight_loss_app/widgets/custom_snackbar.dart';

class WeightController extends GetxController {
  var isLbs = true.obs;
  var isKg = false.obs;
  var sliderValue = 120.0.obs;
  var isShowResriction = false.obs;
  final ApiService apiService = ApiService();
  var isLoading = false.obs;
  double bmi(double height) {
    log("height: $height ");
    if (isLbs.value) {
      double heightInInches = (height / 2.54);
      return sliderValue.value / (heightInInches * heightInInches) * 703;
    } else {
      double heightInMeters = height / 100;
      return ((sliderValue.value) * 0.453592) /
          (heightInMeters * heightInMeters);
    }
  }

  Future<void> weightApi(double height) async {
    var weight = isLbs.value
        ? sliderValue.value.round()
        : isKg.value
            ? ((sliderValue.value) * 0.453592).round()
            : 0;
    var unit = isLbs.value
        ? "lb"
        : isKg.value
            ? "kg"
            : "null";
    // print("$weight$unit");
    Map<String, dynamic> bodyData = {
      "Weight": weight.toString(),
      "WeightUnit": unit,
      "PageName": QuestionPageNames.weightPageName,
    };
    try {
      isLoading.value = true;
      var token = await StorageServivce.getToken();
      await StorageServivce.saveCurrentWeight(weight);
      await StorageServivce.saveWeightUnit(unit);

      log("beforeResponse");
      var response = await apiService.patch(
          ApiUrls.weightEndPoint, jsonEncode(bodyData),
          authToken: token);
      log("afterrResponse");
      log(response.statusCode.toString());
      if (response.statusCode == 200) {
        var dateObj = jsonDecode(response.body);
        var result = UserInfoResponseModel.fromJson(dateObj);
        log("heightResponse --------------------------------\n$dateObj");
        isLoading.value = false;
        if (result.responseDto!.message == AppTexts.userSuccessResponse) {
          Get.to(
            () => TargetWeightPage(
              userWeight: sliderValue.value,
              isKg: isKg.value == true ? true : false,
              userHeight: height,
            ),
            binding: TargetWeightBinding(),
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
      print(e);
      customSnackbar(title: AppTexts.error, message: "Api Exception");
    }
  }
}
