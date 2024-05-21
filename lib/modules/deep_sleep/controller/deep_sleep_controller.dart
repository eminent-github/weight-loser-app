// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:weight_loss_app/common/api_urls.dart';
import 'package:weight_loss_app/common/app_assets.dart';
import 'package:weight_loss_app/common/app_colors.dart';
import 'package:weight_loss_app/common/app_texts.dart';
import 'package:weight_loss_app/modules/deep_sleep/models/deep_sleep_model.dart';
import 'package:weight_loss_app/modules/deep_sleep/models/emogi_model.dart';
import 'package:weight_loss_app/modules/progress_user/controller/progress_user_controller.dart';
import 'package:weight_loss_app/utils/api_service.dart';
import 'package:weight_loss_app/utils/shared_prefrence.dart';
import 'package:weight_loss_app/widgets/custom_snackbar.dart';

class DeepSleepController extends GetxController {
  var filterDate = DateTime.now().obs;
  var showAllItems = false.obs;
  var emogiSelectedIndex = 6.obs;
  List<EmojiImageModel> emojiIconList = [
    EmojiImageModel(imageUrl: AppAssets.deepImgUrl, text: 'Deep'),
    EmojiImageModel(imageUrl: AppAssets.refreshingImgUrl, text: 'Refreshing'),
    EmojiImageModel(imageUrl: AppAssets.moderateImgUrl, text: 'Moderate'),
    EmojiImageModel(imageUrl: AppAssets.notgoodImgUrl, text: 'Not Good'),
    EmojiImageModel(imageUrl: AppAssets.frustratingImgUrl, text: 'Frustrating'),
  ];
  RxString userName = ''.obs;

  getUserName() async {
    userName.value = await StorageServivce.getUserName() ?? 'unknown';
  }

  @override
  void onInit() {
    getUserName();
    getDeepSleepApi(filterDate.value);
    super.onInit();
  }

  var isLoading = false.obs;
  var isTimeLoading = false.obs;

  final ApiService apiService = ApiService();
  var deepSleepData = DeepSleepModel().obs;

  var deepSleepTime = const TimeOfDay(hour: 21, minute: 0).obs;
  var awakeTime = const TimeOfDay(hour: 5, minute: 0).obs;

  Future<void> awakeSelectTime(BuildContext context) async {
    final TimeOfDay? picked = await showTimePicker(
      context: context,
      initialTime: awakeTime.value,
    );
    if (picked != null) {
      awakeTime.value = picked;
    }
  }

  String calTotalTime(TimeOfDay awakeTime, TimeOfDay deepTime) {
    final now = DateTime.now();
    DateTime convertedAwakeTime = DateTime(
        now.year, now.month, now.day, awakeTime.hour, awakeTime.minute);
    DateTime convertedDeepTime =
        DateTime(now.year, now.month, now.day, deepTime.hour, deepTime.minute);

    Duration sleepTime = convertedDeepTime.difference(convertedAwakeTime);

    return sleepTime.inHours < 0
        ? "${-(sleepTime.inHours)} Hours ${sleepTime.inMinutes.remainder(60)} Minutes"
        : "${24 - sleepTime.inHours} Hours ${sleepTime.inMinutes.remainder(60)} Minutes";
  }

  int calHourTime(TimeOfDay awakeTime, TimeOfDay deepTime) {
    final now = DateTime.now();
    DateTime convertedAwakeTime = DateTime(
        now.year, now.month, now.day, awakeTime.hour, awakeTime.minute);
    DateTime convertedDeepTime =
        DateTime(now.year, now.month, now.day, deepTime.hour, deepTime.minute);

    Duration sleepTime = convertedDeepTime.difference(convertedAwakeTime);

    return sleepTime.inHours < 0
        ? -(sleepTime.inHours)
        : 24 - sleepTime.inHours;
  }

  Future<void> deepSelectTime(BuildContext context) async {
    final TimeOfDay? picked = await showTimePicker(
      context: context,
      initialTime: deepSleepTime.value,
    );
    if (picked != null) {
      deepSleepTime.value = picked;
    }
  }

