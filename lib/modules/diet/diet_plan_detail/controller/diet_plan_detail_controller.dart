// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:get/get.dart';

import 'package:weight_loss_app/common/api_urls.dart';
import 'package:weight_loss_app/common/app_texts.dart';
import 'package:weight_loss_app/utils/api_service.dart';
import 'package:weight_loss_app/utils/shared_prefrence.dart';
import 'package:weight_loss_app/widgets/custom_snackbar.dart';

import '../models/diet_plan_detail_model.dart';

class DietPlanDetailController extends GetxController {
  var selectedIndex = 0.obs;
  var isLoading = false.obs;
  var isAddFavouriteLoading = false.obs;
  final ApiService apiService = ApiService();
  var planIdAndDuration = PlanIdAndDuration().obs;
  late ScrollController scrollController;
  RxList<DietPlanDetialModel> getActivePlanList = <DietPlanDetialModel>[].obs;
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
    dietActivePlans(planIdAndDuration.value.planId!,
        planIdAndDuration.value.day! > 0 ? planIdAndDuration.value.day! : 1);
    super.onInit();
  }

  Future<void> dietActivePlans(int planId, int day) async {
    log("planId:$planId day:$day");
    try {
      isLoading.value = true;
      String? token = await StorageServivce.getToken();
      var response = await apiService.get(
        "${ApiUrls.foodPlanDetailEndPoint}?planId=$planId&day=$day",
        authToken: token,
      );
      log(jsonDecode(response.body).toString());
      if (response.statusCode == 200) {
        var dataObj = jsonDecode(response.body);
        var apiPlanList = dataObj["foods"] as List;
        isLoading.value = false;
        getActivePlanList.value =
            apiPlanList.map((e) => DietPlanDetialModel.fromJson(e)).toList();
        log(getActivePlanList.length.toString());
      } else {
        isLoading.value = false;
        getActivePlanList.value = [];
        customSnackbar(title: AppTexts.error, message: "No record found");
      }
    } catch (e) {
      isLoading.value = false;
      log(e.toString());
    }
  }

  Future<void> addFavouriteFood({
    required String foodId,
    required String planId,
    required String dietType,
  }) async {
    Map<String, dynamic> bodyData = {
      "favouriteCatagory": "diet",
      "planId": planId,
      "foodId": foodId,
    };
    try {
      isAddFavouriteLoading.value = true;
      String? token = await StorageServivce.getToken();
      var response = await apiService.post(
        ApiUrls.favouriteEndPoint,
        jsonEncode(bodyData),
        authToken: token,
      );

      if (response.statusCode == 200) {
        var dataObj = await jsonDecode(response.body);
        log(dataObj.toString());
        customSnackbar(
            title: AppTexts.success,
            message: '$dietType added to favourite successfully');
        dietActivePlans(
            planIdAndDuration.value.planId!,
            planIdAndDuration.value.day! > 0
                ? planIdAndDuration.value.day!
                : 1);
        isAddFavouriteLoading.value = false;
      } else {
        isAddFavouriteLoading.value = false;
        customSnackbar(title: AppTexts.error, message: 'Favourite not added');
      }
    } catch (e) {
      isAddFavouriteLoading.value = false;
      log(e.toString());
    }
  }
}

class PlanIdAndDuration {
  int? planId;
  int? duration;
  int? day;
  PlanIdAndDuration({
    this.planId,
    this.duration,
    this.day,
  });
}
