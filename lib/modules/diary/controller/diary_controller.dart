import 'dart:convert';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:weight_loss_app/common/api_urls.dart';
import 'package:weight_loss_app/common/app_assets.dart';
import 'package:weight_loss_app/common/app_texts.dart';
import 'package:weight_loss_app/modules/diary/models/diary_model.dart';
import 'package:weight_loss_app/utils/api_service.dart';
import 'package:weight_loss_app/utils/shared_prefrence.dart';
import 'package:weight_loss_app/widgets/custom_snackbar.dart';

class DiaryController extends GetxController
    with GetSingleTickerProviderStateMixin {
  var selectedDate = DateTime.now().obs;
  void addOneDay() {
    if (selectedDate.value
        .isBefore(DateTime.now().subtract(const Duration(days: 1)))) {
      selectedDate.value = selectedDate.value.add(const Duration(days: 1));
      getDiaryDetail(selectedDate.value);
    } else {
      customSnackbar(
          title: 'Alert', message: 'Can\'t go further into the future');
    }
  }

  void subtractOneDay() {
    selectedDate.value = selectedDate.value.subtract(const Duration(days: 1));
    getDiaryDetail(selectedDate.value);
  }

  late TabController tabController;
  @override
  void onInit() {
    tabController = TabController(
      length: 4,
      vsync: this,
    );
    getDiaryDetail(selectedDate.value);
    super.onInit();
  }

  var dairyScreenTabsList = [
    Tab(
      text: 'Diet',
      icon: SvgPicture.asset(AppAssets.dairyDietTabSvg),
      iconMargin: const EdgeInsets.only(bottom: 5.0),
    ),
    Tab(
      text: 'Water',
      icon: SvgPicture.asset(AppAssets.dairyWatertTabSvg),
      iconMargin: const EdgeInsets.only(bottom: 5.0),
    ),
    Tab(
      text: 'Exercise',
      icon: SvgPicture.asset(AppAssets.dairyExerciseTabSvg),
      iconMargin: const EdgeInsets.only(bottom: 5.0),
    ),
    Tab(
      text: 'Mind',
      icon: SvgPicture.asset(AppAssets.dairyMindTabSvg),
      iconMargin: const EdgeInsets.only(bottom: 5.0),
    ),
  ];

  var isLoading = false.obs;
  final ApiService apiService = ApiService();
  Rx<DiaryModel> diaryData = DiaryModel().obs;
  Future<void> getDiaryDetail(DateTime datetime) async {
    log("datetime : $datetime");
    try {
      isLoading.value = true;
      String? token = await StorageServivce.getToken();
      var response = await apiService.get(
        "${ApiUrls.getTodayDiaryInfo}?filter_date=$datetime",
        authToken: token,
      );
      log("dairy code: ${response.statusCode} dairy body: ${response.body}");
      if (response.statusCode == 200) {
        var dataObj = jsonDecode(response.body);

        diaryData.value = DiaryModel.fromMap(dataObj);
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
}