  Future<void> getDeepSleepApi(DateTime date) async {
    try {
      isLoading.value = true;
      String? token = await StorageServivce.getToken();
      var response = await apiService.get(
        "${ApiUrls.getDeepSleepEndPoint}?date=$date",
        authToken: token,
      );
      log("${response.statusCode}body: ${response.body}");
      if (response.statusCode == 200) {
        var dataObj = jsonDecode(response.body);
        deepSleepData.value = DeepSleepModel.fromJson(dataObj);
        if (deepSleepData.value.mood != null) {
          int changeIndex = emojiIconList.indexWhere(
              (element) => element.text.contains(deepSleepData.value.mood!));
          log("index$changeIndex");
          emogiSelectedIndex.value = changeIndex;
        } else {
          emogiSelectedIndex = 6.obs;
        }
        papulateSleepData();

        isLoading.value = false;
      } else {
        isLoading.value = false;
        customSnackbar(
          title: AppTexts.error,
          message: "No record found",
          backgroundColor: AppColors.white,
          colorText: AppColors.buttonColor,
        );
      }
    } catch (e) {
      isLoading.value = false;
      log("exception ${e.toString()}");
    }
  }

  Future<void> postSleepMoodApi({
    required String moodType,
  }) async {
    Map<String, dynamic> bodyData = {
      "moodType": moodType,
    };

    try {
      isTimeLoading.value = true;
      String? token = await StorageServivce.getToken();
      var response = await apiService.post(
        ApiUrls.postDeepSleepEndPoint,
        jsonEncode(bodyData),
        authToken: token,
      );
      var dataObj = await jsonDecode(response.body);
      if (response.statusCode == 200) {
        log(dataObj.toString());
        isTimeLoading.value = false;

        customSnackbar(
          title: AppTexts.success,
          message: 'Sleep Mood Added successfully',
          backgroundColor: AppColors.white,
          colorText: AppColors.buttonColor,
        );
      } else {
        isTimeLoading.value = false;
        log("$dataObj${response.statusCode}");
        customSnackbar(
          title: AppTexts.error,
          message: 'Sleep not added',
          backgroundColor: AppColors.white,
          colorText: AppColors.buttonColor,
        );
      }
    } catch (e) {
      isTimeLoading.value = false;
      log(e.toString());
    }
  }

  Future<void> postDeepSleepApi({
    required String awakeTime,
    required String deepTime,
    required String totalSleep,
  }) async {
    Map<String, dynamic> bodyData = {
      "sleepTime": deepTime,
      "awake": awakeTime,
      "totalSleep": totalSleep,
    };

    try {
      isTimeLoading.value = true;
      String? token = await StorageServivce.getToken();
      var response = await apiService.post(
        ApiUrls.postDeepSleepEndPoint,
        jsonEncode(bodyData),
        authToken: token,
      );
      var dataObj = await jsonDecode(response.body);
      if (response.statusCode == 200) {
        log(dataObj.toString());
        isTimeLoading.value = false;
        customSnackbar(
          title: AppTexts.success,
          message: 'Sleep Time Added successfully',
          backgroundColor: AppColors.white,
          colorText: AppColors.buttonColor,
        );
        Get.find<ProgressUserController>().getUserStats();
        getDeepSleepApi(filterDate.value);
      } else {
        isTimeLoading.value = false;
        log("$dataObj${response.statusCode}");
        customSnackbar(
          title: AppTexts.error,
          message: 'Sleep not added',
          backgroundColor: AppColors.white,
          colorText: AppColors.buttonColor,
        );
      }
    } catch (e) {
      isTimeLoading.value = false;
      log(e.toString());
    }
  }

  RxList<SleepStat> weekDayList = <SleepStat>[
    SleepStat(hours: 0, weekDay: "Mon"),
    SleepStat(hours: 0, weekDay: "Tue"),
    SleepStat(hours: 0, weekDay: "Wed"),
    SleepStat(hours: 0, weekDay: "Thu"),
    SleepStat(hours: 0, weekDay: "Fri"),
    SleepStat(hours: 0, weekDay: "Sat"),
    SleepStat(hours: 0, weekDay: "Sun"),
  ].obs;
  void papulateSleepData() {
    for (var changeElement in weekDayList) {
      changeElement.hours = 0;
    }

    if (deepSleepData.value.bedTime!.isNotEmpty) {
      for (var element in deepSleepData.value.bedTime!) {
        log(element.day.toString());
        var changeIndex = weekDayList
            .indexWhere((weekday) => element.day!.contains(weekday.weekDay));
        log(changeIndex.toString());
        weekDayList[changeIndex].hours = element.hours!;
      }
    }
  }
}

class SleepStat {
  String weekDay;
  int hours;
  SleepStat({
    required this.weekDay,
    required this.hours,
  });
}
