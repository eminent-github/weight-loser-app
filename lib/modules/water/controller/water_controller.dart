import 'dart:convert';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:weight_loss_app/common/api_urls.dart';
import 'package:weight_loss_app/common/app_texts.dart';
import 'package:weight_loss_app/modules/diary/controller/diary_controller.dart';
import 'package:weight_loss_app/modules/progress_user/controller/progress_user_controller.dart';
import 'package:weight_loss_app/modules/water/model/water_model.dart';
import 'package:weight_loss_app/utils/api_service.dart';
import 'package:weight_loss_app/utils/shared_prefrence.dart';
import 'package:weight_loss_app/widgets/custom_snackbar.dart';

class WaterController extends GetxController {
  final TextEditingController intakeController = TextEditingController();
  var numberOfGlasses = 0.obs;
  var selectedDate = DateFormat("yyyy-MM-dd").format(DateTime.now()).obs;

  @override
  void onInit() {
    getWaterDetailList(selectedDate.value);
    super.onInit();
  }

  @override
  void dispose() {
    intakeController.dispose();
    super.dispose();
  }

  var isLoading = false.obs;
  final ApiService apiService = ApiService();
  RxList<WaterModel> userWaterDetailList = <WaterModel>[].obs;
  Future<void> getWaterDetailList(String dateTime) async {
    log("dateTime:$dateTime");
    try {
      isLoading.value = true;
      String? token = await StorageServivce.getToken();
      var response = await apiService.get(
        "${ApiUrls.getWaterInfo}?filter_date=$dateTime",
        authToken: token,
      );
      log("status code ${response.statusCode} body: ${response.body}");
      if (response.statusCode == 200) {
        var dataObj = jsonDecode(response.body);
        var apiPlanList = dataObj["waterHisList"] as List;
        userWaterDetailList.value =
            apiPlanList.map((e) => WaterModel.fromJson(e)).toList();

        numberOfGlasses.value = userWaterDetailList.fold(
            0, (value, element) => value + element.serving!);
        log("total glass $numberOfGlasses");
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

  var isToadayWaterLoading = false.obs;
  Future<void> saveUserTodayWater({
    required int numberOfGlass,
  }) async {
    // log(todayDietModel.mealType!.toLowerCase());
    Map<String, dynamic> bodyData = {
      "FoodType": "water",
      "WaterServing": numberOfGlass,
    };
    intakeController.clear();
    try {
      isToadayWaterLoading.value = true;
      String? token = await StorageServivce.getToken();
      var response = await apiService.post(
        ApiUrls.saveTodayDiet,
        jsonEncode(bodyData),
        authToken: token,
      );
      log(response.statusCode.toString());
      if (response.statusCode == 200) {
        customSnackbar(
            title: AppTexts.success,
            message: "You've had your $numberOfGlass glasses of water today");
        Get.find<ProgressUserController>().getUserStats();
        Get.find<DiaryController>()
            .getDiaryDetail(DateTime.now())
            .then((value) {
          getWaterDetailList(selectedDate.value);
          isToadayWaterLoading.value = false;
        }).onError((error, stackTrace) {
          getWaterDetailList(selectedDate.value);
          isToadayWaterLoading.value = false;
        });
        // getWaterDetailList(selectedDate.value);
        // isToadayWaterLoading.value = false;
      } else {
        log(jsonDecode(response.body).toString());
        isToadayWaterLoading.value = false;
        customSnackbar(title: AppTexts.success, message: 'Diet not taken');
      }
    } catch (e) {
      isToadayWaterLoading.value = false;
      log(e.toString());
    }
  }

  Future<void> editUserTodayWater({
    required int numberOfGlass,
    required String dateTime,
  }) async {
    // log(todayDietModel.mealType!.toLowerCase());
    Map<String, dynamic> bodyData = {
      "Serving": numberOfGlass,
      "Date": dateTime,
    };

    try {
      isToadayWaterLoading.value = true;
      String? token = await StorageServivce.getToken();
      var response = await apiService.post(
        ApiUrls.editTodayDiet,
        jsonEncode(bodyData),
        authToken: token,
      );
      log(response.statusCode.toString());
      if (response.statusCode == 200) {
        customSnackbar(
            title: AppTexts.success,
            message: "Water intake has been reset successfully");
        Get.find<DiaryController>()
            .getDiaryDetail(DateTime.now())
            .then((value) {
          getWaterDetailList(selectedDate.value);
          isToadayWaterLoading.value = false;
        }).onError((error, stackTrace) {
          getWaterDetailList(selectedDate.value);
          isToadayWaterLoading.value = false;
        });
        // getWaterDetailList(selectedDate.value);
        // isToadayWaterLoading.value = false;
      } else {
        log(jsonDecode(response.body).toString());
        isToadayWaterLoading.value = false;
        customSnackbar(title: AppTexts.success, message: 'Water not Reset');
      }
    } catch (e) {
      isToadayWaterLoading.value = false;
      log(e.toString());
    }
  }
}
