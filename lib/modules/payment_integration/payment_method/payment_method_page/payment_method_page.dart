import 'dart:developer';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pay/pay.dart';
import 'package:weight_loss_app/common/app_colors.dart';
import 'package:weight_loss_app/common/app_text_styles.dart';
import 'package:weight_loss_app/common/app_texts.dart';
import 'package:weight_loss_app/modules/payment_integration/payment_method/controller/payment_method_controller.dart';
import 'package:weight_loss_app/modules/payment_integration/payment_page/model/payment_success_detail.dart';
import 'package:weight_loss_app/utils/internet_check_widget.dart';
import 'package:weight_loss_app/widgets/custom_snackbar.dart';
import 'package:weight_loss_app/widgets/overlay_widget.dart';

class PaymentMethodPage extends GetView<PaymentMethodController> {
  const PaymentMethodPage({
    super.key,
    required this.postPaymentModel,
    required this.userId,
  });
  final PostPaymentModel postPaymentModel;
  final String userId;
  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    final Future<PaymentConfiguration> googlePayConfigFutures =
        PaymentConfiguration.fromAsset('payments/gpay.json');
    double height = size.height;
    double width = size.width;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).appBarTheme.backgroundColor,
        iconTheme: Theme.of(context).iconTheme,
        elevation: 0,
        title: Text(
          "Select Payment Method",
          style: Theme.of(context).appBarTheme.titleTextStyle,
        ),
        centerTitle: true,
      ),
      body: InternetCheckWidget<ConnectivityService>(
        child: Obx(
          () => Stack(
            children: [
              SafeArea(
                child: Padding(
                  padding: EdgeInsets.symmetric(
                    horizontal: width * 0.072,
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Platform.isAndroid
                          ? Material(
                              color: AppColors.black,
                              borderRadius: BorderRadius.circular(50),
                              child: InkWell(
                                borderRadius: BorderRadius.circular(50),
                                onTap: () {
                                  print(
                                      "++++++++++${(postPaymentModel.amount * 100)}");
                                  controller.makePayment(
                                    context: context,
                                    userId: userId,
                                    type: "Stripe",
                                    postPaymentModel: postPaymentModel,
                                    transactionID: (id) async {
                                      print('transaction id ');
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
                                      'Pay with Stripe',
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
                      Platform.isAndroid
                          ? SizedBox(
                              height: height * 0.05,
                            )
                          : const SizedBox.shrink(),
                      Platform.isAndroid
                          ? FutureBuilder<PaymentConfiguration>(
                              future: googlePayConfigFutures,
                              builder: (context, snapshot) => snapshot.hasData
                                  ? GooglePayButton(
                                      width: MediaQuery.of(context).size.width,
                                      height: height * 0.06,
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
                                              .toString(),
                                          type: PaymentItemType.total,
                                          status: PaymentItemStatus.final_price,
                                        ),
                                      ],
                                      type: GooglePayButtonType.pay,
                                      onPaymentResult: (paymentResult) async {
                                        log('get payment result $paymentResult');
                                        // log('my google pay is ${jsonEncode(paymentResult)}');
                                        // PaymentSuccessDetail paymentSuccessDetail =
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
                                        await controller.paymentPostApi(
                                            postPaymentModel, "Google");
                                      },
                                      loadingIndicator: const Center(
                                        child: CircularProgressIndicator(),
                                      ),
                                    )
                                  : const SizedBox.shrink())
                          : ApplePayButton(
                              paymentConfiguration:
                                  controller.applePayConfigFutures,
                              width: MediaQuery.of(context).size.width,
                              height: height * 0.06,
                              cornerRadius: 50,
                              paymentItems: [
                                PaymentItem(
                                  label: 'Total',
                                  amount: postPaymentModel.amount.toString(),
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
                            )
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
