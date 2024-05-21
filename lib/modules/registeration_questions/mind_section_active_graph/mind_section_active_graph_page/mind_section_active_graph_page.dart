import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:weight_loss_app/modules/registeration_questions/final_analizing_graph/binding/final_analizing_graph_binding.dart';
import 'package:weight_loss_app/utils/internet_check_widget.dart';
import 'package:weight_loss_app/widgets/custom_graph/custom_graph_painter.dart';

import '../../../../common/app_colors.dart';
import '../../../../common/app_text_styles.dart';
import '../../final_analizing_graph/final_analizing_graph_page/final_analizing_graph_page.dart';
import '../../widgets/flip_calender.dart';
import '../../widgets/qus_next_button.dart';
import '../controller/mind_section_active_graph_controller.dart';

class MindSectionActiveGraphPage
    extends GetView<MindSectionActiveGraphController> {
  const MindSectionActiveGraphPage({
    super.key,
    required this.targetWeight,
    required this.currentWeight,
    required this.weightUnit,
  });
  final num targetWeight;
  final num currentWeight;
  final String weightUnit;
  @override
  Widget build(BuildContext context) {
    var screenSize = MediaQuery.sizeOf(context);
    double height = screenSize.height;
    double width = screenSize.width;
    final digits = [
      DateFormat('MMM d y').format(controller
          .expectedDate(
              targetWeight: targetWeight,
              currentWeight: currentWeight,
              weightUnit: weightUnit)
          .subtract(const Duration(days: 4))),
      DateFormat('MMM d y').format(controller
          .expectedDate(
              targetWeight: targetWeight,
              currentWeight: currentWeight,
              weightUnit: weightUnit)
          .subtract(const Duration(days: 3))),
      DateFormat('MMM d y').format(controller
          .expectedDate(
              targetWeight: targetWeight,
              currentWeight: currentWeight,
              weightUnit: weightUnit)
          .subtract(const Duration(days: 2))),
      DateFormat('MMM d y').format(controller
          .expectedDate(
              targetWeight: targetWeight,
              currentWeight: currentWeight,
              weightUnit: weightUnit)
          .subtract(const Duration(days: 1))),
      DateFormat('MMM d y').format(controller.expectedDate(
          targetWeight: targetWeight,
          currentWeight: currentWeight,
          weightUnit: weightUnit)),
    ];

    return Scaffold(
      body: InternetCheckWidget<ConnectivityService>(
        child: SafeArea(
          child: SingleChildScrollView(
            child: Stack(
              children: [
                Align(
                  alignment: Alignment.centerLeft,
                  child: IconButton(
                      onPressed: () {
                        Get.back();
                      },
                      padding: EdgeInsets.only(left: width * 0.03),
                      icon: const Icon(Icons.arrow_back)),
                ),
                Column(
                  children: [
                    SizedBox(
                      height: height * 0.05,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Container(
                          height: height * 0.2,
                          width: width * 0.37,
                          decoration: BoxDecoration(
                            color: AppColors.white,
                            borderRadius: BorderRadius.circular(35),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.grey.withOpacity(0.5),
                                spreadRadius: 1,
                                blurRadius: 5,
                                offset: const Offset(0, 2),
                              ),
                            ],
                          ),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                '$targetWeight ${weightUnit}s',
                                style: const TextStyle(
                                  color: AppColors.black,
                                  fontSize: 29,
                                  fontFamily: AppTextStyles.fontFamily,
                                  fontWeight: FontWeight.w700,
                                ),
                              ),
                              SizedBox(
                                height: height * 0.01,
                              ),
                              const Text(
                                'Target Weight',
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  color: AppColors.black,
                                  fontSize: 16,
                                  fontFamily: AppTextStyles.fontFamily,
                                  fontWeight: FontWeight.w400,
                                ),
                              ),
                            ],
                          ),
                        ),
                        FlipPanelPlus.builder(
                          itemBuilder: (context, index) => Container(
                            height: height * 0.2,
                            width: width * 0.37,
                            decoration: BoxDecoration(
                              color: AppColors.sectionGraphDateColor,
                              borderRadius: BorderRadius.circular(35),
                            ),
                            child: Center(
                              child: Padding(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 8.0),
                                child: Text(
                                  digits[index],
                                  textAlign: TextAlign.center,
                                  style: const TextStyle(
                                    color: AppColors.white,
                                    fontSize: 29,
                                    fontFamily: AppTextStyles.fontFamily,
                                    fontWeight: FontWeight.w700,
                                  ),
                                ),
                              ),
                            ),
                          ),
                          itemsCount: digits.length,
                          period: const Duration(milliseconds: 400),
                          loop: 1,
                        )
                      ],
                    ),
                    SizedBox(
                      height: height * 0.03,
                    ),
                    const Text(
                      "Taking it up a notch!",
                      style: TextStyle(
                        color: AppColors.graphTextFColor,
                        fontFamily: AppTextStyles.fontFamily,
                        fontSize: 20,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    SizedBox(
                      height: height * 0.01,
                    ),
                    const AutoSizeText(
                      "Targets Aligned, Victories Defined!",
                      maxLines: 1,
                      minFontSize: 10,
                      style: TextStyle(
                        color: Color(0xFF434343),
                        fontSize: 18,
                        fontFamily: 'Poppins',
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                    SizedBox(
                      height: height * 0.01,
                    ),
                    const Text(
                      "We predict you will be",
                      style: TextStyle(
                        color: Color(0xFF1B2767),
                        fontSize: 20,
                        fontFamily: 'Poppins',
                        fontWeight: FontWeight.w700,
                        height: 0,
                      ),
                    ),
                    SizedBox(
                      height: height * 0.01,
                    ),
                    Text(
                      '$targetWeight ${weightUnit}s by ${DateFormat('MMMM y').format(
                        controller.expectedDate(
                            targetWeight: targetWeight,
                            currentWeight: currentWeight,
                            weightUnit: weightUnit),
                      )}',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: AppColors.buttonColor,
                        fontSize: 17,
                        fontFamily: 'Poppins',
                        fontWeight: FontWeight.w400,
                        height: 0,
                      ),
                    ),
                    SizedBox(
                      height: height * 0.03,
                    ),
                    // SizedBox(
                    //   height: height * 0.27,
                    //   child: const Center(
                    //     child: CustomLineChart(),
                    //   ),
                    // ),
                    SizedBox(
                      // width: screenWidth,
                      // height: screenHeight * 0.3,
                      height: height * 0.26,
                      width: width,
                      child: Padding(
                        padding: EdgeInsets.only(
                            left: width * 0.07, right: width * 0.1),
                        child: CustomPaint(
                          painter: GraphLinePainter(
                            // hint:  0 month == Junuary
                            month: DateTime.now().month - 1,
                            curentWeight: currentWeight.toInt(),
                            estimatedWeight: targetWeight.toInt(),
                            weightUnit: "${weightUnit}s",
                            totalMonths: controller.monthsToLoseWeight(
                                  currentWeight: weightUnit == "kg"
                                      ? currentWeight * 2.2
                                      : currentWeight,
                                  goalWeight: weightUnit == "kg"
                                      ? targetWeight * 2.2
                                      : targetWeight,
                                  weightPerWeek: 1.5,
                                ) +
                                1,
                          ),
                        ),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(
                          horizontal: width * 0.07, vertical: height * 0.03),
                      child: Text(
                        'According to calculations, a healthy weight loss range is between 1 and 2 pounds per week. You will lose weight by ${DateFormat('MMMM y').format(
                          controller.expectedDate(
                              targetWeight: targetWeight,
                              currentWeight: currentWeight,
                              weightUnit: weightUnit),
                        )}',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: AppColors.buttonColor,
                          fontSize: 15,
                          fontFamily: 'Poppins',
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                    ),
                    QusNextButton(
                      callBack: () {
                        Get.to(
                          const FinalAnalizingGraphPage(),
                          binding: FinalAnalizingGraphBinding(),
                        );
                      },
                      height: height * 0.07,
                      width: width * 0.5,
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
