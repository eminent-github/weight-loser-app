/// Flutter package imports
library;

import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
// ignore: depend_on_referenced_packages
import 'package:intl/intl.dart';

/// Gauge import.
import 'package:syncfusion_flutter_gauges/gauges.dart';
import 'package:weight_loss_app/common/app_text_styles.dart';
import 'package:weight_loss_app/modules/deep_sleep/controller/deep_sleep_controller.dart';
import '../../../../common/app_colors.dart';

/// Local import.

/// Renders the gauge sleep tracker sample.
class SleepTrackerSample extends StatefulWidget {
  /// Creates the gauge sleep tracker sample.
  const SleepTrackerSample({
    super.key,
  });

  @override
  State<SleepTrackerSample> createState() => _SleepTrackerSampleState();
}

class _SleepTrackerSampleState extends State<SleepTrackerSample> {
  double wakeTime = 3;
  double sleepTime = 12;
  double sleepingTime = 9;
  final DeepSleepController controller = Get.find<DeepSleepController>();
  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    double height = size.height;
    double width = size.width;
    // final bool isDarkTheme =
    //     Theme.of(context).brightness == Brightness.dark ? true : false;
    return Center(
      child: Column(
        children: <Widget>[
          SizedBox(height: height * 0.02),
          SizedBox(
            height: height * 0.35,
            child: SfRadialGauge(
              axes: <RadialAxis>[
                RadialAxis(
                  showFirstLabel: false,
                  showLastLabel: true,
                  axisLineStyle: AxisLineStyle(
                      thickness: 0.06,
                      thicknessUnit: GaugeSizeUnit.factor,
                      color: Colors.lightBlue[50]),
                  minorTicksPerInterval: 0,
                  majorTickStyle: const MajorTickStyle(length: 0),
                  maximum: 24,
                  interval: 6,
                  startAngle: 270,
                  endAngle: 0,
                  onLabelCreated: (AxisLabelCreatedArgs args) {
                    log(args.text);
                    // if (args.text == '6') {
                    //   args.text = '12';
                    // } else if (args.text == '9') {
                    //   args.text = '3';
                    // } else if (args.text == '12') {
                    //   args.text = '6';
                    // } else if (args.text == '3') {
                    //   args.text = '9';
                    // }
                  },
                  pointers: <GaugePointer>[
                    WidgetPointer(
                      enableDragging: true,
                      value: _wakeupTimeValue,
                      onValueChanged: _handleWakeupTimeValueChanged,
                      onValueChanging: _handleWakeupTimeValueChanging,
                      onValueChangeStart: _handleWakeupTimeValueStart,
                      onValueChangeEnd: _handleWakeupTimeValueEnd,
                      child: Container(
                        decoration: BoxDecoration(
                          color: AppColors.buttonColor,
                          shape: BoxShape.circle,
                        ),
                        height: _wakeupTimePointerHeight,
                        width: _wakeupTimePointerWidth,
                        child: Center(
                            child: Icon(
                          Icons.wb_sunny_outlined,
                          size: height * 0.02,
                          color: Colors.white,
                        )),
                      ),
                    ),
                    WidgetPointer(
                      enableDragging: true,
                      value: _bedTimeValue,
                      onValueChanged: _handleBedTimeValueChanged,
                      onValueChanging: _handleBedTimeValueChanging,
                      onValueChangeStart: _handleBedTimeValueStart,
                      onValueChangeEnd: _handleBedTimeValueEnd,
                      child: Container(
                        decoration: BoxDecoration(
                          color: AppColors.buttonColor,
                          shape: BoxShape.circle,
                        ),
                        height: _bedTimePointerHeight,
                        width: _bedTimePointerWidth,
                        child: Center(
                          child: Icon(
                            Icons.bedtime,
                            color: Colors.white,
                            size: height * 0.02,
                          ),
                        ),
                      ),
                    ),
                  ],
                  ranges: <GaugeRange>[
                    GaugeRange(
                        endValue: _bedTimeValue,
                        sizeUnit: GaugeSizeUnit.factor,
                        startValue: _wakeupTimeValue,
                        color: AppColors.buttonColor,
                        startWidth: 0.08,
                        endWidth: 0.08)
                  ],
                  annotations: <GaugeAnnotation>[
                    GaugeAnnotation(
                        widget: SizedBox(
                          height: height * 0.1,
                          width: width * 0.8,
                          child: Stack(
                            alignment: AlignmentDirectional.center,
                            children: <Widget>[
                              AnimatedPositioned(
                                right: (_isWakeupTime && !_isBedTime)
                                    ? width * 0.25
                                    : width * 0.4,
                                duration: const Duration(milliseconds: 300),
                                curve: Curves.decelerate,
                                child: AnimatedOpacity(
                                  opacity: _isWakeupTime ? 1.0 : 0.0,
                                  duration: (_isWakeupTime && _isBedTime)
                                      ? const Duration(milliseconds: 800)
                                      : const Duration(milliseconds: 200),
                                  child: CustomAnimatedBuilder(
                                    value: !_isBedTime ? 1.1 : 0.6,
                                    curve: Curves.decelerate,
                                    duration: const Duration(milliseconds: 300),
                                    builder: (BuildContext context,
                                            Widget? child,
                                            Animation<dynamic> animation) =>
                                        Transform.scale(
                                      scale: animation.value,
                                      child: child,
                                    ),
                                    child: Column(
                                      mainAxisSize: MainAxisSize.min,
                                      children: <Widget>[
                                        Text(
                                          'Bed Time',
                                          style: TextStyle(
                                            fontWeight: FontWeight.w700,
                                            fontSize: height * 0.032,
                                            color: AppColors.buttonColor,
                                          ),
                                        ),
                                        SizedBox(height: height * 0.01),
                                        Text(
                                          _wakeupTimeAnnotation,
                                          style: TextStyle(
                                              color: AppColors.buttonColor,
                                              fontWeight: FontWeight.w400,
                                              fontSize: height * 0.025),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                              AnimatedOpacity(
                                opacity:
                                    (_isBedTime && _isWakeupTime) ? 1.0 : 0.0,
                                duration: (_isWakeupTime && _isBedTime)
                                    ? const Duration(milliseconds: 800)
                                    : const Duration(milliseconds: 200),
                                child: Text(
                                  '-',
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                    fontSize: height * 0.04,
                                    color: AppColors.buttonColor,
                                  ),
                                ),
                              ),
                              AnimatedPositioned(
                                left: (_isBedTime && !_isWakeupTime)
                                    ? width * 0.25
                                    : width * 0.36,
                                duration: const Duration(milliseconds: 300),
                                curve: Curves.decelerate,
                                child: AnimatedOpacity(
                                  opacity: _isBedTime ? 1.0 : 0.0,
                                  duration: (_isWakeupTime && _isBedTime)
                                      ? const Duration(milliseconds: 800)
                                      : const Duration(milliseconds: 200),
                                  child: CustomAnimatedBuilder(
                                    value: !_isWakeupTime ? 1.1 : 0.6,
                                    curve: Curves.decelerate,
                                    duration: const Duration(milliseconds: 300),
                                    builder: (BuildContext context,
                                            Widget? child,
                                            Animation<dynamic> animation) =>
                                        Transform.scale(
                                      scale: animation.value,
                                      child: child,
                                    ),
                                    child: Column(
                                      mainAxisSize: MainAxisSize.min,
                                      children: <Widget>[
                                        Text(
                                          'Awake Time',
                                          style: TextStyle(
                                            fontWeight: FontWeight.w700,
                                            fontSize: height * 0.032,
                                            color: AppColors.buttonColor,
                                          ),
                                        ),
                                        SizedBox(height: height * 0.01),
                                        Text(
                                          _bedTimeAnnotation,
                                          style: TextStyle(
                                              fontWeight: FontWeight.w400,
                                              color: AppColors.buttonColor,
                                              fontSize: height * 0.025),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        angle: 0),
                  ],
                ),
              ],
            ),
          ),
          SizedBox(height: height * 0.02),
          Text(
            _sleepMinutes == '00'
                ? '${sleepingTime > 12.00 ? sleepingTime.round() : sleepingTime.floor()} hrs'
                : '${sleepingTime > 12.00 ? sleepingTime.round() : sleepingTime.floor()} hrs '
                    '$_sleepMinutes mins',
            style: TextStyle(
                fontSize: height * 0.03,
                color: AppColors.buttonColor,
                fontWeight: FontWeight.w500),
          ),
          SizedBox(height: height * 0.01),
          Text(
            'Total Sleep time',
            style: TextStyle(
                fontSize: height * 0.02,
                color: AppColors.buttonColor,
                fontWeight: FontWeight.w400),
          ),
          SizedBox(height: height * 0.03),
          SizedBox(
            height: height * 0.05,
            width: width * 0.4,
            child: Obx(
              () => Material(
                color: AppColors.buttonColor,
                borderRadius: BorderRadius.circular(50),
                child: InkWell(
                  onTap: () {
                    log("awakeTIme $_bedTimeAnnotation");
                    log("bedTime $_wakeupTimeAnnotation");
                    // if (DateTime.now().isBefore(controller
                    //     .filterDate.value
                    //     .add(const Duration(days: 1)))) {
                    //   log("bedtime: $_bedTimeAnnotation awakeTime: $_wakeupTimeAnnotation");
                    //   controller.postDeepSleepApi(
                    //     totalSleep: sleepingTime.hours.inHours < 10
                    //         ? "${DateFormat("yyyy-MM-dd").format(DateTime.now())}T0${sleepingTime.hours}"
                    //         : "${DateFormat("yyyy-MM-dd").format(DateTime.now())}T${sleepingTime.hours}",
                    //     awakeTime: _bedTimeAnnotation,
                    //     deepTime: _wakeupTimeAnnotation,
                    //   );
                    // }
                  },
                  borderRadius: BorderRadius.circular(50),
                  child: Center(
                    child: Text(
                      "Save",
                      style: AppTextStyles.formalTextStyle(
                        color: AppColors.white,
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  /// Dragged pointer new value is updated to range.
  void _handleWakeupTimeValueChanged(double value) {
    setState(() {
      _wakeupTimeValue = value;
      final int wakeupTimeValue = _wakeupTimeValue.abs().toInt();
      // ignore: no_leading_underscores_for_local_identifiers
      final int _hourValue = wakeupTimeValue;
      final List<String> minList =
          _wakeupTimeValue.toStringAsFixed(2).split('.');
      double currentMinutes = double.parse(minList[1]);
      currentMinutes = (currentMinutes * 60) / 100;
      final String minutesValue = currentMinutes.toStringAsFixed(0);

      final double hour = (_hourValue >= 0 && _hourValue <= 6)
          ? (_hourValue + 6)
          : (_hourValue >= 6 && _hourValue <= 12)
              ? _hourValue - 6
              : 0;
      final String hourValue = hour.toString().split('.')[0];

      _wakeupTimeAnnotation =
          '${(hour >= 6 && hour < 10) ? '0$hourValue' : hourValue}:${minutesValue.length == 1 ? hour >= 11 ? '59' : '0$minutesValue' : minutesValue}${_hourValue >= 6 ? ' pm' : ' pm'}';

      _wakeupTime =
          '${_hourValue + 6 < 10 ? '0$_hourValue' : _hourValue.toString()}:${minutesValue.length == 1 ? '0$minutesValue' : minutesValue}';

      final DateFormat dateFormat = DateFormat('dd/MM/yyyy HH:mm');
      final double wakeupValue = double.parse(_wakeupTime.replaceAll(':', '.'));
      final DateTime wakeup = dateFormat
          .parse('01/01/1970 $_wakeupTime')
          .add(const Duration(hours: 18))
          .subtract(Duration(minutes: wakeupValue >= 5.00 ? 0 : 0));

      final DateTime sleep = dateFormat.parse(
          _bedTime == '09:00 pm' ? '02/01/1970 12:00' : '02/01/1970 $_bedTime');
      final String sleepDuration = sleep.difference(wakeup).toString();
      wakeTime = value;
      sleepingTime = sleepTime - wakeTime;
      _sleepMinutes = sleepDuration.split(':')[1];
    });
  }

  /// Cancelled the dragging when pointer value reaching the axis end/start value, greater/less than another
  /// pointer value
  void _handleWakeupTimeValueChanging(ValueChangingArgs args) {
    if (args.value >= 6 && args.value < 12) {
      args.cancel = true;
    }

    _wakeupTimePointerWidth = _wakeupTimePointerHeight = 40.0;
  }

  /// Cancelled the dragging when pointer value reaching the axis end/start value, greater/less than another
  /// pointer value
  void _handleBedTimeValueChanging(ValueChangingArgs args) {
    if (args.value >= 0 && args.value < 6) {
      args.cancel = true;
    }

    _bedTimePointerWidth = _bedTimePointerHeight = 40.0;
  }

  /// Dragged pointer new value is updated to range.
  void _handleBedTimeValueChanged(double bedTimeValue) {
    setState(() {
      _bedTimeValue = bedTimeValue;
      final int value = _bedTimeValue.abs().toInt();
      final int hourValue = value;

      final List<String> minList = _bedTimeValue.toStringAsFixed(2).split('.');
      double currentMinutes = double.parse(minList[1]);
      currentMinutes = (currentMinutes * 60) / 100;
      final String minutesValue = currentMinutes.toStringAsFixed(0);

      _bedTimeAnnotation =
          '${(hourValue >= 0 && hourValue <= 6) ? (hourValue + 6).toString() : (hourValue >= 6 && hourValue <= 12) ? '0${hourValue - 6}' : ''}:${minutesValue.length == 1 ? '0$minutesValue' : minutesValue}${value >= 6 ? ' am' : ' pm'}';

      _bedTime =
          '${hourValue < 10 ? '0$hourValue' : hourValue.toString()}:${minutesValue.length == 1 ? '0$minutesValue' : minutesValue}';

      final DateFormat dateFormat = DateFormat('dd/MM/yyyy HH:mm');
      final DateTime wakeup = dateFormat
          .parse(_wakeupTime == '06:00 am'
              ? '01/01/1970 03:00'
              : '01/01/1970 $_wakeupTime')
          .subtract(const Duration(hours: 6))
          .subtract(const Duration(minutes: 0));
      final DateTime sleep = dateFormat.parse('02/01/1970 $_bedTime');
      final String sleepDuration = sleep.difference(wakeup).toString();
      sleepTime = bedTimeValue;
      sleepingTime = sleepTime - wakeTime;
      _sleepMinutes = sleepDuration.split(':')[1];
    });
  }

  void _handleWakeupTimeValueStart(double value) {
    _isBedTime = false;
  }

  void _handleWakeupTimeValueEnd(double value) {
    setState(() {
      _isBedTime = true;
    });

    _wakeupTimePointerWidth = _wakeupTimePointerHeight = 30.0;
  }

  void _handleBedTimeValueStart(double value) {
    _isWakeupTime = false;
  }

  void _handleBedTimeValueEnd(double value) {
    setState(() {
      _isWakeupTime = true;
    });

    _bedTimePointerWidth = _bedTimePointerHeight = 30.0;
  }

  double _wakeupTimeValue = 3;
  double _bedTimeValue = 12;
  String _bedTimeAnnotation = '06:00 am';
  String _wakeupTimeAnnotation = '09:00 pm';
  bool _isWakeupTime = true;
  bool _isBedTime = true;
  String _sleepMinutes = '00';
  String _bedTime = '06:00 am';
  String _wakeupTime = '09:00 pm';
  double _bedTimePointerWidth = 30.0;
  double _bedTimePointerHeight = 30.0;
  double _wakeupTimePointerWidth = 30.0;
  double _wakeupTimePointerHeight = 30.0;
}

/// Widget of custom animated builder.
class CustomAnimatedBuilder extends StatefulWidget {
  /// Creates a instance for [CustomAnimatedBuilder].
  const CustomAnimatedBuilder({
    super.key,
    required this.value,
    required this.builder,
    this.duration = const Duration(milliseconds: 200),
    this.curve = Curves.easeInOut,
    this.child,
  });

  /// Specifies the animation duration.
  final Duration duration;

  /// Specifies the curve of animation.
  final Curve curve;

  /// Specifies the animation controller value.
  final double value;

  /// Specifies the child widget.
  final Widget? child;

  /// Specifies the builder function.
  final Widget Function(
    BuildContext context,
    Widget? child,
    Animation<dynamic> animation,
  ) builder;

  @override
  State<CustomAnimatedBuilder> createState() => _CustomAnimatedBuilderState();
}

class _CustomAnimatedBuilderState extends State<CustomAnimatedBuilder>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;

  @override
  void initState() {
    _animationController = AnimationController(
      vsync: this,
      value: widget.value,
      lowerBound: double.negativeInfinity,
      upperBound: double.infinity,
    );
    super.initState();
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  void didUpdateWidget(CustomAnimatedBuilder oldWidget) {
    super.didUpdateWidget(oldWidget);

    if (oldWidget.value != widget.value) {
      _animationController.animateTo(
        widget.value,
        duration: widget.duration,
        curve: widget.curve,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _animationController,
      builder: (BuildContext context, Widget? child) => widget.builder(
        context,
        widget.child,
        _animationController,
      ),
    );
  }
}
