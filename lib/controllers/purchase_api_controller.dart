import 'dart:convert';
import 'dart:developer';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:purchases_flutter/purchases_flutter.dart';
import 'package:weight_loss_app/common/api_urls.dart';
import 'package:weight_loss_app/common/app_colors.dart';
import 'package:weight_loss_app/common/app_texts.dart';
import 'package:weight_loss_app/modules/payment_integration/payment_page/model/payment_success_detail.dart';
import 'package:weight_loss_app/modules/payment_integration/payment_plans/models/payment_plans_model.dart';
import 'package:weight_loss_app/modules/talking_oath/talking_outh/binding/talking_oath_binding.dart';
import 'package:weight_loss_app/modules/talking_oath/talking_outh/view/talking_oath_page.dart';
import 'package:weight_loss_app/utils/api_service.dart';
import 'package:weight_loss_app/utils/shared_prefrence.dart';
import 'package:weight_loss_app/widgets/custom_snackbar.dart';

class PurchaseApiController extends GetxController {
  RxBool isLoading = true.obs;
  List<Package> packages = [];
  RxBool isPurchased = false.obs;

  @override
  void onInit() {
    super.onInit();
    init();
  }

  Future init() async {
    await Purchases.setDebugLogsEnabled(true);
    await Purchases.setup(
      Platform.isIOS ? "appl_xAjGWuzZEokaVJLEdUtSQUTihyW" : "",
    );
    Purchases.addCustomerInfoUpdateListener((purchaserInfo) async {
      await updatePurchaseStatus();
    });
    await fetchOffersNew();
  }

  static Future<List<Offering>> fetchOffers({bool all = true}) async {
    try {
      final offerings = await Purchases.getOfferings();
      if (!all) {
        final current = offerings.current;
        return current == null ? [] : [current];
      } else {
        return offerings.all.values.toList();
      }
    } on PlatformException {
      return [];
    }
  }
  ///
  ///
  ///
  
  ///
  ///
  ///

  // Future<bool> purchasePackage(Package package) async {
  //   try {
  //     await Purchases.purchasePackage(package);
  //     await init();

  //     if (isWeeklyPurchased.value || isOtherPurchased.value) {
  //       log("user is premium");
  //     } else {
  //       log("user is not premium");
  //     }

  //     // Get.offAll(() => const TalkingOathPage(), binding: TalkingOathBinding());
  //     return true;
  //   } catch (e) {
  //     log('Purchase failed: $e');
  //     return false;
  //   }
  // }

  Future<bool> purchasePackage({required Package package}) async {
    try {
      await Purchases.purchasePackage(package);
      await init();
      await updatePurchaseStatus();

      if (isPurchased.value) {
        log("User is premium");
      } else {
        log("User is not premium");
      }

      return true;
    } catch (e) {
      if (e is PlatformException) {
        log('Purchase failed: ${e.message}, code: ${e.code}, details: ${e.details}');

        customSnackbar(
          title: "Error",
          backgroundColor: AppColors.red,
          message: 'Purchase failed: ${e.message}. Please try again later.',
        );

        switch (e.code) {
          case '2':
            log('There is a problem with the App Store. Please try again later.');
            break;
          case '1':
            log('User canceled the purchase.');
            break;
          default:
            log('An unknown error occurred: ${e.message}');
        }
      } else {
        log('An unexpected error occurred: $e');
      }

      return false;
    }
  }

  Future updatePurchaseStatus() async {
    try {
      final purchaserInfo = await Purchases.getCustomerInfo();
      final entitlements = purchaserInfo.entitlements.active.values.toList();
      // print("entitle == ${entitlements.map(
      //   (e) => e.identifier,
      // )}");

      if (entitlements.isEmpty) {
        isPurchased.value = false;
      } else {
        isPurchased.value = true;
      }

      if (isPurchased.value) {
        log("user is premium with weekly plan");
      } else {
        log("user is not premium");
      }

      update();
    } catch (e) {
      log('Error updating purchase status: $e');
    }
  }

  Future fetchOffersNew() async {
    isLoading.value = true;
    final offerings = await PurchaseApiController.fetchOffers(all: true);
    isLoading.value = false;

    if (offerings.isEmpty) {
      ScaffoldMessenger.of(Get.context!).showSnackBar(
        const SnackBar(
          content: Text('No Plans Found'),
        ),
      );
    } else {
      packages = offerings
          .map((offer) => offer.availablePackages)
          .expand((pair) => pair)
          .toList();
    }

    update();
  }

  ///
  ///
  ///
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
        Get.to(() => const TalkingOathPage(), binding: TalkingOathBinding());
      } else {
        isApiLoading.value = false;
        Get.to(() => const TalkingOathPage(), binding: TalkingOathBinding());
      }
    } catch (e) {
      isApiLoading.value = false;
      customSnackbar(title: AppTexts.error, message: "Api Exception");
    }
  }

////
  ///
  ///
  ///
  // PackagesList? monthlyPackage;
  // getPaymentData(PackagesList amonthlyPackage) {
  //   monthlyPackage = amonthlyPackage;
  // }

  ///
  ///
  ///
  ///
  Future<void> confirmPaymentPostApi(
      {required PackagesList selectedPackage}) async {
    customSnackbar(
      title: AppTexts.success,
      message: "Payment Successful!",
      icon: const Icon(
        Icons.check_circle,
        color: Colors.green,
      ),
    );
    print("packageId == ${selectedPackage.id}");
    print("amount == ${selectedPackage.discountPrice}");
    print("discount == ${selectedPackage.discountPercent}");
    print("discountPrice == ${selectedPackage.discountPrice}");
    print("price == ${selectedPackage.price}");
    print("duration == ${selectedPackage.duration}");
    await paymentPostApi(
      PostPaymentModel(
        packageId: selectedPackage.id!,
        amount: selectedPackage.discountPrice ?? 0,
        discount: selectedPackage.discountPercent ?? 0,
        discountPrice: selectedPackage.discountPrice ?? 0,
        totalAmount: selectedPackage.price!,
        status: "paid",
        duration: selectedPackage.duration ?? 0,
      ),
      Platform.isIOS ? "Apple" : "Android",
    );
  }

  ///
  ///
  ///
  ///
}
