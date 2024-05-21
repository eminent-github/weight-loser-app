import 'dart:convert';
import 'dart:developer';

import 'package:get/get.dart';
import 'package:weight_loss_app/common/api_urls.dart';
import 'package:weight_loss_app/common/app_texts.dart';
import 'package:weight_loss_app/modules/dashbored/screens/home/controller/home_controller.dart';
import 'package:weight_loss_app/modules/dashbored/screens/home/screens/home_inner_today/controller/home_inner_today_controller.dart';
import 'package:weight_loss_app/modules/diet/add_your_food/model/own_food_deatil_model.dart';
import 'package:weight_loss_app/modules/diet/diet_food_item_detial/model/diet_food_item_detail_model.dart';
import 'package:weight_loss_app/utils/api_service.dart';
import 'package:weight_loss_app/utils/shared_prefrence.dart';
import 'package:weight_loss_app/widgets/custom_snackbar.dart';

class OwnFoodDetailController extends GetxController {
  var isLoading = false.obs;
  final ApiService apiService = ApiService();
  Future<FoodItemDetailModel> getFoodDetail(String foodId) async {
    log("foodId:$foodId");

    String? token = await StorageServivce.getToken();
    var response = await apiService.get(
      "${ApiUrls.foodDetailEndPoint}/$foodId",
      authToken: token,
    );
    log("status code: ${response.statusCode} body : ${response.body}");
    if (response.statusCode == 200) {
      var dataObj = await jsonDecode(response.body);
      return FoodItemDetailModel.fromJson(dataObj);
    } else {
      throw Exception('Failed to load data');
    }
  }

  Future<void> addReplacedFood({
    required String planFoodId,
    required int planId,
    required OwnFoodDetailModel recipeDetialData,
  }) async {
    Map<String, dynamic> bodyData = {
      "planFoodId": "",
      "repFoodId": recipeDetialData.foodId,
      "planId": planId,
      "Day": recipeDetialData.day,
      "MealType": recipeDetialData.mealType,
      "Phase": recipeDetialData.phase,
      "ServingSize": recipeDetialData.servingSize
    };
    try {
      isLoading.value = true;
      String? token = await StorageServivce.getToken();
      var response = await apiService.post(
        ApiUrls.foodReplacementEndPoint,
        jsonEncode(bodyData),
        authToken: token,
      );
      log("code${response.statusCode} : body${response.body}");
      if (response.statusCode == 200) {
        var dataObj = await jsonDecode(response.body);
        log(dataObj.toString());
        customSnackbar(
            title: AppTexts.success,
            message: "This has been added to your nutrition plan.");
        Get.find<HomeInnerTodayController>().getTodayFoodApi().then((value) {
          isLoading.value = false;
          Get.find<HomeController>().tabController.animateTo(0);
          Get.until(
            (route) => route.isFirst,
          );
        }).onError((error, stackTrace) {
          isLoading.value = false;
          Get.back();
        });
      } else {
        isLoading.value = false;
        customSnackbar(title: AppTexts.error, message: 'Meal not Replaced');
      }
    } catch (e) {
      isLoading.value = false;
      log(e.toString());
    }
  }
}
