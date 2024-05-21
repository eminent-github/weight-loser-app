import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:weight_loss_app/common/app_colors.dart';
import 'package:weight_loss_app/common/app_text_styles.dart';
import 'package:weight_loss_app/modules/payment_integration/payment_detail/controller/payment_detail_controller.dart';

class PaymentDetailPage extends GetView<PaymentDetailController> {
  const PaymentDetailPage({super.key});

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    double height = size.height;
    double width = size.width;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).appBarTheme.backgroundColor,
        iconTheme: Theme.of(context).iconTheme,
        elevation: 0,
        title: Text(
          "Subscription details",
          style: Theme.of(context).appBarTheme.titleTextStyle,
        ),
        centerTitle: true,
      ),
      body: Obx(
        () => Stack(
          children: [
            SafeArea(
              child: SingleChildScrollView(
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: width * 0.08),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      SizedBox(
                        height: height * 0.02,
                      ),
                      Text(
                        'Recent payment',
                        style: AppTextStyles.formalTextStyle(
                          color: const Color(0xFF3E3E3E),
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                      SizedBox(
                        height: height * 0.02,
                      ),
                      Container(
                        margin: EdgeInsets.symmetric(vertical: height * 0.01),
                        padding: EdgeInsets.symmetric(
                            vertical: height * 0.04, horizontal: width * 0.04),
                        decoration: ShapeDecoration(
                          color: const Color(0xFFF6F1F1),
                          shape: RoundedRectangleBorder(
                            side: BorderSide(
                                width: 1,
                                color: AppColors.buttonColor.withOpacity(0.2)),
                            borderRadius: BorderRadius.circular(15),
                          ),
                        ),
                        child: controller.isLoading.value
                            ? Center(
                                child: CircularProgressIndicator(
                                  color: AppColors.buttonColor,
                                ),
                              )
                            : Column(
                                children: [
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(
                                        'Recharge date',
                                        style: AppTextStyles.formalTextStyle(
                                          color: AppColors.buttonColor,
                                          fontSize: 15,
                                        ),
                                      ),
                                      Text(
                                        DateFormat("MMMM dd, y").format(
                                            DateTime.parse(controller
                                                    .getPaymentPlans
                                                    .value
                                                    .startDate ??
                                                DateTime.now().toString())),
                                        textAlign: TextAlign.right,
                                        style: AppTextStyles.formalTextStyle(
                                          color: AppColors.buttonColor,
                                          fontSize: 15,
                                        ),
                                      )
                                    ],
                                  ),
                                  SizedBox(
                                    height: height * 0.015,
                                  ),
                                  Container(
                                    decoration: ShapeDecoration(
                                      shape: RoundedRectangleBorder(
                                        side: BorderSide(
                                          width: 1,
                                          strokeAlign:
                                              BorderSide.strokeAlignCenter,
                                          color: AppColors.buttonColor
                                              .withOpacity(0.2),
                                        ),
                                      ),
                                    ),
                                  ),
                                  SizedBox(
                                    height: height * 0.015,
                                  ),
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(
                                        'Expire in',
                                        style: AppTextStyles.formalTextStyle(
                                          fontSize: 15,
                                        ),
                                      ),
                                      Text(
                                        controller.packageName.value == "Legacy"
                                            ? "∞"
                                            : "${DateTime.parse(controller.getPaymentPlans.value.endDate ?? DateTime.now().toString()).difference(DateTime.now()).inDays} Days",
                                        textAlign: TextAlign.right,
                                        style: AppTextStyles.formalTextStyle(),
                                      )
                                    ],
                                  ),
                                  SizedBox(
                                    height: height * 0.015,
                                  ),
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(
                                        'Duration',
                                        style: AppTextStyles.formalTextStyle(
                                          color: AppColors.black,
                                          fontSize: 15,
                                        ),
                                      ),
                                      Text(
                                        controller.packageName.value == "Legacy"
                                            ? "∞"
                                            : controller.getPaymentPlans.value
                                                        .duration! <
                                                    30
                                                ? "${controller.getPaymentPlans.value.duration} Days"
                                                : '${(controller.getPaymentPlans.value.duration ?? 0) ~/ 30} months',
                                        textAlign: TextAlign.right,
                                        style: AppTextStyles.formalTextStyle(
                                          color: AppColors.black,
                                        ),
                                      )
                                    ],
                                  ),
                                  SizedBox(
                                    height: height * 0.015,
                                  ),
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(
                                        'Amount',
                                        style: AppTextStyles.formalTextStyle(
                                          color: AppColors.black,
                                          fontSize: 15,
                                          fontWeight: FontWeight.w500,
                                        ),
                                      ),
                                      Text(
                                        '\$${controller.getPaymentPlans.value.amount!.toPrecision(2)}',
                                        style: AppTextStyles.formalTextStyle(
                                          color: AppColors.black,
                                          fontSize: 15,
                                        ),
                                      )
                                    ],
                                  ),
                                  SizedBox(
                                    height: height * 0.05,
                                  ),
                                  Padding(
                                    padding: EdgeInsets.symmetric(
                                        horizontal: width * 0.05),
                                    child: Material(
                                      color: AppColors.buttonColor,
                                      shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(6)),
                                      child: InkWell(
                                        onTap: () {
                                          controller.restorePurchases();
                                        },
                                        borderRadius: BorderRadius.circular(6),
                                        child: SizedBox(
                                          height: 50,
                                          child: Center(
                                            child: Text(
                                              'Restore In-App Purchases',
                                              style:
                                                  AppTextStyles.formalTextStyle(
                                                color: Colors.white,
                                                fontSize: 16,
                                              ),
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                  // SizedBox(
                                  //   height: height * 0.05,
                                  // ),
                                  // Padding(
                                  //   padding: EdgeInsets.symmetric(
                                  //       horizontal: width * 0.05),
                                  //   child: Material(
                                  //     color: AppColors.buttonColor,
                                  //     shape: RoundedRectangleBorder(
                                  //         borderRadius:
                                  //             BorderRadius.circular(6)),
                                  //     child: InkWell(
                                  //       onTap: () {
                                  //         if (controller
                                  //                 .getPaymentPlans.value.status!
                                  //                 .trim() ==
                                  //             "trial") {
                                  //           customSnackbar(
                                  //             title: AppTexts.alert,
                                  //             message:
                                  //                 "You cannot upgrade the plan as you're in the trial version.",
                                  //           );
                                  //         } else if (controller
                                  //                 .packageName.value ==
                                  //             "Legacy") {
                                  //           customSnackbar(
                                  //             title: AppTexts.alert,
                                  //             message:
                                  //                 "You cannot upgrade the plan as you're in the Lifetime Plan.",
                                  //             duration: 2000,
                                  //           );
                                  //         } else {
                                  //           Get.to(
                                  //               () => const PaymentPlansPage(),
                                  //               binding: PaymentPlansBinding());
                                  //         }
                                  //       },
                                  //       borderRadius: BorderRadius.circular(6),
                                  //       child: SizedBox(
                                  //         height: 50,
                                  //         child: Center(
                                  //           child: Text(
                                  //             'Upgrade',
                                  //             style:
                                  //                 AppTextStyles.formalTextStyle(
                                  //               color: Colors.white,
                                  //               fontSize: 20,
                                  //             ),
                                  //           ),
                                  //         ),
                                  //       ),
                                  //     ),
                                  //   ),
                                  // ),
                                  // SizedBox(
                                  //   height: height * 0.015,
                                  // ),
                                  // controller.getPaymentPlans.value.status ==
                                  //         "cancelled"
                                  //     ? const SizedBox.shrink()
                                  //     : Padding(
                                  //         padding: EdgeInsets.symmetric(
                                  //             horizontal: width * 0.05),
                                  //         child: Material(
                                  //           shape: RoundedRectangleBorder(
                                  //             side: const BorderSide(
                                  //                 width: 1,
                                  //                 color: Color(0xFFC2C0C0)),
                                  //             borderRadius:
                                  //                 BorderRadius.circular(6),
                                  //           ),
                                  //           child: InkWell(
                                  //             onTap: () {
                                  //               controller
                                  //                   .showAlertDialog(context);
                                  //             },
                                  //             borderRadius:
                                  //                 BorderRadius.circular(6),
                                  //             child: SizedBox(
                                  //               height: 50,
                                  //               child: Center(
                                  //                 child: Opacity(
                                  //                   opacity: 0.84,
                                  //                   child: Text(
                                  //                     'Cancel',
                                  //                     style: AppTextStyles
                                  //                         .formalTextStyle(
                                  //                       fontSize: 20,
                                  //                       color: Theme.of(context)
                                  //                           .primaryTextTheme
                                  //                           .titleMedium!
                                  //                           .color!,
                                  //                     ),
                                  //                   ),
                                  //                 ),
                                  //               ),
                                  //             ),
                                  //           ),
                                  //         ),
                                  //       )
                                ],
                              ),
                      ),
                      // SizedBox(
                      //   height: height * 0.37,
                      //   width: width,
                      //   child: Image.asset(
                      //     AppAssets.paymentDetailGifUrl,
                      //     fit: BoxFit.cover,
                      //   ),
                      // ),
                    ],
                  ),
                ),
              ),
            ),
            controller.isPostLoading.value
                ? Center(
                    child: Container(
                      height: 100,
                      width: 100,
                      decoration: BoxDecoration(
                        color: AppColors.black.withOpacity(0.8),
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Text(
                            "Restoring...",
                            style: AppTextStyles.formalTextStyle(
                                color: Colors.white),
                          ),
                          CircularProgressIndicator.adaptive(
                            backgroundColor:
                                Platform.isIOS ? AppColors.white : null,
                          )
                        ],
                      ),
                    ),
                  )
                : const SizedBox(),
          ],
        ),
      ),
    );
  }
}
