import 'dart:math';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:weight_loss_app/common/app_colors.dart';
import 'package:weight_loss_app/common/app_text_styles.dart';
import 'package:weight_loss_app/modules/payment_integration/payment_confirmation/controller/payment_confirmation_controller.dart';
import 'package:weight_loss_app/modules/payment_integration/payment_method/binding/payment_method_binding.dart';
import 'package:weight_loss_app/modules/payment_integration/payment_method/payment_method_page/payment_method_page.dart';
import 'package:weight_loss_app/modules/payment_integration/payment_page/model/payment_success_detail.dart';
import 'package:weight_loss_app/modules/payment_integration/payment_plans/models/payment_plans_model.dart';
import 'package:weight_loss_app/widgets/custom_large_button.dart';

class PaymentConfirmationPage extends GetView<PaymentConfirmationController> {
  const PaymentConfirmationPage({
    super.key,
    required this.paymentPlanModel,
    required this.legacyPlan,
    required this.userId,
    required this.discount,
  });
  final PackagesList paymentPlanModel;
  final PackagesList legacyPlan;
  final String userId;
  final int discount;
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
          "Confirmation",
          style: Theme.of(context).appBarTheme.titleTextStyle,
        ),
        centerTitle: true,
      ),
      body: SafeArea(
        child: Column(
          children: [
            Padding(
              padding: EdgeInsets.symmetric(
                  horizontal: width * 0.072, vertical: height * 0.02),
              child: Container(
                padding: EdgeInsets.all(min(width, height) * 0.008),
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [
                      AppColors.buttonColor,
                      const Color(0xffD4EFFB),
                    ],
                  ),
                  borderRadius: BorderRadius.circular(15),
                ),
                child: Container(
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(15),
                    boxShadow: const [
                      BoxShadow(
                        color: Color(0x3F4E4E4E),
                        blurRadius: 12,
                        offset: Offset(4, 4),
                        spreadRadius: 0,
                      )
                    ],
                  ),
                  child: Padding(
                    padding: EdgeInsets.symmetric(
                        vertical: height * 0.025, horizontal: width * 0.04),
                    child: Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              paymentPlanModel.title ?? "Plan Name",
                              style: AppTextStyles.formalTextStyle(
                                color: AppColors.buttonColor,
                                fontSize: 15,
                              ),
                            ),
                            Text(
                              "\$${paymentPlanModel.discountPrice}",
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
                                strokeAlign: BorderSide.strokeAlignCenter,
                                color: AppColors.buttonColor.withOpacity(0.2),
                              ),
                            ),
                          ),
                        ),
                        SizedBox(
                          height: height * 0.015,
                        ),
                        Text(
                          paymentPlanModel.description ?? "Detail",
                          style: AppTextStyles.formalTextStyle(),
                        )
                      ],
                    ),
                  ),
                ),
              ),
            ),
            SizedBox(
              height: height * 0.05,
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: width * 0.15),
              child: Text.rich(
                TextSpan(
                  children: [
                    TextSpan(
                      text:
                          "This is for your confirmation for you're purchasing ",
                      style: AppTextStyles.formalTextStyle(
                        color: const Color(0xFF3E3E3E),
                      ),
                    ),
                    TextSpan(
                      text:
                          '${paymentPlanModel.title} in \$${paymentPlanModel.discountPrice} with holding Tax.',
                      style: AppTextStyles.formalTextStyle(
                        color: const Color(0xFF3E3E3E),
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(
              height: height * 0.05,
            ),
            paymentPlanModel.title == legacyPlan.title
                ? const SizedBox.shrink()
                : Padding(
                    padding: EdgeInsets.symmetric(
                      horizontal: width * 0.1,
                    ),
                    child: Row(
                      children: [
                        Expanded(
                          flex: 7,
                          child: Text(
                            'Get ${legacyPlan.title} plan in just \$${legacyPlan.discountPrice}',
                            style: AppTextStyles.formalTextStyle(
                              color: AppColors.buttonColor,
                              fontSize: 15,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                        ),
                        SizedBox(
                          width: width * 0.05,
                        ),
                        Expanded(
                          flex: 2,
                          child: Container(
                            height: height * 0.02,
                            decoration:
                                const BoxDecoration(color: Color(0xFFEF6767)),
                            child: Center(
                              child: Text(
                                'Discounted',
                                style: AppTextStyles.formalTextStyle(
                                  color: Colors.white,
                                  fontSize: 8,
                                  fontWeight: FontWeight.w700,
                                ),
                              ),
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
            SizedBox(
              height: height * 0.05,
            ),
            Material(
              shape: RoundedRectangleBorder(
                side: BorderSide(
                  width: 1,
                  color: AppColors.buttonColor.withOpacity(0.2),
                ),
                borderRadius: BorderRadius.circular(12),
              ),
              color: AppColors.white,
              child: InkWell(
                onTap: () {
                  Get.back();
                },
                borderRadius: BorderRadius.circular(12),
                child: SizedBox(
                  width: width * 0.75,
                  height: height * 0.06,
                  child: Center(
                    child: Text(
                      'Change your plan',
                      style: AppTextStyles.formalTextStyle(
                        color: AppColors.buttonColor,
                        fontSize: 15,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ),
                ),
              ),
            ),
            SizedBox(
              height: height * 0.15,
            ),
            CustomLargeButton(
              height: height,
              width: width * 0.6,
              text: "Subscribe",
              onPressed: () {
                print("-----------${(paymentPlanModel.discountPrice!)}");
                Get.to(
                  () => PaymentMethodPage(
                    postPaymentModel: PostPaymentModel(
                        packageId: paymentPlanModel.id!,
                        amount: paymentPlanModel.discountPrice!,
                        discount: discount.toDouble(),
                        discountPrice: (paymentPlanModel.price! / 100) *
                            discount.toDouble(),
                        totalAmount: paymentPlanModel.price!,
                        status: "paid",
                        duration: paymentPlanModel.duration!),
                    userId: userId,
                  ),
                  binding: PaymentMethodBinding(),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
