import 'dart:convert';
import 'dart:developer';

import 'package:get/get.dart';
import 'package:get/get_rx/src/rx_workers/utils/debouncer.dart';
import 'package:weight_loss_app/common/api_urls.dart';
import 'package:weight_loss_app/common/app_texts.dart';
// import 'package:weight_loss_app/modules/diet/add_your_food/model/food_replacement_model.dart';
import 'package:weight_loss_app/modules/recipe/search_ingredient/model/search_ingredients_model.dart';
import 'package:weight_loss_app/utils/api_service.dart';
import 'package:weight_loss_app/utils/shared_prefrence.dart';
import 'package:weight_loss_app/widgets/custom_snackbar.dart';

class AddYourFoodController extends GetxController {
  final ApiService apiService = ApiService();
  var isLoading = false.obs;
  var isAddMealLoading = false.obs;
  var phaseId = 1;
  var mealType = ''.obs;
  // var foodList = <FoodList>[].obs;
  // var filteredFoodList = <FoodList>[].obs;
  final debouncer = Debouncer(delay: const Duration(milliseconds: 500));
  getPhaseIdAndMealType(int valForPhaseId, String valForMealType) {
    phaseId = valForPhaseId;
    mealType.value = valForMealType;
  }

  var filteredFoodList = <SearchIngredientsModel>[].obs;

  Future<void> fetchIngredients(String query) async {
    try {
      isLoading.value = true;
      String? token = await StorageServivce.getToken();
      var response = await apiService.postWithoutBody(
        "${ApiUrls.searchIngredientsEndPoint}?name=$query",
        authToken: token,
      );
      log(response.statusCode.toString());
      if (response.statusCode == 200) {
        var dataObj = jsonDecode(response.body);
        var jsonList = dataObj["foodList"] as List;
        isLoading.value = false;
        filteredFoodList.value =
            jsonList.map((e) => SearchIngredientsModel.fromJson(e)).toList();
      } else {
        isLoading.value = false;
        customSnackbar(title: AppTexts.error, message: "No record found");
      }
    } catch (e) {
      isLoading.value = false;
      log("exception ${e.toString()}");
    }
  }

  // @override
  // void onInit() {
  //   getAllFoodsForReplacement();
  //   super.onInit();
  // }

  // Future<void> getAllFoodsForReplacement() async {
  //   try {
  //     isLoading.value = true;
  //     String? token = await StorageServivce.getToken();
  //     var response = await apiService.get(
  //       "${ApiUrls.foodReplacementEndPoint}/${mealType.value}",
  //       authToken: token,
  //     );

  //     if (response.statusCode == 200) {
  //       var dataObj = await jsonDecode(response.body);
  //       // print(dataObj);
  //       foodList.value = dataObj["foodList"] != null
  //           ? List<FoodList>.from(
  //               (dataObj["foodList"] as List<dynamic>).map<FoodList>(
  //                 (e) => FoodList.fromJson(e as Map<String, dynamic>),
  //               ),
  //             )
  //           : [];
  //       filteredFoodList.assignAll(foodList);
  //       isLoading.value = false;
  //     } else {
  //       isLoading.value = false;
  //       customSnackbar(title: AppTexts.error, message: "No record found");
  //     }
  //   } catch (e) {
  //     isLoading.value = false;
  //     log(e.toString());
  //   }
  // }

  // void filterFoods(String query) {
  //   if (query.isEmpty) {
  //     filteredFoodList
  //         .assignAll(foodList); // Show all items when query is empty
  //   } else {
  //     final result = foodList.where(
  //         (food) => food.name!.toLowerCase().contains(query.toLowerCase()));
  //     filteredFoodList.assignAll(result.toList());
  //   }
  // }

  // Future<void> addReplacedFood({
  //   required String planFoodId,
  //   required String repFoodId,
  //   required String planId,
  // }) async {
  //   Map<String, dynamic> bodyData = {
  //     "planFoodId": planFoodId,
  //     "repFoodId": repFoodId,
  //     "planId": planId
  //   };
  //   try {
  //     isAddMealLoading.value = true;
  //     String? token = await StorageServivce.getToken();
  //     var response = await apiService.post(
  //       ApiUrls.foodReplacementEndPoint,
  //       jsonEncode(bodyData),
  //       authToken: token,
  //     );
  //     log("code${response.statusCode} : body${response.body}");
  //     if (response.statusCode == 200) {
  //       var dataObj = await jsonDecode(response.body);
  //       log(dataObj.toString());
  //       // customSnackbar(
  //       //     title: AppTexts.success, message: 'Food added successfully');
  //       isAddMealLoading.value = false;
  //       Get.back();
  //     } else {
  //       isAddMealLoading.value = false;
  //       customSnackbar(title: AppTexts.success, message: 'Meal not added');
  //     }
  //   } catch (e) {
  //     isAddMealLoading.value = false;
  //     log(e.toString());
  //   }
  // }
}
