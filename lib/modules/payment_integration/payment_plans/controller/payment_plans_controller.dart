import 'dart:convert';
import 'dart:developer';

import 'package:get/get.dart';
import 'package:weight_loss_app/common/api_urls.dart';
import 'package:weight_loss_app/common/app_texts.dart';
import 'package:weight_loss_app/modules/payment_integration/payment_plans/models/payment_plans_model.dart';
import 'package:weight_loss_app/utils/api_service.dart';
import 'package:weight_loss_app/utils/shared_prefrence.dart';
import 'package:weight_loss_app/widgets/custom_snackbar.dart';

class PaymentPlansController extends GetxController {
  @override
  void onInit() {
    getPaymentPlansApi();
    super.onInit();
  }

  var selectedIndex = 0.obs;
  final ApiService apiService = ApiService();
  var isLoading = false.obs;

  Rx<PaymentPlansModel> getPaymentPlans = PaymentPlansModel().obs;
  Future<void> getPaymentPlansApi() async {
    try {
      isLoading.value = true;
      String? token = await StorageServivce.getToken();
      var response = await apiService.get(
        ApiUrls.paymentPlansEndPoint,
        authToken: token,
      );
      log("status code ${response.statusCode}body ${jsonDecode(response.body)}");
      if (response.statusCode == 200) {
        var dataObj = jsonDecode(response.body);
        getPaymentPlans.value = PaymentPlansModel.fromJson(dataObj);

        isLoading.value = false;
      } else {
        isLoading.value = false;
        customSnackbar(title: AppTexts.error, message: "No Payment Plan Found");
      }
    } catch (e) {
      isLoading.value = false;
      log(e.toString());
    }
  }
}
