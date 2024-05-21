import 'dart:convert';
import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:weight_loss_app/common/api_urls.dart';
import 'package:weight_loss_app/common/app_texts.dart';
import 'package:weight_loss_app/modules/authentication/forget_otp/binding/forget_otp_binding.dart';
import 'package:weight_loss_app/modules/authentication/forget_otp/forget_otp_page/forget_otp_page.dart';
import 'package:weight_loss_app/modules/authentication/signup/models/signup_success_response.dart';
import 'package:weight_loss_app/utils/api_service.dart';
import 'package:weight_loss_app/widgets/custom_snackbar.dart';

class ForgetController extends GetxController {
  Rx<TextEditingController> emailTextEditingController =
      TextEditingController().obs;
  FocusNode emailFocusNode = FocusNode();
  var isLoading = false.obs;
  final ApiService apiService = ApiService();

  void validateAndCallOtpApi(bool isLogin) {
    if (emailTextEditingController.value.text.isEmpty) {
      customSnackbar(title: AppTexts.error, message: AppTexts.emptyEmail);
    } else if (!RegExp(
            r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$')
        .hasMatch(emailTextEditingController.value.text)) {
      customSnackbar(title: AppTexts.error, message: AppTexts.emailFormat);
    } else {
      forgetEmail(
        isLogin,
      );
    }
  }

  Future<void> forgetEmail(bool isLogin) async {
    Map<String, dynamic> bodyData = {
      "Email": emailTextEditingController.value.text,
    };
    try {
      isLoading.value = true;

      log("beforeResponse 9");
      var response = await apiService.formDataPost(
        ApiUrls.verifyEmailEndPoint,
        bodyData,
      );
      log(response.statusCode.toString());

      if (response.statusCode == 200) {
        var dateObj = jsonDecode(response.body);
        var result = SinUpSuccessResponse.fromJson(dateObj);
        isLoading.value = false;
        if (result.responseDto!.message == "Ok") {
          Get.off(
            () => ForgetOtpPage(
              token: result.userTokens!.token!,
              email: emailTextEditingController.value.text,
              isLogin: isLogin,
            ),
            binding: ForgetOtpBinding(),
          );
        } else if (result.responseDto!.message == "Authentication failed") {
          customSnackbar(
              title: AppTexts.error, message: "Email is not registered");
        } else {
          customSnackbar(
              title: AppTexts.error, message: result.responseDto!.message);
        }
      } else {
        isLoading.value = false;
        customSnackbar(title: AppTexts.error, message: "No record found");
      }
    } catch (e) {
      isLoading.value = false;
      // print(e);
    }
  }
}
