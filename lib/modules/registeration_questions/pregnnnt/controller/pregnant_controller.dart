import 'dart:convert';
import 'dart:developer';

import 'package:get/get.dart';
import 'package:weight_loss_app/common/api_urls.dart';
import 'package:weight_loss_app/common/app_texts.dart';
import 'package:weight_loss_app/common/questions_page_name.dart';
import 'package:weight_loss_app/modules/registeration_questions/age/age_page/age_page.dart';
import 'package:weight_loss_app/modules/registeration_questions/age/binding/age_binding.dart';
import 'package:weight_loss_app/modules/registeration_questions/models/user_info_response_model.dart';
import 'package:weight_loss_app/modules/registeration_questions/stopping_point/binding/stopping_point_binding.dart';
import 'package:weight_loss_app/modules/registeration_questions/stopping_point/stopping_point_page/stopping_point_page.dart';
import 'package:weight_loss_app/utils/api_service.dart';
import 'package:weight_loss_app/utils/shared_prefrence.dart';
import 'package:weight_loss_app/widgets/custom_snackbar.dart';

class PregnantController extends GetxController {
  var selectedIndex = 1.obs;
  var isYesSelected = false.obs;
  List<String> isPregnentList = <String>[
    "Yes",
    "No",
  ];
  final ApiService apiService = ApiService();
  var isLoading = false.obs;
  Future<void> pregnentApi() async {
    Map<String, dynamic> bodyData = {
      "isPregnant": isYesSelected.value.toString(),
      "PageName": QuestionPageNames.pregnantPageName,
    };
    try {
      isLoading.value = true;
      var token = await StorageServivce.getToken();
      log("beforeResponse");
      var response = await apiService
          .formDataPatch(ApiUrls.pregnentEndPoint, bodyData, authToken: token);
      log("afterrResponse");
      log(response.statusCode.toString());
      if (response.statusCode == 200) {
        var dateObj = jsonDecode(response.body);
        var result = UserInfoResponseModel.fromJson(dateObj);
        log("signUpResponse --------------------------------\n$dateObj");
        isLoading.value = false;
        if (result.responseDto!.message == AppTexts.userSuccessResponse) {
          if (isPregnentList[selectedIndex.value] == "Yes") {
            Get.to(const StoppingPointPage(), binding: StoppingPointBinding());
          } else {
            Get.to(const AgePage(), binding: AgeBinding());
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
      print(e);
      customSnackbar(title: AppTexts.error, message: "Api Exception");
    }
  }
}
