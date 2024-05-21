import 'dart:convert';
import 'dart:developer';

import 'package:get/get.dart';
import 'package:weight_loss_app/common/api_urls.dart';
import 'package:weight_loss_app/common/app_texts.dart';
import 'package:weight_loss_app/modules/dashbored/screens/home/screens/home_inner_exercise/model/home_inner_exercises_model.dart';
import 'package:weight_loss_app/utils/api_service.dart';
import 'package:weight_loss_app/utils/shared_prefrence.dart';
import 'package:weight_loss_app/widgets/custom_snackbar.dart';

class HomeInnerExerciseController extends GetxController {
  var isLoading = false.obs;
  final ApiService apiService = ApiService();
  Rx<HomeInnerExercisesModel> getExercisePlans = HomeInnerExercisesModel().obs;
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
        "${ApiUrls.getPopularPlansEndPoint}?planType=exercise",
        authToken: token,
      );
      log("code : ${response.statusCode} body : ${response.body}");

      if (response.statusCode == 200) {
        var dataObj = jsonDecode(response.body);
        isLoading.value = false;
        getExercisePlans.value = HomeInnerExercisesModel.fromJson(dataObj);
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
