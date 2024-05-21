import 'dart:developer';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pay/pay.dart';
import 'package:weight_loss_app/common/app_colors.dart';
import 'package:weight_loss_app/common/app_text_styles.dart';
import 'package:weight_loss_app/common/app_texts.dart';
import 'package:weight_loss_app/modules/payment_integration/payment_page/controller/payment_page_controller.dart';
import 'package:weight_loss_app/modules/payment_integration/payment_page/model/payment_success_detail.dart';
import 'package:weight_loss_app/utils/internet_check_widget.dart';
import 'package:weight_loss_app/widgets/app_logo.dart';
import 'package:weight_loss_app/widgets/custom_snackbar.dart';
import 'package:weight_loss_app/widgets/overlay_widget.dart';

class PaymentPage extends GetView<PaymentPageController> {
  const PaymentPage(
      {super.key, required this.postPaymentModel, required this.userId});
  final PostPaymentModel postPaymentModel;
  final String userId;

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    double height = size.height;
    double width = size.width;
    log("-------------------------${postPaymentModel.toString()}");
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: height * 0.15,
        flexibleSpace: const AppLogo(),
      ),
      body: InternetCheckWidget<ConnectivityService>(
        child: Obx(
          () => Stack(
            children: [
              SafeArea(
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: width * 0.07),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Platform.isAndroid
                          ? FutureBuilder<PaymentConfiguration>(
                              future: controller.googlePayConfigFutures,
                              builder: (context, snapshot) => snapshot.hasData
                                  ? GooglePayButton(
                                      width: MediaQuery.of(context).size.width,
                                      // height: height *
                                      onError: (error) async {
                                        log('check error is ${error.toString()}');
                                        customSnackbar(
                                            title: AppTexts.error,
                                            message: error.toString());
                                      },
                                      paymentConfiguration: snapshot.data!,
                                      paymentItems: [
                                        PaymentItem(
                                          label: 'Total',
                                          amount: postPaymentModel.amount
                                              .toStringAsFixed(2),
                                          type: PaymentItemType.total,
                                          status: PaymentItemStatus.final_price,
                                        ),
                                      ],
                                      type: GooglePayButtonType.pay,
                                      onPaymentResult: (paymentResult) async {
                                        // log('my google pay is ${jsonEncode(paymentResult)}');
                                        // PaymentSuccessDetail
                                        //     paymentSuccessDetail =
                                        //     PaymentSuccessDetail.fromJson(
                                        //         paymentResult);
                                        // print(paymentSuccessDetail
                                        //     .paymentMethodData!.description);
                                        await showDialog(
                                            context: context,
                                            builder: (context) {
                                              Future.delayed(
                                                  const Duration(seconds: 2),
                                                  () {
                                                Get.back(); // Close the dialog
                                              });
                                              return const AlertDialog(
                                                content: Column(
                                                  mainAxisSize:
                                                      MainAxisSize.min,
                                                  children: [
                                                    Icon(
                                                      Icons.check_circle,
                                                      color: Colors.green,
                                                      size: 100.0,
                                                    ),
                                                    SizedBox(height: 10.0),
                                                    Text("Payment Successful!"),
                                                  ],
                                                ),
                                              );
                                            });

                                        controller.paymentPostApi(
                                            postPaymentModel, "Google");
                                      },
                                      loadingIndicator: const Center(
                                        child: CircularProgressIndicator(),
                                      ),
                                    )
                                  : const SizedBox.shrink(),
                            )
                          : ApplePayButton(
                              paymentConfiguration:
                                  controller.applePayConfigFutures,
                              width: MediaQuery.of(context).size.width,
                              height: height * 0.06,
                              cornerRadius: 50,
                              paymentItems: [
                                PaymentItem(
                                  label: 'Total',
                                  amount: postPaymentModel.amount
                                      .toStringAsFixed(2),
                                  type: PaymentItemType.total,
                                  status: PaymentItemStatus.final_price,
                                ),
                              ],
                              style: ApplePayButtonStyle.black,
                              type: ApplePayButtonType.buy,
                              onError: (error) async {
                                log('check error is ${error.toString()}');
                                customSnackbar(
                                    title: AppTexts.error,
                                    message: "Payment cancel");
                              },
                              onPaymentResult: (paymentResult) async {
                                // log('my google pay is ${jsonEncode(paymentResult)}');
                                // PaymentSuccessDetail
                                //     paymentSuccessDetail =
                                //     PaymentSuccessDetail.fromJson(
                                //         paymentResult);
                                // print(paymentSuccessDetail
                                //     .paymentMethodData!.description);
                                await showDialog(
                                    context: context,
                                    builder: (context) {
                                      Future.delayed(const Duration(seconds: 2),
                                          () {
                                        Get.back(); // Close the dialog
                                      });
                                      return const AlertDialog(
                                        content: Column(
                                          mainAxisSize: MainAxisSize.min,
                                          children: [
                                            Icon(
                                              Icons.check_circle,
                                              color: Colors.green,
                                              size: 100.0,
                                            ),
                                            SizedBox(height: 10.0),
                                            Text("Payment Successful!"),
                                          ],
                                        ),
                                      );
                                    });

                                controller.paymentPostApi(
                                    postPaymentModel, "Apple");
                              },
                              loadingIndicator: const Center(
                                child: CircularProgressIndicator(),
                              ),
                            ),
                      Platform.isAndroid
                          ? SizedBox(
                              height: height * 0.05,
                            )
                          : const SizedBox.shrink(),
                      Platform.isAndroid
                          ? Material(
                              color: AppColors.black,
                              borderRadius: BorderRadius.circular(50),
                              child: InkWell(
                                borderRadius: BorderRadius.circular(50),
                                onTap: () {
                                  controller.makePayment(
                                    context: context,
                                    userId: userId,
                                    type: "Stripe",
                                    postPaymentModel: postPaymentModel,
                                    transactionID: (id) async {
                                      print('transaction id $id');
                                      // is_true_payment = true;
                                      // bool v = await DataProvider().payment_api(object: {
                                      //   'additional_info':
                                      //       controller.textEditingController.text,
                                      //   'payment_option': 'online',
                                      //   'payment_type': 'online',
                                      //   'trx_id': '$id'
                                      // });
                                      // controller.loader.value = false;
                                      // if (v) {
                                      //   DataProvider().confirm_order_api();
                                      //   controller.active_gif.value = true;
                                      //   Future.delayed(Duration(seconds: 6), () {
                                      //     // snackBarSuccess(
                                      //     //     'Order Placed Successfully');
                                      //     screenLoader(use_opacity: false);
                                      //     Navigator.push(
                                      //         context,
                                      //         MaterialPageRoute(
                                      //             builder: (c) => OrderScreen()));
                                      //     //     .then((value) {
                                      //     //   Navigator.of(context).pop();
                                      //     //   Navigator.of(context).pop();
                                      //     // });
                                      //   });
                                      // }
                                      //get_card_cout();
                                    },
                                    totalPayment:
                                        "${(postPaymentModel.amount * 100).toInt()}",
                                    // '${'${controller.cartSummaryModel!.grandTotal}'.replaceAll(new RegExp(r"\D"), "")}'
                                  );
                                },
                                child: SizedBox(
                                  height: height * 0.06,
                                  child: Center(
                                    child: Text(
                                      'Pay with Visa Card',
                                      style: AppTextStyles.formalTextStyle(
                                        color: Colors.white,
                                        fontSize: 18,
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            )
                          : const SizedBox.shrink(),
                    ],
                  ),
                ),
              ),
              controller.isLoading.value
                  ? const OverlayWidget()
                  : const SizedBox(),
            ],
          ),
        ),
      ),
    );
  }
}

