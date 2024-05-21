// import 'package:fl_chart/fl_chart.dart';
// import 'package:flutter/material.dart';
// import 'package:weight_loss_app/common/app_colors.dart';

// class CustomGoalDateChart extends StatelessWidget {
//   const CustomGoalDateChart({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return LineChart(
//       mainData(),
//     );
//   }

//   Widget bottomTitleWidgets(double value, TitleMeta meta) {
//     TextStyle style = TextStyle(
//       fontWeight: FontWeight.bold,
//       fontSize: 13,
//       color: Colors.grey.shade500,
//     );
//     Widget text;
//     switch (value.toInt()) {
//       case 0:
//         text = Text('July', style: style, textAlign: TextAlign.center);
//         break;
//       case 3:
//         text = Text('Aug', style: style, textAlign: TextAlign.center);
//         break;
//       case 6:
//         text = Text('Sep', style: style, textAlign: TextAlign.center);
//         break;
//       case 9:
//         text = Text('Oct', style: style, textAlign: TextAlign.center);
//         break;
//       case 12:
//         text = Text('Nov', style: style, textAlign: TextAlign.center);
//         break;
//       case 15:
//         text = Text('Dec', style: style, textAlign: TextAlign.center);
//         break;
//       default:
//         text = Text('', style: style, textAlign: TextAlign.center);
//         break;
//     }

//     return SideTitleWidget(
//       axisSide: meta.axisSide,
//       child: text,
//     );
//   }

//   Widget leftTitleWidgets(double value, TitleMeta meta) {
//     TextStyle style = TextStyle(
//       fontWeight: FontWeight.bold,
//       fontSize: 11,
//       color: Colors.grey.shade800,
//     );
//     String text;
//     switch (value.toInt()) {
//       case 0:
//         text = '70';
//         break;
//       case 3:
//         text = '121';
//         break;
//       case 6:
//         text = '128';
//         break;
//       case 9:
//         text = '136';
//         break;
//       case 12:
//         text = '143';
//         break;
//       case 15:
//         text = '150';
//         break;
//       default:
//         return Container();
//     }

//     return Text(
//       text,
//       style: style,
//       textAlign: TextAlign.left,
//     );
//   }

