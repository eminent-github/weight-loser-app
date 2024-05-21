// import 'dart:async';
// import 'dart:developer';

// // import 'dart:ffi';

// import 'package:get/get.dart';
// import 'package:in_app_purchase/in_app_purchase.dart';

// class InAppPurchaseUtilsV1 extends GetxController {
//   // Private constructor
//   InAppPurchaseUtilsV1._();

//   // Singleton instance
//   static final InAppPurchaseUtilsV1 _instance = InAppPurchaseUtilsV1._();

//   // Getter to access the instance
//   static InAppPurchaseUtilsV1 get inAppPurchaseUtilsV1Instance => _instance;

//   // Create a private variable
//   final InAppPurchase iap = InAppPurchase.instance;

//   late StreamSubscription<List<PurchaseDetails>> _purchasesSubscription;

//   @override
//   void onInit() {
//     super.onInit();
//     initialize();
//   }

//   @override
//   void dispose() {
//     _purchasesSubscription.cancel();
//     super.dispose();
//   }

//   @override
//   void onClose() {
//     _purchasesSubscription.cancel();
//     super.onClose();
//   }

//   Future<void> initialize() async {
//     if (!(await iap.isAvailable())) return;

//     ///catch all purchase updates
//     _purchasesSubscription = InAppPurchase.instance.purchaseStream.listen(
//       (List<PurchaseDetails> purchaseDetailsList) {
//         handlePurchaseUpdates(purchaseDetailsList);
//       },
//       onDone: () {
//         _purchasesSubscription.cancel();
//       },
//       onError: (error) {
//         _purchasesSubscription.resume();
//       },
//     );
//   }

//   void handlePurchaseUpdates(List<PurchaseDetails> purchaseDetailsList) async {
//     purchaseDetailsList.map((e) => log(e.toString()));
//     for (int index = 0; index < purchaseDetailsList.length; index++) {
//       var purchaseStatus = purchaseDetailsList[index].status;
//       switch (purchaseDetailsList[index].status) {
//         case PurchaseStatus.pending:
//           print(' purchase is in pending ');
//           _purchasesSubscription.cancel();

//           continue;
//         case PurchaseStatus.error:
//           print(' purchase error ');
//           break;
//         case PurchaseStatus.canceled:
//           print(' purchase cancel ');
//           break;
//         case PurchaseStatus.purchased:
//           print(' purchase complete ');
//           print(
//               "_____________________${purchaseDetailsList[index].transactionDate}");
//           break;
//         case PurchaseStatus.restored:
//           print(' purchase restore ');
//           break;
//       }

//       if (purchaseDetailsList[index].pendingCompletePurchase) {
//         await iap.completePurchase(purchaseDetailsList[index]).then((value) {
//           if (purchaseStatus == PurchaseStatus.purchased) {
//             log("${purchaseDetailsList[index].transactionDate}");
//           }
//         });
//       }
//     }
//   }

//   Future<bool> buyNonConsumableProduct(String productId) async {
//     try {
//       Set<String> productIds = {productId};

//       final ProductDetailsResponse productDetailResponse =
//           await iap.queryProductDetails(productIds);

//       if (productDetailResponse.productDetails.isEmpty) {
//         // Product not found
//         return false;
//       }

//       final PurchaseParam purchaseParam = PurchaseParam(
//           productDetails: productDetailResponse.productDetails.first);
//       return await iap.buyNonConsumable(
//         purchaseParam: purchaseParam,
//       );
//     } catch (e) {
//       // Handle purchase error

//       print('Failed to buy plan: $e');
//       return false;
//     }
//   }

//   void handlePendingPurchases() {
//     iap.purchaseStream
//         .listen((List<PurchaseDetails> purchaseDetailsList) async {
//       for (var purchaseDetails in purchaseDetailsList) {
//         if (purchaseDetails.pendingCompletePurchase) {
//           print("handlePendingPurchases");
//           await iap.completePurchase(purchaseDetails);
//         }
//       }
//     });
//   }

//   Future<bool> buyConsumableProduct(String productId) async {
//     try {
//       // Handle any pending purchases before starting a new one
//       handlePendingPurchases();

//       Set<String> productIds = {productId};

//       final ProductDetailsResponse productDetailResponse =
//           await iap.queryProductDetails(productIds);

//       if (productDetailResponse.productDetails.isEmpty) {
//         // Product not found
//         return false;
//       }

//       final PurchaseParam purchaseParam = PurchaseParam(
//           productDetails: productDetailResponse.productDetails.first);

//       // Add a listener to handle purchase updates
//       StreamSubscription<List<PurchaseDetails>> subscription;
//       final Completer<bool> purchaseCompleter = Completer<bool>();

