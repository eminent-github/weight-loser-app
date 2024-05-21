import 'dart:convert';
import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:weight_loss_app/common/api_urls.dart';
import 'package:weight_loss_app/common/app_texts.dart';
import 'package:weight_loss_app/modules/authentication/signup/models/signup_success_response.dart';
import 'package:weight_loss_app/modules/setting/delete_account/controller/delete_account_controller.dart';
import 'package:weight_loss_app/utils/api_service.dart';
import 'package:weight_loss_app/widgets/custom_snackbar.dart';

class PasswordController extends GetxController {
  Rx<TextEditingController> passwordTextEditingController =
      TextEditingController().obs;
  Rx<TextEditingController> confirmPasswordTextEditingController =
      TextEditingController().obs;
  FocusNode passwordFocusNode = FocusNode();
  FocusNode confirmPasswordFocusNode = FocusNode();

  var passwordVisible = true.obs;
  var confirmPasswordVisible = true.obs;
  var isLoading = false.obs;
  final ApiService apiService = ApiService();
  void validateAndCallNewPasswordApi(String token, bool isLogin) {
    if (passwordTextEditingController.value.text.isEmpty) {
      customSnackbar(title: AppTexts.error, message: AppTexts.emptyPassword);
    } else if (passwordTextEditingController.value.text.length < 6) {
      customSnackbar(title: AppTexts.error, message: "Weak Password");
    } else if (confirmPasswordTextEditingController.value.text.isEmpty) {
      customSnackbar(
          title: AppTexts.error, message: "Confirm ${AppTexts.emptyPassword}");
    } else if (confirmPasswordTextEditingController.value.text.length < 6) {
      customSnackbar(title: AppTexts.error, message: "Weak Password");
    } else {
      if (passwordTextEditingController.value.text ==
          confirmPasswordTextEditingController.value.text) {
        changePassword(token, isLogin);
      } else {
        customSnackbar(title: AppTexts.error, message: "Password do not match");
      }
    }
  }

  Future<void> changePassword(String token, bool isLogin) async {
    Map<String, dynamic> bodyData = {
      "password": passwordTextEditingController.value.text,
    };
    try {
      isLoading.value = true;
      log("beforeResponse 9");
      var response = await apiService.formDataPatch(
        ApiUrls.forgotPasswordEndPoint,
        bodyData,
        authToken: token,
      );
      log("afterrResponse 10  ${response.statusCode}");

      if (response.statusCode == 200) {
        var dateObj = jsonDecode(response.body);
        var result = SinUpSuccessResponse.fromJson(dateObj);
        isLoading.value = false;
        if (result.responseDto!.status == true) {
          if (!isLogin) {
            Get.find<DeleteAccountController>().getUserPasswordApi();
          }
          Get.back();
        } else {
          customSnackbar(
              title: AppTexts.error, message: result.responseDto!.message);
        }
      } else {
        log("afterrResponse 10  $response");
        isLoading.value = false;
        customSnackbar(title: AppTexts.error, message: "Api Exception");
      }
    } catch (e) {
      isLoading.value = false;
      // print(e);
    }
  }
}
