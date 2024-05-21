import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import 'package:weight_loss_app/common/app_colors.dart';
import 'package:weight_loss_app/common/app_text_styles.dart';
import 'package:weight_loss_app/modules/deep_sleep/controller/deep_sleep_controller.dart';

class ColumnSleepChart extends StatelessWidget {
  const ColumnSleepChart({
    super.key,
    required this.sleepTimeList,
  });
  final List<SleepStat> sleepTimeList;
  @override
  Widget build(BuildContext context) {
    return SfCartesianChart(
      // backgroundColor: AppColors.buttonColor.withOpacity(0.2),

      plotAreaBorderWidth: 0,
      primaryXAxis: CategoryAxis(
        majorGridLines: const MajorGridLines(
          width: 0,
        ),
        labelStyle: AppTextStyles.formalTextStyle(
          color: AppColors.buttonColor,
          fontWeight: FontWeight.w900,
          fontSize: 12,
        ),
      ),
      primaryYAxis: NumericAxis(
        majorGridLines: MajorGridLines(
            width: 1,
            color: Theme.of(context).primaryTextTheme.titleMedium!.color!,
            dashArray: const [4]),
        title: AxisTitle(
            text: "hrs",
            textStyle: TextStyle(
              color: Theme.of(context).primaryTextTheme.titleMedium!.color!,
            )),
        isVisible: true,
        minimum: 0,
        maximum: 24,
        interval: 4,
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
        builder: (data, point, series, pointIndex, seriesIndex) {
          SleepStat chartData = data as SleepStat;
          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 7),
            child: Text(
              "${chartData.hours}h",
              style: AppTextStyles.formalTextStyle(color: AppColors.white),
            ),
          );
        },
      ),
      series: <CartesianSeries>[
        ColumnSeries<SleepStat, String>(
            color: AppColors.buttonColor,
            borderRadius: BorderRadius.circular(5),
            dataSource: sleepTimeList,
            xValueMapper: (SleepStat data, _) => data.weekDay,
            yValueMapper: (data, _) => data.hours,
            enableTooltip: true,
            spacing: 0.2,
            pointColorMapper: (data, index) {
              return AppColors.buttonColor;
            })
      ],
    );
  }
}
