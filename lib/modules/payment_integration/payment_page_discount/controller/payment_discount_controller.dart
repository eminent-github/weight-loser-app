import 'dart:async';
import 'dart:convert';
import 'dart:developer';

import 'package:get/get.dart';
import 'package:stop_watch_timer/stop_watch_timer.dart';
import 'package:weight_loss_app/common/api_urls.dart';
import 'package:weight_loss_app/common/app_texts.dart';
import 'package:weight_loss_app/modules/payment_integration/payment_page_discount/model/payment_discount_model.dart';
import 'package:weight_loss_app/utils/api_service.dart';
import 'package:weight_loss_app/utils/shared_prefrence.dart';
import 'package:weight_loss_app/widgets/custom_snackbar.dart';

class PaymentDiscountController extends GetxController {
  var targetWeight = 0.obs;
  var currentWeight = 0.obs;
  var weightUnit = "".obs;
  var userName = "".obs;
  RxDouble dubValue = 1.0.obs;

  void updateValue(double value) {
    dubValue.value = value;
  }

  bool? isLogin;
  var stopWatchTimer = StopWatchTimer(
    mode: StopWatchMode.countDown,
    presetMillisecond: StopWatchTimer.getMilliSecFromSecond(600),
  );

  @override
  void onInit() {
    getTargetAndCurrentWeight();
    isLogin! ? getPaymentPlanApi() : getTrialPaymentPlanApi();
    super.onInit();
  }

  @override
  void dispose() async {
    await stopWatchTimer.dispose();
    super.dispose();
  }

  discountCheck(bool ismLogin) {
    isLogin = ismLogin;
  }

  getTargetAndCurrentWeight() async {
    targetWeight.value = (await StorageServivce.getTargetWeight()) ?? 0;
    currentWeight.value = (await StorageServivce.getCurrentWeight()) ?? 0;
    weightUnit.value = (await StorageServivce.getWeightUnit()) ?? "";
    userName.value = (await StorageServivce.getUserName()) ?? "unKnown";
  }

  int daysToLoseWeight(
      {required num goalWeight,
      required num currentWeight,
      required double weightPerWeek}) {
    log("cwe: $currentWeight gwe: $goalWeight perWeek: $weightPerWeek");
    double numbeOfWeeks = (currentWeight - goalWeight) / weightPerWeek;

    print("days------${((numbeOfWeeks / 4.34524) * 30).round()}");
    return ((numbeOfWeeks / 4.34524) * 30).round();
  }

  DateTime expectedDate(
      {required num targetWeight,
      required num currentWeight,
      required String weightUnit}) {
    // log("cur :$currentWeight tar :$targetWeight");
    return DateTime.now().add(
      Duration(
        days: daysToLoseWeight(
          currentWeight:
              weightUnit == "kg" ? currentWeight * 2.2 : currentWeight,
          goalWeight: weightUnit == "kg" ? targetWeight * 2.2 : targetWeight,
          weightPerWeek: 1.5,
        ),
      ),
    );
  }

  final ApiService apiService = ApiService();
  var isLoading = false.obs;

  Rx<PaymentDiscountModel> getPaymentPlan = PaymentDiscountModel().obs;
  Future<void> getPaymentPlanApi() async {
    try {
      isLoading.value = true;
      String? token = await StorageServivce.getToken();
      var response = await apiService.get(
        "${ApiUrls.paymentPlansEndPoint}/Monthly",
        authToken: token,
      );
      log("status code ${response.statusCode}body ${jsonDecode(response.body)}");
      if (response.statusCode == 200) {
        var dataObj = jsonDecode(response.body);
        getPaymentPlan.value = PaymentDiscountModel.fromJson(dataObj);
        stopWatchTimer.onStartTimer();
        isLoading.value = false;
      } else {
        isLoading.value = false;
        customSnackbar(title: AppTexts.error, message: "No Payment Plan Found");
        getPaymentPlan.value =
            PaymentDiscountModel(discount: 0.0, packages: Packages(price: 0.0));
      }
    } catch (e) {
      isLoading.value = false;
      getPaymentPlan.value =
          PaymentDiscountModel(discount: 0.0, packages: Packages(price: 0.0));
      log(e.toString());
    }
  }

  Future<void> getTrialPaymentPlanApi() async {
    try {
      isLoading.value = true;
      String? token = await StorageServivce.getToken();
      var response = await apiService.get(
        "${ApiUrls.paymentPlansEndPoint}/TrialMonthly",
        authToken: token,
      );
      log("status code ${response.statusCode}body ${jsonDecode(response.body)}");
      if (response.statusCode == 200) {
        var dataObj = jsonDecode(response.body);
        getPaymentPlan.value = PaymentDiscountModel.fromJson(dataObj);
        stopWatchTimer.onStartTimer();
        isLoading.value = false;
      } else {
        isLoading.value = false;
        customSnackbar(title: AppTexts.error, message: "No Payment Plan Found");
        getPaymentPlan.value =
            PaymentDiscountModel(discount: 0.0, packages: Packages(price: 0.0));
      }
    } catch (e) {
      isLoading.value = false;
      getPaymentPlan.value =
          PaymentDiscountModel(discount: 0.0, packages: Packages(price: 0.0));
      log(e.toString());
    }
  }

  double planPriceCalculation(double price) {
    return daysToLoseWeight(
          currentWeight: weightUnit.value == "kg"
              ? currentWeight.value * 2.2
              : currentWeight.value,
          goalWeight: weightUnit.value == "kg"
              ? targetWeight.value * 2.2
              : targetWeight.value,
          weightPerWeek: 1.5,
        ) *
        (price / 30);
  }
}
