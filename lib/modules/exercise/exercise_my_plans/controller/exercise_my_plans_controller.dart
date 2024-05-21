import 'dart:convert';
import 'dart:developer';
import 'package:get/get.dart';
import 'package:weight_loss_app/common/api_urls.dart';
import 'package:weight_loss_app/common/app_texts.dart';
import 'package:weight_loss_app/modules/exercise/exercise_my_plans/model/active_exercise_plan_model.dart';
import 'package:weight_loss_app/utils/api_service.dart';
import 'package:weight_loss_app/utils/shared_prefrence.dart';
import 'package:weight_loss_app/widgets/custom_snackbar.dart';

class ExerciseMyPlansController extends GetxController {
  var isLoading = false.obs;
  final ApiService apiService = ApiService();
  Rx<ExerciseActivePlanModel> getExerciseActivePlans =
      ExerciseActivePlanModel().obs;
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
        ApiUrls.userActivePlanForExercises,
        authToken: token,
      );
      log(jsonDecode(response.body).toString());
      if (response.statusCode == 200) {
        var dataObj = jsonDecode(response.body);
        isLoading.value = false;
        getExerciseActivePlans.value =
            ExerciseActivePlanModel.fromJson(dataObj);
        log(getExerciseActivePlans.value.activePlan!.length.toString());
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
