import 'dart:convert';
import 'dart:developer';
import 'package:http/http.dart' as http;
import 'package:get/get.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:weight_loss_app/common/api_urls.dart';
import 'package:weight_loss_app/common/app_texts.dart';
import 'package:weight_loss_app/modules/dashbored/screens/home/screens/home_inner_today/controller/home_inner_today_controller.dart';
import 'package:weight_loss_app/modules/dashbored/screens/scanner/model.dart';
import 'package:weight_loss_app/modules/diary/controller/diary_controller.dart';
import 'package:weight_loss_app/utils/api_service.dart';
import 'package:weight_loss_app/utils/shared_prefrence.dart';
import 'package:weight_loss_app/widgets/custom_snackbar.dart';

class ScannerController extends GetxController {
  var scannedResult = ''.obs;

  var scanningStarted = false.obs;
  var cameraPermissionStatus = PermissionStatus.denied.obs;
  void controllerScanning() {
    scanningStarted.value = !scanningStarted.value;
  }

  void clearData() {
    scannedResult.value = '';
  }

  void uploadData({required int servings}) {
    saveScanDietToDatabase(
        mealType: foodSelectedItem.value,
        todayDietModel: barcodeSearchedFoodModel.value,
        servings: servings);
  }

  @override
  void onInit() {
    requestPermission();
    super.onInit();
  }

  var isLoading = false.obs;

  var isPostFoodLoading = false.obs;
  final ApiService apiService = ApiService();
  var barcodeSearchedFoodModel = BarcodeSearchedFoodModel().obs;
  Future<void> getScanFoodApi(String scannedResult) async {
    try {
      isLoading.value = true;
      log("before respose$scannedResult");

      final response = await http.get(
        Uri.parse("${ApiUrls.scanFoodEndPoint}$scannedResult.json"),
      );
      log("after respose");
      log("${response.statusCode}body: ${response.body}");
      if (response.statusCode == 200) {
        log("before success");
        var dataObj = jsonDecode(response.body);
        isLoading.value = false;

        barcodeSearchedFoodModel.value =
            BarcodeSearchedFoodModel.fromJson(dataObj);
        scanningStarted.value = false;
        log("after success}");
      } else {
        isLoading.value = false;
        customSnackbar(
          title: AppTexts.error,
          message: "No Product found",
        );
      }
    } catch (e) {
      isLoading.value = false;
      log("exception ${e.toString()}");
    }
  }

  void requestPermission() async {
    var status = await Permission.camera.request();

    cameraPermissionStatus.value = status;
  }

  final List<String> foodMenuItems = ['Breakfast', 'Lunch', 'Snack', 'Dinner'];
  RxString foodSelectedItem = 'Breakfast'.obs;
  final List<String> servingList = [
    'Servings',
    '1',
    '2',
    '3',
    '4',
    '5',
    '6',
    '7',
    '8',
    '9',
    '10'
  ];
  RxString foodServing = 'Servings'.obs;

  Future<void> saveScanDietToDatabase({
    required BarcodeSearchedFoodModel todayDietModel,
    required int servings,
    required String mealType,
  }) async {
    // log(todayDietModel.mealType!.toLowerCase());
    Map<String, dynamic> bodyData = {
      "foodType": mealType,
      "servingSize": servings,
      "foodId": todayDietModel.product!.productName!,
      "name": todayDietModel.product!.productName!,
      "fat": todayDietModel.product!.nutriments!.fat!,
      "protein": todayDietModel.product!.nutriments!.proteins,
      "carbs": todayDietModel.product!.nutriments!.carbohydrates,
      "calories": todayDietModel.product!.nutriments!.energyKcal,
      "fileName": todayDietModel.product!.image,
      "custom": "scanner"
    };
    try {
      isPostFoodLoading.value = true;
      String? token = await StorageServivce.getToken();
      var response = await apiService.post(
        ApiUrls.saveScanDietToDatabase,
        jsonEncode(bodyData),
        authToken: token,
      );
      log("status code : ${response.statusCode} body ${response.body}");
      if (response.statusCode == 200) {
        var dataObj = await jsonDecode(response.body);
        var foodId = dataObj["foodId"];
        if (foodId != null) {
          saveUserTodayDiet(
              foodId: foodId.toString(),
              mealType: mealType,
              todayDietModel: todayDietModel);
        } else {
          isPostFoodLoading.value = false;
          customSnackbar(
              title: AppTexts.success, message: 'scan Diet not taken');
        }
      } else {
        log(jsonDecode(response.body).toString());
        isPostFoodLoading.value = false;
        customSnackbar(title: AppTexts.success, message: 'scan Diet not taken');
      }
    } catch (e) {
      isPostFoodLoading.value = false;
      log(e.toString());
    }
  }

  Future<void> saveUserTodayDiet({
    required BarcodeSearchedFoodModel todayDietModel,
    required String mealType,
    required String foodId,
  }) async {
    // log(todayDietModel.mealType!.toLowerCase());
    Map<String, dynamic> bodyData = {
      "FoodType": mealType,
      "FoodId": foodId,
      "Cons_Cal": todayDietModel.product!.nutriments!.energyKcal,
      "ServingSize": 1,
      "fat": todayDietModel.product!.nutriments!.fat,
      "Protein": todayDietModel.product!.nutriments!.proteins,
      "Carbs": todayDietModel.product!.nutriments!.carbohydrates
    };
    try {
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
        customSnackbar(
            title: AppTexts.success,
            message: "This has been added to your nutrition plan and diary");
        Get.find<DiaryController>()
            .getDiaryDetail(DateTime.now())
            .then((value) {
          Get.find<HomeInnerTodayController>()
              .getTodayBudgetApi()
              .then((value) {
            isPostFoodLoading.value = false;
            scannedResult.value = '';
          }).onError((error, stackTrace) {
            isPostFoodLoading.value = false;
            scannedResult.value = '';
          });
        }).onError((error, stackTrace) {
          isPostFoodLoading.value = false;
          scannedResult.value = '';
        });
      } else {
        log(jsonDecode(response.body).toString());
        isPostFoodLoading.value = false;
        customSnackbar(title: AppTexts.success, message: 'Diet not taken');
      }
    } catch (e) {
      isPostFoodLoading.value = false;
      log(e.toString());
    }
  }
}
