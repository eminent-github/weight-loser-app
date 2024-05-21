import 'dart:convert';
import 'dart:developer';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:image_picker/image_picker.dart';
import 'package:weight_loss_app/common/api_urls.dart';
import 'package:weight_loss_app/common/app_texts.dart';
import 'package:weight_loss_app/modules/dashbored/screens/home/controller/home_controller.dart';
import 'package:weight_loss_app/modules/dashbored/screens/home/screens/home_inner_today/controller/home_inner_today_controller.dart';
import 'package:weight_loss_app/modules/diet/add_custom_food/model/custom_food_model.dart';
import 'package:weight_loss_app/modules/diet/add_your_food/model/rep_food_route_model.dart';
import 'package:weight_loss_app/utils/api_service.dart';
import 'package:weight_loss_app/utils/shared_prefrence.dart';
import 'package:weight_loss_app/widgets/custom_snackbar.dart';

class AddCustomFoodController extends GetxController {
  late TextEditingController foodNameController;
  late TextEditingController foodServingSizeController;
  late TextEditingController foodCaloriesController;
  late TextEditingController foodCarbsController;
  late TextEditingController foodFatController;
  late TextEditingController foodProtienController;
  RxString updatedImage = "".obs;
  var isLoading = false.obs;

  final ApiService apiService = ApiService();

  @override
  void onInit() {
    foodNameController = TextEditingController();
    foodServingSizeController = TextEditingController();
    foodCaloriesController = TextEditingController();
    foodCarbsController = TextEditingController();
    foodProtienController = TextEditingController();
    foodFatController = TextEditingController();
    super.onInit();
  }

  @override
  void dispose() {
    foodNameController.dispose();
    foodServingSizeController.dispose();
    foodCaloriesController.dispose();
    foodCarbsController.dispose();
    foodProtienController.dispose();
    foodFatController.dispose();
    super.dispose();
  }

  Future<void> pickImage(BuildContext context) async {
    final picker = ImagePicker();
    final pickedImage =
        await picker.pickImage(source: ImageSource.camera, imageQuality: 70);

    if (pickedImage != null) {
      updatedImage.value = pickedImage.path;
    } else {
      customSnackbar(title: AppTexts.success, message: 'Please take an Image');
    }
  }

  void validateAndPost(
    String mealType, {
    required ReplaceFoodRouteModel replaceFoodRouteModel,
  }) async {
    if (foodNameController.value.text.isEmpty) {
      customSnackbar(title: AppTexts.alert, message: "Food Name Required");
    }
    //  else if (foodFatController.value.text.isEmpty) {
    //   customSnackbar(title: AppTexts.alert, message: "Food Fat Required");
    // } else if (foodCaloriesController.value.text.isEmpty) {
    //   customSnackbar(title: AppTexts.alert, message: "Food Calories Required");
    // }
    else if (foodServingSizeController.value.text.isEmpty) {
      customSnackbar(title: AppTexts.alert, message: "Serving Size Required");
    }
    //  else if (foodProtienController.value.text.isEmpty) {
    //   customSnackbar(title: AppTexts.alert, message: "Food Protien Required");
    // } else if (foodCarbsController.value.text.isEmpty) {
    //   customSnackbar(title: AppTexts.alert, message: "Food Carbs Required");
    // }
    // else if (double.tryParse(foodFatController.value.text)! <= 0) {
    //   customSnackbar(title: AppTexts.alert, message: "Enter correct Fat value");
    // } else if (double.tryParse(foodCaloriesController.value.text)! <= 0) {
    //   customSnackbar(
    //       title: AppTexts.alert, message: "Enter correct Calories value");
    // }
    else if (double.tryParse(foodServingSizeController.value.text)! <= 0) {
      customSnackbar(
          title: AppTexts.alert, message: "Enter correct Serving value");
    }
    //  else if (double.tryParse(foodProtienController.value.text)! <= 0) {
    //   customSnackbar(
    //       title: AppTexts.alert, message: "Enter correct Protien value");
    // } else if (double.tryParse(foodCarbsController.value.text)! <= 0) {
    //   customSnackbar(
    //       title: AppTexts.alert, message: "Enter correct Carbs value");
    // }
    else {
      if (updatedImage.value.isNotEmpty) {
        String? imageName =
            await postImageApi("image", File(updatedImage.value));
        if (imageName != null) {
          saveCustomDietToDatabase(
            mealType: mealType,
            replaceFoodRouteModel: replaceFoodRouteModel,
            todayDietModel: CustomFoodModel(
                name: foodNameController.text,
                fat: foodFatController.text.isEmpty
                    ? 0
                    : double.parse(foodFatController.text),
                calories: foodCaloriesController.text.isEmpty
                    ? 0
                    : double.parse(foodCaloriesController.text),
                servingSize: int.parse(foodServingSizeController.text),
                protien: foodProtienController.text.isEmpty
                    ? 0
                    : double.parse(foodProtienController.text),
                carbs: foodCarbsController.text.isEmpty
                    ? 0
                    : double.parse(foodCarbsController.text)),
            imagUrl: imageName,
          );
        }
      } else {
        saveCustomDietToDatabase(
          mealType: mealType,
          replaceFoodRouteModel: replaceFoodRouteModel,
          todayDietModel: CustomFoodModel(
              name: foodNameController.text,
              fat: foodFatController.text.isEmpty
                  ? 0
                  : double.parse(foodFatController.text),
              calories: foodCaloriesController.text.isEmpty
                  ? 0
                  : double.parse(foodCaloriesController.text),
              servingSize: int.parse(foodServingSizeController.text),
              protien: foodProtienController.text.isEmpty
                  ? 0
                  : double.parse(foodProtienController.text),
              carbs: foodCarbsController.text.isEmpty
                  ? 0
                  : double.parse(foodCarbsController.text)),
        );
      }
    }
  }