// import 'dart:io';

// import 'package:flutter/material.dart';
// import 'package:pay/pay.dart';
// import 'package:weight_loss_app/FirebaseNotification/payment.dart';

// class PaymentPage extends StatefulWidget {
//   const PaymentPage({super.key});

//   @override
//   State<PaymentPage> createState() => _PaymentPageState();
// }

// class _PaymentPageState extends State<PaymentPage> {
//   String os = Platform.operatingSystem;

//   var applePayButton = ApplePayButton(
//     paymentConfiguration: PaymentConfiguration.fromJsonString(defaultGooglePay),
//     paymentItems: const [
//       PaymentItem(
//         label: 'Item A',
//         amount: '0.01',
//         status: PaymentItemStatus.final_price,
//       ),
//       PaymentItem(
//         label: 'Item B',
//         amount: '0.01',
//         status: PaymentItemStatus.final_price,
//       ),
//       PaymentItem(
//         label: 'Total',
//         amount: '0.02',
//         status: PaymentItemStatus.final_price,
//       )
//     ],
//     style: ApplePayButtonStyle.black,
//     width: double.infinity,
//     height: 50,
//     type: ApplePayButtonType.buy,
//     margin: const EdgeInsets.only(top: 15.0),
//     onPaymentResult: (result) => debugPrint('Payment Result $result'),
//     loadingIndicator: const Center(
//       child: CircularProgressIndicator(),
//     ),
//   );

