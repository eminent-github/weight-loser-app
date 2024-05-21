import 'dart:convert';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:weight_loss_app/common/api_urls.dart';
import 'package:weight_loss_app/common/app_texts.dart';
import 'package:weight_loss_app/modules/authentication/login/binding/login_binding.dart';
import 'package:weight_loss_app/modules/authentication/login/view/login_page.dart';
import 'package:weight_loss_app/utils/api_service.dart';
import 'package:weight_loss_app/utils/shared_prefrence.dart';
import 'package:weight_loss_app/widgets/custom_snackbar.dart';

class DeleteAccountController extends GetxController {
  var isLoading = false.obs;
  final ApiService apiService = ApiService();
  TextEditingController passwordController = TextEditingController();
  var confirmPasswordVisible = true.obs;
  RxString password = "".obs;
  @override
  void dispose() {
    passwordController.dispose();
    super.dispose();
  }

  Future<void> deleteAccount() async {
    try {
      isLoading.value = true;
      String? token = await StorageServivce.getToken();
      var response = await apiService.delete(
        ApiUrls.deleteUserAccountEndPoint,
        authToken: token,
      );
      log(response.statusCode.toString());
      if (response.statusCode == 200) {
        logoutAccount()
            .then((value) => isLoading.value = false)
            .onError((error, stackTrace) => isLoading.value = false);
      } else {
        isLoading.value = false;
        customSnackbar(title: AppTexts.success, message: 'Account not Deleted');
      }
    } catch (e) {
      isLoading.value = false;
      log(e.toString());
    }
  }

  void validateAndDelete() {
    if (passwordController.text.isEmpty) {
      customSnackbar(title: AppTexts.error, message: AppTexts.emptyPassword);
    } else if (passwordController.text != password.value) {
      customSnackbar(
          title: AppTexts.error, message: "Please Enter your correct password");
    } else {
      deleteAccount();
    }
  }

  @override
  void onInit() {
    getUserPasswordApi();
    super.onInit();
  }

  Future<void> getUserPasswordApi() async {
    try {
      isLoading.value = true;
      String? token = await StorageServivce.getToken();
      var response = await apiService.get(
        ApiUrls.getUserPasswordEndPoint,
        authToken: token,
      );
      log(token!);
      if (response.statusCode == 200) {
        var dataObj = jsonDecode(response.body);
        password.value = dataObj["userDto"]["password"] as String;
        print(password.value);
        isLoading.value = false;
      } else {
        isLoading.value = false;
        customSnackbar(title: AppTexts.error, message: "No record found");
      }
    } catch (e) {
      isLoading.value = false;
      log("exception ${e.toString()}");
    }
  }

  Future<void> logoutAccount() async {
    try {
      String? token = await StorageServivce.getToken();
      var response = await apiService.postWithoutBody(
        ApiUrls.logoutAccountEndPoint,
        authToken: token,
      );

      if (response.statusCode == 200) {
        // var dataObj = await jsonDecode(response.body);
        // print(dataObj);

        GoogleSignIn googleSignIn = GoogleSignIn();
        if (await googleSignIn.isSignedIn()) {
          await googleSignIn.signOut();
        }
        bool isLogout = await StorageServivce.logout();
        if (isLogout) {
          Get.offAll(() => const LoginPage(), binding: LoginBinding());
        }
      } else {
        isLoading.value = false;
        customSnackbar(title: AppTexts.success, message: 'Account not Deleted');
      }
    } catch (e) {
      isLoading.value = false;
      log(e.toString());
    }
  }
}
