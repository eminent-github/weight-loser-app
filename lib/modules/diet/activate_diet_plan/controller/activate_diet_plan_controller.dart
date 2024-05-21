import 'dart:convert';
import 'dart:developer';

import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:weight_loss_app/common/api_urls.dart';
import 'package:weight_loss_app/common/app_colors.dart';
import 'package:weight_loss_app/common/app_texts.dart';
import 'package:weight_loss_app/modules/dashbored/screens/home/screens/home_inner_diet/models/diet_popular_plans.dart';
import 'package:weight_loss_app/modules/dashbored/screens/home/screens/home_inner_today/controller/home_inner_today_controller.dart';
import 'package:weight_loss_app/modules/diet/diet_my_plans/models/diet_active_plans.dart';
import 'package:weight_loss_app/modules/diet/diet_plan_detail/binding/diet_plan_detail_binding.dart';
import 'package:weight_loss_app/modules/diet/diet_plan_detail/controller/diet_plan_detail_controller.dart';
import 'package:weight_loss_app/modules/diet/diet_plan_detail/diet_item_detail_page/diet_item_detail_page.dart';
import 'package:weight_loss_app/utils/api_service.dart';
import 'package:weight_loss_app/utils/shared_prefrence.dart';
import 'package:weight_loss_app/widgets/custom_snackbar.dart';

class ActivateDietPlanController extends GetxController {
  final ApiService apiService = ApiService();
  var isLoading = false.obs;
  var isPlanActivate = false.obs;

  viewPlan(PlanData planList) {
    Get.to(
      () => DietPlanDetailPage(
        planTitle: planList.title,
        planImage: planList.fileName,
        isActivated: isPlanActivate,
        activateViewedPlan: () async {
          int totalActivatedPlans =
              getDietActivePlans.value.activePlan!.length +
                  getDietActivePlans.value.prevActivePlan!.length;
          if (totalActivatedPlans >= 3) {
            customSnackbar(
                title: AppTexts.error,
                message: "You already Activated three plans");
          } else {
            await activatePlan(planList, true);
          }
        },
      ),
      binding: DietPlanDetailBinding(),
      arguments: PlanIdAndDuration(
          duration: planList.duration, planId: planList.id, day: 1),
    );
  }

  @override
  void onInit() {
    dietActivePlans();
    super.onInit();
  }

  @override
  void onClose() {
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle.light.copyWith(
      statusBarColor: AppColors.transparent,
    ));
    super.onClose();
  }

  Future<void> activatePlan(PlanData planList, bool isViewPlan) async {
    Map<String, dynamic> bodyData = {
      "userId": planList.userId,
      "planId": planList.id,
      "type": "diet",
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
      log("afterrResponse 10");
      var dateObj = jsonDecode(response.body);
      if (response.statusCode == 200) {
        if (dateObj["responseDto"]["status"] ?? false) {
          Get.find<HomeInnerTodayController>()
              .getTodayFoodApi()
              .then((value) => isLoading.value = false)
              .onError((error, stackTrace) => isLoading.value = false);
          isViewPlan
              ? isPlanActivate.value = true
              : Get.off(
                  () => DietPlanDetailPage(
                    planTitle: planList.title,
                    planImage: planList.fileName,
                    isActivated: true.obs,
                  ),
                  binding: DietPlanDetailBinding(),
                  arguments: PlanIdAndDuration(
                    duration: planList.duration,
                    planId: planList.id,
                    day: 1,
                  ),
                );
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

  Rx<DietActivePlans> getDietActivePlans = DietActivePlans().obs;
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

  Future<void> addFavouriteFood({
    required String planId,
  }) async {
    Map<String, dynamic> bodyData = {
      "favouriteCatagory": "diet",
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
        customSnackbar(title: AppTexts.error, message: 'Favourite not added');
      }
    } catch (e) {
      isLoading.value = false;
      log(e.toString());
    }
  }
}
