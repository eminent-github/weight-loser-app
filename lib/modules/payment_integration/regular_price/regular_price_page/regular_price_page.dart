import 'dart:developer';
import 'dart:io';

import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:lottie/lottie.dart';
import 'package:weight_loss_app/common/app_assets.dart';
import 'package:weight_loss_app/common/app_colors.dart';
import 'package:weight_loss_app/common/app_text_styles.dart';
import 'package:weight_loss_app/controllers/purchase_api_controller.dart';
import 'package:weight_loss_app/modules/payment_integration/monthly_plan/binding/monthly_plan_binding.dart';
import 'package:weight_loss_app/modules/payment_integration/monthly_plan/monthly_plan_page/monthly_plan_page.dart';
import 'package:weight_loss_app/modules/payment_integration/regular_price/controller/regular_price_controller.dart';
import 'package:weight_loss_app/modules/registeration_questions/widgets/qus_next_button.dart';

class RegularPricePage extends StatefulWidget {
  const RegularPricePage({super.key, required this.isLogin});
  final bool isLogin;

  @override
  State<RegularPricePage> createState() => _RegularPricePageState();
}

class _RegularPricePageState extends State<RegularPricePage> {
  final ScrollController scrollController = ScrollController();
  final RegularPriceController controller = Get.find();

  final PurchaseApiController purchaseApiController =
      Get.put(PurchaseApiController());

