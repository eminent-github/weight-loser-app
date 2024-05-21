import 'dart:convert';
import 'dart:developer';

import 'package:get/get.dart';
import 'package:weight_loss_app/common/api_urls.dart';
import 'package:weight_loss_app/common/app_texts.dart';
import 'package:weight_loss_app/modules/dashbored/screens/home/screens/home_inner_diet/models/diet_popular_plans.dart';
import 'package:weight_loss_app/utils/api_service.dart';
import 'package:weight_loss_app/utils/shared_prefrence.dart';
import 'package:weight_loss_app/widgets/custom_snackbar.dart';

class HomeInnerDietController extends GetxController {
  var isLoading = false.obs;
  final ApiService apiService = ApiService();
  Rx<DietPopularPlans> getDietPopularPlans = DietPopularPlans().obs;
  @override
  void onInit() {
    getDietPlans();
    super.onInit();
  }

  Future<void> getDietPlans() async {
    try {
      isLoading.value = true;
      String? token = await StorageServivce.getToken();
      var response = await apiService.get(
        "${ApiUrls.getPopularPlansEndPoint}?planType=diet",
        authToken: token,
      );
      log("status code: ${response.statusCode} body: ${response.body}");

      if (response.statusCode == 200) {
        var dataObj = jsonDecode(response.body);
        isLoading.value = false;
        getDietPopularPlans.value = DietPopularPlans.fromJson(dataObj);
        // log("listLength: ${getDietPopularPlans.value.planList!.length.toString()}");
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
