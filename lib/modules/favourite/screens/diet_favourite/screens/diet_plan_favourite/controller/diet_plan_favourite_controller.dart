import 'dart:convert';
import 'dart:developer';

import 'package:get/get.dart';
import 'package:weight_loss_app/common/api_urls.dart';
import 'package:weight_loss_app/common/app_texts.dart';
import 'package:weight_loss_app/modules/dashbored/screens/home/screens/home_inner_diet/controller/home_inner_diet_controller.dart';
import 'package:weight_loss_app/modules/favourite/model/favourite_model.dart';
import 'package:weight_loss_app/utils/api_service.dart';
import 'package:weight_loss_app/utils/shared_prefrence.dart';
import 'package:weight_loss_app/widgets/custom_snackbar.dart';

class DietPlanFavouriteController extends GetxController {
  var isLoading = false.obs;
  var isDietFavouriteLoading = false.obs;
  final ApiService apiService = ApiService();

  var dietFavouriteList = <FavouriteModel>[].obs;

  @override
  void onInit() {
    getDietFavouriteApi();
    super.onInit();
  }

  Future<void> getDietFavouriteApi() async {
    try {
      isDietFavouriteLoading.value = true;
      String? token = await StorageServivce.getToken();
      var response = await apiService.get(
        "${ApiUrls.getFavouriteEndPoint}?catagory=diet",
        authToken: token,
      );
      log("body : ${response.body}");
      if (response.statusCode == 200) {
        var dataObj = jsonDecode(response.body);
        var jsonList = dataObj["favouriteDataList"] as List;
        dietFavouriteList.value =
            jsonList.map((e) => FavouriteModel.fromJson(e)).toList();

        isDietFavouriteLoading.value = false;
      } else {
        isDietFavouriteLoading.value = false;
        customSnackbar(title: AppTexts.error, message: "No record found");
      }
    } catch (e) {
      isDietFavouriteLoading.value = false;
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
        Get.find<HomeInnerDietController>().getDietPlans();
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
}