  @override
  void initState() {
    purchaseApiController.init();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.sizeOf(context);
    double height = size.height - kToolbarHeight;
    double width = size.width;
    print(width * 0.6);
    print(height * 0.22);

    return Scaffold(
      body: Obx(
        () => Stack(
          children: [
            SafeArea(
              child: SingleChildScrollView(
                controller: scrollController,
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
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: width * 0.05),
                      child: SizedBox(
                        width: width,
                        height: height * 0.15,
                        child: Material(
                          elevation: 8,
                          borderRadius: BorderRadius.circular(15),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              Text(
                                DateFormat('MMMM dd, y').format(
                                  controller.expectedDate(
                                      targetWeight:
                                          controller.targetWeight.value,
                                      currentWeight:
                                          controller.currentWeight.value,
                                      weightUnit: controller.weightUnit.value),
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
                                                      targetWeight: controller
                                                          .targetWeight.value,
                                                      currentWeight: controller
                                                          .currentWeight.value,
                                                      weightUnit: controller
                                                          .weightUnit.value)
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
                                        decoration: TextDecoration.underline,
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
                                            targetWeight:
                                                controller.targetWeight.value,
                                            currentWeight:
                                                controller.currentWeight.value,
                                            weightUnit:
                                                controller.weightUnit.value),
                                      ),
                                      style: const TextStyle(
                                        color: Colors.black,
                                        fontSize: 15,
                                        fontFamily: 'Poppins',
                                        fontWeight: FontWeight.bold,
                                        decoration: TextDecoration.underline,
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
                    // controller.isLoading.value
                    //     ? const Center(
                    //         child: CircularProgressIndicator.adaptive(),
                    //       )
                    //     :
                    controller.getPaymentPlans.isEmpty
                        ? Center(
                            child: Text(
                              "Loading...",
                              style: AppTextStyles.formalTextStyle(),
                            ),
                          )
                        : Padding(
                            padding:
                                EdgeInsets.symmetric(horizontal: width * 0.05),
                            child: Column(
                              children: [
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
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceEvenly,
                                          children: [
                                            Text(
                                              'Regular Price',
                                              style:
                                                  AppTextStyles.formalTextStyle(
                                                      fontSize: 18,
                                                      fontWeight:
                                                          FontWeight.bold),
                                            ),
                                            AutoSizeText(
                                              "\$${controller.planAccordingTOMonths().$1.price!.toStringAsFixed(2)}",
                                              style:
                                                  AppTextStyles.formalTextStyle(
                                                color: AppColors.buttonColor,
                                                fontSize: 49,
                                                fontWeight: FontWeight.w700,
                                              ),
                                              maxLines: 1,
                                            ),
                                          ],
                                        ),
                                        Lottie.asset(
                                          AppAssets.discountCrossUrl,
                                          repeat: false,
                                          fit: BoxFit.fill,
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                                SizedBox(
                                  height: height * 0.03,
                                ),
                                Text(
                                  '*All app premium features included',
                                  textAlign: TextAlign.center,
                                  style: AppTextStyles.formalTextStyle(
                                    fontSize: 12,
                                  ),
                                ),
                                SizedBox(
                                  height: height * 0.04,
                                ),

                                ///
                                ///
                                ///
                                ///
                                QusNextButton(
                                  height: height * 0.07,
                                  width: width * 0.5,
                                  callBack: () async {
                                    Get.to(
                                      () => MonthlyPlanPage(
                                        monthlyPackage: controller
                                            .planAccordingTOMonths()
                                            .$1,
                                        productId: controller
                                            .planAccordingTOMonths()
                                            .$2,
                                        isMonthly: false,
                                      ),
                                      binding: MonthlyPlanBinding(
                                        monthlyPackage: controller
                                            .planAccordingTOMonths()
                                            .$1,
                                      ),
                                    );
                                  },
                                  text: "Offer for you",
                                ),

                                ///
                                ///
                                ///
                                ///
                              ],
                            ),
                          ),
                    SizedBox(
                      height: height * 0.05,
                    ),
                    Stack(
                      children: [
                        Padding(
                          padding: EdgeInsets.only(top: height * 0.007),
                          child: Center(
                            child: Material(
                              color: AppColors.buttonColor,
                              borderRadius: BorderRadius.circular(6),
                              child: InkWell(
                                onTap: () {
                                  Get.to(
                                    () => MonthlyPlanPage(
                                      monthlyPackage: controller.getPaymentPlans
                                          .singleWhere(
                                              (element) => element.id == 1),
                                      productId: "wl_monthly_plan",
                                      isMonthly: true,
                                    ),
                                    binding: MonthlyPlanBinding(
                                      monthlyPackage: controller.getPaymentPlans
                                          .singleWhere(
                                              (element) => element.id == 1),
                                    ),
                                  );
                                },
                                borderRadius: BorderRadius.circular(6),
                                child: SizedBox(
                                  width: width * 0.75,
                                  // height: height * 0.07,

                                  child: Padding(
                                    padding: EdgeInsets.symmetric(
                                        vertical: height * 0.01,
                                        horizontal: width * 0.04),
                                    child: Column(
                                      children: [
                                        // controller.isLoading.value
                                        //     ? const SizedBox()
                                        //     :

                                        Text(
                                          (() {
                                            try {
                                              final plan = controller
                                                  .getPaymentPlans
                                                  .singleWhere((element) =>
                                                      element.id == 1);
                                              final discount =
                                                  plan.discountPercent?.toInt();
                                              if (discount != null) {
                                                return '$discount% Off';
                                              } else {
                                                return '';
                                              }
                                            } catch (e) {
                                              return '';
                                            }
                                          })(),
                                          style: AppTextStyles.formalTextStyle(
                                            color: const Color(0xFFF6F1F1),
                                            fontSize: 10,
                                            fontWeight: FontWeight.w700,
                                          ),
                                        ),
                                        // Text(
                                        //   '${controller.getPaymentPlans.singleWhere((element) => element.id == 1).discountPercent?.toInt()}% Off',
                                        //   style: AppTextStyles.formalTextStyle(
                                        //     color: const Color(0xFFF6F1F1),
                                        //     fontSize: 10,
                                        //     fontWeight: FontWeight.w700,
                                        //   ),
                                        // ),
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Text(
                                              'Get monthly plan for just',
                                              style:
                                                  AppTextStyles.formalTextStyle(
                                                color: Colors.white,
                                              ),
                                            ),
                                            // controller.isLoading.value
                                            //     ? const SizedBox()
                                            //     :
                                            Text(
                                              (() {
                                                try {
                                                  final plan = controller
                                                      .getPaymentPlans
                                                      .singleWhere((element) =>
                                                          element.id == 1);
                                                  final discountPrice =
                                                      plan.discountPrice;
                                                  if (discountPrice != null) {
                                                    return '\$$discountPrice';
                                                  } else {
                                                    return '';
                                                  }
                                                } catch (e) {
                                                  return '';
                                                }
                                              })(),
                                              style:
                                                  AppTextStyles.formalTextStyle(
                                                color: Colors.white,
                                                fontWeight: FontWeight.w700,
                                              ),
                                            ),

                                            // Text(
                                            //     '\$${controller.getPaymentPlans.singleWhere((element) => element.id == 1).discountPrice}',
                                            //     style: AppTextStyles
                                            //         .formalTextStyle(
                                            //       color: Colors.white,
                                            //       fontWeight: FontWeight.w700,
                                            //     ),
                                            //   )
                                          ],
                                        ),
                                        // controller.isLoading.value
                                        //     ? const SizedBox()
                                        //     :
                                        Align(
                                          alignment: Alignment.centerRight,
                                          child: Text(
                                            (() {
                                              try {
                                                final plan = controller
                                                    .getPaymentPlans
                                                    .singleWhere((element) =>
                                                        element.id == 1);
                                                final price = plan.price;
                                                if (price != null) {
                                                  return '\$$price';
                                                } else {
                                                  return '';
                                                }
                                              } catch (e) {
                                                return '';
                                              }
                                            })(),
                                            style: const TextStyle(
                                              color: Colors.white,
                                              fontSize: 10,
                                              fontFamily:
                                                  AppTextStyles.fontFamily,
                                              fontWeight: FontWeight.w400,
                                              decoration:
                                                  TextDecoration.lineThrough,
                                            ),
                                          ),

                                          // Text(
                                          //   '\$${controller.getPaymentPlans.singleWhere((element) => element.id == 1).price}',
                                          //   style: const TextStyle(
                                          //     color: Colors.white,
                                          //     fontSize: 10,
                                          //     fontFamily: AppTextStyles.fontFamily,
                                          //     fontWeight: FontWeight.w400,
                                          //     decoration:
                                          //         TextDecoration.lineThrough,
                                          //   ),
                                          // ),
                                        )
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                        Align(
                          alignment: Alignment.topCenter,
                          child: Container(
                            width: 55,
                            height: height * 0.015,
                            decoration: ShapeDecoration(
                              color: Colors.white,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(35),
                              ),
                              shadows: const [
                                BoxShadow(
                                  color: Color(0x3F000000),
                                  blurRadius: 4,
                                  offset: Offset(0, 0),
                                  spreadRadius: 0,
                                )
                              ],
                            ),
                            child: Center(
                              child: AutoSizeText(
                                'Per Month',
                                style: AppTextStyles.formalTextStyle(
                                  color: AppColors.buttonColor,
                                  fontSize: 8,
                                ),
                                maxLines: 1,
                                minFontSize: 2,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),

                    SizedBox(height: height * 0.01),

                    ///
                    /* -------------------------------------------------------------------------- */
                    /*                                Take a trial                                */
                    /* -------------------------------------------------------------------------- */
                    ///
                    TextButton(
                      onPressed: () async {
                        double discountPrice = controller
                                .planAccordingTOMonths()
                                .$1
                                .discountPrice ??
                            0;
                        bool packageFound = false;
                        for (var package in purchaseApiController.packages) {
                          String identifier = package.storeProduct.identifier;
                          String price =
                              package.storeProduct.price.toStringAsFixed(2);

                          if (discountPrice == double.parse(price)) {
                            switch (identifier) {
                              case "wl_monthly_plan_with_trial":
                              case "wl_3month_plan_with_trial":
                              case "wl_6month_plan_with_trial":
                              case "wl_yearly_plan_with_trial":
                                print("price === $price");
                                print("package == $package");

                                packageFound = true;
                                bool success = await purchaseApiController
                                    .purchasePackage(package: package);

                                if (success) {
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    const SnackBar(
                                      content: Text('Purchase successful!'),
                                    ),
                                  );
                                }
                                break; // Exit switch after finding the matching package identifier
                              default:
                                log("Identifier not in the specified list: $identifier");
                                break;
                            }
                          }
                        }

                        if (!packageFound) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                              content: Text(
                                  'No matching package found for the discount price.'),
                              backgroundColor: Colors.red,
                            ),
                          );
                        }
                      },
                      child: Text(
                        "Take a trial",
                        style: AppTextStyles.formalTextStyle(
                          color: AppColors.buttonColor,
                          fontSize: 16,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    ),

                    ////
                    ///
                    ///
                    ///
                    ///
                    ///
                    ///
                    // TextButton(
                    //   onPressed: () {
                    //     controller.isShowTrial.value = true;
                    //     Future.delayed(const Duration(milliseconds: 100),
                    //         () async {
                    //       await scrollController.animateTo(
                    //         scrollController.position.maxScrollExtent,
                    //         duration: const Duration(seconds: 1),
                    //         curve: Curves.easeInOut,
                    //       );
                    //     });
                    //   },
                    //   child: Text(
                    //     "Take a trial",
                    //     style: AppTextStyles.formalTextStyle(
                    //       color: AppColors.buttonColor,
                    //       fontSize: 16,
                    //       fontWeight: FontWeight.w700,
                    //     ),
                    //   ),
                    // ),

                    ///
                    ///
                    ///
                    // if (controller.isShowTrial.value)
                    //   Column(
                    //     children: [
                    //       Text(
                    //         'Choose a price for your weekly trial',
                    //         style: AppTextStyles.formalTextStyle(
                    //           color: AppColors.primaryColor,
                    //           fontWeight: FontWeight.bold,
                    //         ),
                    //       ),

                    //       ///
                    //       ///
                    //       ///
                    //       ///
                    //       Wrap(
                    //         children:
                    //             purchaseApiController.packages.map((package) {
                    //           // log("identifier === $package");
                    //           log("identifier === ${package.storeProduct.identifier}");
                    //           // log("price === ${package.storeProduct.priceString}");

                    //           if (package.packageType.name != "custom") {
                    //             return const SizedBox.shrink();
                    //           }

                    //           return Padding(
                    //             padding: const EdgeInsets.all(8.0),
                    //             child: GestureDetector(
                    //               onTap: () async {
                    //                 purchaseApiController.isLoading.value =
                    //                     true;

                    //                 print(
                    //                     "price === ${package.storeProduct.priceString}");

                    //                 await purchaseApiController
                    //                     .purchasePackage(package);

                    //                 ///

                    //                 purchaseApiController.isLoading.value =
                    //                     false;
                    //               },
                    //               child: SizedBox(
                    //                 width: width * 0.19,
                    //                 height: height * 0.09,
                    //                 child: Material(
                    //                   color: AppColors.buttonColor,
                    //                   borderRadius: BorderRadius.circular(6),
                    //                   child: Padding(
                    //                     padding: const EdgeInsets.all(8.0),
                    //                     child: Center(
                    //                       child: Text(
                    //                         controller
                    //                             .getCustomOfferNameByPrice(
                    //                           price: package
                    //                               .storeProduct.priceString,
                    //                         ),
                    //                         style:
                    //                             AppTextStyles.formalTextStyle(
                    //                           color: AppColors.white,
                    //                           fontWeight: FontWeight.bold,
                    //                         ),
                    //                       ),
                    //                     ),
                    //                   ),
                    //                 ),
                    //               ),
                    //             ),
                    //           );
                    //         }).toList(),
                    //       ),

                    //       SizedBox(height: height * 0.05),

                    //       ///
                    //       ///
                    //       ///
                    //     ],
                    //   ),

                    ///
                    ///
                    ///
                    ///
                  ],
                ),
              ),
            ),

            ///
            ///
            ///
            if (purchaseApiController.isLoading.value)
              SizedBox(
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.height,
                child: const Center(
                  child: CircularProgressIndicator.adaptive(),
                ),
              )
          ],
        ),
      ),
    );
  }
}
