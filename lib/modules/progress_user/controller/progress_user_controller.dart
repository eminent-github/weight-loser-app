import 'dart:convert';
import 'dart:developer';

import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:weight_loss_app/common/api_urls.dart';
import 'package:weight_loss_app/common/app_texts.dart';
import 'package:weight_loss_app/modules/progress_user/modal/user_stats_modal.dart';
import 'package:weight_loss_app/modules/progress_user/modal/weight_stat_model.dart';
import 'package:weight_loss_app/utils/api_service.dart';
import 'package:weight_loss_app/utils/date_formatter.dart';
import 'package:weight_loss_app/utils/shared_prefrence.dart';
import 'package:weight_loss_app/widgets/custom_snackbar.dart';

class ProgressUserController extends GetxController {
  var weightUnit = "".obs;

  @override
  void onInit() {
    getUserName();
    getUserWeightStats();
    getUserStats();
    super.onInit();
  }

  RxString userName = ''.obs;

  getUserName() async {
    userName.value = await StorageServivce.getUserName() ?? 'unknown';
  }

  var selectedIndex = 0.obs;
  List<String> progressTitle = <String>[
    'User Stats',
    'Weight Stats',
  ];

  var isLoading = false.obs;
  final ApiService apiService = ApiService();
  Rx<UserStatsModal> userStatsModal = UserStatsModal(
    averageSleepHours: AverageSleepHours(hours: 0, minutes: 0),
    dietCompliance: 0.0,
    mindCompliance: 0.0,
    exerciseCompliance: 0.0,
    totalCompliance: 0.0,
    updateWeight: [],
    weekAverageWater: 0.0,
    goalCarbCount: 0,
    goalFatCount: 0,
    goalProteinCount: 0,
    goalSodiumCount: 0,
    totalAvgCal: 0,
    sumOfSodium: 0,
    sumOfProtein: 0,
    sumOfFat: 0,
    sumOfCarbs: 0,
    history: History(
      exerciseCalories: [],
    ),
  ).obs;
  var startingWeight = 0.0.obs;
  var startingWeightDate = DateFormat().format(DateTime.now()).obs;
  var currentWeight = 0.obs;
  var currentWeightDate = DateFormat().format(DateTime.now()).obs;
  var targetWeight = 0.0.obs;
  var targetWeightDate = DateFormat().format(DateTime.now()).obs;
  var userWeightDate = DateFormat().format(DateTime.now()).obs;

  getUserWeightStats() async {
    try {
      isLoading.value = true;
      var dateToBeSend = DateFormat('yyyy-MM-dd').format(DateTime.now());
      // log('this is a date to be send $dateToBeSend');
      String? token = await StorageServivce.getToken();
      // log('this is token $token');
      var response = await apiService.get(
        '${ApiUrls.getUserWeightStatsEndPoint}?filter_date=$dateToBeSend',
        authToken: token,
      );
      // log(token!);
      log('status code ${response.statusCode} body ${response.body}');
      if (response.statusCode == 200) {
        var dataObj = jsonDecode(response.body);
        var data = WeightStatsModel.fromJson(dataObj);
        startingWeight.value = data.startingWeight!;
        log('this is startingWeight.value ${startingWeight.value}');
        userWeightDate.value = data.startingWeightDate!;
        startingWeightDate.value = formatDate(data.startingWeightDate!);
        log('this is startingWeightDate.value ${startingWeightDate.value}');
        currentWeight.value = data.currentWeight!;
        log('this is currentWeight.value ${currentWeight.value}');
        currentWeightDate.value = formatDate(data.currentWeightDate!);
        log('this is currentWeightDate.value ${currentWeightDate.value}');
        targetWeight.value = data.targetWeight!;
        weightUnit.value = data.weightUnit!;
        log('this is targetWeight.value ${targetWeight.value}');
        targetWeightDate.value = formatDate(data.targetWeightDate!);
        log('this is targetWeightDate.value ${targetWeightDate.value}');

        isLoading.value = false;
      } else {
        isLoading.value = false;
        customSnackbar(title: AppTexts.error, message: "No record found");
      }
    } catch (e) {
      log(e.toString());
      isLoading.value = false;
    }
  }

  Future<void> getUserStats() async {
    try {
      isLoading.value = true;
      var dateToBeSend = DateFormat('yyyy-MM-dd').format(DateTime.now());
      log('this is a date to be send $dateToBeSend');
      String? token = await StorageServivce.getToken();
      log('this is token $token');
      var response = await apiService.get(
        '${ApiUrls.getUserStatsEndPoint}?filter_date=$dateToBeSend',
        authToken: token,
      );
      // log(token!);
      log('this is status code : ${response.statusCode} this is body: ${response.body}');
      if (response.statusCode == 200) {
        var dataObj = jsonDecode(response.body);
        userStatsModal.value = UserStatsModal.fromJson(dataObj);
        // log('This is user stats model  /api/Diary/GetUserWeekHistory ${userStatsModal.toString()} and tojson is ${userStatsModal.toJson()}');
        isLoading.value = false;
      } else {
        isLoading.value = false;
        customSnackbar(title: AppTexts.error, message: "No record found");
      }
    } catch (e) {
      log(e.toString());
      isLoading.value = false;
    }
  }
}
