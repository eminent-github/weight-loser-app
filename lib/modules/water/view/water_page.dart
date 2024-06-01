import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:weight_loss_app/common/app_text_styles.dart';
import 'package:weight_loss_app/modules/water/controller/water_controller.dart';
import 'package:weight_loss_app/modules/water/widget/water_bottle.dart';
import 'package:weight_loss_app/modules/water/widget/water_intake_dialog.dart';
import 'package:weight_loss_app/utils/internet_check_widget.dart';
import 'package:weight_loss_app/widgets/custom_large_button.dart';
import 'package:weight_loss_app/widgets/custom_snackbar.dart';
import 'package:weight_loss_app/widgets/overlay_widget.dart';

import '../../../../common/app_colors.dart';
import '../../../../common/app_texts.dart';
import '../../../../widgets/custom_datetime_calender.dart';

class WaterPage extends GetView<WaterController> {
  const WaterPage({super.key});

  @override
  Widget build(BuildContext context) {
    var screenSize = MediaQuery.sizeOf(context);
    double height = screenSize.height;
    double width = screenSize.width;
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        backgroundColor: Theme.of(context).appBarTheme.backgroundColor,
        iconTheme: Theme.of(context).iconTheme,
        elevation: 0,
        title: Text(
          AppTexts.addWaterIntake,
          style: Theme.of(context).appBarTheme.titleTextStyle,
        ),
        centerTitle: true,
        actions: [
          Padding(
            padding: EdgeInsets.only(right: width * 0.025),
            child: IconButton(
                onPressed: () async {
                  print(controller.userWaterDetailList.last.serving);
                  if (DateTime.now().isBefore(
                      DateTime.parse(controller.selectedDate.value)
                          .add(const Duration(days: 1)))) {
                    controller.editUserTodayWater(
                      numberOfGlass:
                          controller.userWaterDetailList.last.serving ?? 0,
                      dateTime: controller.selectedDate.value,
                    );
                  }
                },
                icon: const Icon(Icons.refresh_rounded)),
          )
        ],
      ),
      body: InternetCheckWidget<ConnectivityService>(
        child: Obx(
          () => Stack(
            children: [
              Column(
                children: [
                  SizedBox(
                    height: height * 0.03,
                  ),
                  Container(
                    height: height * 0.12,
                    width: width,
                    color: AppColors.buttonColor.withOpacity(0.10),
                    child: Center(
                      child: SizedBox(
                        height: height * 0.085,
                        child: MyCustomCalender(
                          tableCalenderIcon: const Icon(
                            Icons.calendar_today,
                            color: Colors.white,
                          ),
                          date: DateTime.now(),
                          lastDate: DateTime.now(),
                          colorOfWeek: Theme.of(context)
                              .primaryTextTheme
                              .titleMedium!
                              .color!,
                          colorOfMonth: Theme.of(context)
                              .primaryTextTheme
                              .titleMedium!
                              .color!,
                          fontSizeOfWeek: 12,
                          fontSizeOfMonth: 18,
                          backgroundColor: Colors.transparent,
                          selectedColor: AppColors.buttonColor,
                          tableCalenderButtonColor: AppColors.buttonColor,
                          onDateSelected: (date) {
                            controller.selectedDate.value = date;
                            controller.getWaterDetailList(date);
                          },
                        ),
                      ),
                    ),
                  ),
                  Expanded(
                    child: controller.isLoading.value
                        ? Center(
                            child: CircularProgressIndicator(
                              color: AppColors.buttonColor,
                            ),
                          )
                        : Column(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              Text(
                                'Please try to take 8 glasses of water daily',
                                style: AppTextStyles.formalTextStyle(
                                  color: AppColors.buttonColor,
                                  fontWeight: FontWeight.w700,
                                ),
                              ),
                              // SizedBox(
                              //   height: height * 0.04,
                              // ),
                              SizedBox(
                                height: height * 0.35,
                                width: width * 0.33,
                                child: Center(
                                  child: Stack(
                                    alignment: Alignment.center,
                                    children: [
                                      CustomPaint(
                                        size: Size(
                                          width * 0.33,
                                          height * 0.35,
                                        ),
                                        painter: BottlePainter(
                                          controller.numberOfGlasses.value > 8
                                              ? 0.96
                                              : controller
                                                      .numberOfGlasses.value *
                                                  0.12,
                                          controller.numberOfGlasses.value > 8
                                              ? AppColors.abstractionTextColor
                                              : const Color(0xff87CEFA),
                                        ),
                                      ),
                                      Positioned(
                                        top: 0,
                                        child: Container(
                                          width: width * 0.22,
                                          height: height * 0.04,
                                          decoration: BoxDecoration(
                                            color: AppColors.buttonColor,
                                            border:
                                                Border.all(color: Colors.white),
                                            borderRadius:
                                                BorderRadius.circular(20),
                                          ),
                                        ),
                                      ),
                                      Center(
                                        child: Container(
                                          width: width * 0.33,
                                          height: height * 0.04,
                                          alignment: Alignment.center,
                                          decoration: BoxDecoration(
                                            color: AppColors.buttonColor
                                                .withOpacity(0.6),
                                          ),
                                          child: Text(
                                            "${(controller.numberOfGlasses.value * 0.2366).toPrecision(1)} L",
                                            style: const TextStyle(
                                                color: Colors.white,
                                                fontSize: 22,
                                                fontWeight: FontWeight.bold),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                              // SizedBox(
                              //   height: height * 0.04,
                              // ),
                              Container(
                                width: width * 0.55,
                                height: height * 0.05,
                                decoration: ShapeDecoration(
                                  shape: RoundedRectangleBorder(
                                    side: BorderSide(
                                        width: 0.50,
                                        color: AppColors.buttonColor),
                                    borderRadius: BorderRadius.circular(6),
                                  ),
                                ),
                                child: Center(
                                  child: SizedBox(
                                    width: width * 0.48,
                                    child: FittedBox(
                                      child: Text(
                                        'Total Water Intake: ${(controller.numberOfGlasses.value * 0.2375).toPrecision(1)}/1.9L',
                                        style: AppTextStyles.formalTextStyle(
                                          color: AppColors.buttonColor,
                                          fontWeight: FontWeight.w700,
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                              // SizedBox(
                              //   height: height * 0.02,
                              // ),
                              Text(
                                // controller.numberOfGlasses.value <= 8
                                //     ? 'Water Intake (Glass): ${controller.numberOfGlasses.value}'
                                //     : 'Water Intake (Glass): 8',

                                'Water Intake (Glass): ${controller.numberOfGlasses.value}',
                                textAlign: TextAlign.center,
                                style: AppTextStyles.formalTextStyle(
                                  fontWeight: FontWeight.w700,
                                  color: Theme.of(context)
                                      .primaryTextTheme
                                      .titleMedium!
                                      .color!,
                                ),
                              ),

                              // SizedBox(
                              //   height: height * 0.02,
                              // ),
                              Text(
                                controller.numberOfGlasses.value <= 8
                                    ? 'Extra Water Intake: 0'
                                    : 'Extra Water Intake: ${controller.numberOfGlasses.value - 8}',
                                textAlign: TextAlign.center,
                                style: AppTextStyles.formalTextStyle(
                                  fontWeight: FontWeight.w700,
                                  color: Theme.of(context)
                                      .primaryTextTheme
                                      .titleMedium!
                                      .color!,
                                ),
                              ),

                              // SizedBox(
                              //   height: height * 0.04,
                              // ),
                              CustomLargeButton(
                                height: height,
                                width: width * 0.6,
                                borderRadius: BorderRadius.circular(15),
                                text: "Water Intake",
                                onPressed: () async {
                                  if (DateTime.now().isBefore(DateTime.parse(
                                          controller.selectedDate.value)
                                      .add(const Duration(days: 1)))) {
                                    if (controller.numberOfGlasses.value >=
                                        30) {
                                      customSnackbar(
                                          title: AppTexts.error,
                                          message:
                                              "You are drinking lot more water than prescribed range. Please consult your doctor");
                                    } else {
                                      await waterIntakeDialog(context);
                                    }
                                  }
                                },
                              )
                            ],
                          ),
                  ),
                ],
              ),
              controller.isToadayWaterLoading.value
                  ? const OverlayWidget()
                  : const SizedBox(),
            ],
          ),
        ),
      ),
    );
  }

  Future<void> waterIntakeDialog(BuildContext context) async {
    await showDialog(
      context: context,
      builder: (BuildContext context) {
        return WaterIntakeDialog(
          controller: controller,
        );
      },
    );
  }
}
