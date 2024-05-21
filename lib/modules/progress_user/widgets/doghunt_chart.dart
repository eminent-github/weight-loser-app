import 'package:flutter/cupertino.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

import '../../../common/app_colors.dart';

class ProgressDoughnutChart extends StatefulWidget {
  const ProgressDoughnutChart({
    Key? key,
    this.width,
    this.height,
    this.color1,
    required  this.value1,
    required this.value2,
    required this.value3,

    this.color3,
    this.color2,
  }) : super(key: key);

  final double? width;
  final double? height;
  final Color? color1;

  final int value1;
  final int value2;
  final int value3;
  final Color? color2;
  final Color? color3;

  State<ProgressDoughnutChart> createState() => _ProgressDoughnutChartState();
}

class _ProgressDoughnutChartState extends State<ProgressDoughnutChart> {
  late List<ChartData> chartData;
  void initState() {
    chartData = [
      ChartData('0.3%', widget.value1, widget.color1!),
      ChartData('', 1, Color(0xffF0F0F0)),
      ChartData('0.2', widget.value2, widget.color2!),
      ChartData('', 1, Color(0xffF0F0F0)),
      ChartData('0.1%', widget.value3, widget.color3!),
      ChartData('', 1, Color(0xffF0F0F0)),
      ChartData('', 1, Color(0xffF0F0F0)),
      ChartData('', 1, Color(0xffF0F0F0)),
    ];
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SfCircularChart(
      annotations: [CircularChartAnnotation(widget: Center(child: Column(

        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text('Total Avg.',style: TextStyle(fontWeight: FontWeight.bold,color: AppColors.buttonColor)),
          SizedBox(height: 5,),
          Text('11.22%',style: TextStyle(fontSize: 10,color: AppColors.buttonColor),)
        ],
      ),))],


      series: <DoughnutSeries<ChartData, String>>[
        DoughnutSeries<ChartData, String>(


          dataSource: chartData,
          xValueMapper: (ChartData data, _) => data.category,
          yValueMapper: (ChartData data, _) => data.value,
          pointColorMapper: (ChartData data, _) => data.color,
          dataLabelMapper: (ChartData data, _) => data.category,
          innerRadius: '70%',
          dataLabelSettings: DataLabelSettings(isVisible: true),
        ),
      ],
    );
  }
}

class ChartData {
  ChartData(this.category, this.value, this.color);
  String category;
  int value;
  Color color;
}