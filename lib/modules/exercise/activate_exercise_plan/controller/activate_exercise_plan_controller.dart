import 'dart:convert';
import 'dart:developer';

import 'package:get/get.dart';
import 'package:weight_loss_app/common/api_urls.dart';
import 'package:weight_loss_app/common/app_texts.dart';
import 'package:weight_loss_app/modules/dashbored/screens/home/screens/home_inner_exercise/model/home_inner_exercises_model.dart';
import 'package:weight_loss_app/modules/dashbored/screens/home/screens/home_inner_today/controller/home_inner_today_controller.dart';
import 'package:weight_loss_app/modules/diet/diet_plan_detail/controller/diet_plan_detail_controller.dart';
import 'package:weight_loss_app/modules/exercise/exercise_my_plans/model/active_exercise_plan_model.dart';
import 'package:weight_loss_app/modules/exercise/exercise_plan_detail/binding/exercise_plan_detial_binding.dart';
import 'package:weight_loss_app/modules/exercise/exercise_plan_detail/exercise_plan_detial_page/exercise_plan_detial_page.dart';
import 'package:weight_loss_app/utils/api_service.dart';
import 'package:weight_loss_app/utils/shared_prefrence.dart';
import 'package:weight_loss_app/widgets/custom_snackbar.dart';

class ActivateExercisePlanController extends GetxController {
  final ApiService apiService = ApiService();
  var isLoading = false.obs;

  @override
  void onInit() {
    exerciseActivePlans();
    super.onInit();
  }

  Future<void> activatePlan(PlanData planList) async {
    Map<String, dynamic> bodyData = {
      "userId": planList.userId,
      "planId": planList.id,
      "type": "exercise",
      "active": "true",
      "days": planList.duration,
    };
    try {
      isLoading.value = true;
      log("beforeResponse 9");
      String? token = await StorageServivce.getToken();
      var response = await apiService.post(
          ApiUrls.activatePlanEndPoint, json.encode(bodyData),
          authToken: token);
      log("afterrResponse ${response.statusCode} body: ${response.body}");

      if (response.statusCode == 200) {
        var dateObj = jsonDecode(response.body);

        if (dateObj["responseDto"]["status"] ?? false) {
          Get.find<HomeInnerTodayController>()
              .getTodayExerciseApi()
              .then((value) => isLoading.value = false)
              .onError((error, stackTrace) => isLoading.value = false);
          Get.off(
            () => ExercisePlanDetialPage(
                planTitle: planList.title!, planImage: null),
            binding: ExercisePlanDetialBinding(),
            arguments: PlanIdAndDuration(
                duration: planList.duration, planId: planList.id, day: 1),
          );
          // Get.to(
          //   () => DietPlanDetailPage(
          //     planTitle: planList.title,
          //     isActivated: true,
          //   ),
          //   binding: DietPlanDetailBinding(),
          //   arguments: PlanIdAndDuration(
          //     duration: planList.duration,
          //     planId: planList.id,
          //   ),
          // );
        } else {
          isLoading.value = false;
          customSnackbar(
              title: AppTexts.alert,
              message: dateObj["responseDto"]["message"] ?? "No record Found");
        }
      } else {
        isLoading.value = false;
        customSnackbar(title: AppTexts.error, message: "No record found");
      }
    } catch (e) {
      isLoading.value = false;
      // print(e);
    }
  }

  Rx<ExerciseActivePlanModel> exerciseActivePlansModel =
      ExerciseActivePlanModel().obs;
  Future<void> exerciseActivePlans() async {
    try {
      isLoading.value = true;
      String? token = await StorageServivce.getToken();
      var response = await apiService.get(
        ApiUrls.userActivePlanForExercises,
        authToken: token,
      );

      if (response.statusCode == 200) {
        var dataObj = jsonDecode(response.body);
        isLoading.value = false;
        exerciseActivePlansModel.value =
            ExerciseActivePlanModel.fromJson(dataObj);
        log(exerciseActivePlansModel.value.activePlan!.length.toString());
      } else {
        isLoading.value = false;
        customSnackbar(title: AppTexts.error, message: "No record found");
      }
    } catch (e) {
      isLoading.value = false;
      log(e.toString());
    }
  }

  Future<void> addFavouriteFood({
    required String planId,
  }) async {
    Map<String, dynamic> bodyData = {
      "favouriteCatagory": "exercise",
      "planId": planId,
    };
    try {
      isLoading.value = true;
      String? token = await StorageServivce.getToken();
      var response = await apiService.post(
        ApiUrls.favouriteEndPoint,
        jsonEncode(bodyData),
        authToken: token,
      );

      if (response.statusCode == 200) {
        var dataObj = await jsonDecode(response.body);
        log(dataObj.toString());
        Get.back();
        customSnackbar(
            title: AppTexts.success,
            message: 'Added to Favourite successfully');
        isLoading.value = false;
      } else {
        isLoading.value = false;
        customSnackbar(title: AppTexts.success, message: 'Favourite not added');
      }
    } catch (e) {
      isLoading.value = false;
      log(e.toString());
    }
  }
}
