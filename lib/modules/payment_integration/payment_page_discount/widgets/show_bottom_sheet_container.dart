import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:weight_loss_app/modules/payment_integration/payment_page/binding/payment_page_binding.dart';
import 'package:weight_loss_app/modules/payment_integration/payment_page/model/payment_success_detail.dart';
import 'package:weight_loss_app/modules/payment_integration/payment_page/view/payment_Page.dart';
import 'package:weight_loss_app/modules/payment_integration/payment_page_discount/controller/payment_discount_controller.dart';

import '../../../../common/app_colors.dart';

class ShowBottomSheetContainer extends StatelessWidget {
  const ShowBottomSheetContainer(
      {super.key,
      required this.userId,
      required this.packageId,
      required this.controller});
  final String userId;
  final int packageId;
  final PaymentDiscountController controller;
  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    return Container(
      height: height * 0.35,
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(15),
      ),
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            const Text(
              'Pay what you think is fair',
              style: TextStyle(
                color: Colors.black,
                fontSize: 12,
                fontFamily: 'Poppins',
                fontWeight: FontWeight.w700,
              ),
            ),
            SizedBox(
              height: height * 0.18,
              child: Stack(
                children: [
                  Positioned(
                    top: height * 0.03,
                    left: width * 0.05,
                    child: Container(
                      height: height * 0.15,
                      width: width * 0.9,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        border: Border.all(
                            color: AppColors.understandWidgetBorderColor,
                            width: width * 0.002),
                      ),
                      child: Center(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            const SizedBox(
                              height: 15,
                            ),
                            Obx(
                              () => Text(
                                '\$${controller.dubValue.value.toInt()}',
                                style: TextStyle(
                                  color: AppColors.buttonColor,
                                  fontSize: 19,
                                  fontFamily: 'Poppins',
                                  fontWeight: FontWeight.w700,
                                ),
                              ),
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                const Text(
                                  'Lower ',
                                  style: TextStyle(
                                    color: Color(0xFF434343),
                                    fontSize: 9,
                                    fontFamily: 'Poppins',
                                    fontWeight: FontWeight.w400,
                                  ),
                                ),
                                SizedBox(
                                  width: 200,
                                  child: Obx(() {
                                    return SliderTheme(
                                      data: SliderTheme.of(context).copyWith(
                                        trackHeight: 2,
                                        thumbShape: const RoundSliderThumbShape(
                                            enabledThumbRadius: 7.0),
                                        // You can adjust the enabledThumbRadius value to change thumb size
                                      ),
                                      child: Slider(
                                        activeColor: Colors.black,
                                        inactiveColor: Colors.grey.shade300,
                                        divisions: 6,
                                        mouseCursor: MouseCursor.defer,
                                        value: controller.dubValue.value,
                                        onChanged: controller.updateValue,
                                        min: 1.0,
                                        max: 7.0,
                                      ),
                                    );
                                  }),
                                ),
                                const Text(
                                  'Higher',
                                  style: TextStyle(
                                    color: Color(0xFF434343),
                                    fontSize: 9,
                                    fontFamily: 'Poppins',
                                    fontWeight: FontWeight.w400,
                                  ),
                                )
                              ],
                            )
                          ],
                        ),
                      ),
                    ),
                  ),
                  Positioned(
                    top: height * 0.02,
                    left: width * 0.27,
                    child: Container(
                      height: height * 0.04,
                      width: width * 0.45,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(30),
                        color: Colors.white,
                        border: Border.all(
                            color: AppColors.understandWidgetBorderColor,
                            width: width * 0.002),
                      ),
                      child: const Center(
                        child: Text(
                          'Most people pick \$7',
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 10,
                            fontFamily: 'Poppins',
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Container(
              height: height * 0.03,
              width: width * 0.45,
              color: AppColors.paymentBottomSheetColor,
              child: const Center(
                child: Text(
                  '7 days trial, cancel anytime',
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 9,
                    fontFamily: 'Poppins',
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ),
            ),
            GestureDetector(
              onTap: () {
                Get.back();
                Get.to(
                  () => PaymentPage(
                    postPaymentModel: PostPaymentModel(
                      packageId: packageId,
                      amount: controller.dubValue.value,
                      discount: 0.0,
                      discountPrice: 0.0,
                      totalAmount: controller.dubValue.value,
                      status: "trial",
                      duration: 7,
                    ),
                    userId: userId,
                  ),
                  binding: PaymentPageBinding(),
                );
              },
              child: Container(
                height: height * 0.05,
                width: width * 0.6,
                decoration: BoxDecoration(
                    color: AppColors.buttonColor,
                    borderRadius: BorderRadius.circular(8)),
                child: const Center(
                  child: Text(
                    'Continue',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 17,
                      fontFamily: 'Poppins',
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
