// import 'dart:developer';
// import 'dart:io';

// import 'package:flutter/material.dart';
// import 'package:flutter/services.dart';
// import 'package:get/get.dart';
// import 'package:purchases_flutter/purchases_flutter.dart';

// class PurchaseApiController extends GetxController {
//   RxBool isLoading = true.obs;
//   List<Package> packages = [];
//   RxBool isWeeklyPurchased = false.obs;
//   RxBool isOtherPurchased = false.obs;

//   @override
//   void onInit() async {
//     init();
//     super.onInit();
//   }

//   Future init() async {
//     await Purchases.setDebugLogsEnabled(true);
//     await Purchases.setup(
//       Platform.isIOS ? "appl_xAjGWuzZEokaVJLEdUtSQUTihyW" : "",
//     );
//     Purchases.addCustomerInfoUpdateListener((purchaserInfo) async {
//       updatePurchaseStatus();
//     });
//     await fetchOffersNew();
//   }

//   static Future<List<Offering>> fetchOffers({bool all = true}) async {
//     try {
//       final offerings = await Purchases.getOfferings();
//       if (!all) {
//         final current = offerings.current;
//         return current == null ? [] : [current];
//       } else {
//         return offerings.all.values.toList();
//       }
//     } on PlatformException {
//       return [];
//     }
//   }

//   static Future<bool> purchasePackage(Package package) async {
//     try {
//       await Purchases.purchasePackage(package);
//       return true;
//     } catch (e) {
//       return false;
//     }
//   }

//   /* -------------------------------------------------------------------------- */
//   /*                            revenuecat controller                           */
//   /* -------------------------------------------------------------------------- */

//   Future updatePurchaseStatus() async {
//     final purchaserInfo = await Purchases.getCustomerInfo();
//     final entitlements = purchaserInfo.entitlements.active.values.toList();

//     if (entitlements.isEmpty) {
//       isWeeklyPurchased.value = false;
//       isOtherPurchased.value = false;
//     } else {
//       isWeeklyPurchased.value = true;
//       // Get.offAll(() => SplashScreen());
//     }
//     log("purchaserInfo === $purchaserInfo");
//     log("entitlements === $entitlements");

//     if (isWeeklyPurchased.value) {
//       log("user is premium with weekly plan");
//     } else if (isOtherPurchased.value) {
//       log("user is premium with other plan");
//     } else {
//       log("user is not premium");
//     }

//     update();
//   }

//   Future fetchOffersNew() async {
//     isLoading.value = true;
//     final offerings = await PurchaseApiController.fetchOffers(all: true);
//     isLoading.value = false;

//     ///
//     ///
//     ///
//     if (offerings.isEmpty) {
//       ScaffoldMessenger.of(Get.context!).showSnackBar(
//         const SnackBar(
//           content: Text('No Plans Found'),
//         ),
//       );
//     } else {
//       packages = offerings
//           .map((offer) => offer.availablePackages)
//           .expand((pair) => pair)
//           .toList();
//     }

//     ///
//     ///
//     ///
//     update();
//   }
// }

///
///
///
library;

import 'dart:developer';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:purchases_flutter/purchases_flutter.dart';

class PurchaseApiController extends GetxController {
  RxBool isLoading = true.obs;
  List<Package> packages = [];
  RxBool isWeeklyPurchased = false.obs;
  RxBool isOtherPurchased = false.obs;

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

  static Future<bool> purchasePackage(Package package) async {
    try {
      await Purchases.purchasePackage(package);
      return true;
    } catch (e) {
      log('Purchase failed: $e');
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
        isWeeklyPurchased.value = false;
        isOtherPurchased.value = false;
      } else {
        for (var entitlement in entitlements) {
          if (entitlement.productIdentifier == "wl_weekly_0.99" ||
              entitlement.productIdentifier == "wl_weekly_2.99" ||
              entitlement.productIdentifier == "wl_weekly_4.99" ||
              entitlement.productIdentifier == "wl_weekly_6.99") {
            isWeeklyPurchased.value = true;
          } else {
            isOtherPurchased.value = true;
          }
        }
      }

      if (isWeeklyPurchased.value) {
        log("user is premium with weekly plan");
      } else if (isOtherPurchased.value) {
        log("user is premium with other plan");
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
