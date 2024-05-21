import 'dart:convert';
import 'dart:developer';

import 'package:get/get.dart';
import 'package:weight_loss_app/common/api_urls.dart';
import 'package:weight_loss_app/common/app_texts.dart';
import 'package:weight_loss_app/modules/payment_integration/payment_plans/models/payment_plans_model.dart';
import 'package:weight_loss_app/utils/api_service.dart';
import 'package:weight_loss_app/utils/shared_prefrence.dart';
import 'package:weight_loss_app/widgets/custom_snackbar.dart';

class RegularPriceController extends GetxController {
  var targetWeight = 0.obs;
  var currentWeight = 0.obs;
  var weightUnit = "".obs;
  var userName = "".obs;
  RxBool isShowTrial = false.obs;
  RxString selectedConsumableProduct = "".obs;

// $0.3
// $0.7
// $1
// $3
// $7
  List<String> trialPrices = ["0.99", "2.99", "4.99", "6.99"];

  @override
  void onInit() {
    getTargetAndCurrentWeight();
    getPaymentPlanApi();
    super.onInit();
  }

  getTargetAndCurrentWeight() async {
    targetWeight.value = (await StorageServivce.getTargetWeight()) ?? 0;
    currentWeight.value = (await StorageServivce.getCurrentWeight()) ?? 0;
    weightUnit.value = (await StorageServivce.getWeightUnit()) ?? "lb";
    userName.value = (await StorageServivce.getUserName()) ?? "unKnown";
  }

  int daysToLoseWeight(
      {required num goalWeight,
      required num currentWeight,
      required double weightPerWeek}) {
    // log("cwe: $currentWeight gwe: $goalWeight perWeek: $weightPerWeek");
    double numbeOfWeeks = (currentWeight - goalWeight) / weightPerWeek;

    // print("days------${((numbeOfWeeks / 4.34524) * 30).round()}");
    return ((numbeOfWeeks / 4.34524) * 30).round();
  }

  final ApiService apiService = ApiService();
  var isLoading = false.obs;

  var getPaymentPlans = <PackagesList>[].obs;
  Future<void> getPaymentPlanApi() async {
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
        var list = dataObj["packagesList"] != null
            ? dataObj["packagesList"] as List
            : [];
        getPaymentPlans.value =
            list.map((e) => PackagesList.fromJson(e)).toList();

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

  (PackagesList, String) planAccordingTOMonths() {
    int days = expectedDate(
            targetWeight: targetWeight.value,
            currentWeight: currentWeight.value,
            weightUnit: weightUnit.value)
        .difference(DateTime.now())
        .inDays;

    if (days <= 90) {
      return (
        getPaymentPlans.singleWhere((element) => element.id == 5),
        "wl_3month_plan"
      );
    } else if (days > 90 && days <= 180) {
      return (
        getPaymentPlans.singleWhere((element) => element.id == 4),
        "wl_6month_plan"
      );
    } else {
      return (
        getPaymentPlans.singleWhere((element) => element.id == 2),
        "wl_yearly_plan"
      );
    }
  }

  ///
  ///
  ///
  ///
  ///
  ///
  Future<void> selectedPurchase({required String value}) async {
    /// wl_trail_0.99
    /// wl_trail_2.99
    ///wl_trial_4.99
    ///wl_trial_6.99
    switch (value) {
      case '0.99':
        // selectedConsumableProduct.value = "wl_program_90";
        selectedConsumableProduct.value = "wl_trail_0.99";
        print('Value is 0.99');
        break;
      case '2.99':
        selectedConsumableProduct.value = "wl_trail_2.99";
        print('Value is 2.00');
        break;
      case '4.99':
        selectedConsumableProduct.value = "wl_trial_4.99";
        print('Value is 4.99');
        break;
      case '6.99':
        selectedConsumableProduct.value = "wl_trial_6.99";
        print('Value is 6.99');
        break;
      default:
        print('Value is unknown');
    }
  }

  ///
  ///
  ///
  // Future<void> makePayment() async {
  //   try {
  //     //STEP 1: Create Payment Intent
  //     paymentIntent = await createPaymentIntent('100', 'USD');

  //     //STEP 2: Initialize Payment Sheet
  //     await Stripe.instance
  //         .initPaymentSheet(
  //             paymentSheetParameters: SetupPaymentSheetParameters(
  //                 paymentIntentClientSecret: paymentIntent![
  //                     'client_secret'], //Gotten from payment intent
  //                 style: ThemeMode.light,
  //                 merchantDisplayName: 'Ikay'))
  //         .then((value) {});

  //     //STEP 3: Display Payment sheet
  //     displayPaymentSheet();
  //   } catch (err) {
  //     throw Exception(err);
  //   }
  // }
  ///
  ///
  ///
  // void createPaymentIntent(String amount, String currency) async {
  //   try {
  //     //Request body
  //     Map<String, dynamic> body = {
  //       'amount': calculateAmount(amount),
  //       'currency': currency,
  //     };

  //     //Make post request to Stripe
  //     var response = await http.post(
  //       Uri.parse('https://api.stripe.com/v1/payment_intents'),
  //       headers: {
  //         'Authorization': 'Bearer ${dotenv.env['STRIPE_SECRET']}',
  //         'Content-Type': 'application/x-www-form-urlencoded'
  //       },
  //       body: body,
  //     );
  //     return json.decode(response.body);
  //   } catch (err) {
  //     throw Exception(err.toString());
  //   }
  // }
}