//   LineChartData mainData() {
//     return LineChartData(
//       lineTouchData: const LineTouchData(
//           touchTooltipData: LineTouchTooltipData(
//             tooltipBgColor: Colors.black,
//           ),
//           // touchCallback: (LineTouchResponse touchResponse) {},
//           handleBuiltInTouches: true,
//           enabled: true),
//       gridData: FlGridData(
//         show: true,
//         drawVerticalLine: true,
//         drawHorizontalLine: false,
//         verticalInterval: 3,
//         getDrawingVerticalLine: (value) {
//           return const FlLine(
//             color: Colors.black26,
//             strokeWidth: 1,
//           );
//         },
//       ),
//       titlesData: FlTitlesData(
//         show: true,
//         rightTitles: const AxisTitles(
//           sideTitles: SideTitles(showTitles: false),
//         ),
//         topTitles: const AxisTitles(sideTitles: SideTitles(showTitles: false)),
//         bottomTitles: AxisTitles(
//           sideTitles: SideTitles(
//             showTitles: true,
//             reservedSize: 30,
//             interval: 1,
//             getTitlesWidget: bottomTitleWidgets,
//           ),
//         ),
//         leftTitles: AxisTitles(
//           sideTitles: SideTitles(
//             showTitles: true,
//             interval: 1,
//             getTitlesWidget: leftTitleWidgets,
//             reservedSize: 30,
//           ),
//         ),
//       ),
//       borderData: FlBorderData(
//         show: true,
//         border: Border.all(color: Colors.black26),
//       ),
//       minX: 0,
//       maxX: 15,
//       minY: 0,
//       maxY: 16,
//       //  lineTouchData: LineTouchData(
//       //   enabled: true,
//       //   touchCallback:
//       //       (FlTouchEvent event, LineTouchResponse? touchResponse) {
//       //     // TODO : Utilize touch event here to perform any operation
//       //   },
//       //   touchTooltipData: LineTouchTooltipData(
//       //     tooltipBgColor: Colors.blue,
//       //     tooltipRoundedRadius: 20.0,
//       //     showOnTopOfTheChartBoxArea: true,
//       //     fitInsideHorizontally: true,
//       //     tooltipMargin: 0,
//       //     getTooltipItems: (touchedSpots) {
//       //       return touchedSpots.map(
//       //         (LineBarSpot touchedSpot) {
//       //           const textStyle = TextStyle(
//       //             fontSize: 10,
//       //             fontWeight: FontWeight.w700,
//       //             color: Colors.white,
//       //           );
//       //           return LineTooltipItem(
//       //             points[touchedSpot.spotIndex].y.toStringAsFixed(2),
//       //             textStyle,
//       //           );
//       //         },
//       //       ).toList();
//       //     },
//       //   ),
//       //   getTouchedSpotIndicator:
//       //       (LineChartBarData barData, List<int> indicators) {
//       //     return indicators.map(
//       //       (int index) {
//       //         final line = FlLine(
//       //             color: Colors.grey,
//       //             strokeWidth: 1,
//       //             dashArray: [2, 4]);
//       //         return TouchedSpotIndicatorData(
//       //           line,
//       //           FlDotData(show: false),
//       //         );
//       //       },
//       //     ).toList();
//       //   },
//       //   getTouchLineEnd: (_, __) => double.infinity
//       // ),
//       lineBarsData: [
//         LineChartBarData(
//           spots: const [
//             FlSpot(0, 13),
//             FlSpot(3, 10),
//             FlSpot(6, 11),
//             FlSpot(9, 15),
//             FlSpot(12, 11),
//             FlSpot(15, 12),
//           ],
//           isCurved: true,
//           color: const Color(0xffBB8B81),
//           barWidth: 4,
//           isStrokeCapRound: true,
//           dotData: const FlDotData(
//             show: false,
//           ),
//           belowBarData: BarAreaData(show: true, color: Colors.transparent),
//           shadow: Shadow(
//             color: Colors.grey.shade700.withOpacity(0.5),
//             blurRadius: 3,
//             offset: const Offset(3, 5),
//           ),
//           show: true,
//         ),
//         LineChartBarData(
//           spots: const [
//             FlSpot(0, 8.7),
//             FlSpot(3, 7.5),
//             FlSpot(6, 6.2),
//             FlSpot(9, 4.5),
//             FlSpot(12, 2.5),
//             FlSpot(15, 0),
//           ],
//           isCurved: true,
//           color: AppColors.buttonColor,
//           barWidth: 4,
//           isStrokeCapRound: true,
//           dotData: FlDotData(
//             show: true,
//             checkToShowDot: (spot, barData) {
//               if (spot.x == 12.0) {
//                 return true;
//               }
//               return false;
//             },
//           ),
//           belowBarData: BarAreaData(show: true, color: Colors.transparent),
//           shadow: Shadow(
//             color: Colors.grey.shade700.withOpacity(0.5),
//             blurRadius: 3,
//             offset: const Offset(3, 5),
//           ),
//           show: true,
//         ),
//       ],
//     );
//   }
// }

// class CustomLineChart extends StatelessWidget {
//   const CustomLineChart({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return LineChart(
//       mainData(),
//     );
//   }