  Future<String?> postImageApi(String type, File myimageFile) async {
    try {
      isLoading.value = true;
      String? token = await StorageServivce.getToken();
      var request = http.MultipartRequest('POST',
          Uri.parse("${ApiUrls.baseUrl}${ApiUrls.communityPostImageEndPoint}"));

      request.headers.addAll({
        'Accept': 'multipart/form-data',
        'Authorization': 'Bearer $token',
      });

      request.fields['Type'] = type;

      var stream = http.ByteStream(Stream.castFrom(myimageFile.openRead()));
      var length = await myimageFile.length();
      var multipartFile = http.MultipartFile('ImageFile', stream, length,
          filename: myimageFile.path.split('/').last);
      request.files.add(multipartFile);

      var response = await request.send();
      // print(response.statusCode);
      if (response.statusCode == 200) {
        var responseBody = await response.stream.bytesToString();
        Map<String, dynamic> jsonData = jsonDecode(responseBody);
        log("images name list by apis${updatedImage.value}");
        return jsonData["fileName"] as String;
      } else {
        isLoading.value = false;
        // customSnackbar(title: AppTexts.success, message: 'image not added');
        return null;
      }
    } catch (e) {
      isLoading.value = false;

      log(e.toString());
      return null;
    }
  }

  Future<void> saveCustomDietToDatabase({
    required CustomFoodModel todayDietModel,
    required String mealType,
    String? imagUrl,
    required ReplaceFoodRouteModel replaceFoodRouteModel,
  }) async {
    // log(todayDietModel.mealType!.toLowerCase());
    Map<String, dynamic> bodyData = {
      "servingSize": todayDietModel.servingSize,
      "name": todayDietModel.name,
      "protein": todayDietModel.protien,
      "carbs": todayDietModel.calories,
      "calories": todayDietModel.calories,
      "fat": todayDietModel.fat,
      "fileName": imagUrl,
      "custom": "custom"
    };
    try {
      isLoading.value = true;
      String? token = await StorageServivce.getToken();
      var response = await apiService.post(
        ApiUrls.saveCustomDietToDatabase,
        jsonEncode(bodyData),
        authToken: token,
      );
      log("status code : ${response.statusCode} body ${response.body}");
      if (response.statusCode == 200) {
        var dataObj = await jsonDecode(response.body);
        var foodId = dataObj["foodId"];
        if (foodId != null) {
          await addReplacedFood(
            repFoodId: foodId.toString(),
            replaceFoodRouteModel: replaceFoodRouteModel,
            mealType: mealType,
            servingSize: todayDietModel.servingSize,
          );
        } else {
          isLoading.value = false;
          customSnackbar(title: AppTexts.success, message: 'Diet not taken');
        }
      } else {
        log(jsonDecode(response.body).toString());
        isLoading.value = false;
        customSnackbar(title: AppTexts.success, message: 'Diet not taken');
      }
    } catch (e) {
      isLoading.value = false;
      log(e.toString());
    }
  }

  Future<void> addReplacedFood({
    required String repFoodId,
    required ReplaceFoodRouteModel replaceFoodRouteModel,
    required String mealType,
    required int servingSize,
  }) async {
    Map<String, dynamic> bodyData = {
      "planFoodId": "",
      "repFoodId": repFoodId,
      "planId": replaceFoodRouteModel.planId,
      "Day": replaceFoodRouteModel.day,
      "MealType": mealType,
      "Phase": replaceFoodRouteModel.phase,
      "ServingSize": servingSize
    };
    try {
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
