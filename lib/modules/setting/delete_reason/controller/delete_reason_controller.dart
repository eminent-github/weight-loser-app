import 'dart:developer';
import 'package:weight_loss_app/modules/setting/delete_account/binding/delete_account_binding.dart';
import 'package:weight_loss_app/modules/setting/delete_account/view/delete_account_page.dart';
import 'package:get/get.dart';
import 'package:weight_loss_app/common/api_urls.dart';
import 'package:weight_loss_app/common/app_texts.dart';
import 'package:weight_loss_app/utils/api_service.dart';
import 'package:weight_loss_app/widgets/custom_snackbar.dart';

import '../../../../utils/shared_prefrence.dart';

class DeleteReasonController extends GetxController {
  var selectedIndex = 0.obs;
  var isLoading = false.obs;
  final ApiService apiService = ApiService();

  var optionList = [
    "Achieved desired weight loss goals",
    "Dissatisfied with the app's meal plans",
    "Prefer a different exercise regimen",
    "Found better support elsewhere",
    "Privacy concerns",
    "Financial reasons",
    "Other",
  ];
  Future<void> reviewApi(String reason) async {
    Map<String, dynamic> bodyData = {
      "review": reason,
    };
    try {
      isLoading.value = true;
      log("beforeResponse 9");
      String? token = await StorageServivce.getToken();
      var response = await apiService.formDataPost(
        ApiUrls.userReviewEndPoint,
        bodyData,
        authToken: token,
      );
      log("afterrResponse 10");

      if (response.statusCode == 200) {
        isLoading.value = false;
        Get.to(() => const DeleteAccountPage(),
            binding: DeleteAccountBinding());
      } else {
        isLoading.value = false;
        customSnackbar(title: AppTexts.error, message: "Record not found.");
      }
    } catch (e) {
      isLoading.value = false;
      log("$e");
    }
  }
}
