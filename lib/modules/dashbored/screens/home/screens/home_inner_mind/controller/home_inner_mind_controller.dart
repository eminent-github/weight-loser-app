import 'dart:convert';
import 'dart:developer';

import 'package:get/get.dart';
import 'package:weight_loss_app/common/api_urls.dart';
import 'package:weight_loss_app/common/app_texts.dart';
import 'package:weight_loss_app/modules/dashbored/screens/home/screens/home_inner_mind/models/home_inner_mind_model.dart';
import 'package:weight_loss_app/utils/api_service.dart';
import 'package:weight_loss_app/utils/shared_prefrence.dart';
import 'package:weight_loss_app/widgets/custom_snackbar.dart';

class HomeInnerMindController extends GetxController {
  var isLoading = false.obs;
  final ApiService apiService = ApiService();
  Rx<HomeInnerMindModel> homeInnerMindPlans = HomeInnerMindModel().obs;
  @override
  void onInit() {
    getMindPlans();
    super.onInit();
  }

  Future<void> getMindPlans() async {
    try {
      isLoading.value = true;
      String? token = await StorageServivce.getToken();
      var response = await apiService.get(
        "${ApiUrls.getPopularPlansEndPoint}?planType=mind",
        authToken: token,
      );
      log(token!);

      if (response.statusCode == 200) {
        var dataObj = jsonDecode(response.body);
        isLoading.value = false;
        homeInnerMindPlans.value = HomeInnerMindModel.fromJson(dataObj);
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
