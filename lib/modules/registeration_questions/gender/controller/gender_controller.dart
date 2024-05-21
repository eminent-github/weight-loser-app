import 'dart:convert';
import 'dart:developer';

import 'package:get/get.dart';
import 'package:weight_loss_app/common/api_urls.dart';
import 'package:weight_loss_app/common/app_texts.dart';
import 'package:weight_loss_app/common/questions_page_name.dart';
import 'package:weight_loss_app/modules/registeration_questions/age/age_page/age_page.dart';
import 'package:weight_loss_app/modules/registeration_questions/age/binding/age_binding.dart';
import 'package:weight_loss_app/modules/registeration_questions/models/user_info_response_model.dart';
import 'package:weight_loss_app/modules/registeration_questions/pregnnnt/binding/pregnant_binding.dart';
import 'package:weight_loss_app/modules/registeration_questions/pregnnnt/pregnant_page/pregnant_page.dart';
import 'package:weight_loss_app/utils/api_service.dart';
import 'package:weight_loss_app/utils/shared_prefrence.dart';
import 'package:weight_loss_app/widgets/custom_snackbar.dart';

class GenderController extends GetxController {
  var selectedIndex = 0.obs;
  final ApiService apiService = ApiService();
  List<String> genderList = <String>[
    "Male",
    "Female",
    "Non Binary",
  ];
  var isLoading = false.obs;
  Future<void> genderApi() async {
    Map<String, dynamic> bodyData = {
      "Gender": genderList[selectedIndex.value],
      "PageName": QuestionPageNames.genderPageName,
    };
    try {
      isLoading.value = true;
      var token = await StorageServivce.getToken();
      log("beforeResponse");
      var response = await apiService
          .formDataPatch(ApiUrls.genderEndPoint, bodyData, authToken: token);
      log("afterrResponse${response.statusCode} body${response.body}");
      // log(token!);
      if (response.statusCode == 200) {
        var dateObj = jsonDecode(response.body);
        var result = UserInfoResponseModel.fromJson(dateObj);
        // log("signUpResponse --------------------------------\n$dateObj");
        isLoading.value = false;
        if (result.responseDto!.message == AppTexts.userSuccessResponse) {
          await StorageServivce.saveGender(genderList[selectedIndex.value]);
          if (genderList[selectedIndex.value] == "Female") {
            Get.to(
              const PregnantPage(),
              binding: PregnantBinding(),
            );
          } else {
            Get.to(
              () => const AgePage(),
              binding: AgeBinding(),
            );
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
      customSnackbar(title: AppTexts.error, message: "Api Exception");
    }
  }
}
