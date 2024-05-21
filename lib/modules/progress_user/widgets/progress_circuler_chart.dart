import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import 'package:weight_loss_app/common/app_colors.dart';
import 'package:weight_loss_app/common/app_text_styles.dart';

class DonutChart extends StatelessWidget {
  const DonutChart({
    super.key,
    required this.doghuntchartDataList,
    required this.totalAvg,
  });
  final List<DoghuntchartData> doghuntchartDataList;
  final String totalAvg;
  @override
  Widget build(BuildContext context) {
    return SfCircularChart(
      annotations: <CircularChartAnnotation>[
        CircularChartAnnotation(
          widget: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'Total Avg.',
                style: AppTextStyles.formalTextStyle(
                  color: AppColors.buttonColor,
                  // fontSize: 10,
                ),
              ),
              Text(
                "$totalAvg%",
                style: AppTextStyles.formalTextStyle(
                  color: AppColors.buttonColor,
                  // fontSize: 10,
                  fontWeight: FontWeight.w700,
                ),
              ),
            ],
          ),
        ),
      ],
      series: <CircularSeries>[
        DoughnutSeries<DoghuntchartData, String>(
          dataSource: doghuntchartDataList,
          pointColorMapper: (data, _) =>
              data.value == 0 ? const Color(0xffEEEEEE) : data.color,
          xValueMapper: (data, _) => data.label,
          dataLabelMapper: (data, _) => data.value == 0 ? " " : data.label,
          radius: "100%",
          innerRadius: "53%",
          strokeColor: AppColors.white,
          strokeWidth: 3,
          dataLabelSettings: DataLabelSettings(
              isVisible: true,
              textStyle: AppTextStyles.formalTextStyle(
                  color: AppColors.white, fontWeight: FontWeight.bold)),
          yValueMapper: (data, _) => data.value == 0 ? 1 : data.value,
        )
      ],
    );
  }
}

class DoghuntchartData {
  final double value;
  final String label;
  final Color color;
  DoghuntchartData(
      {required this.value, required this.label, required this.color});
}
