import 'dart:convert';
import 'dart:developer';
import 'package:get/get.dart';
import 'package:weight_loss_app/common/api_urls.dart';
import 'package:weight_loss_app/common/app_texts.dart';
import 'package:weight_loss_app/modules/diet/diet_food_item_detial/model/diet_food_item_detail_model.dart';
import 'package:weight_loss_app/modules/diet/diet_plan_detail/models/diet_plan_detail_model.dart';
import 'package:weight_loss_app/utils/api_service.dart';
import 'package:weight_loss_app/utils/shared_prefrence.dart';
import 'package:weight_loss_app/widgets/custom_snackbar.dart';
// import 'package:html/parser.dart' as html;

class DietFoodItemDetialController extends GetxController {
  DietPlanDetialModel? dietPlanDetialModel;
  var totalDaysForMenuItems = 0.obs;
  void getdietplanDetialModel(DietPlanDetialModel val, int days) {
    dietPlanDetialModel = val;
    totalDaysForMenuItems.value = days;
    daySelectedItem.value = "Day ${val.day!}";
  }

  final List<String> foodMenuItems = ['Breakfast', 'Lunch', 'Snacks', 'Dinner'];
  RxString foodSelectedItem = 'Breakfast'.obs;
  // final List<String> dayMenuItems = ['Day 1', 'Day 2', 'Day 3', 'Day 4'];
  final List<String> dayMenuItems = [];
  // List<String> proceduresList = [];
  RxString daySelectedItem = ''.obs;
  Rx<FoodItemDetailModel> foodItemDetailModel = FoodItemDetailModel().obs;
  var isLoading = false.obs;
  var isAddFoodLoading = false.obs;
  final ApiService apiService = ApiService();

  @override
  void onInit() {
    getFoodDetail(dietPlanDetialModel!.foodId!);
    generateDayList(totalDaysForMenuItems.value);
    super.onInit();
  }

  void generateDayList(int totalDays) {
    log('day ${dietPlanDetialModel!.day!} .. \total days $totalDays');
    for (int i = dietPlanDetialModel!.day!; i <= totalDays; i++) {
      dayMenuItems.add('Day $i');
    }
  }

  Future<void> getFoodDetail(String foodId) async {
    log("foodId:$foodId");
    try {
      isLoading.value = true;
      String? token = await StorageServivce.getToken();
      var response = await apiService.get(
        "${ApiUrls.foodDetailEndPoint}/$foodId",
        authToken: token,
      );
      log("status code: ${response.statusCode} body : ${response.body}");
      if (response.statusCode == 200) {
        var dataObj = await jsonDecode(response.body);
        foodItemDetailModel.value = FoodItemDetailModel.fromJson(dataObj);
        // final document =
        //     html.parse(foodItemDetailModel.value.foodDetailVM!.procedure);

        // Extract the content of <p> tags into a Dart list
        // proceduresList =
        //     document.querySelectorAll('p').map((p) => p.text).toList();

        isLoading.value = false;
      } else {
        isLoading.value = false;
        customSnackbar(title: AppTexts.error, message: "No record found");
      }
    } catch (e) {
      isLoading.value = false;
      log(e.toString());
    }
  }

  Future<void> addMeal(
      {required String mealType,
      required String foodId,
      required int planId,
      required int day}) async {
    log('day $day .. \nfood id $foodId..\nfood plan id $planId..\n plan id ${dietPlanDetialModel!.planId}..\n mealtype $mealType..');
    Map<String, dynamic> bodyData = {
      "mealType": mealType,
      "repFoodId": foodId,
      "planId": "$planId",
      "day": "$day"
    };
    try {
      isAddFoodLoading.value = true;
      String? token = await StorageServivce.getToken();
      var response = await apiService.post(
        ApiUrls.addMealEndPoint,
        jsonEncode(bodyData),
        authToken: token,
      );

      if (response.statusCode == 200) {
        // var dataObj = await jsonDecode(response.body);
        // print(dataObj);
        customSnackbar(
            title: AppTexts.success, message: 'Meal added successfully');
        isAddFoodLoading.value = false;
      } else {
        isAddFoodLoading.value = false;
        customSnackbar(title: AppTexts.success, message: 'Meal not added');
      }
    } catch (e) {
      isAddFoodLoading.value = false;
      log(e.toString());
    }
  }
}
