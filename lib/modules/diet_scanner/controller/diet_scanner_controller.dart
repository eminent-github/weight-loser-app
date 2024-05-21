import 'dart:convert';
import 'dart:developer';
import 'package:http/http.dart' as http;
import 'package:get/get.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:weight_loss_app/common/api_urls.dart';
import 'package:weight_loss_app/common/app_texts.dart';
import 'package:weight_loss_app/modules/dashbored/screens/home/controller/home_controller.dart';
import 'package:weight_loss_app/modules/dashbored/screens/home/screens/home_inner_today/controller/home_inner_today_controller.dart';
import 'package:weight_loss_app/modules/dashbored/screens/scanner/model.dart';
import 'package:weight_loss_app/modules/diet/add_your_food/model/rep_food_route_model.dart';
import 'package:weight_loss_app/utils/api_service.dart';
import 'package:weight_loss_app/utils/shared_prefrence.dart';
import 'package:weight_loss_app/widgets/custom_snackbar.dart';

class DietScannerController extends GetxController {
  var scannedResult = ''.obs;

  var scanningStarted = false.obs;
  var cameraPermissionStatus = PermissionStatus.denied.obs;
  void controllerScanning() {
    scanningStarted.value = !scanningStarted.value;
    requestPermission();
  }

  void clearData() {
    scannedResult.value = '';
  }

  @override
  void onInit() {
    requestPermission();
    super.onInit();
  }

  void requestPermission() async {
    var status = await Permission.camera.request();

    cameraPermissionStatus.value = status;
  }

  void uploadData({
    required int servings,
    required String mealType,
    required ReplaceFoodRouteModel replaceFoodRouteModel,
  }) {
    saveScanDietToDatabase(
      mealType: mealType,
      todayDietModel: barcodeSearchedFoodModel.value,
      servings: servings,
      replaceFoodRouteModel: replaceFoodRouteModel,
    );
  }

  var isLoading = false.obs;

  var isPostFoodLoading = false.obs;
  final ApiService apiService = ApiService();
  var barcodeSearchedFoodModel = BarcodeSearchedFoodModel().obs;
  Future<void> getScanFoodApi(String barcode) async {
    try {
      isLoading.value = true;
      log("before respose$barcode");

      final response = await http.get(
        Uri.parse("${ApiUrls.scanFoodEndPoint}$barcode.json"),
      );
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
    required ReplaceFoodRouteModel replaceFoodRouteModel,
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
        print("foodId: $foodId");
        if (foodId != null) {
          addReplacedFood(
                  repFoodId: foodId.toString(),
                  replaceFoodRouteModel: replaceFoodRouteModel,
                  mealType: mealType,
                  servingSize: servings)
              .then((value) => scannedResult.value = '')
              .onError((error, stackTrace) => scannedResult.value = '');
        } else {
          isPostFoodLoading.value = false;
          customSnackbar(title: AppTexts.alert, message: 'scan Diet not taken');
        }
      } else {
        log(jsonDecode(response.body).toString());
        isPostFoodLoading.value = false;
        customSnackbar(title: AppTexts.error, message: 'scan Diet not taken');
      }
    } catch (e) {
      isPostFoodLoading.value = false;
      log(e.toString());
    }
  }

  Future<void> addReplacedFood({
    required ReplaceFoodRouteModel replaceFoodRouteModel,
    required String repFoodId,
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
          isPostFoodLoading.value = false;
          Get.find<HomeController>().tabController.animateTo(0);
          Get.until(
            (route) => route.isFirst,
          );
        }).onError((error, stackTrace) {
          isPostFoodLoading.value = false;
        });
      } else {
        isPostFoodLoading.value = false;
        customSnackbar(title: AppTexts.error, message: 'Meal not Replaced');
      }
    } catch (e) {
      isPostFoodLoading.value = false;
      log(e.toString());
    }
  }
}
