import 'dart:convert';
import 'dart:developer';

import 'package:get/get.dart';
import 'package:weight_loss_app/common/api_urls.dart';
import 'package:weight_loss_app/common/app_texts.dart';
import 'package:weight_loss_app/modules/dashbored/screens/home/screens/home_inner_mind/models/home_inner_mind_model.dart';
import 'package:weight_loss_app/modules/dashbored/screens/home/screens/home_inner_today/controller/home_inner_today_controller.dart';
import 'package:weight_loss_app/modules/diet/diet_plan_detail/controller/diet_plan_detail_controller.dart';
import 'package:weight_loss_app/modules/mind/mind_my_plans/models/mind_active_plans_model.dart';
import 'package:weight_loss_app/modules/mind/mind_plan_detail/binding/mind_paln_detial_binding.dart';
import 'package:weight_loss_app/modules/mind/mind_plan_detail/mind_paln_detail_page/mind_paln_detail_page.dart';
import 'package:weight_loss_app/utils/api_service.dart';
import 'package:weight_loss_app/utils/shared_prefrence.dart';
import 'package:weight_loss_app/widgets/custom_snackbar.dart';

class ActivateMindPlanController extends GetxController {
  final ApiService apiService = ApiService();
  var isLoading = false.obs;

  @override
  void onInit() {
    mindActivePlans();
    super.onInit();
  }

  Future<void> activateMindPlan(PlanData planList) async {
    Map<String, dynamic> bodyData = {
      "userId": planList.userId,
      "planId": planList.id,
      "type": "mind",
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

      if (response.statusCode == 200) {
        var dateObj = jsonDecode(response.body);

        if (dateObj["responseDto"]["status"] == true) {
          Get.find<HomeInnerTodayController>()
              .getTodayMeditationApi()
              .then((value) => isLoading.value = false)
              .onError((error, stackTrace) => isLoading.value = false);
          Get.off(
            () => MindPalnDetailPage(
              planTitle: planList.title!,
              planImage: null,
            ),
            binding: MindPalnDetailBinding(),
            arguments: PlanIdAndDuration(
                duration: planList.duration, planId: planList.id, day: 1),
          );
        } else {
          isLoading.value = false;
          customSnackbar(title: AppTexts.error, message: "Plan not activated");
        }
      } else {
        isLoading.value = false;
        customSnackbar(title: AppTexts.error, message: "No record found");
      }
    } catch (e) {
      isLoading.value = false;
      print(e);
    }
  }

  Rx<MindActivePlansModel> mindActivePlansModel = MindActivePlansModel().obs;
  Future<void> mindActivePlans() async {
    try {
      isLoading.value = true;
      String? token = await StorageServivce.getToken();
      var response = await apiService.get(
        ApiUrls.userActivePlanForMind,
        authToken: token,
      );

      if (response.statusCode == 200) {
        var dataObj = jsonDecode(response.body);
        isLoading.value = false;
        mindActivePlansModel.value = MindActivePlansModel.fromJson(dataObj);
        // log(exerciseActivePlansModel.value.activePlan!.length.toString());
      } else {
        isLoading.value = false;
        customSnackbar(title: AppTexts.error, message: "No record found");
      }
    } catch (e) {
      isLoading.value = false;
      log(e.toString());
    }
  }

  Future<void> addFavouriteMindPlan({
    required String planId,
  }) async {
    Map<String, dynamic> bodyData = {
      "favouriteCatagory": "mind",
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
