import 'dart:convert';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:get/get.dart';
import 'package:weight_loss_app/common/api_urls.dart';
import 'package:weight_loss_app/common/app_texts.dart';
import 'package:weight_loss_app/modules/diet/diet_plan_detail/controller/diet_plan_detail_controller.dart';
import 'package:weight_loss_app/modules/exercise/exercise_plan_detail/models/exercise_item_detial_model.dart';
import 'package:weight_loss_app/utils/api_service.dart';
import 'package:weight_loss_app/utils/shared_prefrence.dart';
import 'package:weight_loss_app/widgets/custom_snackbar.dart';

class ExercisePlanDetialController extends GetxController {
  var selectedIndex = 0.obs;
  var isLoading = false.obs;
  final ApiService apiService = ApiService();
  var planIdAndDuration = PlanIdAndDuration().obs;
  late ScrollController scrollController;
  RxList<ExerciseItemDetailModel> getActivePlanDetailList =
      <ExerciseItemDetailModel>[].obs;
  @override
  void onInit() {
    planIdAndDuration.value = Get.arguments as PlanIdAndDuration;
    selectedIndex.value = planIdAndDuration.value.day! - 1;
    scrollController = ScrollController();
    SchedulerBinding.instance.addPostFrameCallback((_) {
      scrollController.jumpTo(
        selectedIndex.value * 61.7,
      );
    });
    planExercises(
        planIdAndDuration.value.planId!, planIdAndDuration.value.day!);
    super.onInit();
  }

  Future<void> planExercises(int planId, int day) async {
    log("planId:$planId day:$day");
    try {
      isLoading.value = true;
      String? token = await StorageServivce.getToken();
      var response = await apiService.get(
        "${ApiUrls.exercisePlanDetailEndPoint}?planId=$planId&day=$day",
        authToken: token,
      );
      log("status code : ${response.statusCode} body : ${response.body}");
      if (response.statusCode == 200) {
        var dataObj = jsonDecode(response.body);
        print(dataObj);
        var apiPlanList = dataObj["burners"] as List;

        getActivePlanDetailList.value = apiPlanList
            .map((e) => ExerciseItemDetailModel.fromJson(e))
            .toList();
        isLoading.value = false;
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
