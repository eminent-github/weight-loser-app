import 'dart:developer';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:purchases_flutter/purchases_flutter.dart';

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
        // Navigate to TalkingOathPage after successful purchase and status update
        // Get.offAll(() => const TalkingOathPage(),
        //     binding: TalkingOathBinding());
      } else {
        log("User is not premium");
      }

      return true;
    } catch (e) {
      if (e is PlatformException) {
        log('Purchase failed: ${e.message}, code: ${e.code}, details: ${e.details}');

        ScaffoldMessenger.of(Get.context!).showSnackBar(
          SnackBar(
            content: Text(
              'Purchase failed: ${e.message}. Please try again later.',
              style: const TextStyle(color: Colors.white),
            ),
            backgroundColor: Colors.red,
          ),
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
        ///
        ///
        ///
        // wl_monthly_plan
        // wl_3month_plan
        // wl_6month_plan
        // wl_yearly_plan
        // wl_6month_plan_with_trial
        // wl_monthly_plan_with_trial
        // wl_yearly_plan_with_trial
        // wl_3month_plan_with_trial
        ///
        ///
        ///
        ///
        for (var entitlement in entitlements) {
          if (entitlement.productIdentifier == "wl_weekly_0.99" ||
              entitlement.productIdentifier == "wl_weekly_2.99" ||
              entitlement.productIdentifier == "wl_weekly_4.99" ||
              entitlement.productIdentifier == "wl_weekly_6.99") {
            isPurchased.value = true;
          } else {
            // isOtherPurchased.value = true;
          }
        }
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
}
