import 'dart:convert';
import 'dart:developer';

import 'package:get/get.dart';
import 'package:weight_loss_app/common/api_urls.dart';
import 'package:weight_loss_app/common/app_texts.dart';
import 'package:weight_loss_app/modules/favourite/model/favourite_model.dart';
import 'package:weight_loss_app/utils/api_service.dart';
import 'package:weight_loss_app/utils/shared_prefrence.dart';
import 'package:weight_loss_app/widgets/custom_snackbar.dart';

class DietFoodFavouriteController extends GetxController {
  final List<String> menuItems = [
    "All",
    'Breakfast',
    'Lunch',
    'Snacks',
    'Dinner'
  ];
  var isLoading = false.obs;
  var isDietFoodFavouriteLoading = false.obs;
  final ApiService apiService = ApiService();
  var favouriteIndex = 0.obs;

  var dietFoodFavouriteList = <FavouriteModel>[].obs;
  var filterFoodFavouriteList = <FavouriteModel>[].obs;

  @override
  void onInit() {
    getDietFavouriteApi();
    super.onInit();
  }

  Future<void> getDietFavouriteApi() async {
    try {
      isDietFoodFavouriteLoading.value = true;
      String? token = await StorageServivce.getToken();
      var response = await apiService.get(
        "${ApiUrls.getSubDietFavouriteEndPoint}?catagory=diet",
        authToken: token,
      );
      log("body : ${response.body}");
      if (response.statusCode == 200) {
        var dataObj = jsonDecode(response.body);
        var jsonList = dataObj["favouriteDataList"] as List;
        dietFoodFavouriteList.value =
            jsonList.map((e) => FavouriteModel.fromJson(e)).toList();
        filterFoodFavouriteList.assignAll(dietFoodFavouriteList);
        isDietFoodFavouriteLoading.value = false;
      } else {
        isDietFoodFavouriteLoading.value = false;
        customSnackbar(title: AppTexts.error, message: "No record found");
      }
    } catch (e) {
      isDietFoodFavouriteLoading.value = false;
      log("exception ${e.toString()}");
    }
  }

  Future<void> deleteFavouriteApi({required int favouriteId}) async {
    try {
      isLoading.value = true;
      String? token = await StorageServivce.getToken();
      var response = await apiService.delete(
        "${ApiUrls.deleteFavouriteEndPoint}?id=$favouriteId",
        authToken: token,
      );

      if (response.statusCode == 200) {
        // var dataObj = await jsonDecode(response.body);
        // print(dataObj);
        customSnackbar(
            title: AppTexts.success, message: 'Favourite Deleted successfully');

        isLoading.value = false;
        getDietFavouriteApi();
      } else {
        isLoading.value = false;
        customSnackbar(
            title: AppTexts.success, message: 'Favourite Not Deleted');
      }
    } catch (e) {
      isLoading.value = false;
      log(e.toString());
    }
  }

  void filterCousine(String query) {
    if (query == "All") {
      filterFoodFavouriteList.assignAll(dietFoodFavouriteList);
    } else {
      final result = dietFoodFavouriteList.where(
        (food) {
          if (food.mealType == null) {
            return false;
          }
          return food.mealType!.toLowerCase().contains(query.toLowerCase());
        },
      );
      filterFoodFavouriteList.assignAll(result.toList());
    }
    update();
  }
}
