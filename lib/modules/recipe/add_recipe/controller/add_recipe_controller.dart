import 'dart:developer';

import 'package:get/get.dart';
import 'package:weight_loss_app/common/api_urls.dart';
import 'package:weight_loss_app/common/app_texts.dart';
import 'package:weight_loss_app/utils/api_service.dart';
import 'package:weight_loss_app/utils/shared_prefrence.dart';
import 'package:weight_loss_app/widgets/custom_snackbar.dart';

class AddRecipeController extends GetxController {
  var isLoading = false.obs;
  final ApiService apiService = ApiService();

  Future<void> addRecipeApi(
      {
        // required String fileName,
      required String recipeName,
      required int numberOfServing,
      required int calories,
      required double protein,
      required double carbs,
      required double fat,
      required String ingredients}) async {
    Map<String, dynamic> bodyData = {
      // "FileName": fileName,
      "Calories": calories.toString(),
      "Protein": protein.toString(),
      "Carbs": carbs.toString(),
      "fat": fat.toString(),
      "ServingSize": numberOfServing.toString(),
      "Name": recipeName,
      "Ingredients": ingredients,
    };
    try {
      isLoading.value = true;
      var token = await StorageServivce.getToken();
      log("beforeResponse");
      var response = await apiService.formDataPost(
          ApiUrls.addNewRecipeEndPoint, bodyData,
          authToken: token);
      log("afterrResponse");
      if (response.statusCode == 200) {
        isLoading.value = false;
        Get.until((route) => Get.currentRoute == "/RecipePage");
      } else {
        isLoading.value = false;
        customSnackbar(
            title: AppTexts.error, message: AppTexts.userAPiExceptionResponse);
      }
    } catch (e) {
      isLoading.value = false;
      log("catch $e");
      customSnackbar(title: AppTexts.error, message: "Api Exception");
    }
  }
}
