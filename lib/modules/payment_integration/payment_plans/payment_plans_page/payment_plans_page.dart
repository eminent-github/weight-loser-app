import 'dart:math';

import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:weight_loss_app/common/app_colors.dart';
import 'package:weight_loss_app/common/app_text_styles.dart';
import 'package:weight_loss_app/modules/payment_integration/payment_confirmation/binding/payment_confirmation_binding.dart';
import 'package:weight_loss_app/modules/payment_integration/payment_confirmation/payment_confirmation_page/payment_confirmation_page.dart';
import 'package:weight_loss_app/modules/payment_integration/payment_plans/controller/payment_plans_controller.dart';
import 'package:weight_loss_app/modules/payment_integration/payment_plans/models/payment_plans_model.dart';
import 'package:weight_loss_app/utils/internet_check_widget.dart';
import 'package:weight_loss_app/widgets/custom_large_button.dart';

class PaymentPlansPage extends GetView<PaymentPlansController> {
  const PaymentPlansPage({super.key});

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
          "Choose Plan",
          style: Theme.of(context).appBarTheme.titleTextStyle,
        ),
        centerTitle: true,
      ),
      body: InternetCheckWidget<ConnectivityService>(
        child: SafeArea(
          child: Obx(
            () => controller.isLoading.value
                ? Center(
                    child: CircularProgressIndicator(
                      color: AppColors.buttonColor,
                    ),
                  )
                : controller.getPaymentPlans.value.packagesList == null
                    ? Center(
                        child: Text(
                        "No Payment Plan Found",
                        style: AppTextStyles.formalTextStyle(),
                      ))
                    : controller.getPaymentPlans.value.packagesList!.isEmpty
                        ? Center(
                            child: Text(
                            "No Payment Plan Found",
                            style: AppTextStyles.formalTextStyle(),
                          ))
                        : Column(
                            children: [
                              Expanded(
                                child: ListView.builder(
                                  itemCount: controller.getPaymentPlans.value
                                      .packagesList!.length,
                                  itemBuilder: (context, index) {
                                    PackagesList paymentPlanModel = controller
                                        .getPaymentPlans
                                        .value
                                        .packagesList![index];
                                    return Stack(
                                      children: [
                                        Obx(
                                          () => Padding(
                                            padding: EdgeInsets.symmetric(
                                                horizontal: width * 0.072,
                                                vertical: height * 0.02),
                                            child: Container(
                                              padding: EdgeInsets.all(controller
                                                          .selectedIndex
                                                          .value ==
                                                      index
                                                  ? min(width, height) * 0.008
                                                  : min(width, height) * 0.001),
                                              decoration: BoxDecoration(
                                                gradient:
                                                    LinearGradient(colors: [
                                                  AppColors.buttonColor,
                                                  controller.selectedIndex
                                                              .value ==
                                                          index
                                                      ? const Color(0xffD4EFFB)
                                                      : AppColors.buttonColor,
                                                ]),
                                                borderRadius:
                                                    BorderRadius.circular(15),
                                              ),
                                              child: Container(
                                                decoration: BoxDecoration(
                                                  color: Colors.white,
                                                  borderRadius:
                                                      BorderRadius.circular(15),
                                                  boxShadow: controller
                                                              .selectedIndex
                                                              .value ==
                                                          index
                                                      ? [
                                                          const BoxShadow(
                                                            color: Color(
                                                                0x3F4E4E4E),
                                                            blurRadius: 12,
                                                            offset:
                                                                Offset(4, 4),
                                                            spreadRadius: 0,
                                                          )
                                                        ]
                                                      : null,
                                                ),
                                                child: InkWell(
                                                  onTap: () {
                                                    controller.selectedIndex
                                                        .value = index;
                                                  },
                                                  borderRadius:
                                                      BorderRadius.circular(15),
                                                  child: Padding(
                                                    padding:
                                                        EdgeInsets.symmetric(
                                                            vertical:
                                                                height * 0.025,
                                                            horizontal:
                                                                width * 0.04),
                                                    child: Column(
                                                      children: [
                                                        Align(
                                                          alignment: Alignment
                                                              .centerRight,
                                                          child: Container(
                                                            decoration:
                                                                BoxDecoration(
                                                              color: const Color(
                                                                  0xfff40725),
                                                              borderRadius:
                                                                  BorderRadius
                                                                      .circular(
                                                                          50),
                                                            ),
                                                            child: Padding(
                                                              padding:
                                                                  const EdgeInsets
                                                                      .all(5.0),
                                                              child: Text(
                                                                "${paymentPlanModel.discountPercent}%",
                                                                style: const TextStyle(
                                                                    color: AppColors
                                                                        .white,
                                                                    fontSize:
                                                                        15,
                                                                    fontFamily:
                                                                        AppTextStyles
                                                                            .fontFamily,
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .bold),
                                                              ),
                                                            ),
                                                          ),
                                                        ),
                                                        SizedBox(
                                                          height: height * 0.01,
                                                        ),
                                                        Row(
                                                          mainAxisAlignment:
                                                              MainAxisAlignment
                                                                  .spaceBetween,
                                                          children: [
                                                            Text(
                                                              paymentPlanModel
                                                                      .title ??
                                                                  "Plan",
                                                              style: AppTextStyles
                                                                  .formalTextStyle(
                                                                color: AppColors
                                                                    .buttonColor,
                                                                fontSize: 15,
                                                              ),
                                                            ),
                                                            Row(
                                                              children: [
                                                                Text(
                                                                  "\$${paymentPlanModel.discountPrice}",
                                                                  style: AppTextStyles
                                                                      .formalTextStyle(
                                                                    color: AppColors
                                                                        .buttonColor,
                                                                    fontSize:
                                                                        15,
                                                                  ),
                                                                ),
                                                                Text(
                                                                  controller.getPaymentPlans.value
                                                                              .discount! ==
                                                                          0
                                                                      ? ""
                                                                      : "/ ",
                                                                  style: AppTextStyles
                                                                      .formalTextStyle(
                                                                    color: AppColors
                                                                        .buttonColor,
                                                                    fontSize:
                                                                        15,
                                                                  ),
                                                                ),
                                                                Text(
                                                                  "\$${paymentPlanModel.price}",
                                                                  style: TextStyle(
                                                                      color: AppColors
                                                                          .black,
                                                                      fontSize:
                                                                          15,
                                                                      fontFamily:
                                                                          AppTextStyles
                                                                              .fontFamily,
                                                                      decoration: controller.getPaymentPlans.value.discount! ==
                                                                              0
                                                                          ? null
                                                                          : TextDecoration
                                                                              .lineThrough),
                                                                ),
                                                              ],
                                                            )
                                                          ],
                                                        ),
                                                        SizedBox(
                                                          height:
                                                              height * 0.015,
                                                        ),
                                                        Container(
                                                          decoration:
                                                              ShapeDecoration(
                                                            shape:
                                                                RoundedRectangleBorder(
                                                              side: BorderSide(
                                                                width: 1,
                                                                strokeAlign:
                                                                    BorderSide
                                                                        .strokeAlignCenter,
                                                                color: AppColors
                                                                    .buttonColor
                                                                    .withOpacity(
                                                                        0.2),
                                                              ),
                                                            ),
                                                          ),
                                                        ),
                                                        SizedBox(
                                                          height:
                                                              height * 0.015,
                                                        ),
                                                        Text(
                                                          paymentPlanModel
                                                                  .description ??
                                                              "Detail",
                                                          style: AppTextStyles
                                                              .formalTextStyle(),
                                                        )
                                                      ],
                                                    ),
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ),
                                        ),
                                        index == 1
                                            ? Positioned(
                                                top: height * 0.05,
                                                left: width * 0.04,
                                                child: Transform(
                                                  transform: Matrix4.identity()
                                                    ..translate(0.0, 0.0)
                                                    ..rotateZ(-0.57),
                                                  child: Container(
                                                    width: 66.23,
                                                    height: 16.39,
                                                    decoration: ShapeDecoration(
                                                      color: const Color(
                                                          0xFFF4FBFF),
                                                      shape:
                                                          RoundedRectangleBorder(
                                                        side: BorderSide(
                                                            width: 0.77,
                                                            color: AppColors
                                                                .buttonColor),
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(4.51),
                                                      ),
                                                    ),
                                                    child: Center(
                                                      child: AutoSizeText(
                                                        'Recommended',
                                                        minFontSize: 4,
                                                        maxLines: 1,
                                                        style: AppTextStyles
                                                            .formalTextStyle(
                                                          color: AppColors
                                                              .buttonColor,
                                                          fontSize: 8.49,
                                                        ),
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                              )
                                            : const SizedBox.shrink()
                                      ],
                                    );
                                  },
                                ),
                              ),
                              SizedBox(
                                height: height * 0.05,
                              ),
                              CustomLargeButton(
                                height: height,
                                width: width * 0.6,
                                text: "Subscribe",
                                onPressed: () {
                                  Get.to(
                                    () => PaymentConfirmationPage(
                                      paymentPlanModel: controller
                                              .getPaymentPlans
                                              .value
                                              .packagesList![
                                          controller.selectedIndex.value],
                                      userId: controller
                                          .getPaymentPlans.value.user!.id!,
                                      legacyPlan: controller.getPaymentPlans
                                              .value.packagesList![
                                          controller.getPaymentPlans.value
                                              .packagesList!
                                              .indexWhere(
                                        (element) => element.title == "Legacy",
                                      )],
                                      discount: controller
                                              .getPaymentPlans.value.discount ??
                                          0,
                                    ),
                                    binding: PaymentConfirmationBinding(),
                                  );
                                },
                              ),
                              SizedBox(
                                height: height * 0.05,
                              ),
                            ],
                          ),
          ),
        ),
      ),
    );
  }
}
