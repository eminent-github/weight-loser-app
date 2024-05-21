import 'dart:convert';
import 'dart:developer';

import 'package:get/get.dart';
import 'package:weight_loss_app/common/api_urls.dart';
import 'package:weight_loss_app/common/app_texts.dart';
import 'package:weight_loss_app/modules/favourite/model/favourite_model.dart';
import 'package:weight_loss_app/utils/api_service.dart';
import 'package:weight_loss_app/utils/shared_prefrence.dart';
import 'package:weight_loss_app/widgets/custom_snackbar.dart';

class MindFavouriteController extends GetxController {
  var isLoading = false.obs;
  var isMindFavouriteLoading = false.obs;
  final ApiService apiService = ApiService();

  var mindFavouriteList = <FavouriteModel>[].obs;

  @override
  void onInit() {
    getMindFavouriteApi();
    super.onInit();
  }

  Future<void> getMindFavouriteApi() async {
    try {
      isMindFavouriteLoading.value = true;
      String? token = await StorageServivce.getToken();
      var response = await apiService.get(
        "${ApiUrls.getFavouriteEndPoint}?catagory=mind",
        authToken: token,
      );
      log(response.statusCode.toString());
      if (response.statusCode == 200) {
        var dataObj = jsonDecode(response.body);
        var jsonList = dataObj["favouriteDataList"] as List;
        mindFavouriteList.value =
            jsonList.map((e) => FavouriteModel.fromJson(e)).toList();

        isMindFavouriteLoading.value = false;
      } else {
        isMindFavouriteLoading.value = false;
        customSnackbar(title: AppTexts.error, message: "No record found");
      }
    } catch (e) {
      isMindFavouriteLoading.value = false;
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
        getMindFavouriteApi();
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