//       subscription = iap.purchaseStream
//           .listen((List<PurchaseDetails> purchaseDetailsList) {
//         for (var purchaseDetails in purchaseDetailsList) {
//           if (purchaseDetails.productID == productId) {
//             if (purchaseDetails.status == PurchaseStatus.purchased) {
//               // Purchase successful
//               print("Purchase successful");
//               purchaseCompleter.complete(true);
//               iap.completePurchase(purchaseDetails);
//             } else if (purchaseDetails.status == PurchaseStatus.error) {
//               // Purchase failed
//               print("Purchase failed");
//               purchaseCompleter.complete(false);
//             } else if (purchaseDetails.status == PurchaseStatus.pending) {
//               // Purchase pending
//               print("Purchase pending");
//               // Optional: handle pending state if needed
//             }
//           }
//         }
//       });

//       final bool result = await iap.buyConsumable(
//         purchaseParam: purchaseParam,
//         autoConsume: true,
//       );

//       print("result = $result");

//       // Wait for purchase completion
//       final bool purchaseResult = await purchaseCompleter.future;

//       // Cancel subscription to avoid memory leaks
//       await subscription.cancel();

//       return purchaseResult;
//     } catch (e) {
//       // Handle purchase error
//       print('Failed to buy plan: $e');
//       return false;
//     }
//   }

//   // Future<bool> buyConsumableProduct(String productId) async {
//   //   try {
//   //     Set<String> productIds = {productId};

//   //     final ProductDetailsResponse productDetailResponse =
//   //         await iap.queryProductDetails(productIds);

//   //     if (productDetailResponse.productDetails.isEmpty) {
//   //       // Product not found
//   //       return false;
//   //     }

//   //     final PurchaseParam purchaseParam = PurchaseParam(
//   //         productDetails: productDetailResponse.productDetails.first);

//   //     // Add a listener to handle purchase updates
//   //     StreamSubscription<List<PurchaseDetails>> subscription;
//   //     final Completer<bool> purchaseCompleter = Completer<bool>();

//   //     subscription = iap.purchaseStream
//   //         .listen((List<PurchaseDetails> purchaseDetailsList) {
//   //       for (var purchaseDetails in purchaseDetailsList) {
//   //         if (purchaseDetails.productID == productId) {
//   //           if (purchaseDetails.status == PurchaseStatus.purchased) {
//   //             // Purchase successful
//   //             print("Purchase successful");
//   //             purchaseCompleter.complete(true);
//   //             iap.completePurchase(purchaseDetails);
//   //           } else if (purchaseDetails.status == PurchaseStatus.error) {
//   //             // Purchase failed
//   //             print("Purchase failed");
//   //             purchaseCompleter.complete(false);
//   //           }
//   //         }
//   //       }
//   //     });

//   //     final bool result = await iap.buyConsumable(
//   //       purchaseParam: purchaseParam,
//   //       autoConsume: true,
//   //     );

//   //     print("result = $result");

//   //     // Wait for purchase completion
//   //     final bool purchaseResult = await purchaseCompleter.future;

//   //     // Cancel subscription to avoid memory leaks
//   //     await subscription.cancel();

//   //     return purchaseResult;
//   //   } catch (e) {
//   //     // Handle purchase error
//   //     print('Failed to buy plan: $e');
//   //     return false;
//   //   }
//   // }

//   ////
//   // Future<bool> buyConsumableProduct(String productId) async {
//   //   try {
//   //     Set<String> productIds = {productId};

//   //     final ProductDetailsResponse productDetailResponse =
//   //         await iap.queryProductDetails(productIds);

//   //     if (productDetailResponse.productDetails.isEmpty) {
//   //       // Product not found
//   //       return false;
//   //     }

//   //     final PurchaseParam purchaseParam = PurchaseParam(
//   //         productDetails: productDetailResponse.productDetails.first);
//   //     return await iap.buyConsumable(
//   //       purchaseParam: purchaseParam,
//   //       autoConsume: true,
//   //     );
//   //   } catch (e) {
//   //     // Handle purchase error

//   //     print('Failed to buy plan: $e');
//   //     return false;
//   //   }
//   // }

//   ///
//   ///
//   ///
//   ///

//   restorePurchases() async {
//     try {
//       await iap.restorePurchases();
//     } catch (error) {
//       //you can handle error if restore purchase fails
//     }
//   }
// }
// // Future<bool> buyNonConsumableProduct(String productId) async {
// //     try {
// //       ///
// //       ///
// //       ///

// //       final transactions = await SKPaymentQueueWrapper().transactions();
// //       for (var transaction in transactions) {
// //         await SKPaymentQueueWrapper().finishTransaction(transaction);
// //       }

// //       ///
// //       ///
// //       ///
// //       Set<String> productIds = {productId};

// //       final ProductDetailsResponse productDetailResponse =
// //           await InAppPurchase.instance.queryProductDetails(productIds);

// //       if (productDetailResponse.productDetails.isEmpty) {
// //         // Product not found
// //         return false;
// //       }

// //       final PurchaseParam purchaseParam = PurchaseParam(
// //           productDetails: productDetailResponse.productDetails.first);
// //       return await InAppPurchase.instance.buyNonConsumable(
// //         purchaseParam: purchaseParam,
// //       );
// //     } catch (e) {
// //       // Handle purchase error

// //       print('Failed to buy plan: $e');
// //       return false;
// //     }
// //   }