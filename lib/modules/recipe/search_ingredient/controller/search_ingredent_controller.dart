import 'dart:convert';
import 'dart:developer';

import 'package:get/get.dart';
import 'package:get/get_rx/src/rx_workers/utils/debouncer.dart';
import 'package:weight_loss_app/common/api_urls.dart';
import 'package:weight_loss_app/common/app_texts.dart';
import 'package:weight_loss_app/modules/recipe/search_ingredient/model/search_ingredients_model.dart';
import 'package:weight_loss_app/utils/api_service.dart';
import 'package:weight_loss_app/utils/shared_prefrence.dart';
import 'package:weight_loss_app/widgets/custom_snackbar.dart';

class SearchIngredientsController extends GetxController {
  var isLoading = false.obs;
  final ApiService apiService = ApiService();
  var ingredientsList = <SearchIngredientsModel>[].obs;
  final debouncer = Debouncer(delay: const Duration(milliseconds: 500));
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
        ingredientsList.value =
            jsonList.map((e) => SearchIngredientsModel.fromJson(e)).toList();
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
}
