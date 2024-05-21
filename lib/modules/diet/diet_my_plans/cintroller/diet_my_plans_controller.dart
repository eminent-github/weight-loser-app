import 'dart:convert';
import 'dart:developer';

import 'package:get/get.dart';
import 'package:weight_loss_app/common/api_urls.dart';
import 'package:weight_loss_app/common/app_texts.dart';
import 'package:weight_loss_app/modules/diet/diet_my_plans/models/diet_active_plans.dart';
import 'package:weight_loss_app/utils/api_service.dart';
import 'package:weight_loss_app/utils/shared_prefrence.dart';
import 'package:weight_loss_app/widgets/custom_snackbar.dart';

class DietMyPlansController extends GetxController {
  var isLoading = false.obs;
  final ApiService apiService = ApiService();
  Rx<DietActivePlans> getDietActivePlans = DietActivePlans().obs;
  @override
  void onInit() {
    dietActivePlans();
    super.onInit();
  }

  Future<void> dietActivePlans() async {
    try {
      isLoading.value = true;
      String? token = await StorageServivce.getToken();
      var response = await apiService.get(
        ApiUrls.userActivePlansEndPoint,
        authToken: token,
      );
      if (response.statusCode == 200) {
        var dataObj = jsonDecode(response.body);
        isLoading.value = false;
        getDietActivePlans.value = DietActivePlans.fromJson(dataObj);
        log(getDietActivePlans.value.activePlan!.length.toString());
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
