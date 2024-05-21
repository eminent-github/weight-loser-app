import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import 'package:weight_loss_app/common/app_colors.dart';
import 'package:weight_loss_app/common/app_text_styles.dart';
import 'package:weight_loss_app/modules/progress_user/modal/user_stats_modal.dart';

class ProgressColumnChart extends StatelessWidget {
  const ProgressColumnChart({
    super.key,
    required this.progressExerciseList,
  });
  final List<ProgressExercise> progressExerciseList;
  @override
  Widget build(BuildContext context) {
    print(progressExerciseList.length);
    return progressExerciseList.isEmpty
        ? Center(
            child: Text(
              "No Data found for Exercise",
              style: AppTextStyles.formalTextStyle(
                color: Theme.of(context).primaryTextTheme.titleMedium!.color!,
              ),
            ),
          )
        : SfCartesianChart(
            plotAreaBorderWidth: 0,
            primaryXAxis: CategoryAxis(
              majorGridLines: const MajorGridLines(
                width: 0,
              ),
              title: AxisTitle(
                  text: "Date",
                  textStyle: AppTextStyles.formalTextStyle(
                    color:
                        Theme.of(context).primaryTextTheme.titleMedium!.color!,
                  )),
              labelStyle: AppTextStyles.formalTextStyle(
                color: AppColors.buttonColor,
                fontWeight: FontWeight.w900,
                fontSize: 12,
              ),
            ),
            primaryYAxis: NumericAxis(
              majorGridLines:
                  const MajorGridLines(width: 2, color: AppColors.white),
              title: AxisTitle(
                  text: "Calories",
                  textStyle: AppTextStyles.formalTextStyle(
                    color:
                        Theme.of(context).primaryTextTheme.titleMedium!.color!,
                  )),
              isVisible: true,
              minimum: 0,
              labelStyle: AppTextStyles.formalTextStyle(
                color: AppColors.buttonColor,
                fontWeight: FontWeight.w900,
                fontSize: 12,
              ),
            ),
            tooltipBehavior: TooltipBehavior(
              enable: true,
              elevation: 5,
              color: const Color(0xff566f7a),
              tooltipPosition: TooltipPosition.auto,
              builder: (data, point, series, pointIndex, seriesIndex) {
                ProgressExercise chartData = data as ProgressExercise;
                return Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 10, vertical: 7),
                  child: Text(
                    "~${chartData.calories!.toPrecision(1)} kcal",
                    style:
                        AppTextStyles.formalTextStyle(color: AppColors.white),
                  ),
                );
              },
            ),
            series: <CartesianSeries>[
              ColumnSeries<ProgressExercise, String>(
                  color: AppColors.buttonColor,
                  borderRadius: BorderRadius.circular(5),
                  dataSource: progressExerciseList,
                  xValueMapper: (ProgressExercise data, _) =>
                      DateFormat('dd').format(DateTime.parse(data.date!)),
                  yValueMapper: (data, _) => data.calories,
                  enableTooltip: true,
                  spacing: 0.1,
                  pointColorMapper: (data, index) {
                    return AppColors.buttonColor;
                  })
            ],
          );
  }
}
