import 'dart:developer';
import 'dart:io';

import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:weight_loss_app/common/app_assets.dart';
import 'package:weight_loss_app/common/app_colors.dart';
import 'package:weight_loss_app/common/app_text_styles.dart';
import 'package:weight_loss_app/common/app_texts.dart';
import 'package:weight_loss_app/controllers/purchase_api_controller.dart';
import 'package:weight_loss_app/modules/payment_integration/monthly_plan/controller/monthly_plan_controller.dart';
import 'package:weight_loss_app/modules/payment_integration/payment_plans/models/payment_plans_model.dart';
import 'package:weight_loss_app/widgets/custom_snackbar.dart';
import 'package:weight_loss_app/widgets/overlay_widget.dart';

class MonthlyPlanPage extends GetView<MonthlyPlanController> {
  const MonthlyPlanPage({
    super.key,
    required this.monthlyPackage,
    required this.isMonthly,
  });
  final PackagesList monthlyPackage;
  final bool isMonthly;
  @override
  Widget build(BuildContext context) {
    PurchaseApiController purchaseApiController =
        Get.put(PurchaseApiController());
    var size = MediaQuery.sizeOf(context);
    double height = size.height - kToolbarHeight;
    double width = size.width;
    return Scaffold(
      body: Obx(
        () => Stack(
          children: [
            Align(
              alignment: Alignment.bottomCenter,
              child: Image.asset(
                AppAssets.splashImgUrl,
                fit: BoxFit.cover,
                width: width,
              ),
            ),
            SafeArea(
              child: Center(
                child: Column(
                  children: [
                    SizedBox(
                      height: height * 0.02,
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: width * 0.01),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          IconButton(
                            onPressed: () {
                              Get.back();
                            },
                            alignment: Alignment.topLeft,
                            icon: Icon(
                              Platform.isAndroid
                                  ? Icons.arrow_back
                                  : Icons.arrow_back_ios_new_rounded,
                            ),
                          ),
                          Expanded(
                            child: Text(
                              '${controller.userName.value.split(" ")[0]}, We guarantee you will lose actual weight ${controller.currentWeight.value - controller.targetWeight.value} ${controller.weightUnit.value}s by:',
                              textAlign: TextAlign.start,
                              style: AppTextStyles.formalTextStyle(
                                color: const Color(0xFF434343),
                                fontSize: 24,
                              ),
                              maxLines: 3,
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(
                      height: height * 0.03,
                    ),
                    isMonthly
                        ? const SizedBox.shrink()
                        : Padding(
                            padding:
                                EdgeInsets.symmetric(horizontal: width * 0.05),
                            child: SizedBox(
                              width: width,
                              height: height * 0.15,
                              child: Material(
                                elevation: 8,
                                borderRadius: BorderRadius.circular(15),
                                child: Column(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceEvenly,
                                  children: [
                                    Text(
                                      DateFormat('MMMM dd, y').format(
                                        controller.expectedDate(
                                            targetWeight:
                                                controller.targetWeight.value,
                                            currentWeight:
                                                controller.currentWeight.value,
                                            weightUnit:
                                                controller.weightUnit.value),
                                      ),
                                      style: AppTextStyles.formalTextStyle(
                                        color: AppColors.buttonColor,
                                        fontSize: 24,
                                        fontWeight: FontWeight.w700,
                                      ),
                                    ),
                                    Text.rich(
                                      TextSpan(
                                        children: [
                                          const TextSpan(
                                            text: 'Price for next ',
                                            style: TextStyle(
                                              color: Colors.black,
                                              fontSize: 15,
                                              fontFamily: 'Poppins',
                                              fontWeight: FontWeight.w400,
                                            ),
                                          ),
                                          TextSpan(
                                            text: controller
                                                        .expectedDate(
                                                            targetWeight:
                                                                controller
                                                                    .targetWeight
                                                                    .value,
                                                            currentWeight:
                                                                controller
                                                                    .currentWeight
                                                                    .value,
                                                            weightUnit:
                                                                controller
                                                                    .weightUnit
                                                                    .value)
                                                        .difference(
                                                          DateTime.now(),
                                                        )
                                                        .inDays >=
                                                    30
                                                ? '${(controller.expectedDate(targetWeight: controller.targetWeight.value, currentWeight: controller.currentWeight.value, weightUnit: controller.weightUnit.value).difference(
                                                      DateTime.now(),
                                                    ).inDays / 30).ceil()} months'
                                                : "${controller.expectedDate(targetWeight: controller.targetWeight.value, currentWeight: controller.currentWeight.value, weightUnit: controller.weightUnit.value).difference(
                                                      DateTime.now(),
                                                    ).inDays} Days",
                                            style: const TextStyle(
                                              color: Colors.black,
                                              fontSize: 15,
                                              fontFamily: 'Poppins',
                                              fontWeight: FontWeight.bold,
                                              decoration:
                                                  TextDecoration.underline,
                                            ),
                                          ),
                                          const TextSpan(
                                            text: ' until ',
                                            style: TextStyle(
                                              color: Colors.black,
                                              fontSize: 15,
                                              fontFamily: 'Poppins',
                                              fontWeight: FontWeight.w400,
                                            ),
                                          ),
                                          TextSpan(
                                            text: DateFormat('dd MMMM').format(
                                              controller.expectedDate(
                                                  targetWeight: controller
                                                      .targetWeight.value,
                                                  currentWeight: controller
                                                      .currentWeight.value,
                                                  weightUnit: controller
                                                      .weightUnit.value),
                                            ),
                                            style: const TextStyle(
                                              color: Colors.black,
                                              fontSize: 15,
                                              fontFamily: 'Poppins',
                                              fontWeight: FontWeight.bold,
                                              decoration:
                                                  TextDecoration.underline,
                                            ),
                                          ),
                                        ],
                                      ),
                                      textAlign: TextAlign.center,
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                    SizedBox(
                      height: height * 0.04,
                    ),
                    Material(
                      elevation: 8,
                      borderRadius: BorderRadius.circular(30),
                      child: SizedBox(
                        width: width * 0.6,
                        height: height * 0.22,
                        child: Stack(
                          fit: StackFit.passthrough,
                          children: [
                            Column(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                Container(
                                  height: height * 0.045,
                                  width: width * 0.24,
                                  decoration: BoxDecoration(
                                      color: AppColors.buttonColor,
                                      borderRadius: BorderRadius.circular(8)),
                                  child: Center(
                                    child: Text(
                                      "${monthlyPackage.discountPercent!.toInt()}% Off",
                                      style: const TextStyle(
                                        color: Colors.white,
                                        fontSize: 17,
                                        fontFamily: AppTextStyles.fontFamily,
                                        fontWeight: FontWeight.w700,
                                      ),
                                    ),
                                  ),
                                ),
                                Text(
                                  'Discounted Price',
                                  style: AppTextStyles.formalTextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold),
                                ),
                                AutoSizeText(
                                  "\$${monthlyPackage.discountPrice!.toStringAsFixed(2)}",
                                  style: AppTextStyles.formalTextStyle(
                                    color: AppColors.buttonColor,
                                    fontSize: 49,
                                    fontWeight: FontWeight.w700,
                                  ),
                                  maxLines: 1,
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                    SizedBox(
                      height: height * 0.04,
                    ),
                    Material(
                      color: AppColors.buttonColor,
                      borderRadius: BorderRadius.circular(5),
                      child: InkWell(
                        onTap: () async {
                          purchaseApiController.isLoading.value = true;

                          if (isMonthly) {
                            for (var package
                                in purchaseApiController.packages) {
                              String identifier =
                                  package.storeProduct.identifier;
                              if (identifier == "wl_monthly_plan") {
                                bool success = await purchaseApiController
                                    .purchasePackage(package: package);

                                if (success) {
                                  log("Purchase successful!");
                                  purchaseApiController.isLoading.value = false;
                                } else {
                                  purchaseApiController.isLoading.value = false;
                                }
                              }
                            }
                          } else {
                            ///
                            ///
                            ///
                            ///
                            double discountPrice =
                                monthlyPackage.discountPrice ?? 0;
                            bool packageFound = false;
                            print("discountPrice === $discountPrice");

                            for (var package
                                in purchaseApiController.packages) {
                              String identifier =
                                  package.storeProduct.identifier;
                              String price =
                                  package.storeProduct.price.toStringAsFixed(2);
                              print("price === $price");

                              if (discountPrice == double.parse(price)) {
                                switch (identifier) {
                                  case "wl_monthly_plan":
                                  case "wl_3month_plan":
                                  case "wl_6month_plan":
                                  case "wl_yearly_plan":
                                    print("price === $price");
                                    print("package == $package");

                                    packageFound = true;
                                    bool success = await purchaseApiController
                                        .purchasePackage(package: package);

                                    if (success) {
                                      log("Purchase successful!");

                                      purchaseApiController.isLoading.value =
                                          false;
                                    } else {
                                      purchaseApiController.isLoading.value =
                                          false;
                                    }
                                    break;
                                  default:
                                    log("Identifier not in the specified list: $identifier");
                                    break;
                                }
                              }
                            }

                            if (!packageFound) {
                              customSnackbar(
                                backgroundColor: AppColors.red,
                                message:
                                    "No matching package found for the discount price.",
                              );
                            }
                          }
                        },
                        borderRadius: BorderRadius.circular(5),
                        child: Container(
                          height: height * 0.07,
                          width: width * 0.5,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(5),
                            boxShadow: [
                              BoxShadow(
                                color: AppColors.buttonColor.withOpacity(0.2),
                                blurRadius: 2,
                                offset: const Offset(0, 3),
                              ),
                            ],
                          ),
                          child: Center(
                            child: controller.isLoading.value
                                ? const CircularProgressIndicator.adaptive(
                                    backgroundColor: AppColors.white,
                                  )
                                : const AutoSizeText(
                                    AppTexts.paymentDiscountPageContinue,
                                    minFontSize: 10,
                                    style: TextStyle(
                                      fontSize: 16,
                                      fontFamily: AppTextStyles.fontFamily,
                                      fontWeight: FontWeight.w700,
                                      color: AppColors.white,
                                    ),
                                  ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            controller.isApiLoading.value ||
                    purchaseApiController.isLoading.value
                ? const OverlayWidget()
                : const SizedBox.shrink()
          ],
        ),
      ),
    );
  }
}
