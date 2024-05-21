import 'dart:convert';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_stripe/flutter_stripe.dart';
import 'package:get/get.dart';
import 'package:pay/pay.dart';
import 'package:uuid/uuid.dart';
import 'package:http/http.dart' as http;
import 'package:weight_loss_app/common/api_urls.dart';
import 'package:weight_loss_app/common/app_texts.dart';
import 'package:weight_loss_app/modules/dashbored/screens/home/home_page/home_page.dart';
import 'package:weight_loss_app/modules/dashbored/screens/home/screens/home_inner_today/controller/home_inner_today_controller.dart';
import 'package:weight_loss_app/modules/payment_integration/payment_configuration/payment_configuration.dart';
import 'package:weight_loss_app/modules/payment_integration/payment_detail/controller/payment_detail_controller.dart';
import 'package:weight_loss_app/modules/payment_integration/payment_page/model/payment_success_detail.dart';
import 'package:weight_loss_app/utils/api_service.dart';
import 'package:weight_loss_app/utils/shared_prefrence.dart';
import 'package:weight_loss_app/widgets/custom_snackbar.dart';

class PaymentMethodController extends GetxController {
  void onApplePayResult(paymentResult) {
    log(paymentResult.toString());
  }

  final Future<PaymentConfiguration> googlePayConfigFutures =
      PaymentConfiguration.fromAsset('payments/gpay.json');
  final PaymentConfiguration applePayConfigFutures =
      PaymentConfiguration.fromJsonString(defaultApplePay);

  final ApiService apiService = ApiService();
  var isLoading = false.obs;

  Future<void> paymentPostApi(
      PostPaymentModel postPaymentModel, String type) async {
    Map<String, dynamic> bodyData = {
      "packageId": postPaymentModel.packageId,
      "amount": postPaymentModel.amount,
      "Discount": postPaymentModel.discount,
      "DiscountPrice": postPaymentModel.discountPrice,
      "TotalAmount": postPaymentModel.totalAmount,
      "type": type,
      "status": postPaymentModel.status, //trial,pending,paid
      "duration": postPaymentModel.duration
    };
    try {
      isLoading.value = true;
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
        isLoading.value = false;

        var homeController = Get.find<HomeInnerTodayController>();
        if (homeController.getTodayBudget.value.customerPackageExpired ??
            false) {
          scaffoldKey.currentState!.closeDrawer();
          homeController.getTodayBudgetApi();
          Get.until(
            (route) => route.isFirst,
          );
        } else {
          Get.find<PaymentDetailController>().getRecentPaymentApi();
          Get.until(
            (route) =>
                (route as GetPageRoute).routeName == "/PaymentDetailPage",
          );
        }
      } else {
        isLoading.value = false;
        var homeController = Get.find<HomeInnerTodayController>();
        if (homeController.getTodayBudget.value.customerPackageExpired ??
            false) {
          scaffoldKey.currentState!.closeDrawer();
          homeController.getTodayBudgetApi();
          Get.until(
            (route) => route.isFirst,
          );
        } else {
          Get.find<PaymentDetailController>().getRecentPaymentApi();
          Get.until(
            (route) =>
                (route as GetPageRoute).routeName == "/PaymentDetailPage",
          );
        }
      }
    } catch (e) {
      isLoading.value = false;
      customSnackbar(title: AppTexts.error, message: "Api Exception");
    }
  }

  Map<String, dynamic>? paymentIntent;

  Future makePayment(
      {String? totalPayment,
      required BuildContext context,
      required String userId,
      required PostPaymentModel postPaymentModel,
      required String type,
      required Function(String) transactionID}) async {
    var uuid = const Uuid();
    String id = uuid.v1();
    try {
      print("ooooooooooooo$totalPayment");
      paymentIntent = await createPaymentIntent(
          amount: '$totalPayment', currency: 'USD', paymentId: id);

      await Stripe.instance.initPaymentSheet(
          paymentSheetParameters: SetupPaymentSheetParameters(
        paymentIntentClientSecret:
            paymentIntent!['client_secret'], //Gotten from payment intent
        style: ThemeMode.light,

        //........user login id
        customerId: userId,
        // allowsDelayedPaymentMethods: true,
        // user_model.user!.id.toString(),
        merchantDisplayName: 'American Heart Center',

        googlePay: PaymentSheetGooglePay(
          merchantCountryCode: 'USA',
          currencyCode: 'USD',
          testEnv: false,
          amount: totalPayment,
        ),
        // setupIntentClientSecret: '25aad351-46c9-4208-d664-08dc230ec102',
        // user_model.user!.id.toString(),
        // applePay: const PaymentSheetApplePay(
        //     merchantCountryCode: 'US',
        //     buttonType: PlatformButtonType.pay)
      ));
      await displayPaymentSheet(
        paymentId: id,
        context: context,
        transactionID: transactionID,
        postPaymentModel: postPaymentModel,
        type: type,
      );
    } catch (err) {
      print('catch error is ${err.toString()}');

      customSnackbar(title: AppTexts.error, message: err.toString());
    }
  }

  displayPaymentSheet({
    String? paymentId,
    required BuildContext context,
    required Function(String) transactionID,
    required PostPaymentModel postPaymentModel,
    required String type,
  }) async {
    try {
      await Stripe.instance.presentPaymentSheet().then((value) async {
        transactionID.call(paymentId!);
        await showDialog(
            context: context,
            builder: (inContext) {
              Future.delayed(const Duration(seconds: 2), () {
                Navigator.of(inContext).pop(); // Close the dialog
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
        paymentIntent = null;

        paymentPostApi(postPaymentModel, type);
      }).onError((error, stackTrace) {
        throw http.ClientException(error.toString());
      });
    } on StripeException catch (e) {
      print('Error is:---> $e');
      await showDialog(
          context: context,
          builder: (inContext) {
            Future.delayed(const Duration(seconds: 2), () {
              Navigator.of(inContext).pop(); // Close the dialog
            });
            return const AlertDialog(
              content: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(
                    Icons.cancel,
                    color: Colors.red,
                    size: 100.0,
                  ),
                  SizedBox(height: 10.0),
                  Text("Payment Cancel"),
                ],
              ),
            );
          });
    } catch (e) {
      print('$e');
    }
  }

  createPaymentIntent(
      {String? amount, String? currency, String? paymentId}) async {
    try {
      //Request body
      Map<String, dynamic> body = {
        'amount': amount!,
        'currency': currency,
        'description': paymentId
      };
      //Make post request to Stripe
      //......stripe key test...........//
      //....sk_test_51On2EbDQ0SCp7bRiixbFFXidjqyHb9A9CB598CDRXt6bldjNoorzCsLw0pY6FGJ4WbfQx3iEzyPgO6USdbGTc0a900mBxT08uA ......//
      //......stripe key Live...........//
      //.....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
      var response = await http.post(
        Uri.parse('https://api.stripe.com/v1/payment_intents'),
        headers: {
          'Authorization':
              'Bearer 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',
          'Content-Type': 'application/x-www-form-urlencoded'
        },
        body: body,
      );
      log(response.statusCode.toString());
      var result = json.decode(response.body);
      if (response.statusCode == 200) {
        return result;
      } else {
        print(result);
        throw http.ClientException(
            result["error"]["message"] ?? "Payment Failed");
      }
    } catch (err) {
      print('catch api error is $err');
      throw http.ClientException(err.toString());
    }
  }
}
