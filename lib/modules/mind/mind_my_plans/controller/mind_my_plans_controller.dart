import 'dart:convert';
import 'dart:developer';

import 'package:get/get.dart';
import 'package:weight_loss_app/common/api_urls.dart';
import 'package:weight_loss_app/common/app_texts.dart';
import 'package:weight_loss_app/modules/mind/mind_my_plans/models/mind_active_plans_model.dart';
import 'package:weight_loss_app/utils/api_service.dart';
import 'package:weight_loss_app/utils/shared_prefrence.dart';
import 'package:weight_loss_app/widgets/custom_snackbar.dart';

class MindMyPlansController extends GetxController {
  final ApiService apiService = ApiService();
  var isLoading = false.obs;

  @override
  void onInit() {
    mindActivePlans();
    super.onInit();
  }

  Rx<MindActivePlansModel> mindActivePlansModel = MindActivePlansModel().obs;
  Future<void> mindActivePlans() async {
    try {
      isLoading.value = true;
      String? token = await StorageServivce.getToken();
      var response = await apiService.get(
        ApiUrls.userActivePlanForMind,
        authToken: token,
      );

      if (response.statusCode == 200) {
        var dataObj = jsonDecode(response.body);
        isLoading.value = false;
        mindActivePlansModel.value = MindActivePlansModel.fromJson(dataObj);
        // log(exerciseActivePlansModel.value.activePlan!.length.toString());
      } else {
        isLoading.value = false;
        customSnackbar(title: AppTexts.error, message: "No record found");
      }
    } catch (e) {
      isLoading.value = false;
      log(e.toString());
    }
  }
}
