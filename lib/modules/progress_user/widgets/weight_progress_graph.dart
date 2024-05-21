import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import 'package:weight_loss_app/common/app_colors.dart';
import 'package:weight_loss_app/common/app_text_styles.dart';
import 'package:weight_loss_app/modules/progress_user/modal/user_stats_modal.dart';

class WeightProgressGraph extends StatelessWidget {
  const WeightProgressGraph({
    super.key,
    required this.weightList,
    required this.currentWeight,
    required this.startWeightDate,
    required this.weightUnit,
  });
  final List<UpdateWeight> weightList;
  final num currentWeight;
  final String startWeightDate;
  final String weightUnit;
  @override
  Widget build(BuildContext context) {
    // print(currentWeight);
    // print(startWeightDate);
    // final List<UpdateWeight> chartData = [
    //   UpdateWeight(date: "2023-11-7T00:00:00", weight: 245),
    //   UpdateWeight(date: "2023-11-14T00:00:00", weight: 240),
    //   UpdateWeight(date: "2023-11-21T00:00:00", weight: 235),
    //   UpdateWeight(date: "2023-11-30T00:00:00", weight: 240)
    // ];
    weightList.insert(
        0, UpdateWeight(date: startWeightDate, weight: currentWeight));

    return SfCartesianChart(
      plotAreaBorderWidth: 0,
      primaryXAxis: CategoryAxis(
        isVisible: true,
        majorGridLines: const MajorGridLines(
          width: 0,
        ),
        labelStyle: AppTextStyles.formalTextStyle(
          color: AppColors.buttonColor,
          fontSize: 12,
        ),
      ),
      primaryYAxis: NumericAxis(
        labelStyle: AppTextStyles.formalTextStyle(
          color: AppColors.buttonColor,
          fontSize: 12,
        ),
      ),
      tooltipBehavior: TooltipBehavior(
        enable: true,
        elevation: 5,
        color: const Color(0xff566f7a),
        tooltipPosition: TooltipPosition.auto,
        builder: (data, point, series, pointIndex, seriesIndex) {
          UpdateWeight chartData = data as UpdateWeight;
          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 7),
            child: Text(
              "${chartData.weight} $weightUnit",
              style: AppTextStyles.formalTextStyle(color: AppColors.white),
            ),
          );
        },
      ),
      series: <CartesianSeries>[
        SplineSeries<UpdateWeight, String>(
          color: AppColors.buttonColor,
          dataSource: weightList,
          width: 3.5,
          xValueMapper: (data, _) => DateFormat("MMM dd")
              .format(DateTime.tryParse(data.date!) ?? DateTime.now()),
          yValueMapper: (data, _) => data.weight ?? 0,
          markerSettings: const MarkerSettings(
            isVisible: true,
          ),
          enableTooltip: true,
        ),
      ],
    );
  }
}