//   var googlePayButton = GooglePayButton(
//     paymentConfiguration: PaymentConfiguration.fromJsonString(defaultGooglePay),
//     paymentItems: const [
//       PaymentItem(
//         label: 'Total',
//         amount: '0.01',
//         status: PaymentItemStatus.final_price,
//       )
//     ],
//     type: GooglePayButtonType.pay,
//     margin: const EdgeInsets.only(top: 15.0),
//     onPaymentResult: (result) => debugPrint('Payment Result $result'),
//     loadingIndicator: const Center(
//       child: CircularProgressIndicator(),
//     ),
//   );

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: Padding(
//         padding: const EdgeInsets.all(10),
//         child: Center(child: Platform.isIOS ? applePayButton : googlePayButton),
//       ),
//     );
//   }
// }

// // import 'dart:developer';
// // import 'dart:io';

// // import 'package:flutter/material.dart';
// // import 'package:pay/pay.dart';

// // class PaymentPage extends StatefulWidget {
// //   const PaymentPage({super.key});

// //   @override
// //   State<PaymentPage> createState() => _PaymentPageState();
// // }

// // class _PaymentPageState extends State<PaymentPage> {
// //   late final Future<PaymentConfiguration> _googlePayConfigFuture;
// //   //late Future<bool> _userCanPay;

// //   Pay payClient = Pay.withAssets(['gpay.json']);

// //   @override
// //   void initState() {
// //     _googlePayConfigFuture = PaymentConfiguration.fromAsset('gpay.json');
// //     // _userCanPay = payClient.userCanPay(PayProvider.google_pay);
// //     super.initState();
// //   }

// //   void onGooglePayResult(paymentResult) {
// //    // debugPrint(paymentResult.toString());
// //    print('check my patyment $paymentResult');

// //   }

// //   @override
// //   Widget build(BuildContext context) {
// //     return Scaffold(
// //       appBar: AppBar(
// //         title: const Text('T-shirt Shop'),
// //       ),
// //       backgroundColor: Colors.white,
// //       body: ListView(
// //         padding: const EdgeInsets.symmetric(horizontal: 20),
// //         children: [
// //           // Container(
// //           //   margin: const EdgeInsets.symmetric(vertical: 20),
// //           //   child: const Image(
// //           //     image: AssetImage('assets/images/ts_10_11019a.jpg'),
// //           //     height: 350,
// //           //   ),
// //           // ),
// //           const Text(
// //             'Amanda\'s Polo Shirt',
// //             style: TextStyle(
// //               fontSize: 20,
// //               color: Color(0xff333333),
// //               fontWeight: FontWeight.bold,
// //             ),
// //           ),
// //           const SizedBox(height: 5),
// //           const Text(
// //             '\$50.20',
// //             style: TextStyle(
// //               color: Color(0xff777777),
// //               fontSize: 15,
// //             ),
// //           ),
// //           const SizedBox(height: 15),
// //           const Text(
// //             'Description',
// //             style: TextStyle(
// //               fontSize: 15,
// //               color: Color(0xff333333),
// //               fontWeight: FontWeight.bold,
// //             ),
// //           ),
// //           const SizedBox(height: 5),
// //           const Text(
// //             'A versatile full-zip that you can wear all day long and even...',
// //             style: TextStyle(
// //               color: Color(0xff777777),
// //               fontSize: 15,
// //             ),
// //           ),
// //           // Example pay button configured using an asset

// //           FutureBuilder<PaymentConfiguration>(
// //               future: _googlePayConfigFuture,
// //               builder: (context, snapshot) => snapshot.hasData
// //                   ?

// //                   GooglePayButton(
// //                       paymentConfiguration: snapshot.data!,
// //                       paymentItems: const [
// //                         PaymentItem(
// //                           label: 'Total',
// //                           amount: '99.99',
// //                           status: PaymentItemStatus.pending,
// //                         ),
// //                         PaymentItem(
// //                           label: 'Total',
// //                           amount: '100.99',
// //                           status: PaymentItemStatus.pending,
// //                         )
// //                       ],
// //                      // type: GooglePayButtonType.buy,
// //                       margin: const EdgeInsets.only(top: 15.0),
// //                       onPaymentResult: onGooglePayResult,
// //                       loadingIndicator: const Center(
// //                         child: CircularProgressIndicator(),
// //                       ),
// //                     )

// //                   : const SizedBox.shrink()),

// //           // Example pay button configured using a string
// //           // ApplePayButton(
// //           //   paymentConfiguration: PaymentConfiguration.fromJsonString(
// //           //       payment_configurations.defaultApplePay),
// //           //   paymentItems: _paymentItems,
// //           //   style: ApplePayButtonStyle.black,
// //           //   type: ApplePayButtonType.buy,
// //           //   margin: const EdgeInsets.only(top: 15.0),
// //           //   onPaymentResult: onApplePayResult,
// //           //   loadingIndicator: const Center(
// //           //     child: CircularProgressIndicator(),
// //           //   ),
// //           // ),
// //           const SizedBox(height: 15)

// //         ],
// //       ),
// //     );

// //     // return Scaffold(
// //     //   body: Center(
// //     //     child: Visibility(
// //     //       visible: Platform.isAndroid,
// //     //       child: FutureBuilder(
// //     //         future: _userCanPay,
// //     //         builder: (BuildContext context, AsyncSnapshot snapshot) {
// //     //           if (snapshot.connectionState == ConnectionState.done) {
// //     //             if (snapshot.data == true) {
// //     //               return FutureBuilder<PaymentConfiguration>(
// //     //           future: googlePayConfigFuture,
// //     //           builder: (context, snapshot) => snapshot.hasData
// //     //               ? GooglePayButton(
// //     //                   paymentConfiguration: snapshot.data!,
// //     //                   paymentItems: const [
// //     //                      PaymentItem(
// //     //                         amount: '50.00',
// //     //                         status: PaymentItemStatus.pending,
// //     //                       ),
// //     //                       PaymentItem(
// //     //                         amount: '100.00',
// //     //                         status: PaymentItemStatus.final_price,
// //     //                       )
// //     //                   ],
// //     //                   type: GooglePayButtonType.buy,
// //     //                   margin: const EdgeInsets.only(top: 15.0),
// //     //                   onPaymentResult: onGooglePayResult,
// //     //                   loadingIndicator: const Center(
// //     //                     child: CircularProgressIndicator(),
// //     //                   ),
// //     //                 )
// //     //               : const SizedBox.shrink());
// //     //               // ElevatedButton(
// //     //               //   onPressed: () async {
// //     //               //     final result = await payClient.showPaymentSelector(
// //     //               //       PayProvider.google_pay,
// //     //               //       [
// //     //               //         const PaymentItem(
// //     //               //           amount: '50.00',
// //     //               //           status: PaymentItemStatus.pending,
// //     //               //         ),
// //     //               //         const PaymentItem(
// //     //               //           amount: '100.00',
// //     //               //           status: PaymentItemStatus.final_price,
// //     //               //         )
// //     //               //       ],
// //     //               //     );
// //     //               //     log(result.toString());
// //     //               //   },
// //     //               //   child: const Text(
// //     //               //     'Pay with GPay',
// //     //               //   ),
// //     //               // );
// //     //               // ElevatedButton(
// //     //               //   child: const Text('Pay With GPay'),
// //     //               //   onPressed: () async {},
// //     //               // );
// //     //             } else {
// //     //               // userCanPay returned false
// //     //               // Consider showing an alternative payment method
// //     //             }
// //     //           }
// //     //           return Container();
// //     //         },
// //     //       ),
// //     //     ),
// //     //   ),
// //     // );
// //   }
// // }

// // // import 'dart:developer';

// // // import 'package:auto_size_text/auto_size_text.dart';
// // // import 'package:flutter/material.dart';
// // // import 'package:flutter_svg/svg.dart';
// // // import 'package:get/get.dart';
// // // import 'package:pay/pay.dart';
// // // import 'package:weight_loss_app/common/app_assets.dart';
// // // import 'package:weight_loss_app/common/app_text_styles.dart';
// // // import 'package:weight_loss_app/modules/payment_integration/payment_page/controller/payment_page_controller.dart';
// // // import 'package:weight_loss_app/modules/talking_oath/talking_outh/binding/talking_oath_binding.dart';
// // // import 'package:weight_loss_app/modules/talking_oath/talking_outh/view/talking_oath_page.dart';
// // // import 'package:weight_loss_app/utils/internet_check_widget.dart';

// // // import '../../../../common/app_colors.dart';
// // // import '../../../../common/app_texts.dart';
// // // import '../../../../widgets/app_logo.dart';

// // // class PaymentPage extends GetView<PaymentPageController> {
// // //    PaymentPage({super.key});
// // //   late Future<bool> _userCanPay;

// // //     Pay payClient = Pay.withAssets(['gpay.json']);

// // //     @override
// // //     void initState() {
// // //       _userCanPay = payClient.userCanPay(PayProvider.google_pay);
// // //       super.initState();
// // //     }

// // //   @override
// // //   Widget build(BuildContext context) {
// // //     var size = MediaQuery.sizeOf(context);
// // //     double height = size.height;
// // //     double width = size.width;

// // //     return Scaffold(
// // //         body: Center(
// // //           child: Visibility(
// // //             visible: Platform.isAndroid,
// // //             child: FutureBuilder(
// // //               future: _userCanPay,
// // //               builder: (BuildContext context, AsyncSnapshot snapshot) {
// // //                 if (snapshot.connectionState == ConnectionState.done) {
// // //                   if (snapshot.data == true) {
// // //                     return ElevatedButton(
// // //                       child: const Text('Pay With GPay'),
// // //                       onPressed: () async {},
// // //                     );
// // //                   } else {
// // //                     // userCanPay returned false
// // //                     // Consider showing an alternative payment method
// // //                   }
// // //                 }
// // //                 return Container();
// // //               },
// // //             ),
// // //           ),
// // //         ),
// // //       );

// // //     // return Scaffold(
// // //     //   body: Center(
// // //     //     child: GooglePayButton(
// // //     //       paymentConfigurationAsset: 'gpay.json',
// // //     //       paymentItems: const [
// // //     //         PaymentItem(
// // //     //           label: 'Total',
// // //     //           amount: '10.00',
// // //     //           status: PaymentItemStatus.final_price,
// // //     //         )
// // //     //       ],
// // //     //       type: GooglePayButtonType.pay,
// // //     //       margin: const EdgeInsets.only(top: 15.0),
// // //     //       onPaymentResult: (result) {
// // //     //         log(result.toString());
// // //     //       },
// // //     //       loadingIndicator: const Center(
// // //     //         child: CircularProgressIndicator(),
// // //     //       ),
// // //     //     ),
// // //     //   ),
// // //     // );

// // //     // return Scaffold(
// // //     //   body: InternetCheckWidget<ConnectivityService>(
// // //     //     child: SafeArea(
// // //     //       child: Center(
// // //     //         child: Padding(
// // //     //           padding: EdgeInsets.only(
// // //     //             left: width * 0.125,
// // //     //             right: width * 0.125,
// // //     //             top: height * 0.04,
// // //     //             bottom: height * 0.1,
// // //     //           ),
// // //     //           child: Column(
// // //     //             mainAxisAlignment: MainAxisAlignment.spaceBetween,
// // //     //             children: [
// // //     //               const AppLogo(),
// // //     //               Material(
// // //     //                 borderRadius: BorderRadius.circular(17),
// // //     //                 color: AppColors.paymentPayButtonColor,
// // //     //                 child: InkWell(
// // //     //                   onTap: () {
// // //     //                     Get.to(() => const TalkingOathPage(),
// // //     //                         binding: TalkingOathBinding());
// // //     //                   },
// // //     //                   borderRadius: BorderRadius.circular(17),
// // //     //                   child: SizedBox(
// // //     //                     height: height * 0.067,
// // //     //                     width: width * 0.75,
// // //     //                     child: Row(
// // //     //                       mainAxisAlignment: MainAxisAlignment.center,
// // //     //                       children: [
// // //     //                         const Text(
// // //     //                           AppTexts.paymentPagePayWith,
// // //     //                           style: TextStyle(
// // //     //                             fontSize: 19,
// // //     //                             color: AppColors.white,
// // //     //                             fontWeight: FontWeight.w700,
// // //     //                             fontFamily: AppTextStyles.fontFamily,
// // //     //                           ),
// // //     //                         ),
// // //     //                         SvgPicture.asset(AppAssets.google,
// // //     //                             height: height * 0.06),
// // //     //                         const Text(
// // //     //                           AppTexts.paymentPagePay,
// // //     //                           style: TextStyle(
// // //     //                             fontSize: 19,
// // //     //                             color: AppColors.white,
// // //     //                             fontFamily: AppTextStyles.fontFamily,
// // //     //                             fontWeight: FontWeight.w700,
// // //     //                           ),
// // //     //                         ),
// // //     //                       ],
// // //     //                     ),
// // //     //                   ),
// // //     //                 ),
// // //     //               ),
// // //     //               Row(
// // //     //                 // mainAxisAlignment: MainAxisAlignment.spaceBetween,
// // //     //                 children: [
// // //     //                   Expanded(
// // //     //                     flex: 1,
// // //     //                     child: Center(
// // //     //                       child: AutoSizeText(
// // //     //                         AppTexts.paymentPagePrivacyPolicy,
// // //     //                         minFontSize: 8,
// // //     //                         style: TextStyle(
// // //     //                             color: AppColors.buttonColor,
// // //     //                             fontSize: 13,
// // //     //                             fontWeight: FontWeight.w700,
// // //     //                             fontFamily: AppTextStyles.fontFamily),
// // //     //                       ),
// // //     //                     ),
// // //     //                   ),
// // //     //                   Expanded(
// // //     //                     flex: 1,
// // //     //                     child: Center(
// // //     //                       child: AutoSizeText(
// // //     //                         AppTexts.paymentPageTermsCondition,
// // //     //                         // maxLines: 1,
// // //     //                         textAlign: TextAlign.center,
// // //     //                         minFontSize: 8,
// // //     //                         style: TextStyle(
// // //     //                           fontSize: 13,
// // //     //                           color: AppColors.buttonColor,
// // //     //                           fontWeight: FontWeight.w700,
// // //     //                           fontFamily: AppTextStyles.fontFamily,
// // //     //                         ),
// // //     //                       ),
// // //     //                     ),
// // //     //                   ),
// // //     //                 ],
// // //     //               ),
// // //     //             ],
// // //     //           ),
// // //     //         ),
// // //     //       ),
// // //     //     ),
// // //     //   ),
// // //     // );

// // //   }
// // // }
