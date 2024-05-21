import 'dart:convert';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:weight_loss_app/common/api_urls.dart';
import 'package:weight_loss_app/common/app_texts.dart';
import 'package:weight_loss_app/modules/authentication/signup/models/signup_success_response.dart';

import 'package:weight_loss_app/modules/registeration_questions/gender/binding/gender_binding.dart';
import 'package:weight_loss_app/modules/registeration_questions/gender/gender_page/gender_page.dart';
import 'package:weight_loss_app/utils/api_service.dart';
import 'package:weight_loss_app/utils/shared_prefrence.dart';
import 'package:weight_loss_app/widgets/custom_snackbar.dart';

class OtpController extends GetxController {
  final pinController = TextEditingController();
  final focusNode = FocusNode();
  var otpCounter = 0.obs;
  var isLoading = false.obs;
  final ApiService apiService = ApiService();
  @override
  void dispose() {
    pinController.dispose();
    focusNode.dispose();
    super.dispose();
  }

  void validateAndCallOtpApi(bool isSignup) {
    if (pinController.text.isEmpty) {
      customSnackbar(title: AppTexts.error, message: "Otp Required");
    } else {
      signUpOtp(isSignup);
    }
  }

  Future<void> signUpOtp(bool isSignup) async {
    Map<String, dynamic> bodyData = {
      "otp": pinController.text,
      "type": isSignup ? "signup" : "login",
    };
    try {
      isLoading.value = true;
      log("beforeResponse");
      var response =
          await apiService.formDataPost(ApiUrls.verifyOtpEndPoint, bodyData);
      log("afterrResponse ${response.statusCode}");
      var dateObj = jsonDecode(response.body);
      if (response.statusCode == 200) {
        var result = SinUpSuccessResponse.fromJson(dateObj);
        log("signUpResponse --------------------------------\n$dateObj");
        isLoading.value = false;
        if (result.responseDto!.message == "Ok") {
          log("ok");
          if (await StorageServivce.saveToken(result.userTokens!.token!)) {
            Get.off(() => const GenderPage(), binding: GenderBinding());
          }
        } else if (result.responseDto!.message == "No record/s found") {
          log("not ok");
          pinController.clear();
          customSnackbar(title: AppTexts.error, message: "Invalid OTP");
        }
      } else {
        isLoading.value = false;
        customSnackbar(title: AppTexts.error, message: "Api response failed");
      }
    } catch (e) {
      isLoading.value = false;
      customSnackbar(title: AppTexts.error, message: "Api Exception");
    }
  }

  Future<void> resendOtpApi() async {
    try {
      isLoading.value = true;
      var token = await StorageServivce.getToken();
      var response =
          await apiService.get(ApiUrls.resendOtpEndPoint, authToken: token);

      if (response.statusCode == 200) {
        isLoading.value = false;
        otpCounter++;
        customSnackbar(
            title: "OTP",
            message: "Otp has been sent to your Registered Email");
      } else {
        isLoading.value = false;
        customSnackbar(title: AppTexts.error, message: "Api response failed");
      }
    } catch (e) {
      isLoading.value = false;
      customSnackbar(title: AppTexts.error, message: "Api Exception");
    }
  }
}
