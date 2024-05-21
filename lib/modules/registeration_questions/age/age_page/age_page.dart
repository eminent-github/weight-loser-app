import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:scroll_date_picker/scroll_date_picker.dart';
import 'package:weight_loss_app/modules/registeration_questions/widgets/stepper.dart';
import 'package:weight_loss_app/utils/internet_check_widget.dart';
import 'package:weight_loss_app/widgets/overlay_widget.dart';

import '../../../../common/app_colors.dart';
import '../../../../common/app_text_styles.dart';
import '../../../../common/app_texts.dart';
import '../../../../widgets/qus_understand_widget.dart';
import '../../widgets/qus_next_button.dart';
import '../controller/age_controller.dart';

class AgePage extends GetView<AgeController> {
  const AgePage({super.key});

  @override
  Widget build(BuildContext context) {
    var screenSize = MediaQuery.of(context).size;
    double height = screenSize.height;
    double width = screenSize.width;
    return Scaffold(
      body: InternetCheckWidget<ConnectivityService>(
        child: Obx(
          () => Stack(
            children: [
              SafeArea(
                child: Column(
                  children: [
                    Column(
                      children: [
                        SizedBox(
                          height: height * 0.1,
                          child: Row(
                            children: [
                              InkWell(
                                onTap: () {
                                  Get.back();
                                },
                                child: SizedBox(
                                  height: height,
                                  child: Padding(
                                    padding: EdgeInsets.symmetric(
                                        horizontal: width * 0.02),
                                    child: const Icon(
                                        Icons.arrow_back_ios_new_rounded),
                                  ),
                                ),
                              ),
                              const Expanded(child: QusStepper(question: 1)),
                            ],
                          ),
                        ),
                        SizedBox(
                          height: height * 0.24,
                          child: UnderstandWidget(
                            headerText: AppTexts.qusUnderstandText,
                            requestText: AppTexts.qusUnderstandAgeText,
                            isShowDiscription: true,
                            discriptionText:
                                "Age helps us to understand your metabolism",
                            height: height * 0.24,
                            width: width,
                          ),
                        ),
                      ],
                    ),
                    Expanded(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          Container(
                            height: height * 0.2,
                            width: width * 0.5,
                            decoration: BoxDecoration(
                              color: AppColors.white,
                              shape: BoxShape.circle,
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.grey.withOpacity(0.5),
                                  spreadRadius: 1,
                                  blurRadius: 2,
                                  offset: const Offset(0, 2),
                                ),
                              ],
                            ),
                            child: Obx(() => Center(
                                    child: Text(
                                  "${controller.age.value} Years",
                                  style: TextStyle(
                                    color: AppColors.black,
                                    fontSize: height * 0.038,
                                    fontFamily: AppTextStyles.fontFamily,
                                    fontWeight: FontWeight.w400,
                                  ),
                                ))),
                          ),
                          Column(
                            children: [
                              SizedBox(
                                width: width * 0.46,
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      'Month',
                                      style: AppTextStyles.formalTextStyle(
                                          fontSize: 16,
                                          fontWeight: FontWeight.bold),
                                    ),
                                    Text(
                                      'Day',
                                      style: AppTextStyles.formalTextStyle(
                                          fontSize: 16,
                                          fontWeight: FontWeight.bold),
                                    ),
                                    Text(
                                      'Year',
                                      style: AppTextStyles.formalTextStyle(
                                          fontSize: 16,
                                          fontWeight: FontWeight.bold),
                                    )
                                  ],
                                ),
                              ),
                              SizedBox(
                                height: height * 0.11,
                                width: width * 0.6,
                                child: Center(
                                  child: ScrollDatePicker(
                                    selectedDate: controller.selectedDate.value,
                                    minimumDate: DateTime(1920),
                                    maximumDate: DateTime.now(),
                                    locale: const Locale('en'),
                                    scrollViewOptions:
                                        const DatePickerScrollViewOptions(
                                      year: ScrollViewDetailOptions(
                                        margin: EdgeInsets.only(left: 10),
                                        selectedTextStyle: TextStyle(
                                            fontWeight: FontWeight.w700,
                                            fontSize: 16),
                                      ),
                                      month: ScrollViewDetailOptions(
                                        margin: EdgeInsets.only(right: 10),
                                        selectedTextStyle: TextStyle(
                                            fontWeight: FontWeight.w700,
                                            fontSize: 16),
                                      ),
                                      day: ScrollViewDetailOptions(
                                        margin: EdgeInsets.only(
                                            left: 10, right: 10),
                                        selectedTextStyle: TextStyle(
                                            fontWeight: FontWeight.w700,
                                            fontSize: 16),
                                      ),
                                    ),
                                    onDateTimeChanged: (DateTime value) {
                                      controller.selectedDate.value = value;
                                      controller.age.value = controller
                                              .currentDate.year -
                                          controller.selectedDate.value.year;
                                      if (controller.age.value < 18 ||
                                          controller.age.value > 75) {
                                        controller.isShowResriction.value =
                                            true;
                                      } else {
                                        controller.isShowResriction.value =
                                            false;
                                      }
                                    },
                                  ),
                                ),
                              ),
                            ],
                          ),
                          controller.isShowResriction.value
                              ? SizedBox(
                                  width: width * 0.6,
                                  child: const Text(
                                    '*At this time our application allows age between 18 to 75 years',
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                      color: AppColors.abstractionTextColor,
                                      fontSize: 12,
                                      fontFamily: AppTextStyles.fontFamily,
                                      fontWeight: FontWeight.w400,
                                    ),
                                  ),
                                )
                              : const Text(
                                  '',
                                  style: TextStyle(
                                    fontSize: 12,
                                  ),
                                ),
                          QusNextButton(
                            height: height * 0.07,
                            width: width * 0.5,
                            callBack: () {
                              if (controller.age.value <= 75 &&
                                  controller.age.value >= 18) {
                                controller.ageApi();
                              }
                            },
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              controller.isLoading.value
                  ? const OverlayWidget()
                  : const SizedBox(),
            ],
          ),
        ),
      ),
    );
  }
}
