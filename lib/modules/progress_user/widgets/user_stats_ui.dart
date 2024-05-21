import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:syncfusion_flutter_gauges/gauges.dart';
import 'package:weight_loss_app/modules/progress_user/modal/user_stats_modal.dart';
import 'package:weight_loss_app/modules/progress_user/widgets/progress_circuler_chart.dart';
import 'package:weight_loss_app/modules/progress_user/widgets/progress_column_chart.dart';
import 'package:weight_loss_app/modules/progress_user/widgets/weight_progress_graph.dart';
import '../../../common/app_assets.dart';
import '../../../common/app_colors.dart';
import '../../../common/app_text_styles.dart';
import '../../../common/app_texts.dart';
import '../../../widgets/progress_ui_circuler_progress.dart';

class UserStatsUI extends StatelessWidget {
  const UserStatsUI({
    super.key,
    required this.userStatsModal,
    required this.currentWeight,
    required this.startWeightDate,
    required this.weightUnit,
  });
  final UserStatsModal userStatsModal;
  final num currentWeight;
  final String startWeightDate;
  final String weightUnit;
  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.sizeOf(context);
    double height = size.height;
    double width = size.width;

    return SingleChildScrollView(
      child: Column(
        children: [
          SizedBox(
            height: height * 0.03,
          ),
          Align(
            alignment: Alignment.centerLeft,
            child: Padding(
              padding: EdgeInsets.only(left: width * 0.06),
              child: Text(
                AppTexts.progressWeightText,
                style: TextStyle(
                  color: AppColors.buttonColor,
                  fontSize: 14,
                  fontFamily: AppTextStyles.fontFamily,
                  fontWeight: FontWeight.w400,
                  letterSpacing: 1,
                ),
              ),
            ),
          ),
          SizedBox(
            height: height * 0.02,
          ),
          SizedBox(
            height: height * 0.35,
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: width * 0.04),
              child: WeightProgressGraph(
                weightList: userStatsModal.updateWeight ?? [],
                currentWeight: currentWeight,
                startWeightDate: startWeightDate,
                weightUnit: weightUnit,
              ),
            ),
          ),
          SizedBox(
            height: height * 0.03,
          ),
          Align(
            alignment: Alignment.centerLeft,
            child: Padding(
              padding: EdgeInsets.only(left: width * 0.06),
              child: Text(
                AppTexts.totalComplianceText,
                style: TextStyle(
                  color: AppColors.buttonColor,
                  fontSize: 14,
                  fontFamily: AppTextStyles.fontFamily,
                  fontWeight: FontWeight.w400,
                  letterSpacing: 1,
                ),
              ),
            ),
          ),
          SizedBox(
            height: height * 0.03,
          ),
          SizedBox(
            height: height * 0.35,
            width: width,
            child: DonutChart(
              doghuntchartDataList: [
                DoghuntchartData(
                    value: userStatsModal.mindCompliance!,
                    label: "${userStatsModal.mindCompliance!.toPrecision(2)}%",
                    color: AppColors.mindColor),
                DoghuntchartData(
                  value: userStatsModal.dietCompliance!,
                  label: "${userStatsModal.dietCompliance!.toPrecision(2)}%",
                  color: AppColors.dietColor,
                ),
                DoghuntchartData(
                  value: userStatsModal.exerciseCompliance!,
                  label:
                      "${userStatsModal.exerciseCompliance!.toPrecision(2)}%",
                  color: AppColors.exerciseColor,
                ),
                // DoghuntchartData(
                //   value: 1 -
                //       (((userStatsModal.mindCompliance! * 0.33) / 100) +
                //           ((userStatsModal.dietCompliance! * 0.33) / 100) +
                //           ((userStatsModal.exerciseCompliance! * 0.33) / 100)),
                //   label: "",
                //   color: const Color(0xffEEEEEE),
                // ),
              ],
              totalAvg: "${userStatsModal.totalCompliance!.toPrecision(2)}",
            ),
          ),
          SizedBox(
            height: height * 0.03,
          ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: width * 0.2),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                SizedBox(
                  height: height * 0.08,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      SvgPicture.asset(AppAssets.dietProgressSvg,
                          height: height * 0.04),
                      Text(
                        AppTexts.dietText,
                        style: TextStyle(
                          color: Theme.of(context)
                              .primaryTextTheme
                              .titleMedium!
                              .color!,
                          fontSize: 12,
                          fontFamily: AppTextStyles.fontFamily,
                          fontWeight: FontWeight.w700,
                          letterSpacing: 1,
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: height * 0.08,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      SvgPicture.asset(AppAssets.workout,
                          color: AppColors.exerciseColor,
                          height: height * 0.04),
                      Text(
                        AppTexts.exerciseText,
                        style: TextStyle(
                          color: Theme.of(context)
                              .primaryTextTheme
                              .titleMedium!
                              .color!,
                          fontSize: 12,
                          fontFamily: AppTextStyles.fontFamily,
                          fontWeight: FontWeight.w700,
                          letterSpacing: 1,
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: height * 0.08,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      SvgPicture.asset(AppAssets.mindProgressSvg,
                          height: height * 0.04),
                      Text(
                        AppTexts.mind,
                        style: TextStyle(
                          color: Theme.of(context)
                              .primaryTextTheme
                              .titleMedium!
                              .color!,
                          fontSize: 12,
                          fontFamily: AppTextStyles.fontFamily,
                          fontWeight: FontWeight.w700,
                          letterSpacing: 1,
                        ),
                      ),
                    ],
                  ),
                )
              ],
            ),
          ),
          SizedBox(
            height: height * 0.015,
          ),
          Container(
            color: AppColors.borderColor,
            height: height * 0.001,
            width: width * 0.85,
          ),
          SizedBox(
            height: height * 0.015,
          ),
          Padding(
            padding: EdgeInsets.only(left: width * 0.07, right: width * 0.15),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  AppTexts.sleep,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: AppColors.buttonColor,
                    fontSize: 14,
                    fontFamily: AppTextStyles.fontFamily,
                    fontWeight: FontWeight.w400,
                    letterSpacing: 1,
                  ),
                ),
                Text(
                  AppTexts.waterText,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: AppColors.buttonColor,
                    fontSize: 14,
                    fontFamily: AppTextStyles.fontFamily,
                    fontWeight: FontWeight.w400,
                  ),
                ),
              ],
            ),
          ),
          SizedBox(
            height: height * 0.01,
          ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: width * 0.07),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  width: width * 0.5,
                  height: height * 0.15,
                  decoration: BoxDecoration(
                    color: Colors.grey.shade50,
                    borderRadius: BorderRadius.circular(10),
                    boxShadow: const [
                      BoxShadow(
                        color: AppColors.colorShadow,
                        blurRadius: 4,
                        offset: Offset(0, 1),
                        spreadRadius: 0,
                      ),
                    ],
                  ),
                  child: Column(
                    children: [
                      Container(
                        height: height * 0.07,
                        decoration: const BoxDecoration(
                          color: AppColors.white,
                          borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(10),
                            topRight: Radius.circular(10),
                          ),
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Container(
                              height: height * 0.1,
                              width: width * 0.1,
                              decoration: const BoxDecoration(
                                  shape: BoxShape.circle,
                                  color: Color(0xffF2F3FB)),
                              child: SvgPicture.asset(
                                AppAssets.sleepNotification,
                                fit: BoxFit.scaleDown,
                              ),
                            ),
                            const Text(
                              AppTexts.dailySleepAverageText,
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                color: Colors.black,
                                fontSize: 10,
                                fontFamily: AppTextStyles.fontFamily,
                                fontWeight: FontWeight.w400,
                                letterSpacing: 1,
                              ),
                            ),
                            Text.rich(
                              TextSpan(
                                children: [
                                  TextSpan(
                                    text:
                                        "${userStatsModal.averageSleepHours!.hours}",
                                    style: TextStyle(
                                      color: AppColors.buttonColor,
                                      fontSize: 20,
                                      fontFamily: AppTextStyles.fontFamily,
                                      fontWeight: FontWeight.w700,
                                      height: 0.75,
                                    ),
                                  ),
                                  TextSpan(
                                    text: 'h',
                                    style: TextStyle(
                                      color: AppColors.buttonColor,
                                      fontSize: 12,
                                      fontFamily: AppTextStyles.fontFamily,
                                      fontWeight: FontWeight.w700,
                                      height: 0.75,
                                    ),
                                  ),
                                  TextSpan(
                                    text: userStatsModal
                                        .averageSleepHours!.minutes
                                        .toString(),
                                    style: TextStyle(
                                      color: AppColors.buttonColor,
                                      fontSize: 20,
                                      fontFamily: AppTextStyles.fontFamily,
                                      fontWeight: FontWeight.w700,
                                      height: 0.75,
                                    ),
                                  ),
                                  TextSpan(
                                    text: 'm',
                                    style: TextStyle(
                                      color: AppColors.buttonColor,
                                      fontSize: 12,
                                      fontFamily: AppTextStyles.fontFamily,
                                      fontWeight: FontWeight.w700,
                                      height: 0.75,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                      Container(
                        height: height * 0.08,
                        decoration: BoxDecoration(
                            color: AppColors.white,
                            borderRadius: BorderRadius.circular(12)),
                        child: Center(
                          child: Image.asset(
                            width: width * 0.5,
                            AppAssets.cardProgressImg,
                            fit: BoxFit.fill,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                Container(
                  width: width * 0.3,
                  height: height * 0.15,
                  decoration: BoxDecoration(
                    color: AppColors.white,
                    borderRadius: BorderRadius.circular(10),
                    boxShadow: const [
                      BoxShadow(
                        color: AppColors.colorShadow,
                        blurRadius: 4,
                        offset: Offset(0, 1),
                        spreadRadius: 0,
                      ),
                    ],
                  ),
                  child: Container(
                    width: width * 0.3,
                    height: height * 0.25,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: AppColors.white,
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        SizedBox(
                          height: height * 0.1,
                          child: SfRadialGauge(
                            axes: <RadialAxis>[
                              RadialAxis(
                                showLabels: false,
                                showTicks: false,
                                startAngle: 180,
                                endAngle: 0,
                                // radiusFactor: 0.7,
                                canScaleToFit: true,
                                axisLineStyle: const AxisLineStyle(
                                  thickness: 0.15,
                                  thicknessUnit: GaugeSizeUnit.factor,
                                  // cornerStyle: CornerStyle.startCurve,
                                ),
                                pointers: <GaugePointer>[
                                  RangePointer(
                                    value: userStatsModal.weekAverageWater! > 8
                                        ? 100
                                        : (userStatsModal.weekAverageWater! /
                                                8) *
                                            100,
                                    width: 0.17,
                                    color: AppColors.buttonColor,
                                    sizeUnit: GaugeSizeUnit.factor,
                                    // cornerStyle: CornerStyle.bothCurve
                                  )
                                ],
                                annotations: <GaugeAnnotation>[
                                  GaugeAnnotation(
                                      positionFactor: 0.5,
                                      angle: 85,
                                      widget: Column(
                                        children: [
                                          AutoSizeText(
                                            '${userStatsModal.weekAverageWater!.toPrecision(0).toInt()} Glass daily',
                                            textAlign: TextAlign.center,
                                            minFontSize: 3,
                                            maxLines: 1,
                                            style: const TextStyle(
                                              color: AppColors.black,
                                              fontSize: 8,
                                              fontFamily:
                                                  AppTextStyles.fontFamily,
                                              fontWeight: FontWeight.w700,
                                            ),
                                          ),
                                          SizedBox(
                                            height: height * 0.003,
                                          ),
                                          SvgPicture.asset(
                                            AppAssets.glassProgressSvg,
                                            height: height * 0.025,
                                          ),
                                        ],
                                      ))
                                ],
                              )
                            ],
                          ),
                        ),
                        Container(
                          decoration: BoxDecoration(
                              color: const Color(0xffECECEC),
                              borderRadius: BorderRadius.circular(12)),
                          height: height * 0.02,
                          width: width * 0.25,
                          child: const Center(
                            child: Text(
                              AppTexts.averageWaterIntakeText,
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                color: AppColors.black,
                                fontSize: 7,
                                fontFamily: AppTextStyles.fontFamily,
                                fontWeight: FontWeight.w400,
                              ),
                            ),
                          ),
                        ),
                        SizedBox(
                          height: height * 0.01,
                        )
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
          SizedBox(
            height: height * 0.035,
          ),
          Align(
            alignment: Alignment.centerLeft,
            child: Padding(
              padding: EdgeInsets.only(left: width * 0.06),
              child: Text(
                AppTexts.averageCaloriesConsumedText,
                style: TextStyle(
                  color: AppColors.buttonColor,
                  fontSize: 14,
                  fontFamily: AppTextStyles.fontFamily,
                  fontWeight: FontWeight.w400,
                  letterSpacing: 1,
                ),
              ),
            ),
          ),
          SizedBox(
            height: height * 0.01,
          ),
          Container(
              width: width * 0.95,
              height: height * 0.22,
              decoration: ShapeDecoration(
                color: AppColors.white,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(14),
                ),
                shadows: const [
                  BoxShadow(
                    color: AppColors.colorShadow,
                    blurRadius: 4,
                    offset: Offset(0, 0),
                    spreadRadius: 0,
                  )
                ],
              ),
              child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    SizedBox(
                      height: height * 0.15,
                      width: width,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          CircularProgressIndicatorUi(
                            size: height * 0.04,
                            progress: userStatsModal.sumOfCarbs == 0.0
                                ? 0
                                : (userStatsModal.sumOfCarbs! / 7) /
                                            userStatsModal.goalCarbCount! >
                                        1
                                    ? 1
                                    : (userStatsModal.sumOfCarbs! / 7) /
                                        userStatsModal.goalCarbCount!,
                            progressType:
                                "${(userStatsModal.sumOfCarbs! / 7).toPrecision(1)}g",
                            underText: 'Carbs',
                            progressColor: AppColors.carbsColor,
                          ),
                          CircularProgressIndicatorUi(
                              size: height * 0.04,
                              progress: userStatsModal.sumOfFat == 0.0
                                  ? 0
                                  : (userStatsModal.sumOfFat! / 7) /
                                              userStatsModal.goalFatCount! >
                                          1
                                      ? 1
                                      : (userStatsModal.sumOfFat! / 7) /
                                          userStatsModal.goalFatCount!,
                              progressType:
                                  "${(userStatsModal.sumOfFat! / 7).toPrecision(1)}g",
                              underText: 'Fat',
                              progressColor: AppColors.fatColor),
                          CircularProgressIndicatorUi(
                              size: height * 0.04,
                              progress: userStatsModal.sumOfProtein == 0.0
                                  ? 0
                                  : (userStatsModal.sumOfProtein! / 7) /
                                              userStatsModal.goalProteinCount! >
                                          1
                                      ? 1
                                      : (userStatsModal.sumOfProtein! / 7) /
                                          userStatsModal.goalProteinCount!,
                              progressType:
                                  "${(userStatsModal.sumOfProtein! / 7).toPrecision(1)}g",
                              underText: 'Protein',
                              progressColor: AppColors.proteinColor),
                          // CircularProgressIndicatorUi(
                          //     size: height * 0.04,
                          //     progress: userStatsModal.goalSodiumCount == 0.0
                          //         ? 0
                          //         : (userStatsModal.sumOfSodium! / 7) /
                          //             userStatsModal.goalSodiumCount!,
                          //     progressType:
                          //         "${(userStatsModal.sumOfSodium! / 7).toPrecision(0).toInt()}g",
                          //     underText: 'Sodium',
                          //     progressColor: AppColors.buttonColor),
                        ],
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: width * 0.03),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            AppTexts.totalAvgText,
                            style: TextStyle(
                              color: AppColors.buttonColor,
                              fontSize: 13,
                              fontFamily: AppTextStyles.fontFamily,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                          Text.rich(
                            TextSpan(
                              children: [
                                TextSpan(
                                  text:
                                      '${(((userStatsModal.sumOfCarbs! / 7) * 4) + ((userStatsModal.sumOfFat! / 7) * 9) + ((userStatsModal.sumOfProtein! / 7) * 4)).round()} ',
                                  style: TextStyle(
                                    color: AppColors.buttonColor,
                                    fontSize: 13,
                                    fontFamily: AppTextStyles.fontFamily,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                                const TextSpan(
                                  text: 'kcal',
                                  style: TextStyle(
                                    color: AppColors.black,
                                    fontSize: 11,
                                    fontFamily: AppTextStyles.fontFamily,
                                    fontWeight: FontWeight.w400,
                                  ),
                                ),
                              ],
                            ),
                          )
                        ],
                      ),
                    ),
                  ])),
          SizedBox(
            height: height * 0.04,
          ),
          Align(
            alignment: Alignment.centerLeft,
            child: Padding(
              padding: EdgeInsets.only(left: width * 0.06),
              child: Text(
                AppTexts.averageExerciseDoneText,
                style: TextStyle(
                  color: AppColors.buttonColor,
                  fontSize: 14,
                  fontFamily: AppTextStyles.fontFamily,
                  fontWeight: FontWeight.w400,
                ),
              ),
            ),
          ),
          SizedBox(
            height: height * 0.02,
          ),
          Container(
            height: height * 0.4,
            width: width * 0.95,
            color: AppColors.transparent,
            child: ProgressColumnChart(
                progressExerciseList:
                    userStatsModal.history!.exerciseCalories!),
          ),
          SizedBox(
            height: height * 0.07,
          ),
        ],
      ),
    );
  }

  int monthsToLoseWeight(
      {required int goalWeight,
      required int currentWeight,
      required double weightPerWeek}) {
    // log("cw: $currentWeight gw: $goalWeight perWeek: $weightPerWeek");
    double numbeOfWeeks = (currentWeight - goalWeight) / weightPerWeek;
    // print("numbeOfWeeks : $numbeOfWeeks");
    if (numbeOfWeeks <= 4) {
      return 1;
    }
    return numbeOfWeeks ~/ 4.34524;
  }
}

// class DonutChartWidget extends StatefulWidget {
//   final List<DoghuntchartData> dataSet;
//   final String? totalAvg;
//   final double? exerciseValue;
//   final double? dietValue;
//   final double? mindValue;
//   const DonutChartWidget(this.dataSet,
//       {super.key,
//       this.totalAvg,
//       this.exerciseValue,
//       this.dietValue,
//       this.mindValue});
//   @override
//   State<DonutChartWidget> createState() => _DonutChartWidgetState();
// }
// class _DonutChartWidgetState extends State<DonutChartWidget> {
//   late Timer timer;
//   double fullAngle = 0.0;
//   double secondsToComplete = 5.0;
//   @override
//   void initState() {
//     timer = Timer.periodic(const Duration(milliseconds: 1000 ~/ 60), (timer) {
//       setState(() {
//         fullAngle += 360.0 / (secondsToComplete * 1000 ~/ 60);
//         if (fullAngle >= 360.0) {
//           fullAngle = 360.0;
//           timer.cancel();
//         }
//       });
//     });
//     super.initState();
//   }
//   @override
//   void dispose() {
//     timer.cancel();
//     super.dispose();
//   }
//   @override
//   Widget build(BuildContext context) {
//     return CustomPaint(
//       painter: DonutChartPainter(widget.dataSet, fullAngle, widget.totalAvg),
//       child: Container(),
//     );
//   }
// }
// class DonutChartPainter extends CustomPainter {
//   final List<DoghuntchartData> dataSet;
//   final double fullAngle;
//   final String? totalAvg;
//   DonutChartPainter(this.dataSet, this.fullAngle, this.totalAvg);
//   static const labelStyle = TextStyle(color: Colors.black, fontSize: 11.0);
//   final midPaint = Paint()
//     ..color = Colors.white
//     ..style = PaintingStyle.fill;
//   static final textBigStyle = TextStyle(
//       color: AppColors.buttonColor,
//       fontWeight: FontWeight.bold,
//       fontSize: 15.0);
//   @override
//   void paint(Canvas canvas, Size size) {
//     final linePath = Paint()
//       ..color = Colors.white
//       ..strokeWidth = 2.0
//       ..style = PaintingStyle.stroke;
//     final c = Offset(size.width / 2.0, size.height / 2.0);
//     final radius = size.width * 0.9;
//     final rect = Rect.fromCenter(center: c, width: radius, height: radius);
//     var startAngle = 0.0;
//     for (var di in dataSet) {
//       final sweepAngle = di.value * fullAngle / 180 * pi;
//       drawSectors(di, canvas, rect, startAngle, sweepAngle);
//       startAngle += sweepAngle;
//     }
//     startAngle = 0.0;
//     for (var di in dataSet) {
//       final sweepAngle = di.value * fullAngle / 180 * pi;
//       drawLines(radius, startAngle, c, canvas, linePath);
//       startAngle += sweepAngle;
//     }
//     startAngle = 0.0;
//     for (var di in dataSet) {
//       final sweepAngle = di.value * fullAngle / 180 * pi;
//       di.label.isNotEmpty
//           ? drawLabels(canvas, c, radius, startAngle, sweepAngle, di.label)
//           : null;
//       startAngle += sweepAngle;
//     }
//     canvas.drawCircle(c, radius * 0.3, midPaint);
//     drawTextCentered(canvas, c, "Total Avg.\n ${totalAvg!}%", textBigStyle,
//         radius * 0.5, (Size sz) {});
//   }
//   TextPainter measureText(String string, TextStyle textStyle, double maxWidth,
//       TextAlign textAlign) {
//     final span = TextSpan(text: string, style: textStyle);
//     final tp = TextPainter(
//         text: span, textAlign: textAlign, textDirection: TextDirection.ltr);
//     tp.layout(minWidth: 0, maxWidth: maxWidth);
//     return tp;
//   }
//   Size drawTextCentered(Canvas canvas, Offset position, String text,
//       TextStyle textStyle, double maxWidth, Function(Size size) bgCb) {
//     final textPainter =
//         measureText(text, textStyle, maxWidth, TextAlign.center);
//     final pos =
//         position + Offset(-textPainter.width / 2.0, -textPainter.height / 2.0);
//     bgCb(textPainter.size);
//     textPainter.paint(canvas, pos);
//     return textPainter.size;
//   }
//   void drawLines(double radius, double startAngle, Offset c, Canvas canvas,
//       Paint linePath) {
//     final lineLength = radius / 2;
//     final dx = lineLength * cos(startAngle);
//     final dy = lineLength * sin(startAngle);
//     final p2 = c + Offset(dx, dy);
//     canvas.drawLine(c, p2, linePath);
//   }
//   void drawSectors(DoghuntchartData di, Canvas canvas, Rect rect,
//       double startAngle, double sweepAngle) {
//     final paint = Paint()
//       ..style = PaintingStyle.fill
//       ..color = di.color;
//     canvas.drawArc(rect, startAngle, sweepAngle, true, paint);
//   }
//   void drawLabels(Canvas canvas, Offset c, double radius, double startAngle,
//       double sweepAngle, String label) {
//     final r = radius * 0.4;
//     final dx = r * cos(startAngle + sweepAngle / 2.0);
//     final dy = r * sin(startAngle + sweepAngle / 2.0);
//     final position = c + Offset(dx, dy);
//     drawTextCentered(canvas, position, label, labelStyle, 100.0, (Size size) {
//       final rect = Rect.fromCenter(
//           center: position, width: size.width + 5, height: size.height + 5);
//       final rrect = RRect.fromRectAndRadius(rect, const Radius.circular(5));
//       canvas.drawRRect(rrect, midPaint);
//     });
//   }
//   @override
//   bool shouldRepaint(covariant CustomPainter oldDelegate) => true;
// }
// ////
// class CustomSlider extends StatelessWidget {
//   final double? percentage;
//   final double? height;
//   final Color? color;
//   const CustomSlider({
//     super.key,
//     this.percentage,
//     this.height,
//     this.color,
//   });
//   @override
//   Widget build(BuildContext context) {
//     return Padding(
//       padding: const EdgeInsets.all(8.0),
//       child: Stack(
//         alignment: Alignment.bottomCenter,
//         children: [
//           Container(
//             height: double.infinity,
//             width: 20,
//             color: Colors.grey,
//           ),
//           Container(
//             color: color ?? Colors.blue,
//             height: percentage == null ? 0 : height! * percentage!,
//             width: 20,
//             child: const Align(
//               alignment: Alignment.centerLeft,
//               // child: Text(
//               //   percentage == null ? "0" : (percentage! * 100).toString(),
//               // ),
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }
// class PercentageBar extends StatelessWidget {
//   final double percentage;
//   final double totalHeight;
//   final int calories;
//   const PercentageBar({
//     super.key,
//     required this.percentage,
//     required this.totalHeight,
//     required this.calories,
//   });
//   @override
//   Widget build(BuildContext context) {
//     // Ensure the percentage is between 0 and 100.
//     final clampedPercentage = percentage.clamp(0.0, 100.0);
//     // Calculate the height of the bar based on the percentage.
//     // const totalHeight = 200.0; // Set your desired total height
//     final barHeight = (clampedPercentage / 100.0) * (totalHeight * 0.86);
//     return Padding(
//       padding: const EdgeInsets.symmetric(horizontal: 8.0),
//       child: Container(
//         width: 50.0, // Set your desired width
//         height: totalHeight, // Set your desired total height
//         color: Colors.transparent, // Background color
//         child: Column(
//           mainAxisAlignment: MainAxisAlignment.end,
//           children: <Widget>[
//             ClipPath(
//               clipper: ExerciseGraphClipper(),
//               child: Container(
//                 decoration: BoxDecoration(
//                   borderRadius: BorderRadius.circular(3),
//                   color: AppColors.buttonColor,
//                 ),
//                 width: 50,
//                 height: totalHeight * 0.12,
//                 child: Center(
//                   child: Text(
//                     '$calories cal',
//                     style: AppTextStyles.formalTextStyle(
//                       color: Colors.white,
//                       fontSize: 15,
//                     ),
//                   ),
//                 ),
//               ),
//             ),
//             SizedBox(
//               height: totalHeight * 0.02,
//             ),
//             Container(
//               height: barHeight,
//               width: 20.0, // Should match the width of the parent container
//               // color: color ?? Colors.blue, // Bar color
//               decoration: BoxDecoration(
//                 borderRadius: BorderRadius.circular(4),
//                 gradient: percentage >= 70.0
//                     ? const LinearGradient(
//                         begin: Alignment(0.00, -1.00),
//                         end: Alignment(0, 1),
//                         colors: [
//                           Color(0xFFCE7575),
//                           Color(0x42CE7575),
//                           Color(0x3FCE7575)
//                         ],
//                       )
//                     : const LinearGradient(
//                         begin: Alignment(0.00, -1.00),
//                         end: Alignment(0, 1),
//                         colors: [
//                           Color(0xFF307CA0),
//                           Color(0x3F146C94),
//                         ],
//                       ),
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }
// class ExerciseGraphClipper extends CustomClipper<Path> {
//   @override
//   Path getClip(Size size) {
//     var height = size.height;
//     var width = size.width;
//     var path = Path();
//     path.lineTo(0, height * 0.75);
//     path.conicTo(width * 0.5, height, width, height * 0.75, width);
//     path.lineTo(width, 0);
//     path.close();
//     return path;
//   }
//   @override
//   bool shouldReclip(CustomClipper<Path> oldClipper) => false;
// }
