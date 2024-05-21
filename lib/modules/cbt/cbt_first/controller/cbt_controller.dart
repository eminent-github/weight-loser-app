import 'dart:convert';
import 'dart:developer';
import 'package:get/get.dart';
import 'package:weight_loss_app/common/api_urls.dart';
import 'package:weight_loss_app/common/app_texts.dart';
import 'package:weight_loss_app/modules/cbt/cbt_summary/cbt_summary_page.dart';
import 'package:weight_loss_app/modules/cbt/model/cbt_questions_model.dart';
import 'package:weight_loss_app/utils/api_service.dart';
import 'package:weight_loss_app/utils/shared_prefrence.dart';
import 'package:weight_loss_app/widgets/custom_snackbar.dart';

class CbtController extends GetxController {
  final ApiService apiService = ApiService();
  var isLoading = false.obs;
  Future<void> cbtQusApi() async {
    try {
      isLoading.value = true;
      var token = await StorageServivce.getToken();
      log("beforeResponse");
      var response = await apiService.get(
        ApiUrls.getCbtQuestionsEndPoint,
        authToken: token,
      );
      log("api: ${ApiUrls.baseUrl + ApiUrls.getCbtQuestionsEndPoint} statusCode ${response.statusCode} body:${response.body}");
      var dateObj = jsonDecode(response.body);
      if (response.statusCode == 200) {
        var dateObj = jsonDecode(response.body);
        var dataList = dateObj["response"] as List;
        List<CBTQuestionsModel> cbtQuestionsList =
            dataList.map((e) => CBTQuestionsModel.fromJson(e)).toList();

        isLoading.value = false;
        Get.off(
          () => CBTSummary(cbtQuestionsList: cbtQuestionsList),
        );
      } else {
        isLoading.value = false;
        if (dateObj["message"] == "You are done for today") {
          customSnackbar(
              title: AppTexts.alert,
              message: dateObj["message"] ?? "Api Error"); 
        } else {
          customSnackbar(
              title: AppTexts.alert,
              message: AppTexts.userAPiExceptionResponse);
        }
      }
    } catch (e) {
      isLoading.value = false;
      // print(e);
      // customSnackbar(title: AppTexts.error, message: "Api Exception");
    }
  }
}
