import 'dart:convert';
import 'dart:developer';

import 'package:get/get.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:weight_loss_app/common/api_urls.dart';
import 'package:weight_loss_app/common/app_texts.dart';
import 'package:weight_loss_app/modules/authentication/login/binding/login_binding.dart';
import 'package:weight_loss_app/modules/authentication/login/view/login_page.dart';
import 'package:weight_loss_app/utils/api_service.dart';
import 'package:weight_loss_app/utils/shared_prefrence.dart';
import 'package:weight_loss_app/widgets/custom_snackbar.dart';

class AccountController extends GetxController {
  var isLoading = false.obs;
  final ApiService apiService = ApiService();
  RxString userEmail = "".obs;
  @override
  void onInit() {
    getUserEmailApi();
    super.onInit();
  }

  Future<void> getUserEmailApi() async {
    try {
      isLoading.value = true;
      String? token = await StorageServivce.getToken();
      var response = await apiService.get(
        ApiUrls.getUserEmailEndPoint,
        authToken: token,
      );
      log(response.statusCode.toString());
      if (response.statusCode == 200) {
        var dataObj = jsonDecode(response.body);
        userEmail.value = dataObj["userEmail"]["email"] ?? "";

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
      isLoading.value = true;
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
        isLoading.value = false;
        if (isLogout) {
          Get.offAll(() => const LoginPage(), binding: LoginBinding());
        }
      } else {
        isLoading.value = false;
        customSnackbar(title: AppTexts.success, message: 'Account not Logout');
      }
    } catch (e) {
      isLoading.value = false;
      log(e.toString());
    }
  }
}
