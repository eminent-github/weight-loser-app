import 'dart:convert';
import 'dart:developer';
import 'package:get/get.dart';
import 'package:weight_loss_app/common/api_urls.dart';
import 'package:weight_loss_app/common/app_texts.dart';
import 'package:weight_loss_app/modules/dashbored/screens/home/screens/home_inner_today/controller/home_inner_today_controller.dart';
import 'package:weight_loss_app/modules/diary/controller/diary_controller.dart';
import 'package:weight_loss_app/modules/diet/diet_food_item_detial/model/diet_food_item_detail_model.dart';
import 'package:weight_loss_app/modules/progress_user/controller/progress_user_controller.dart';
import 'package:weight_loss_app/modules/recipe/add_recipe_discover/model/recipe_detial_model.dart';
import 'package:weight_loss_app/utils/api_service.dart';
import 'package:weight_loss_app/utils/shared_prefrence.dart';
import 'package:weight_loss_app/widgets/custom_snackbar.dart';

class AddRecipeDiscoverController extends GetxController {
  var isLoading = false.obs;
  final ApiService apiService = ApiService();
  final List<String> foodMenuItems = ['Breakfast', 'Lunch', 'Snacks', 'Dinner'];
  RxString foodSelectedItem = 'Breakfast'.obs;
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

  Future<void> saveUserTodayDiet({
    required RecipeDetialModel todayDietModel,
    required String foodId,
    required String mealType,
  }) async {
    // log(todayDietModel.mealType!.toLowerCase());
    Map<String, dynamic> bodyData = {
      "FoodType": mealType == "Snacks" ? "Snack" : mealType,
      "FoodId": foodId,
      "Cons_Cal": todayDietModel.calories,
      "ServingSize": int.parse(todayDietModel.servingSize),
      "fat": todayDietModel.fat,
      "Protein": todayDietModel.protein,
      "Carbs": todayDietModel.carbs
    };
    try {
      isLoading.value = true;
      String? token = await StorageServivce.getToken();
      var response = await apiService.post(
        ApiUrls.saveTodayDiet,
        jsonEncode(bodyData),
        authToken: token,
      );
      log("status code : ${response.statusCode} body ${response.body}");
      if (response.statusCode == 200) {
        // var dataObj = await jsonDecode(response.body);
        // log(DateTime.now().toString());
        // log(dataObj.toString());

        Get.find<DiaryController>()
            .getDiaryDetail(DateTime.now())
            .then((value) async {
          await Get.find<HomeInnerTodayController>().getTodayBudgetApi();
          await Get.find<ProgressUserController>().getUserStats();
          isLoading.value = false;
          Get.back();
          customSnackbar(
              title: AppTexts.success,
              message: "This has been added to your nutrition plan and diary");
        }).onError((error, stackTrace) {
          isLoading.value = false;
          print(error.toString());
        });
      } else {
        log(jsonDecode(response.body).toString());
        isLoading.value = false;
        customSnackbar(title: AppTexts.error, message: 'Diet not taken');
      }
    } catch (e) {
      isLoading.value = false;
      log(e.toString());
    }
  }

  // Future<void> addFavouriteFood({
  //   required int planId,
  //   required int id,
  // }) async {
  //   Map<String, dynamic> bodyData = {
  //     "foodId": id,
  //     "planId": planId,
  //     "favouriteCatagory": "recipe",
  //   };
  //   try {
  //     isLoading.value = true;
  //     String? token = await StorageServivce.getToken();
  //     var response = await apiService.post(
  //       ApiUrls.favouriteEndPoint,
  //       jsonEncode(bodyData),
  //       authToken: token,
  //     );
  //     if (response.statusCode == 200) {
  //       var dataObj = await jsonDecode(response.body);
  //       log(dataObj.toString());
  //       Get.back();
  //       customSnackbar(
  //           title: AppTexts.success,
  //           message: 'Added to Favourite successfully');
  //       isLoading.value = false;
  //     } else {
  //       isLoading.value = false;
  //       customSnackbar(title: AppTexts.success, message: 'Favourite not added');
  //     }
  //   } catch (e) {
  //     isLoading.value = false;
  //     log(e.toString());
  //   }
  // }
}
