import 'dart:convert';
import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:weight_loss_app/common/api_urls.dart';
import 'package:weight_loss_app/common/app_texts.dart';
import 'package:weight_loss_app/modules/authentication/login/binding/login_binding.dart';
import 'package:weight_loss_app/modules/authentication/login/view/login_page.dart';
import 'package:weight_loss_app/modules/authentication/signup/models/signup_success_response.dart';
import 'package:weight_loss_app/utils/api_service.dart';
import 'package:weight_loss_app/utils/shared_prefrence.dart';
import 'package:weight_loss_app/widgets/custom_snackbar.dart';

class ChangePasswordController extends GetxController {
  var currentPasswordTextEditingController = TextEditingController().obs;
  var setNewPasswordTextEditingController = TextEditingController().obs;
  var confirmPasswordTextEditingController = TextEditingController().obs;
  FocusNode currentPasswordFocusNode = FocusNode();
  FocusNode newPasswordFocusNode = FocusNode();
  FocusNode confirmPasswordFocusNode = FocusNode();
  var currentPasswordVisible = true.obs;
  var newPasswordVisible = true.obs;
  var confirmPasswordVisible = true.obs;

  RxString password = "".obs;
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

  @override
  void dispose() {
    currentPasswordTextEditingController.value.dispose();
    setNewPasswordTextEditingController.value.dispose();
    confirmPasswordTextEditingController.value.dispose();
    super.dispose();
  }

  var isLoading = false.obs;
  final ApiService apiService = ApiService();
  void validateAndCallChangePasswordApi() {
    if (currentPasswordTextEditingController.value.text.isEmpty) {
      customSnackbar(
          title: AppTexts.error, message: "Current ${AppTexts.emptyPassword}");
    } else if (setNewPasswordTextEditingController.value.text.isEmpty) {
      customSnackbar(
          title: AppTexts.error, message: "New ${AppTexts.emptyPassword}");
    } else if (confirmPasswordTextEditingController.value.text.isEmpty) {
      customSnackbar(
          title: AppTexts.error, message: "Confirm ${AppTexts.emptyPassword}");
    } else if (currentPasswordTextEditingController.value.text !=
        password.value) {
      customSnackbar(
          title: AppTexts.error, message: "Please Enter your correct password");
    } else if (setNewPasswordTextEditingController.value.text.length < 6) {
      customSnackbar(title: AppTexts.error, message: "Weak Password");
    } else {
      if (setNewPasswordTextEditingController.value.text ==
          confirmPasswordTextEditingController.value.text) {
        changePassword();
      } else {
        customSnackbar(
            title: AppTexts.error, message: "Passwords do not match");
      }
    }
  }

  Future<void> changePassword() async {
    Map<String, dynamic> bodyData = {
      "password": setNewPasswordTextEditingController.value.text,
      "currentPassword": currentPasswordTextEditingController.value.text,
    };
    try {
      isLoading.value = true;
      log("beforeResponse 9");
      String? token = await StorageServivce.getToken();
      var response = await apiService.formDataPatch(
        ApiUrls.forgotPasswordEndPoint,
        bodyData,
        authToken: token,
      );
      log("afterrResponse 10");

      if (response.statusCode == 200) {
        var dateObj = jsonDecode(response.body);
        var result = SinUpSuccessResponse.fromJson(dateObj);

        if (result.responseDto!.status == true) {
          logoutAccount()
              .then((value) => isLoading.value = false)
              .onError((error, stackTrace) => isLoading.value = false);
        } else {
          isLoading.value = false;
          customSnackbar(
              title: AppTexts.error, message: result.responseDto!.message);
        }
      } else {
        isLoading.value = false;
        customSnackbar(title: AppTexts.error, message: "Record not found.");
      }
    } catch (e) {
      isLoading.value = false;
      log("$e");
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

        GoogleSignIn googleSignIn = GoogleSignIn(
          // clientId:
          //     "509631727697-f74qbmhj2se28o5a2a42asko58nl0s16.apps.googleusercontent.com",
        );
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
