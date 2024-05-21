import 'dart:convert';
import 'dart:developer';

import 'package:get/get.dart';
import 'package:weight_loss_app/common/api_urls.dart';
import 'package:weight_loss_app/common/app_texts.dart';
import 'package:weight_loss_app/modules/profile/view_profile/model/user_profile_model.dart';
import 'package:weight_loss_app/utils/api_service.dart';
import 'package:weight_loss_app/utils/shared_prefrence.dart';
import 'package:weight_loss_app/widgets/custom_snackbar.dart';

class ViewProfileController extends GetxController {
  var isLoading = false.obs;
  final ApiService apiService = ApiService();

  var userProfileData = UserProfileModel().obs;
  @override
  void onInit() {
    getUserProfileApi();
    super.onInit();
  }

  Future<void> getUserProfileApi() async {
    try {
      isLoading.value = true;
      String? token = await StorageServivce.getToken();
      var response = await apiService.get(
        ApiUrls.getUserProfileEndPoint,
        authToken: token,
      );
      log(token!);
      if (response.statusCode == 200) {
        var dataObj = jsonDecode(response.body);
        var data = dataObj["userProfileData"];

        userProfileData.value = UserProfileModel.fromMap(data);

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
}
