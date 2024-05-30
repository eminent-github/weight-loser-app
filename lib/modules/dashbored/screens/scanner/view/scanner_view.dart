import 'dart:math';

import 'package:auto_size_text/auto_size_text.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:qr_mobile_vision/qr_camera.dart';
import 'package:weight_loss_app/common/app_assets.dart';
import 'package:weight_loss_app/common/app_colors.dart';
import 'package:weight_loss_app/common/app_text_styles.dart';
import 'package:weight_loss_app/common/app_texts.dart';
import 'package:weight_loss_app/modules/dashbored/screens/scanner/controller/scanner_controller.dart';
import 'package:weight_loss_app/modules/dashbored/screens/scanner/widgets/overlay_widget.dart';
import 'package:weight_loss_app/utils/internet_check_widget.dart';
import 'package:weight_loss_app/widgets/custom_large_button.dart';
import 'package:weight_loss_app/widgets/custom_snackbar.dart';
import 'package:weight_loss_app/widgets/overlay_widget.dart';
import 'package:weight_loss_app/widgets/progress_bar.dart';

class ScannerPage extends StatelessWidget {
  ScannerPage({super.key});
  final ScannerController controller = Get.put(ScannerController());
  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.sizeOf(context);
    double height = size.height - kBottomNavigationBarHeight;
    double width = size.width;
    return InternetCheckWidget<ConnectivityService>(
      child: Obx(
        () => Scaffold(
          appBar: AppBar(),
          body: Stack(
            children: [
              controller.scannedResult.value.isEmpty
                  ? Column(
                      children: [
                        Expanded(
                          child: Stack(
                            alignment: AlignmentDirectional.center,
                            children: [
                              SizedBox(
                                // height: height * 0.75,
                                width: width,
                                child: Center(
                                  child: controller.scanningStarted.value
                                      ? QrCamera(
                                          onError: (context, error) {
                                            print(controller
                                                .cameraPermissionStatus.value);
                                            if (controller
                                                .cameraPermissionStatus
                                                .value
                                                .isGranted) {
                                              return Padding(
                                                padding: EdgeInsets.symmetric(
                                                    horizontal: width * 0.05),
                                                child: Text(
                                                  error.toString(),
                                                  textAlign: TextAlign.center,
                                                  style: AppTextStyles
                                                      .formalTextStyle(
                                                          color: Colors.red),
                                                ),
                                              );
                                            } else {
                                              return Column(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.center,
                                                children: [
                                                  Padding(
                                                    padding:
                                                        EdgeInsets.symmetric(
                                                            horizontal:
                                                                width * 0.05),
                                                    child: Text(
                                                      "Camera Access Denied",
                                                      textAlign:
                                                          TextAlign.center,
                                                      style: AppTextStyles
                                                          .formalTextStyle(
                                                              color:
                                                                  Colors.red),
                                                    ),
                                                  ),
                                                  const SizedBox(
                                                    height: 3,
                                                  ),
                                                  Padding(
                                                    padding:
                                                        EdgeInsets.symmetric(
                                                            horizontal:
                                                                width * 0.05),
                                                    child: Text(
                                                      "Go to Settings > Weight Loser > Allow camera access",
                                                      textAlign:
                                                          TextAlign.center,
                                                      style: AppTextStyles
                                                          .formalTextStyle(
                                                              color:
                                                                  Colors.black),
                                                    ),
                                                  ),
                                                  const SizedBox(
                                                    height: 3,
                                                  ),
                                                  controller
                                                          .cameraPermissionStatus
                                                          .value
                                                          .isPermanentlyDenied
                                                      ? const SizedBox.shrink()
                                                      : TextButton(
                                                          onPressed: () async {
                                                            await Permission
                                                                .camera
                                                                .request();
                                                          },
                                                          child: Text(
                                                            "Click to request",
                                                            textAlign: TextAlign
                                                                .center,
                                                            style: AppTextStyles
                                                                .formalTextStyle(
                                                                    color: AppColors
                                                                        .buttonColor),
                                                          ))
                                                ],
                                              );
                                            }
                                          },
                                          notStartedBuilder: (context) =>
                                              const Center(
                                            child: CircularProgressIndicator(),
                                          ),
                                          offscreenBuilder: (context) =>
                                              const Text(
                                            'Off screen builder called',
                                          ),
                                          qrCodeCallback: (code) {
                                            if (code!.isNotEmpty) {
                                              controller.scannedResult.value =
                                                  code;
                                              controller.getScanFoodApi(code);
                                            }
                                          },
                                          child: Container(
                                            decoration: ShapeDecoration(
                                              shape: MyOverlayShape(
                                                borderColor: Colors.white,
                                                borderWidth: 10,
                                                overlayColor: Colors.black
                                                    .withOpacity(0.6),
                                                borderRadius: 15,
                                                borderLength: 40,
                                                cutOutSize: 270,
                                                cutOutBottomOffset: 0,
                                              ),
                                            ),
                                          ),
                                        )
                                      : Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: [
                                            Icon(
                                              Icons.qr_code_scanner_rounded,
                                              size: min(width, height) * 0.5,
                                              color: AppColors.blue,
                                            ),
                                            SizedBox(
                                              height: height * 0.03,
                                            ),
                                            Text(
                                              'Scan barcode of food item',
                                              style:
                                                  AppTextStyles.formalTextStyle(
                                                color: Theme.of(context)
                                                    .primaryTextTheme
                                                    .titleMedium!
                                                    .color!,
                                                fontSize: 24,
                                                fontWeight: FontWeight.w700,
                                              ),
                                            ),
                                            // SizedBox(
                                            //   height: height * 0.03,
                                            // ),
                                            Padding(
                                              padding: EdgeInsets.symmetric(
                                                  horizontal: width * 0.2),
                                              child: Text(
                                                'Your nutritional coach in your pocket',
                                                textAlign: TextAlign.center,
                                                style: AppTextStyles
                                                    .formalTextStyle(
                                                  color: Theme.of(context)
                                                      .primaryTextTheme
                                                      .titleMedium!
                                                      .color!,
                                                  fontSize: 18,
                                                ),
                                              ),
                                            )
                                          ],
                                        ),
                                ),
                              ),
                              Positioned(
                                bottom: height * 0.13,
                                child: Material(
                                  shape: const CircleBorder(),
                                  color: AppColors.buttonColor,
                                  elevation: 5,
                                  child: InkWell(
                                    onTap: () =>
                                        controller.controllerScanning(),
                                    borderRadius: BorderRadius.circular(50),
                                    child: SizedBox(
                                      height: height * 0.1,
                                      width: width * 0.2,
                                      child: Center(
                                        child: Text(
                                          controller.scanningStarted.value
                                              ? 'Stop'
                                              : 'Start',
                                          style: AppTextStyles.formalTextStyle(
                                              color: AppColors.white,
                                              fontSize: 16,
                                              fontWeight: FontWeight.bold),
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                              Positioned(
                                top: height * 0.08,
                                child: Text(
                                  "Scan Your Food",
                                  style: AppTextStyles.formalTextStyle(
                                      color: AppColors.white, fontSize: 18),
                                ),
                              ),
                            ],
                          ),
                        ),
                        // Expanded(
                        //   child: Row(
                        //     mainAxisAlignment: MainAxisAlignment.center,
                        //     children: [
                        //       CustomLargeButton(
                        //         height: height,
                        //         width: width * 0.7,
                        //         borderRadius: BorderRadius.circular(50),
                        //         text: controller.scanningStarted.value
                        //             ? 'Stop Scanning'
                        //             : 'Start Scanning',
                        //         onPressed: () => controller.controllerScanning(),
                        //       ),
                        //     ],
                        //   ),
                        // ),
                      ],
                    )
                  : controller.isLoading.value
                      ? Center(
                          child: CircularProgressIndicator(
                            color: AppColors.buttonColor,
                          ),
                        )
                      : controller.barcodeSearchedFoodModel.value.status == 0
                          ? Center(
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(
                                    "Product Not found",
                                    style: AppTextStyles.formalTextStyle(
                                      color: Theme.of(context)
                                          .primaryTextTheme
                                          .titleMedium!
                                          .color!,
                                    ),
                                  ),
                                  SizedBox(
                                    height: height * 0.03,
                                  ),
                                  SizedBox(
                                    height: height * 0.07,
                                    width: width * 0.2,
                                    child: MaterialButton(
                                      onPressed: () => controller.clearData(),
                                      // color: AppColors.blue,
                                      elevation: 5,
                                      shape: RoundedRectangleBorder(
                                        side: const BorderSide(
                                            width: 1.5, color: AppColors.blue),
                                        borderRadius: BorderRadius.circular(6),
                                      ),

                                      child: const Icon(
                                        Icons.refresh_outlined,
                                        color: AppColors.blue,
                                        size: 35,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            )
                          : Padding(
                              padding: EdgeInsets.symmetric(
                                  horizontal: width * 0.08),
                              child: controller.barcodeSearchedFoodModel.value
                                          .product!.nutriments ==
                                      null
                                  ? Center(
                                      child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          Text(
                                            "No Information Available for this Product",
                                            style:
                                                AppTextStyles.formalTextStyle(
                                              color: Theme.of(context)
                                                  .primaryTextTheme
                                                  .titleMedium!
                                                  .color!,
                                            ),
                                          ),
                                          SizedBox(
                                            height: height * 0.03,
                                          ),
                                          SizedBox(
                                            height: height * 0.07,
                                            width: width * 0.2,
                                            child: MaterialButton(
                                              onPressed: () =>
                                                  controller.clearData(),
                                              // color: AppColors.blue,
                                              elevation: 5,
                                              shape: RoundedRectangleBorder(
                                                side: const BorderSide(
                                                    width: 1.5,
                                                    color: AppColors.blue),
                                                borderRadius:
                                                    BorderRadius.circular(6),
                                              ),

                                              child: const Icon(
                                                Icons.refresh_outlined,
                                                color: AppColors.blue,
                                                size: 35,
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    )
                                  : Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        Container(
                                          width: width * 0.35,
                                          height: height * 0.18,
                                          decoration: ShapeDecoration(
                                            color: Colors.white,
                                            shape: RoundedRectangleBorder(
                                              borderRadius:
                                                  BorderRadius.circular(16),
                                            ),
                                            shadows: const [
                                              BoxShadow(
                                                color: Color(0x3F000000),
                                                blurRadius: 4,
                                                offset: Offset(0, 1),
                                                spreadRadius: 0,
                                              )
                                            ],
                                          ),
                                          child: ClipRRect(
                                            borderRadius:
                                                BorderRadius.circular(16),
                                            child: controller
                                                        .barcodeSearchedFoodModel
                                                        .value
                                                        .product!
                                                        .image ==
                                                    null
                                                ? const Center(
                                                    child: Icon(
                                                      Icons.image,
                                                      size: 50,
                                                    ),
                                                  )
                                                : CachedNetworkImage(
                                                    imageUrl: controller
                                                        .barcodeSearchedFoodModel
                                                        .value
                                                        .product!
                                                        .image!,
                                                    fit: BoxFit.fill,
                                                    placeholder:
                                                        (context, url) =>
                                                            const Center(
                                                      child: SizedBox(
                                                        child:
                                                            CircularProgressIndicator(),
                                                      ),
                                                    ),
                                                    errorWidget:
                                                        (context, url, error) =>
                                                            const Center(
                                                      child: Icon(
                                                        Icons.error_outline,
                                                        color: Colors.red,
                                                      ),
                                                    ),
                                                  ),
                                          ),
                                        ),
                                        SizedBox(
                                          height: height * 0.03,
                                        ),
                                        Row(
                                          children: [
                                            Text(
                                              'Product Name',
                                              style:
                                                  AppTextStyles.formalTextStyle(
                                                fontSize: 12,
                                                color: Theme.of(context)
                                                    .primaryTextTheme
                                                    .titleMedium!
                                                    .color!,
                                              ),
                                            ),
                                          ],
                                        ),
                                        SizedBox(
                                          height: height * 0.01,
                                        ),
                                        Container(
                                          width: width,
                                          height: height * 0.07,
                                          decoration: ShapeDecoration(
                                            color: Colors.white,
                                            shape: RoundedRectangleBorder(
                                                borderRadius:
                                                    BorderRadius.circular(6)),
                                            shadows: const [
                                              BoxShadow(
                                                color: Color(0x3F000000),
                                                blurRadius: 4,
                                                offset: Offset(0, 1),
                                                spreadRadius: 0,
                                              )
                                            ],
                                          ),
                                          child: Row(
                                            children: [
                                              Padding(
                                                padding: EdgeInsets.only(
                                                    left: width * 0.05),
                                                child: AutoSizeText(
                                                  controller
                                                          .barcodeSearchedFoodModel
                                                          .value
                                                          .product!
                                                          .productName ??
                                                      "Unknown",
                                                  minFontSize: 10,
                                                  style: AppTextStyles
                                                      .formalTextStyle(),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                        SizedBox(
                                          height: height * 0.03,
                                        ),
                                        Row(
                                          children: [
                                            Text(
                                              'Nutriments',
                                              style:
                                                  AppTextStyles.formalTextStyle(
                                                fontSize: 12,
                                                color: Theme.of(context)
                                                    .primaryTextTheme
                                                    .titleMedium!
                                                    .color!,
                                              ),
                                            ),
                                          ],
                                        ),
                                        SizedBox(
                                          height: height * 0.01,
                                        ),
                                        SizedBox(
                                          height: height * 0.15,
                                          width: width * 0.7,
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              CirculerProgress(
                                                size: height * 0.048,
                                                progress: 1,
                                                progressText: controller
                                                            .barcodeSearchedFoodModel
                                                            .value
                                                            .product!
                                                            .nutriments!
                                                            .carbohydrates ==
                                                        null
                                                    ? "0g"
                                                    : "${controller.barcodeSearchedFoodModel.value.product!.nutriments!.carbohydrates!.toInt()}g",
                                                progressType: "Carbs",
                                                progressColor:
                                                    const Color(0xffDEBDA2),
                                                textColor: Theme.of(context)
                                                    .primaryTextTheme
                                                    .titleMedium!
                                                    .color!,
                                              ),
                                              CirculerProgress(
                                                size: height * 0.048,
                                                progress: 1,
                                                progressText: controller
                                                            .barcodeSearchedFoodModel
                                                            .value
                                                            .product!
                                                            .nutriments!
                                                            .fat ==
                                                        null
                                                    ? "0g"
                                                    : "${controller.barcodeSearchedFoodModel.value.product!.nutriments!.fat!.toInt()}g",
                                                progressType: "Fat",
                                                progressColor:
                                                    const Color(0xffFAD56D),
                                                textColor: Theme.of(context)
                                                    .primaryTextTheme
                                                    .titleMedium!
                                                    .color!,
                                              ),
                                              CirculerProgress(
                                                size: height * 0.048,
                                                progress: 1,
                                                progressText: controller
                                                            .barcodeSearchedFoodModel
                                                            .value
                                                            .product!
                                                            .nutriments!
                                                            .proteins ==
                                                        null
                                                    ? "0g"
                                                    : "${controller.barcodeSearchedFoodModel.value.product!.nutriments!.proteins!.toInt()}g",
                                                progressType: "Protein",
                                                progressColor:
                                                    const Color(0xffFD898D),
                                                textColor: Theme.of(context)
                                                    .primaryTextTheme
                                                    .titleMedium!
                                                    .color!,
                                              ),
                                              // CirculerProgress(
                                              //   size: height * 0.045,
                                              //   progress: 1,
                                              //   progressText:
                                              //       "${controller.barcodeSearchedFoodModel.value.product!.nutriments!.sodium!.toInt()}g",
                                              //   progressType: "Sodium",
                                              //   progressColor:
                                              //       const Color(0xffDEBDA2),
                                              // ),
                                            ],
                                          ),
                                        ),
                                        SizedBox(
                                          height: height * 0.01,
                                        ),
                                        Container(
                                          width: width * 0.75,
                                          // height: height * 0.07,
                                          decoration: ShapeDecoration(
                                            color: Colors.white,
                                            shape: RoundedRectangleBorder(
                                                borderRadius:
                                                    BorderRadius.circular(6)),
                                            shadows: const [
                                              BoxShadow(
                                                color: Color(0x3F000000),
                                                blurRadius: 4,
                                                offset: Offset(0, 1),
                                                spreadRadius: 0,
                                              )
                                            ],
                                          ),
                                          child: ListTile(
                                            title: Text(
                                              'Total Calories',
                                              style:
                                                  AppTextStyles.formalTextStyle(
                                                fontSize: 14,
                                              ),
                                            ),
                                            leading: SvgPicture.asset(
                                                AppAssets.kcalSvgUrl),
                                            trailing: Text(
                                              controller
                                                          .barcodeSearchedFoodModel
                                                          .value
                                                          .product!
                                                          .nutriments!
                                                          .energyKcal ==
                                                      null
                                                  ? "0.0 kcal"
                                                  : '${controller.barcodeSearchedFoodModel.value.product!.nutriments!.energyKcal!.toInt()} kcal',
                                              style:
                                                  AppTextStyles.formalTextStyle(
                                                color: AppColors.buttonColor,
                                                fontSize: 18,
                                                fontWeight: FontWeight.w700,
                                              ),
                                            ),
                                          ),
                                        ),
                                        SizedBox(
                                          height: height * 0.03,
                                        ),
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Container(
                                              width: width * 0.35,
                                              decoration: ShapeDecoration(
                                                color: Colors.white,
                                                shape: RoundedRectangleBorder(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            6)),
                                                shadows: const [
                                                  BoxShadow(
                                                    color: Color(0x3F000000),
                                                    blurRadius: 4,
                                                    offset: Offset(0, 0),
                                                    spreadRadius: 0,
                                                  )
                                                ],
                                              ),
                                              child: DropdownButton<String>(
                                                value: controller
                                                    .foodSelectedItem.value,
                                                isExpanded: true,
                                                underline: const SizedBox(),
                                                borderRadius:
                                                    BorderRadius.circular(10),
                                                onChanged: (newValue) {
                                                  controller.foodSelectedItem
                                                      .value = newValue!;
                                                },
                                                items: controller.foodMenuItems
                                                    .map<
                                                        DropdownMenuItem<
                                                            String>>(
                                                  (String value) {
                                                    return DropdownMenuItem<
                                                        String>(
                                                      value: value,
                                                      child: Padding(
                                                        padding: EdgeInsets
                                                            .symmetric(
                                                                horizontal:
                                                                    width *
                                                                        0.02),
                                                        child: AutoSizeText(
                                                          value,
                                                          minFontSize: 10,
                                                          style: AppTextStyles
                                                              .formalTextStyle(),
                                                        ),
                                                      ),
                                                    );
                                                  },
                                                ).toList(),
                                              ),
                                            ),
                                            Container(
                                              width: width * 0.35,
                                              decoration: ShapeDecoration(
                                                color: Colors.white,
                                                shape: RoundedRectangleBorder(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            6)),
                                                shadows: const [
                                                  BoxShadow(
                                                    color: Color(0x3F000000),
                                                    blurRadius: 4,
                                                    offset: Offset(0, 0),
                                                    spreadRadius: 0,
                                                  )
                                                ],
                                              ),
                                              child: DropdownButton<String>(
                                                value: controller
                                                    .foodServing.value,
                                                isExpanded: true,
                                                underline: const SizedBox(),
                                                borderRadius:
                                                    BorderRadius.circular(10),
                                                onChanged: (newValue) {
                                                  controller.foodServing.value =
                                                      newValue!;
                                                },
                                                items: controller.servingList
                                                    .map<
                                                        DropdownMenuItem<
                                                            String>>(
                                                  (String value) {
                                                    return DropdownMenuItem<
                                                        String>(
                                                      value: value,
                                                      child: Padding(
                                                        padding: EdgeInsets
                                                            .symmetric(
                                                                horizontal:
                                                                    width *
                                                                        0.02),
                                                        child: AutoSizeText(
                                                          value,
                                                          minFontSize: 10,
                                                          style: AppTextStyles
                                                              .formalTextStyle(),
                                                        ),
                                                      ),
                                                    );
                                                  },
                                                ).toList(),
                                              ),
                                            ),
                                          ],
                                        ),
                                        SizedBox(
                                          height: height * 0.03,
                                        ),
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            CustomLargeButton(
                                              height: height,
                                              width: width * 0.55,
                                              borderRadius:
                                                  BorderRadius.circular(7),
                                              text: "Add to your budget",
                                              onPressed: () {
                                                if (controller
                                                        .foodServing.value !=
                                                    "Servings") {
                                                  controller.uploadData(
                                                      servings: int.parse(
                                                          controller.foodServing
                                                              .value));
                                                } else {
                                                  customSnackbar(
                                                    title: AppTexts.error,
                                                    message:
                                                        "Please select Serving",
                                                  );
                                                }
                                              },
                                            ),
                                            SizedBox(
                                              height: height * 0.07,
                                              width: width * 0.2,
                                              child: MaterialButton(
                                                onPressed: () =>
                                                    controller.clearData(),
                                                // color: AppColors.blue,
                                                elevation: 5,
                                                shape: RoundedRectangleBorder(
                                                  side: const BorderSide(
                                                      width: 1.5,
                                                      color: AppColors.blue),
                                                  borderRadius:
                                                      BorderRadius.circular(6),
                                                ),

                                                child: const Icon(
                                                  Icons.refresh_outlined,
                                                  color: AppColors.blue,
                                                  size: 35,
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                            ),
              controller.isPostFoodLoading.value
                  ? const OverlayWidget()
                  : const SizedBox(),
            ],
          ),
        ),
      ),
    );
  }
}
