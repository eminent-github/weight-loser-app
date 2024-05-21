import 'dart:async';
import 'dart:convert';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:in_app_purchase/in_app_purchase.dart';
import 'package:weight_loss_app/common/api_urls.dart';
import 'package:weight_loss_app/common/app_texts.dart';
import 'package:weight_loss_app/modules/payment_integration/payment_page/model/payment_success_detail.dart';
import 'package:weight_loss_app/modules/payment_integration/payment_plans/models/payment_plans_model.dart';
import 'package:weight_loss_app/modules/talking_oath/talking_outh/binding/talking_oath_binding.dart';
import 'package:weight_loss_app/modules/talking_oath/talking_outh/view/talking_oath_page.dart';
import 'package:weight_loss_app/utils/api_service.dart';
import 'package:weight_loss_app/utils/shared_prefrence.dart';
import 'package:weight_loss_app/widgets/custom_snackbar.dart';

class MonthlyPlanController extends GetxController {
  var targetWeight = 0.obs;
  var currentWeight = 0.obs;
  var weightUnit = "".obs;
  var userName = "".obs;

  PackagesList? monthlyPackage;
  getPaymentData(PackagesList amonthlyPackage) {
    monthlyPackage = amonthlyPackage;
  }

  final InAppPurchase iap = InAppPurchase.instance;

  late StreamSubscription<List<PurchaseDetails>> _purchasesSubscription;
  var isLoading = false.obs;

  @override
  void onInit() {
    super.onInit();
    getTargetAndCurrentWeight();
    initialize();
  }

  final ApiService apiService = ApiService();
  var isApiLoading = false.obs;

  Future<void> paymentPostApi(
      PostPaymentModel postPaymentModel, String type) async {
    Map<String, dynamic> bodyData = {
      "packageId": postPaymentModel.packageId,
      "amount": postPaymentModel.amount.toStringAsFixed(2),
      "Discount": postPaymentModel.discount,
      "DiscountPrice": postPaymentModel.discountPrice,
      "TotalAmount": postPaymentModel.totalAmount,
      "type": type,
      "status": postPaymentModel.status, //trial,pending,paid
      "duration": postPaymentModel.duration
    };
    try {
      isApiLoading.value = true;
      log("beforeResponse");
      var response = await apiService.post(
        ApiUrls.postPaymentEndPoint,
        jsonEncode(bodyData),
        authToken: await StorageServivce.getToken(),
      );
      log("afterrResponse");
      log(response.statusCode.toString());
      if (response.statusCode == 200) {
        var dateObj = jsonDecode(response.body);

        log("ageResponse --------------------------------\n$dateObj");
        isApiLoading.value = false;
        Get.offAll(() => const TalkingOathPage(),
            binding: TalkingOathBinding());
      } else {
        isApiLoading.value = false;
        Get.offAll(() => const TalkingOathPage(),
            binding: TalkingOathBinding());
      }
    } catch (e) {
      isApiLoading.value = false;
      customSnackbar(title: AppTexts.error, message: "Api Exception");
    }
  }

  @override
  void dispose() {
    _purchasesSubscription.cancel();
    super.dispose();
  }

  @override
  void onClose() {
    _purchasesSubscription.cancel();
    super.onClose();
  }

  Future<void> initialize() async {
    if (!(await iap.isAvailable())) return;

    ///catch all purchase updates
    _purchasesSubscription = InAppPurchase.instance.purchaseStream.listen(
      (List<PurchaseDetails> purchaseDetailsList) {
        log("^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^${purchaseDetailsList.length}");
        handlePurchaseUpdates(purchaseDetailsList);
      },
      onDone: () {
        log("%%%%%%%%%%%% Done");

        _purchasesSubscription.cancel();
      },
      onError: (error) {
        log("@@@@@@@@@@@@@@@@@@ error:$error");
        _purchasesSubscription.resume();
      },
    );
  }

  void handlePurchaseUpdates(List<PurchaseDetails> purchaseDetailsList) async {
    PurchaseDetails purchaseDetails = purchaseDetailsList.first;
    var purchaseStatus = purchaseDetails.status;
    log("^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^${purchaseDetailsList.length}");
    switch (purchaseDetails.status) {
      case PurchaseStatus.pending:
        isLoading.value = true;
        print(' purchase is in pending');

      case PurchaseStatus.error:
        print(' purchase error ');
        isLoading.value = false;
        break;
      case PurchaseStatus.canceled:
        isLoading.value = false;
        print(' purchase cancel ');
        break;
      case PurchaseStatus.purchased:
        isLoading.value = false;
        print("_____________________${purchaseDetails.transactionDate}");
        break;
      case PurchaseStatus.restored:
        isLoading.value = false;
        print(' purchase restore ');
        break;
      default:
        isLoading.value = false;
        print(
            'this is purchase status not purchased ${purchaseDetails.status}');
    }

    if (purchaseDetails.pendingCompletePurchase) {
      await iap.completePurchase(purchaseDetails).then((value) {
        if (purchaseStatus == PurchaseStatus.purchased) {
          isLoading.value = false;
          customSnackbar(
            title: AppTexts.success,
            message: "Payment Successful!",
            icon: const Icon(
              Icons.check_circle,
              color: Colors.green,
            ),
          );
          paymentPostApi(
            PostPaymentModel(
                packageId: monthlyPackage!.id!,
                amount: monthlyPackage!.discountPrice ?? 0,
                discount: monthlyPackage!.discountPercent ?? 0,
                discountPrice: monthlyPackage!.discountPrice ?? 0,
                totalAmount: monthlyPackage!.price!,
                status: "paid",
                duration: monthlyPackage!.duration ?? 0),
            "Apple",
          );
        }
      });
    }
  }

  Future<void> buyNonConsumableProduct(String productId) async {
    try {
      Set<String> productIds = {productId};

      final ProductDetailsResponse productDetailResponse =
          await iap.queryProductDetails(productIds);

      if (productDetailResponse.productDetails.isEmpty) {
        // Product not found
        return;
      }

      final PurchaseParam purchaseParam = PurchaseParam(
          productDetails: productDetailResponse.productDetails.first);
      log("(((((((((((((${purchaseParam.productDetails.price}");
      await iap.buyNonConsumable(
        purchaseParam: purchaseParam,
      );
    } catch (e) {
      // Handle purchase error

      print('Failed to buy plan: $e');
    }
  }

  restorePurchases() async {
    try {
      await iap.restorePurchases();
    } catch (error) {
      //you can handle error if restore purchase fails
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
}
