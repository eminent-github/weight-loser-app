import 'dart:convert';
import 'dart:developer';

import 'package:get/get.dart';
import 'package:weight_loss_app/common/api_urls.dart';
import 'package:weight_loss_app/common/app_texts.dart';
import 'package:weight_loss_app/common/questions_page_name.dart';
import 'package:weight_loss_app/modules/registeration_questions/models/user_info_response_model.dart';
import 'package:weight_loss_app/modules/registeration_questions/weight/binding/weight_binding.dart';
import 'package:weight_loss_app/modules/registeration_questions/weight/weight_page/weight_page.dart';
import 'package:weight_loss_app/utils/api_service.dart';
import 'package:weight_loss_app/utils/shared_prefrence.dart';
import 'package:weight_loss_app/widgets/custom_snackbar.dart';

class HeightController extends GetxController {
  var isFt = true.obs;
  var isCm = false.obs;
  var sliderValue = 54.0.obs;
  final ApiService apiService = ApiService();
  var isLoading = false.obs;

  Future<void> heightApi() async {
    var height = ((sliderValue.value) * 2.54).toPrecision(1);

    Map<String, dynamic> bodyData = {
      "Height": height.toInt().toString(),
      "HeightUnit": "cm",
      "PageName": QuestionPageNames.heightPageName,
    };
    try {
      isLoading.value = true;
      var token = await StorageServivce.getToken();
      log("beforeResponse");
      var response = await apiService
          .formDataPatch(ApiUrls.heightEndPoint, bodyData, authToken: token);
      log("afterrResponse");
      log(response.statusCode.toString());
      if (response.statusCode == 200) {
        var dateObj = jsonDecode(response.body);
        var result = UserInfoResponseModel.fromJson(dateObj);
        log("heightResponse --------------------------------\n$dateObj");
        log("heightResult --------------------------------\n$result");
        isLoading.value = false;
        if (result.responseDto!.message == AppTexts.userSuccessResponse) {
          Get.to(
            () => WeightPage(
              userHeight: height,
            ),
            binding: WeightBinding(),
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
      customSnackbar(title: AppTexts.error, message: "Api Exception");
    }
  }
}
