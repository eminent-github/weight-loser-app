import 'dart:convert';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:weight_loss_app/common/api_urls.dart';
import 'package:weight_loss_app/common/app_colors.dart';
import 'package:weight_loss_app/common/app_texts.dart';
import 'package:weight_loss_app/modules/cheat_food/model/cheat_food_model.dart';
import 'package:weight_loss_app/utils/api_service.dart';
import 'package:weight_loss_app/utils/shared_prefrence.dart';
import 'package:weight_loss_app/widgets/custom_snackbar.dart';

class CheatFoodController extends GetxController {
  var selectedDate = DateTime.now().obs;
  var isLoading = false.obs;
  var isPostFoodLoading = false.obs;
  final ApiService apiService = ApiService();
  late final TextEditingController caloriesController;
  late final TextEditingController nameController;
  var cheatFoodModel = CheatFoodModel().obs;

  @override
  void onInit() {
    caloriesController = TextEditingController();
    nameController = TextEditingController();
    getCheatFoodApi();
    super.onInit();
  }

  @override
  void dispose() {
    caloriesController.dispose();
    nameController.dispose();
    super.dispose();
  }

  Future<void> selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: selectedDate.value,
      firstDate: DateTime.now(),
      lastDate: DateTime(2101),
      builder: (BuildContext context, Widget? child) {
        return Theme(
          data: ThemeData.light().copyWith(
            colorScheme: ColorScheme.light(primary: AppColors.buttonColor),
          ),
          child: child!,
        );
      },
    );
    if (picked != null) {
      selectedDate.value = picked;
    }
  }

  Future<void> postCheatFoodApi() async {
    Map<String, dynamic> bodyData = {
      "foddTakenDate": selectedDate.value.toString(),
      "totalCalories": caloriesController.text,
    };
    try {
      isPostFoodLoading.value = true;
      caloriesController.clear();
      String? token = await StorageServivce.getToken();
      var response = await apiService.post(
        ApiUrls.postCheatFoodEndPoint,
        jsonEncode(bodyData),
        authToken: token,
      );
      log("status code ${response.statusCode} body ${response.body}");
      var dataObj = await jsonDecode(response.body);
      if (response.statusCode == 200) {
        // print(dataObj);
        customSnackbar(
            title: AppTexts.success, message: 'Food Added successfully');
        isPostFoodLoading.value = false;
        getCheatFoodApi();
      } else {
        isPostFoodLoading.value = false;
        customSnackbar(title: AppTexts.alert, message: dataObj["message"]);
      }
    } catch (e) {
      isPostFoodLoading.value = false;
      log(e.toString());
    }
  }

  Future<void> getCheatFoodApi() async {
    try {
      isLoading.value = true;
      String? token = await StorageServivce.getToken();
      var response = await apiService.get(
        ApiUrls.getCheatFoodEndPoint,
        authToken: token,
      );
      log("status code ${response.statusCode} body ${response.body}");
      if (response.statusCode == 200) {
        var dataObj = jsonDecode(response.body);
        var jsonData = dataObj["cheatFoodList"];
        cheatFoodModel.value = CheatFoodModel.fromJson(jsonData);

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
