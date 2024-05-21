import 'dart:convert';
import 'dart:developer';

import 'package:get/get.dart';
import 'package:weight_loss_app/common/api_urls.dart';
import 'package:weight_loss_app/common/app_texts.dart';
import 'package:weight_loss_app/common/questions_page_name.dart';
import 'package:weight_loss_app/modules/registeration_questions/height/binding/height_binding.dart';
import 'package:weight_loss_app/modules/registeration_questions/height/height_page/height_page.dart';
import 'package:weight_loss_app/modules/registeration_questions/models/user_info_response_model.dart';
import 'package:weight_loss_app/utils/api_service.dart';
import 'package:weight_loss_app/utils/shared_prefrence.dart';
import 'package:weight_loss_app/widgets/custom_snackbar.dart';

class AgeController extends GetxController {
  DateTime currentDate = DateTime.now();
  var selectedDate = DateTime.now().obs;
  var isShowResriction = true.obs;
  var age = 0.obs;
  final ApiService apiService = ApiService();
  var isLoading = false.obs;
  Future<void> ageApi() async {
    Map<String, dynamic> bodyData = {
      "Age": age.value.toString(),
      "PageName": QuestionPageNames.agePageName,
    };
    try {
      isLoading.value = true;
      log("beforeResponse");
      var response = await apiService.formDataPatch(
          ApiUrls.ageEndPoint, bodyData,
          authToken: await StorageServivce.getToken());
      log("afterrResponse");
      log(response.statusCode.toString());
      if (response.statusCode == 200) {
        var dateObj = jsonDecode(response.body);
        var result = UserInfoResponseModel.fromJson(dateObj);
        log("ageResponse --------------------------------\n$dateObj");
        isLoading.value = false;
        if (result.responseDto!.message == "Data updated successfully") {
          Get.to(
            () => const HeightPage(),
            binding: HeightBinding(),
          );
        } else {
          customSnackbar(
              title: AppTexts.error, message: result.responseDto!.message);
        }
      } else {
        isLoading.value = false;
        customSnackbar(title: AppTexts.error, message: "Api response failed");
      }
    } catch (e) {
      isLoading.value = false;
      print(e);
      customSnackbar(title: AppTexts.error, message: "Api Exception");
    }
  }
}