//   Widget bottomTitleWidgets(double value, TitleMeta meta) {
//     TextStyle style = TextStyle(
//       fontWeight: FontWeight.bold,
//       fontSize: 13,
//       color: Colors.grey.shade500,
//     );
//     Widget text;
//     switch (value.toInt()) {
//       case 0:
//         text = Text('July', style: style, textAlign: TextAlign.center);
//         break;
//       case 3:
//         text = Text('Aug', style: style, textAlign: TextAlign.center);
//         break;
//       case 6:
//         text = Text('Sep', style: style, textAlign: TextAlign.center);
//         break;
//       case 9:
//         text = Text('Oct', style: style, textAlign: TextAlign.center);
//         break;
//       case 12:
//         text = Text('Nov', style: style, textAlign: TextAlign.center);
//         break;
//       case 15:
//         text = Text('Dec', style: style, textAlign: TextAlign.center);
//         break;
//       default:
//         text = Text('', style: style, textAlign: TextAlign.center);
//         break;
//     }

//     return SideTitleWidget(
//       axisSide: meta.axisSide,
//       child: text,
//     );
//   }

//   Widget leftTitleWidgets(double value, TitleMeta meta) {
//     TextStyle style = TextStyle(
//       fontWeight: FontWeight.bold,
//       fontSize: 11,
//       color: Colors.grey.shade800,
//     );
//     String text;
//     switch (value.toInt()) {
//       case 0:
//         text = '70';
//         break;
//       case 3:
//         text = '121';
//         break;
//       case 6:
//         text = '128';
//         break;
//       case 9:
//         text = '136';
//         break;
//       case 12:
//         text = '143';
//         break;
//       case 15:
//         text = '150';
//         break;
//       default:
//         return Container();
//     }

//     return Text(
//       text,
//       style: style,
//       textAlign: TextAlign.left,
//     );
//   }

//   LineChartData mainData() {
//     return LineChartData(
//       lineTouchData: const LineTouchData(
//           touchTooltipData: LineTouchTooltipData(
//             tooltipBgColor: Colors.black,
//           ),
//           // touchCallback: (LineTouchResponse touchResponse) {},
//           handleBuiltInTouches: true,
//           enabled: true),
//       gridData: FlGridData(
//         show: true,
//         drawVerticalLine: true,
//         drawHorizontalLine: false,
//         verticalInterval: 3,
//         getDrawingVerticalLine: (value) {
//           return const FlLine(
//             color: Colors.black26,
//             strokeWidth: 1,
//           );
//         },
//       ),
//       titlesData: FlTitlesData(
//         show: true,
//         rightTitles: const AxisTitles(
//           sideTitles: SideTitles(showTitles: false),
//         ),
//         topTitles: const AxisTitles(sideTitles: SideTitles(showTitles: false)),
//         bottomTitles: AxisTitles(
//           sideTitles: SideTitles(
//             showTitles: true,
//             reservedSize: 30,
//             interval: 1,
//             getTitlesWidget: bottomTitleWidgets,
//           ),
//         ),
//         leftTitles: AxisTitles(
//           sideTitles: SideTitles(
//             showTitles: true,
//             interval: 1,
//             getTitlesWidget: leftTitleWidgets,
//             reservedSize: 30,
//           ),
//         ),
//       ),
//       borderData: FlBorderData(
//         show: true,
//         border: Border.all(color: Colors.black26),
//       ),
//       minX: 0,
//       maxX: 15,
//       minY: 0,
//       maxY: 16,
//       lineBarsData: [
//         LineChartBarData(
//           spots: const [
//             FlSpot(0, 15),
//             FlSpot(3, 14),
//             FlSpot(6, 12.5),
//             FlSpot(9, 10),
//             FlSpot(12, 6),
//             FlSpot(15, 0),
//           ],
//           isCurved: true,
//           color: AppColors.buttonColor,
//           barWidth: 4,
//           isStrokeCapRound: true,
//           dotData: FlDotData(
//             show: true,
//             checkToShowDot: (spot, barData) {
//               if (spot.x == 12.0) {
//                 return true;
//               }
//               return false;
//             },
//           ),
//           belowBarData: BarAreaData(show: true, color: Colors.transparent),
//           shadow: Shadow(
//             color: Colors.grey.shade700.withOpacity(0.5),
//             blurRadius: 3,
//             offset: const Offset(3, 5),
//           ),
//           show: true,
//         ),
//       ],
//     );
//   }
// }
