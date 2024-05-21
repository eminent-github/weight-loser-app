import 'dart:convert';
import 'dart:developer';

import 'package:get/get.dart';
import 'package:weight_loss_app/common/api_urls.dart';
import 'package:weight_loss_app/common/app_texts.dart';
import 'package:weight_loss_app/modules/recipe/recipe_page/model/user_recipe_model.dart';
import 'package:weight_loss_app/utils/api_service.dart';
import 'package:weight_loss_app/utils/shared_prefrence.dart';
import 'package:weight_loss_app/widgets/custom_snackbar.dart';

class RecipeController extends GetxController {
  var isLoading = false.obs;
  final ApiService apiService = ApiService();
  var userRecipeData = UserRecipeModel().obs;
  var filterUserRecipeData = <UserCustomRecipeList>[].obs;

  @override
  void onInit() {
    getUserRecipe();
    super.onInit();
  }

  Future<void> getUserRecipe() async {
    try {
      isLoading.value = true;
      String? token = await StorageServivce.getToken();
      var response = await apiService.get(
        ApiUrls.userRecipeEndPoint,
        authToken: token,
      );
      log(response.statusCode.toString());
      if (response.statusCode == 200) {
        var dataObj = jsonDecode(response.body);
        log(dataObj.toString());
        userRecipeData.value = UserRecipeModel.fromMap(dataObj);
        log("list length ${userRecipeData.value.userCustomRecipeList!.length}");
        filterUserRecipeData
            .assignAll(userRecipeData.value.userCustomRecipeList!);

        isLoading.value = false;
      } else {
        isLoading.value = false;
        customSnackbar(title: AppTexts.error, message: "No record found");
      }
    } catch (e) {
      isLoading.value = false;
      log("exception ${e.toString()}");
    }
  }

  void filterFoods(String query) {
    if (query.isEmpty) {
      filterUserRecipeData
          .assignAll(userRecipeData.value.userCustomRecipeList!);
    } else {
      final result = userRecipeData.value.userCustomRecipeList!.where(
          (food) => food.name!.toLowerCase().contains(query.toLowerCase()));
      filterUserRecipeData.assignAll(result.toList());
    }
    update();
  }
}
