import 'dart:async';
import 'dart:convert';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:in_app_purchase/in_app_purchase.dart';
import 'package:weight_loss_app/common/api_urls.dart';
import 'package:weight_loss_app/common/app_colors.dart';
import 'package:weight_loss_app/common/app_text_styles.dart';
import 'package:weight_loss_app/common/app_texts.dart';
import 'package:weight_loss_app/modules/dashbored/screens/home/home_page/home_page.dart';
import 'package:weight_loss_app/modules/dashbored/screens/home/screens/home_inner_today/controller/home_inner_today_controller.dart';
import 'package:weight_loss_app/modules/payment_integration/payment_detail/model/recent_plan_model.dart';
import 'package:weight_loss_app/utils/api_service.dart';
import 'package:weight_loss_app/utils/shared_prefrence.dart';
import 'package:weight_loss_app/widgets/custom_snackbar.dart';

class PaymentDetailController extends GetxController {
  @override
  void onInit() {
    getRecentPaymentApi();
    initialize();
    super.onInit();
  }

  final ApiService apiService = ApiService();
  var isLoading = false.obs;
  var isPostLoading = false.obs;
  var packageName = "".obs;

  Rx<RecentPaymentModel> getPaymentPlans = RecentPaymentModel().obs;
  Future<void> getRecentPaymentApi() async {
    try {
      isLoading.value = true;
      String? token = await StorageServivce.getToken();
      var response = await apiService.get(
        ApiUrls.recentPaymentEndPoint,
        authToken: token,
      );
      log("status code ${response.statusCode}body ${jsonDecode(response.body)}");
      if (response.statusCode == 200) {
        var dataObj = jsonDecode(response.body);
        packageName.value = dataObj["packageName"] ?? "";
        getPaymentPlans.value =
            RecentPaymentModel.fromJson(dataObj["customerPackages"]);

        isLoading.value = false;
      } else {
        isLoading.value = false;
        customSnackbar(
            title: AppTexts.error, message: "No Recent Payment Found");
      }
    } catch (e) {
      isLoading.value = false;
      log(e.toString());
    }
  }

  Future<void> cancelApi() async {
    Map<String, dynamic> bodyData = {
      "status": "cancelled",
    };
    try {
      isPostLoading.value = true;
      log("beforeResponse");
      String? token = await StorageServivce.getToken();
      var response = await apiService.post(
        ApiUrls.cancelMembershipEndPoint,
        jsonEncode(bodyData),
        authToken: token,
      );
      log("afterrResponse : ${response.statusCode}");

      if (response.statusCode == 200) {
        // var dateObj = jsonDecode(response.body);

        isPostLoading.value = false;
        scaffoldKey.currentState!.closeDrawer();
        Get.find<HomeInnerTodayController>().getTodayBudgetApi();
        Get.until(
          (route) => route.isFirst,
        );
      } else {
        isPostLoading.value = false;
        customSnackbar(title: AppTexts.error, message: "Cancellation Failed");
      }
    } catch (e) {
      isPostLoading.value = false;
      customSnackbar(title: AppTexts.error, message: "Api Exception");
    }
  }

  void showAlertDialog(
    BuildContext context,
  ) {
    // Create the AlertDialog
    AlertDialog alert = AlertDialog(
      icon: Icon(
        Icons.cancel_sharp,
        size: 45,
        color: AppColors.buttonColor,
      ),
      title: Text(
        'Cancel Membership',
        style: AppTextStyles.formalTextStyle(
          fontWeight: FontWeight.w700,
          color: AppColors.buttonColor,
        ),
      ),
      content: Text(
        "It's sad to see you leave. Are you sure you want to end your membership?",
        textAlign: TextAlign.justify,
        style: AppTextStyles.formalTextStyle(),
      ),
      actions: [
        TextButton(
          onPressed: () {
            Navigator.of(context).pop(); // Close the alert dialog
          },
          child: Text(
            'Cancel',
            style: AppTextStyles.formalTextStyle(
              color: AppColors.abstractionTextColor,
            ),
          ),
        ),
        TextButton(
          onPressed: () async {
            Navigator.of(context).pop();
            cancelApi();
          },
          child: Text(
            'Yes',
            style: AppTextStyles.formalTextStyle(
              color: AppColors.buttonColor,
            ),
          ),
        ),
      ],
    );

    // Show the AlertDialog
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }

  final InAppPurchase iap = InAppPurchase.instance;

  late StreamSubscription<List<PurchaseDetails>> _purchasesSubscription;

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
        handlePurchaseUpdates(purchaseDetailsList);
      },
      onDone: () {
        log("%%%%%%%%%%%% DOne");

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

    switch (purchaseDetails.status) {
      case PurchaseStatus.pending:
        isPostLoading.value = false;

      case PurchaseStatus.canceled:
        isPostLoading.value = false;
        break;
      case PurchaseStatus.purchased:
        isPostLoading.value = false;
        break;
      case PurchaseStatus.error:
        isPostLoading.value = false;
        break;

      case PurchaseStatus.restored:
        isPostLoading.value = false;
        customSnackbar(
          title: AppTexts.success,
          message: "Purchase Restored",
          icon: const Icon(
            Icons.check_circle,
            color: Colors.green,
          ),
        );
        break;
      default:
        isPostLoading.value = false;
    }
    if (purchaseDetails.pendingCompletePurchase) {
      isPostLoading.value = false;
      await iap.completePurchase(purchaseDetails);
    }
  }

  restorePurchases() async {
    try {
      isPostLoading.value = true;
      await iap.restorePurchases();
    } catch (error) {
      print("_____________$error");
      isPostLoading.value = false;
    }
  }
}
