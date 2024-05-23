// import 'package:auto_size_text/auto_size_text.dart';
// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:intl/intl.dart';
// import 'package:stop_watch_timer/stop_watch_timer.dart';
// import 'package:weight_loss_app/common/app_text_styles.dart';
// import 'package:weight_loss_app/modules/payment_integration/payment_page/binding/payment_page_binding.dart';
// import 'package:weight_loss_app/modules/payment_integration/payment_page/model/payment_success_detail.dart';
// import 'package:weight_loss_app/modules/payment_integration/payment_page/view/payment_Page.dart';
// import 'package:weight_loss_app/modules/payment_integration/payment_page_discount/controller/payment_discount_controller.dart';
// import 'package:weight_loss_app/modules/payment_integration/payment_page_discount/widgets/show_bottom_sheet_container.dart';
// import 'package:weight_loss_app/utils/internet_check_widget.dart';
// import 'package:weight_loss_app/widgets/custom_large_button.dart';

// import '../../../../common/app_colors.dart';
// import '../../../../common/app_texts.dart';

// class PaymentDiscountPage extends GetView<PaymentDiscountController> {
//   const PaymentDiscountPage({
//     super.key,
//   });

//   @override
//   Widget build(BuildContext context) {
//     var size = MediaQuery.sizeOf(context);
//     double height = size.height - kToolbarHeight;
//     double width = size.width;
//     return Scaffold(
//       appBar: AppBar(
//         title: Obx(() => AutoSizeText(
//               '${controller.userName.value.split(" ")[0]}, Be fitter, happier, healthier and ${controller.currentWeight.value - controller.targetWeight.value} ${controller.weightUnit.value}s lighter by:',
//               textAlign: TextAlign.start,
//               style: AppTextStyles.formalTextStyle(
//                 color: const Color(0xFF434343),
//                 fontSize: 24,
//               ),
//               minFontSize: 10,
//               maxLines: 3,
//             )),
//         toolbarHeight: height * 0.15,
//         centerTitle: false,
//       ),
//       body: SafeArea(
//         child: InternetCheckWidget<ConnectivityService>(
//           child: Obx(
//             () => Center(
//               child: Column(
//                 children: [
//                   Container(
//                     width: width * 0.9,
//                     decoration: BoxDecoration(
//                       borderRadius: BorderRadius.circular(10),
//                       color: Colors.white,
//                       boxShadow: [
//                         BoxShadow(
//                           color: Colors.grey.shade300,
//                           blurRadius: 6.0, // soften the shadow
//                           spreadRadius: 1.0, //extend the shadow
//                           offset: const Offset(
//                             0.0,
//                             3.0,
//                           ),
//                         )
//                       ],
//                     ),
//                     child: Padding(
//                       padding: EdgeInsets.symmetric(vertical: height * 0.02),
//                       child: Center(
//                         child: Text(
//                           DateFormat('MMMM dd, y').format(
//                             controller.expectedDate(
//                                 targetWeight: controller.targetWeight.value,
//                                 currentWeight: controller.currentWeight.value,
//                                 weightUnit: controller.weightUnit.value),
//                           ),
//                           style: TextStyle(
//                             color: AppColors.buttonColor,
//                             fontSize: 24,
//                             fontFamily: AppTextStyles.fontFamily,
//                             fontWeight: FontWeight.w700,
//                           ),
//                         ),
//                       ),
//                     ),
//                   ),
//                   Padding(
//                     padding: EdgeInsets.symmetric(
//                         horizontal: width * 0.05, vertical: height * 0.02),
//                     child: AutoSizeText.rich(
//                       TextSpan(
//                         children: [
//                           TextSpan(
//                             text: controller.userName.value.split(" ")[0],
//                             style: AppTextStyles.formalTextStyle(
//                               color: const Color(0xFF1E1E1E),
//                               fontSize: 21,
//                               fontWeight: FontWeight.w600,
//                             ),
//                           ),
//                           TextSpan(
//                             text:
//                                 ', Take this one time personalized offer in next 10 minutes.',
//                             style: AppTextStyles.formalTextStyle(
//                               color: const Color(0xFF1E1E1E),
//                               fontSize: 18,
//                               fontWeight: FontWeight.w600,
//                             ),
//                           ),
//                         ],
//                       ),
//                       maxLines: 2,
//                       minFontSize: 10,
//                       textAlign: TextAlign.center,
//                     ),
//                   ),
//                   Expanded(
//                     child: controller.isLoading.value
//                         ? Center(
//                             child: CircularProgressIndicator(
//                               color: AppColors.buttonColor,
//                             ),
//                           )
//                         : controller.getPaymentPlan.value.packages!.price == 0.0
//                             ? Center(
//                                 child: Text(
//                                   "Unable to Connect",
//                                   style: AppTextStyles.formalTextStyle(),
//                                 ),
//                               )
//                             : SingleChildScrollView(
//                                 child: Column(
//                                   children: [
//                                     SizedBox(
//                                       width: width * 0.55,
//                                       height: height * 0.25,
//                                       child: Material(
//                                         elevation: 8,
//                                         borderRadius: BorderRadius.circular(30),
//                                         child: Column(
//                                           mainAxisAlignment:
//                                               MainAxisAlignment.spaceEvenly,
//                                           children: [
//                                             Container(
//                                               height: height * 0.045,
//                                               width: width * 0.24,
//                                               decoration: BoxDecoration(
//                                                   color: AppColors.buttonColor,
//                                                   borderRadius:
//                                                       BorderRadius.circular(8)),
//                                               child: Center(
//                                                 child: Text(
//                                                   "${calculateDiscountPercentage(controller.planPriceCalculation(controller.getPaymentPlan.value.packages!.price!), discountCalculation(controller.planPriceCalculation(controller.getPaymentPlan.value.packages!.price!), controller.getPaymentPlan.value.discount!)).round()}% Off",
//                                                   style: const TextStyle(
//                                                     color: Colors.white,
//                                                     fontSize: 17,
//                                                     fontFamily: AppTextStyles
//                                                         .fontFamily,
//                                                     fontWeight: FontWeight.w700,
//                                                   ),
//                                                 ),
//                                               ),
//                                             ),
//                                             Text(
//                                               'Special Discount',
//                                               style:
//                                                   AppTextStyles.formalTextStyle(
//                                                 fontSize: 18,
//                                               ),
//                                             ),
//                                             AutoSizeText(
//                                               "\$${discountCalculation(controller.planPriceCalculation(controller.getPaymentPlan.value.packages!.price!), controller.getPaymentPlan.value.discount!).toStringAsFixed(2)}",
//                                               style:
//                                                   AppTextStyles.formalTextStyle(
//                                                 color: AppColors.buttonColor,
//                                                 fontSize: 49,
//                                                 fontWeight: FontWeight.w700,
//                                               ),
//                                               maxLines: 1,
//                                             ),
//                                           ],
//                                         ),
//                                       ),
//                                     ),
//                                     SizedBox(
//                                       height: height * 0.03,
//                                     ),
//                                     Container(
//                                       height: height * 0.13,
//                                       width: width * 0.67,
//                                       decoration: BoxDecoration(
//                                         borderRadius: BorderRadius.circular(15),
//                                         color: Colors.white,
//                                         boxShadow: [
//                                           BoxShadow(
//                                             color: Colors.grey.shade300,
//                                             blurRadius:
//                                                 6.0, // soften the shadow
//                                             spreadRadius:
//                                                 1.0, //extend the shadow
//                                             offset: const Offset(
//                                               0.0, // Move to right 5  horizontally
//                                               2.0, // Move to bottom 5 Vertically
//                                             ),
//                                           )
//                                         ],
//                                       ),
//                                       child: Column(children: [
//                                         Expanded(
//                                           flex: 2,
//                                           child: Row(
//                                             mainAxisAlignment:
//                                                 MainAxisAlignment.center,
//                                             children: [
//                                               const Text('Hours',
//                                                   style: AppTextStyles
//                                                       .discountPaymentTimerTitle),
//                                               SizedBox(
//                                                 width: width * 0.03,
//                                               ),
//                                               const Text('Minutes',
//                                                   style: AppTextStyles
//                                                       .discountPaymentTimerTitle),
//                                               SizedBox(
//                                                 width: width * 0.03,
//                                               ),
//                                               const Text('Seconds',
//                                                   style: AppTextStyles
//                                                       .discountPaymentTimerTitle)
//                                             ],
//                                           ),
//                                         ),
//                                         Expanded(
//                                           flex: 3,
//                                           child: StreamBuilder<int>(
//                                             stream: controller
//                                                 .stopWatchTimer.rawTime,
//                                             initialData: controller
//                                                 .stopWatchTimer.rawTime.value,
//                                             builder: (context, snap) {
//                                               final value = snap.data!;
//                                               final displayTime =
//                                                   StopWatchTimer.getDisplayTime(
//                                                       value,
//                                                       milliSecond: false);
//                                               return Column(
//                                                 children: <Widget>[
//                                                   Text(
//                                                     displayTime,
//                                                     style: const TextStyle(
//                                                         fontSize: 40,
//                                                         fontFamily: 'Poppins',
//                                                         color: AppColors
//                                                             .abstractionTextColor,
//                                                         fontWeight:
//                                                             FontWeight.bold),
//                                                   )
//                                                 ],
//                                               );
//                                             },
//                                           ),
//                                         ),
//                                       ]),
//                                     ),
//                                     SizedBox(
//                                       height: height * 0.02,
//                                     ),
//                                     Text(
//                                       '*All premium features included',
//                                       textAlign: TextAlign.center,
//                                       style: AppTextStyles.formalTextStyle(
//                                         fontSize: 12,
//                                       ),
//                                     ),
//                                     SizedBox(
//                                       height: height * 0.02,
//                                     ),
//                                     Text(
//                                       'Or',
//                                       textAlign: TextAlign.center,
//                                       style: AppTextStyles.formalTextStyle(
//                                         color: AppColors.buttonColor,
//                                         fontSize: 12,
//                                       ),
//                                     ),
//                                     controller.isLogin!
//                                         ? TextButton(
//                                             onPressed: () {
//                                               showModalBottomSheet(
//                                                 context: context,
//                                                 builder: (context) {
//                                                   return ShowBottomSheetContainer(
//                                                     userId: controller
//                                                         .getPaymentPlan
//                                                         .value
//                                                         .user!
//                                                         .id!,
//                                                     packageId: controller
//                                                         .getPaymentPlan
//                                                         .value
//                                                         .packages!
//                                                         .id!,
//                                                     controller: controller,
//                                                   );
//                                                 },
//                                               );
//                                             },
//                                             child: Text(
//                                               'Pick a 7 days trial?',
//                                               style:
//                                                   AppTextStyles.formalTextStyle(
//                                                 color: AppColors.buttonColor,
//                                                 fontSize: 15,
//                                               ),
//                                             ),
//                                           )
//                                         : const SizedBox.shrink(),
//                                     SizedBox(
//                                       height: height * 0.02,
//                                     ),
//                                     CustomLargeButton(
//                                       text:
//                                           AppTexts.paymentDiscountPageContinue,
//                                       height: height,
//                                       width: width * 0.5,
//                                       onPressed: () async {
//                                         controller.stopWatchTimer.onStopTimer();
//                                         await Get.to(
//                                             () => PaymentPage(
//                                                 postPaymentModel:
//                                                     PostPaymentModel(
//                                                         packageId: controller
//                                                             .getPaymentPlan
//                                                             .value
//                                                             .packages!
//                                                             .id!,
//                                                         amount: discountCalculation(
//                                                             controller.planPriceCalculation(controller
//                                                                 .getPaymentPlan
//                                                                 .value
//                                                                 .packages!
//                                                                 .price!),
//                                                             controller
//                                                                 .getPaymentPlan
//                                                                 .value
//                                                                 .discount!),
//                                                         discount: calculateDiscountPercentage(controller.planPriceCalculation(controller.getPaymentPlan.value.packages!.price!), discountCalculation(controller.planPriceCalculation(controller.getPaymentPlan.value.packages!.price!), controller.getPaymentPlan.value.discount!))
//                                                             .roundToDouble(),
//                                                         discountPrice:
//                                                             (controller.planPriceCalculation(controller.getPaymentPlan.value.packages!.price!) - discountCalculation(controller.planPriceCalculation(controller.getPaymentPlan.value.packages!.price!), controller.getPaymentPlan.value.discount!))
//                                                                 .roundToDouble(),
//                                                         totalAmount: controller
//                                                             .planPriceCalculation(
//                                                                 controller.getPaymentPlan.value.packages!.price!)
//                                                             .roundToDouble(),
//                                                         status: "paid",
//                                                         duration: controller.daysToLoseWeight(
//                                                           currentWeight: controller
//                                                                       .weightUnit
//                                                                       .value ==
//                                                                   "kg"
//                                                               ? controller
//                                                                       .currentWeight
//                                                                       .value *
//                                                                   2.2
//                                                               : controller
//                                                                   .currentWeight
//                                                                   .value,
//                                                           goalWeight: controller
//                                                                       .weightUnit
//                                                                       .value ==
//                                                                   "kg"
//                                                               ? controller
//                                                                       .targetWeight
//                                                                       .value *
//                                                                   2.2
//                                                               : controller
//                                                                   .targetWeight
//                                                                   .value,
//                                                           weightPerWeek: 1.5,
//                                                         )),
//                                                 userId: controller.getPaymentPlan.value.user!.id!),
//                                             binding: PaymentPageBinding());
//                                         controller.stopWatchTimer
//                                             .onStartTimer();
//                                       },
//                                     ),
//                                   ],
//                                 ),
//                               ),
//                   ),
//                 ],
//               ),
//             ),
//           ),
//         ),
//       ),
//     );
//   }

//   double discountCalculation(double price, double discount) {
//     double discounted = (price / 100) * discount;
//     double discountedPrice = price - discounted;
//     return discountedPrice > 99.99
//         ? 99.99
//         : discountedPrice < 49.99
//             ? 49.99
//             : discountedPrice;
//   }

//   double calculateDiscountPercentage(
//       double originalPrice, double discountedPrice) {
//     // Calculate the difference between original and discounted price
//     double priceDifference = originalPrice - discountedPrice;

//     // Calculate the discount percentage
//     double discountPercentage = (priceDifference / originalPrice) * 100;

//     return discountPercentage;
//   }
// }
