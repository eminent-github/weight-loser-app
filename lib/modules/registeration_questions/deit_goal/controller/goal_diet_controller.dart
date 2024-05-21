import 'dart:convert';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:weight_loss_app/common/api_urls.dart';
import 'package:weight_loss_app/common/app_colors.dart';
import 'package:weight_loss_app/common/app_texts.dart';
import 'package:weight_loss_app/common/questions_page_name.dart';
import 'package:weight_loss_app/modules/registeration_questions/biology_section_graph/binding/biology_section_graph_binding.dart';
import 'package:weight_loss_app/modules/registeration_questions/biology_section_graph/biology_section_graph_page/section_graph_page.dart';
import 'package:weight_loss_app/modules/registeration_questions/models/user_info_response_model.dart';
import 'package:weight_loss_app/utils/api_service.dart';
import 'package:weight_loss_app/utils/shared_prefrence.dart';
import 'package:weight_loss_app/widgets/custom_snackbar.dart';

class GoalDietController extends GetxController {
  var selectedDate = DateTime.now().obs;
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
    if (picked != null && picked != selectedDate.value) {
      if (picked.isBefore(DateTime.now())) {
        customSnackbar(
            title: AppTexts.error, message: AppTexts.pleaseSelectDateInFuture);
      } else {
        selectedDate.value = picked;
      }
    }
  }

  final ApiService apiService = ApiService();
  var isLoading = false.obs;
  Future<void> targeDateApi() async {
    print(selectedDate);
    Map<String, dynamic> bodyData = {
      "value": selectedDate.value.toString().substring(0, 10),
      "PageName": QuestionPageNames.goalDietPageName,
    };
    try {
      isLoading.value = true;
      var token = await StorageServivce.getToken();
      log("beforeResponse");
      var response = await apiService.formDataPatch(
          ApiUrls.targetDateEndPoint, bodyData,
          authToken: token);
      log("afterrResponse");
      if (response.statusCode == 200) {
        var dateObj = jsonDecode(response.body);
        var result = UserInfoResponseModel.fromJson(dateObj);
        log("targetWeightResponse --------------------------------\n$dateObj");
        isLoading.value = false;
        if (result.responseDto!.status ?? false) {
          await StorageServivce.saveGoalDate(
              DateFormat("yyyy-MM-dd").format(selectedDate.value));
          Get.to(
              BiologySectionGraphPage(
                targetWeight: await StorageServivce.getTargetWeight() ?? 0,
                currentWeight: await StorageServivce.getCurrentWeight() ?? 0,
                weightUnit: await StorageServivce.getWeightUnit() ?? "",
              ),
              binding: BiologySectionGraphBinding());
        } else {
          customSnackbar(
              title: AppTexts.error, message: result.responseDto!.message);
        }
      } else {
        isLoading.value = false;
        customSnackbar(
            title: AppTexts.error, message: AppTexts.userAPiExceptionResponse);
      }
    } catch (e) {
      isLoading.value = false;
      // print(e);
      customSnackbar(title: AppTexts.error, message: "Api Exception");
    }
  }
}
