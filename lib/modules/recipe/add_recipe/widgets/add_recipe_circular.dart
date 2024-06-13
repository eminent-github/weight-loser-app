import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import 'package:weight_loss_app/common/app_text_styles.dart';

class CaloriesChart extends StatefulWidget {
  const CaloriesChart({
    super.key,
    this.carbColor,
    required this.carbs,
    required this.protien,
    required this.fat,
    this.fatColor,
    this.protienColor,
    required this.calories,
  });

  final Color? fatColor;
  final double carbs;
  final double protien;
  final double fat;
  final Color? protienColor;
  final Color? carbColor;
  final int calories;

  @override
  State<CaloriesChart> createState() => _CaloriesChartState();
}

class _CaloriesChartState extends State<CaloriesChart> {
  late List<ChartData> chartData;
  @override
  void initState() {
    chartData = [
      ChartData(' ', widget.carbs, widget.carbColor!),
      ChartData(' ', 1, const Color(0xffF0F0F0)),
      ChartData(' ', widget.protien, widget.protienColor!),
      ChartData(' ', 1, const Color(0xffF0F0F0)),
      ChartData(' ', widget.fat, widget.fatColor!),
      ChartData(' ', 1, const Color(0xffF0F0F0)),
    ];
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SfCircularChart(
      annotations: [
        CircularChartAnnotation(
          widget: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  widget.calories.toString(),
                  style: AppTextStyles.formalTextStyle(
                    fontWeight: FontWeight.bold,
                    color:
                        Theme.of(context).primaryTextTheme.titleMedium!.color!,
                  ),
                ),
                Text(
                  'Cal',
                  style: AppTextStyles.formalTextStyle(
                    fontSize: 10,
                    color:
                        Theme.of(context).primaryTextTheme.titleMedium!.color!,
                  ),
                )
              ],
            ),
          ),
        )
      ],
      series: <DoughnutSeries<ChartData, String>>[
        DoughnutSeries<ChartData, String>(
          dataSource: chartData,
          xValueMapper: (ChartData data, _) => data.category,
          yValueMapper: (ChartData data, _) => data.value,
          pointColorMapper: (ChartData data, _) => data.color,
          // dataLabelMapper: (ChartData data, _) => data.category,
          innerRadius: '80%',
          enableTooltip: false,
          dataLabelSettings: const DataLabelSettings(isVisible: false),
        ),
      ],
    );
  }
}

class ChartData {
  ChartData(this.category, this.value, this.color);
  String category;
  double value;
  Color color;
}
