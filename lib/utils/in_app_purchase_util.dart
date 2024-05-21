import 'dart:async';
import 'dart:developer';

import 'package:get/get.dart';
import 'package:in_app_purchase/in_app_purchase.dart';
import 'package:in_app_purchase_storekit/store_kit_wrappers.dart';
import 'package:weight_loss_app/modules/talking_oath/talking_outh/binding/talking_oath_binding.dart';
import 'package:weight_loss_app/modules/talking_oath/talking_outh/view/talking_oath_page.dart';

class InAppPurchaseUtils extends GetxController {
  // Singleton instance
  InAppPurchaseUtils._();
  static final InAppPurchaseUtils _instance = InAppPurchaseUtils._();
  static InAppPurchaseUtils get instance => _instance;

  late StreamSubscription<List<PurchaseDetails>> _purchasesSubscription;

  @override
  void onInit() {
    super.onInit();
    initialize();
  }

  @override
  void onClose() {
    _purchasesSubscription.cancel();
    super.onClose();
  }

  Future<void> initialize() async {
    if (await InAppPurchase.instance.isAvailable()) {
      _listenToPurchaseUpdates();
    }
  }

  void _listenToPurchaseUpdates() {
    _purchasesSubscription = InAppPurchase.instance.purchaseStream.listen(
      (List<PurchaseDetails> purchaseDetailsList) {
        _handlePurchaseUpdates(purchaseDetailsList);
      },
      onDone: () => _purchasesSubscription.cancel(),
      onError: (error) {
        log('Purchase stream error: $error');
      },
    );
  }

  void _handlePurchaseUpdates(List<PurchaseDetails> purchaseDetailsList) async {
    log('In-App Purchase Listener Called');
    for (var purchaseDetails in purchaseDetailsList) {
      log('Purchase details status: ${purchaseDetails.status}');
      if (purchaseDetails.status == PurchaseStatus.pending) {
        log('Pending purchase: ${purchaseDetails.status}');
        // Show pending UI if needed
      } else if (purchaseDetails.status == PurchaseStatus.error) {
        log('Error during purchase: ${purchaseDetails.error}');
        // Handle error
      } else if (purchaseDetails.status == PurchaseStatus.canceled) {
        log('Purchase canceled');
        // Handle canceled purchase
      } else if (purchaseDetails.status == PurchaseStatus.purchased ||
          purchaseDetails.status == PurchaseStatus.restored) {
        log('Product purchased or restored');
        if (purchaseDetails.pendingCompletePurchase) {
          await InAppPurchase.instance.completePurchase(purchaseDetails);
        }
        _navigateToNextScreen();
        // Handle purchased or restored product
      }
    }
  }

  void _navigateToNextScreen() {
    Get.to(() => const TalkingOathPage(), binding: TalkingOathBinding());
  }

  ///
  ///
  ///
  Future<void> buyConsumableProduct(String productId) async {
    try {
      // Retrieve all pending transactions
      final transactions = await SKPaymentQueueWrapper().transactions();
      log('Retrieved transactions: $transactions');

      // Finish each pending transaction and log details
      for (var transaction in transactions) {
        log('Processing transaction: ${transaction.transactionIdentifier}');
        log('Transaction state: ${transaction.transactionState}');
        log('Transaction error: ${transaction.error}');
        await SKPaymentQueueWrapper().finishTransaction(transaction);
        log('Finished transaction: ${transaction.transactionIdentifier}');
      }

      // Query product details
      final Set<String> productIds = {productId};
      final ProductDetailsResponse productDetailResponse =
          await InAppPurchase.instance.queryProductDetails(productIds);
      log('Product detail response: $productDetailResponse');

      ///
      ///
      ///
      ///
      log('currencyCode: ${productDetailResponse.productDetails.map((e) => {
            e.currencyCode
          })}');
      log('currencySymbol: ${productDetailResponse.productDetails.map((e) => {
            e.currencySymbol
          })}');
      log('description: ${productDetailResponse.productDetails.map((e) => {
            e.description
          })}');
      log('id: ${productDetailResponse.productDetails.map((e) => {e.id})}');
      log('price: ${productDetailResponse.productDetails.map((e) => {
            e.price
          })}');
      log('rawPrice: ${productDetailResponse.productDetails.map((e) => {
            e.rawPrice
          })}');
      log('title: ${productDetailResponse.productDetails.map((e) => {
            e.title
          })}');

      ///
      ///
      ///
      ///

      // Check if the product is found
      if (productDetailResponse.productDetails.isEmpty) {
        log('Product not found');
        return;
      }

      // Prepare purchase parameters
      final PurchaseParam purchaseParam = PurchaseParam(
        productDetails: productDetailResponse.productDetails.first,
      );
      log('Purchase parameter: $purchaseParam');
      log('applicationUserName: ${purchaseParam.applicationUserName}');
      log('productDetails: ${purchaseParam.productDetails}');
      log('productDetails: ${purchaseParam.productDetails.currencyCode}');
      log('productDetails: ${purchaseParam.productDetails.currencySymbol}');
      log('productDetails: ${purchaseParam.productDetails.description}');
      log('productDetails: ${purchaseParam.productDetails.id}');
      log('productDetails: ${purchaseParam.productDetails.price}');
      log('productDetails: ${purchaseParam.productDetails.rawPrice}');
      log('productDetails: ${purchaseParam.productDetails.title}');

      // Buy the consumable product
      await InAppPurchase.instance.buyConsumable(
        purchaseParam: purchaseParam,
        autoConsume: true,
      );
      log('Purchase initiated');
    } catch (e) {
      // Handle any errors during the purchase process
      log('Failed to buy product: $e');
    }
  }

  ///
  ///
  ///

  // Future<void> buyConsumableProduct(String productId) async {
  //   try {
  //     final transactions = await SKPaymentQueueWrapper().transactions();
  //     for (var transaction in transactions) {
  //       await SKPaymentQueueWrapper().finishTransaction(transaction);
  //     }

  //     final Set<String> productIds = {productId};
  //     final ProductDetailsResponse productDetailResponse =
  //         await InAppPurchase.instance.queryProductDetails(productIds);

  //     if (productDetailResponse.productDetails.isEmpty) {
  //       log('Product not found');
  //       return;
  //     }

  //     final PurchaseParam purchaseParam = PurchaseParam(
  //       productDetails: productDetailResponse.productDetails.first,
  //     );

  //     await InAppPurchase.instance.buyConsumable(
  //       purchaseParam: purchaseParam,
  //       autoConsume: true,
  //     );
  //   } catch (e) {
  //     log('Failed to buy product: $e');
  //   }
  // }

  Future<void> restorePurchases() async {
    try {
      await InAppPurchase.instance.restorePurchases();
    } catch (error) {
      log('Failed to restore purchases: $error');
    }
  }
}
