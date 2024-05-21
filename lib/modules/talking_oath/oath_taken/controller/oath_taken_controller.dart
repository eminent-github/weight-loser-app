import 'dart:convert';
import 'dart:developer';

import 'package:get/get.dart';
import 'package:weight_loss_app/common/api_urls.dart';
import 'package:weight_loss_app/common/app_texts.dart';
import 'package:weight_loss_app/utils/api_service.dart';
import 'package:weight_loss_app/utils/shared_prefrence.dart';
import 'package:weight_loss_app/widgets/custom_snackbar.dart';

class OathTakenController extends GetxController {
  var isLoading = false.obs;
  final ApiService apiService = ApiService();
  Future<void> takenOathApi() async {
    var body = {"isOath": "true"};
    try {
      isLoading.value = true;
      String? token = await StorageServivce.getToken();
      var response = await apiService.formDataPatch(
        ApiUrls.takingOathEndPoint,
        body,
        authToken: token,
      );
      log(response.statusCode.toString());
      if (response.statusCode == 200) {
        var dataObj = await jsonDecode(response.body);
        print(dataObj);
        isLoading.value = false;
        Get.back();
      } else {
        isLoading.value = false;
        customSnackbar(title: AppTexts.success, message: 'Oath Failed');
      }
    } catch (e) {
      isLoading.value = false;
      log(e.toString());
    }
  }

  var userName = ''.obs;
  var gender = 'Gender'.obs;

  getUserName() async {
    userName.value = await StorageServivce.getUserName() ?? 'unknown';
    gender.value = await StorageServivce.getGender() ?? 'Gender';
  }

  @override
  void onInit() {
    getUserName();
    super.onInit();
  }
}
