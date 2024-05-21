import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:weight_loss_app/common/app_colors.dart';
import 'package:weight_loss_app/common/app_text_styles.dart';

// typedef OnDateSelected(date);

typedef OnDateSelected = dynamic Function(String date);

class MyCustomCalender extends StatefulWidget {
  final DateTime date;
  final DateTime? initialDate;
  final DateTime? lastDate;
  final Color? textColor;
  final Color? colorOfWeek;
  final Color? colorOfMonth;
  final double? fontSizeOfWeek;
  final FontWeight? fontWeightWeek;
  final double? fontSizeOfMonth;
  final FontWeight? fontWeightMonth;
  final Color? backgroundColor;
  final Color? selectedColor;
  final int? duration;
  final Curve? curve;
  final BoxShadow? selectedBoxShadow;
  final BoxShadow? unSelectedBoxShadow;
  final OnDateSelected? onDateSelected;
  final Widget tableCalenderIcon;
  final Color? tableCalenderButtonColor;
  final ThemeData? tableCalenderThemeData;
  final LinearGradient? gradient;
  final double borderRadius;
  final Color? selectedTextColor;

  const MyCustomCalender({
    super.key,
    required this.date,
    required this.tableCalenderIcon,
    this.initialDate,
    this.lastDate,
    this.textColor,
    this.curve,
    this.tableCalenderThemeData,
    this.selectedBoxShadow,
    this.unSelectedBoxShadow,
    this.duration,
    this.tableCalenderButtonColor,
    this.colorOfMonth,
    this.colorOfWeek,
    this.fontSizeOfWeek,
    this.fontWeightWeek,
    this.fontSizeOfMonth,
    this.fontWeightMonth,
    this.backgroundColor,
    this.selectedColor,
    this.gradient,
    this.borderRadius = 5.0,
    this.selectedTextColor,
    required this.onDateSelected,
  });

  @override
  _CalendarState createState() => _CalendarState();
}

class _CalendarState extends State<MyCustomCalender> {
  DateTime? _startDate;
  var selectedCalenderDate;
  final ScrollController _scrollController = ScrollController();

  calenderAnimation() {
    _scrollController.animateTo(
      _scrollController.position.maxScrollExtent,
      duration: Duration(seconds: widget.duration ?? 1),
      curve: widget.curve ?? Curves.fastOutSlowIn,
    );
  }

  @override
  void initState() {
    super.initState();
    selectedCalenderDate = widget.date;
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;

    DateTime findFirstDateOfTheWeek(DateTime dateTime) {
      if (dateTime.weekday == 7) {
        if (_scrollController.hasClients) {
          calenderAnimation();
        }
        return dateTime;
      } else {
        if (dateTime.weekday == 1 || dateTime.weekday == 2) {
          if (_scrollController.hasClients) {
            calenderAnimation();
          }
        }
        return dateTime.subtract(Duration(days: dateTime.weekday));
      }
    }

    _startDate = findFirstDateOfTheWeek(selectedCalenderDate);

    return SingleChildScrollView(
      controller: _scrollController,
      scrollDirection: Axis.horizontal,
      reverse: true,
      child: Row(
        children: <Widget>[
          ListView.builder(
            itemCount: 7,
            shrinkWrap: true,
            scrollDirection: Axis.horizontal,
            itemBuilder: (context, index) {
              DateTime? date = _startDate?.add(Duration(days: index));
              int? diffDays = date?.difference(selectedCalenderDate).inDays;
              return GestureDetector(
                onTap: () {
                  if (date.isBefore(DateTime.now())) {
                    widget.onDateSelected!(Utils.getDate(date));
                    setState(() {
                      selectedCalenderDate =
                          _startDate?.add(Duration(days: index));
                      _startDate = _startDate?.add(Duration(days: index));
                    });
                  }
                },
                child: Container(
                  width: 50,

                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                    color: diffDays != 0
                        ? widget.backgroundColor ?? Colors.white
                        : widget.selectedColor ?? AppColors.buttonColor,

                    borderRadius: BorderRadius.circular(widget.borderRadius),
                    // boxShadow: [
                    //   diffDays != 0
                    //       ? widget.selectedBoxShadow ??
                    //           BoxShadow(
                    //             color: CalenderColors.black.withOpacity(0.25),
                    //             spreadRadius: 0.0,
                    //             blurRadius: 10,
                    //             offset: Offset(
                    //                 0, 4), // changes position of shadow
                    //           )
                    //       : widget.unSelectedBoxShadow ??
                    //           BoxShadow(
                    //             color: CalenderColors.primaryColor
                    //                 .withOpacity(0.35),
                    //             spreadRadius: 2.0,
                    //             blurRadius: 10,
                    //             offset: Offset(
                    //                 0, 4), // changes position of shadow
                    //           )
                    // ],
                  ),
                  margin: const EdgeInsets.only(
                    left: 8,
                  ),
                  // ignore: deprecated_member_use
                  child: Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Text(
                          Utils.getDayOfMonth(date!),
                          style: TextStyle(
                            color: diffDays != 0
                                ? widget.colorOfMonth ??
                                    CalenderColors.primaryTextColor
                                : widget.selectedTextColor ?? AppColors.white,
                            fontSize: widget.fontSizeOfMonth ?? 20.0,
                            fontFamily: AppTextStyles.fontFamily,
                            fontWeight:
                                widget.fontWeightMonth ?? FontWeight.w500,
                          ),
                        ),
                        const SizedBox(height: 2.0),
                        Text(
                          Utils.getDayOfWeek(date),
                          style: TextStyle(
                              color: diffDays != 0
                                  ? widget.colorOfWeek ??
                                      CalenderColors.secondaryTextColor
                                  : widget.selectedTextColor ?? AppColors.white,
                              fontFamily: AppTextStyles.fontFamily,
                              fontSize: widget.fontSizeOfWeek ?? 12.0,
                              fontWeight:
                                  widget.fontWeightWeek ?? FontWeight.w400),
                        ),
                      ],
                    ),
                  ),
                ),
              );
            },
          ),
          const SizedBox(
            width: 10,
          ),
          Container(
            padding: const EdgeInsets.only(
              right: 10,
            ),
            width: 60,
            // height: 85,
            // color: CalenderColors.backgroundColor,

            child: InkWell(
              onTap: () async {
                DateTime? date = await selectDate() ?? DateTime.now();
                widget.onDateSelected!(Utils.getDate(date));
                setState(() => selectedCalenderDate = date);
              },
              child: Container(
                height: double.infinity,
                width: width,
                decoration: BoxDecoration(
                  color: widget.tableCalenderButtonColor ??
                      CalenderColors.primaryColor,
                  borderRadius: BorderRadius.circular(widget.borderRadius),
                ),
                child: widget.tableCalenderIcon,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Future<DateTime?> selectDate() async {
    return await showDatePicker(
      context: context,
      initialDatePickerMode: DatePickerMode.day,
      initialDate: selectedCalenderDate,
      builder: (BuildContext context, Widget? child) {
        return Theme(
          data: widget.tableCalenderThemeData ??
              ThemeData.light().copyWith(
                primaryColor: CalenderColors.secondaryColor,
                buttonTheme:
                    const ButtonThemeData(textTheme: ButtonTextTheme.primary),
                colorScheme: const ColorScheme.light(
                        primary: CalenderColors.secondaryColor)
                    .copyWith(secondary: CalenderColors.secondaryColor),
              ),
          child: child ?? const SizedBox(),
        );
      },
      firstDate: widget.initialDate ??
          DateTime.now().subtract(const Duration(days: 30)),
      lastDate: widget.lastDate ?? DateTime.now().add(const Duration(days: 30)),
    );
  }
}

class Utils {
  static String getDayOfWeek(DateTime date) => DateFormat('EEE').format(date);

  static String getDayOfMonth(DateTime date) => DateFormat('dd').format(date);

  static String getDate(DateTime date) => DateFormat('yyyy-MM-dd').format(date);
}

class CalenderColors {
  static const Color primaryColor = Color(0xff2F98B9);
  static const Color secondaryColor = Color(0xff092B47);
  static const Color primaryTextColor = Color(0xff0D2145);
  static const Color secondaryTextColor = Color(0xff768791);
  static const Color white = Color(0xffFFFFFF);
  static const Color black = Color(0xff45597A);
  static const Color grey = Color(0xffC4C4C4);
  static const Color backgroundColor = Color(0xffF3F5F8);
}

class MMCustomCalender extends StatefulWidget {
  final DateTime date;
  final DateTime? initialDate;
  final DateTime? lastDate;
  final Color? textColor;
  final Color? colorOfWeek;
  final Color? colorOfMonth;
  final double? fontSizeOfWeek;
  final FontWeight? fontWeightWeek;
  final double? fontSizeOfMonth;
  final FontWeight? fontWeightMonth;
  final Color? backgroundColor;
  final Color? selectedColor;
  final int? duration;
  final Curve? curve;
  final BoxShadow? selectedBoxShadow;
  final BoxShadow? unSelectedBoxShadow;
  final OnDateSelected? onDateSelected;
  final Widget tableCalenderIcon;
  final Color? tableCalenderButtonColor;
  final ThemeData? tableCalenderThemeData;

  const MMCustomCalender({
    super.key,
    required this.date,
    required this.tableCalenderIcon,
    this.initialDate,
    this.lastDate,
    this.textColor,
    this.curve,
    this.tableCalenderThemeData,
    this.selectedBoxShadow,
    this.unSelectedBoxShadow,
    this.duration,
    this.tableCalenderButtonColor,
    this.colorOfMonth,
    this.colorOfWeek,
    this.fontSizeOfWeek,
    this.fontWeightWeek,
    this.fontSizeOfMonth,
    this.fontWeightMonth,
    this.backgroundColor,
    this.selectedColor,
    required this.onDateSelected,
  });

  @override
  _MMCalendarState createState() => _MMCalendarState();
}

class _MMCalendarState extends State<MMCustomCalender> {
  DateTime? _startDate;
  var selectedCalenderDate;
  final ScrollController _scrollController = ScrollController();

  calenderAnimation() {
    _scrollController.animateTo(
      _scrollController.position.maxScrollExtent,
      duration: Duration(seconds: widget.duration ?? 1),
      curve: widget.curve ?? Curves.fastOutSlowIn,
    );
  }

  @override
  void initState() {
    super.initState();
    selectedCalenderDate = widget.date;
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;

    DateTime findFirstDateOfTheWeek(DateTime dateTime) {
      if (dateTime.weekday == 7) {
        if (_scrollController.hasClients) {
          calenderAnimation();
        }
        return dateTime;
      } else {
        if (dateTime.weekday == 1 || dateTime.weekday == 2) {
          if (_scrollController.hasClients) {
            calenderAnimation();
          }
        }
        return dateTime.subtract(Duration(days: dateTime.weekday));
      }
    }

    _startDate = findFirstDateOfTheWeek(selectedCalenderDate);

    return SingleChildScrollView(
      controller: _scrollController,
      scrollDirection: Axis.horizontal,
      reverse: true,
      child: Row(
        children: <Widget>[
          ListView.builder(
            itemCount: 7,
            shrinkWrap: true,
            scrollDirection: Axis.horizontal,
            itemBuilder: (context, index) {
              DateTime? date = _startDate?.add(Duration(days: index));
              int? diffDays = date?.difference(selectedCalenderDate).inDays;
              return GestureDetector(
                onTap: () {
                  widget.onDateSelected!(Utils.getDate(date));
                  setState(() {
                    selectedCalenderDate =
                        _startDate?.add(Duration(days: index));
                    _startDate = _startDate?.add(Duration(days: index));
                  });
                },
                child: Container(
                  width: 70,

                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                    color: diffDays != 0
                        ? widget.backgroundColor ?? Colors.white
                        : widget.selectedColor ?? Colors.blue,

                    // border: diffDays == 0
                    //     ? Border.all(
                    //         color: CalenderColors.white.withOpacity(0.95),
                    //         width: 0)
                    //     : Border.all(
                    //         color:Color(0xff2F98B9),
                    //         width: 0.83),
                    borderRadius: BorderRadius.circular(12.0),
                    // boxShadow: [
                    //   diffDays != 0
                    //       ? widget.selectedBoxShadow ??
                    //           BoxShadow(
                    //             color: CalenderColors.black.withOpacity(0.25),
                    //             spreadRadius: 0.0,
                    //             blurRadius: 10,
                    //             offset: Offset(
                    //                 0, 4), // changes position of shadow
                    //           )
                    //       : widget.unSelectedBoxShadow ??
                    //           BoxShadow(
                    //             color: CalenderColors.primaryColor
                    //                 .withOpacity(0.35),
                    //             spreadRadius: 2.0,
                    //             blurRadius: 10,
                    //             offset: Offset(
                    //                 0, 4), // changes position of shadow
                    //           )
                    // ],
                  ),
                  margin: const EdgeInsets.only(
                    left: 8,
                  ),
                  // ignore: deprecated_member_use
                  child: Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Text(
                          Utils.getDayOfWeek(date!),
                          style: TextStyle(
                              color: diffDays != 0
                                  ? widget.colorOfWeek ??
                                      CalenderColors.secondaryTextColor
                                  : Colors.white,
                              fontSize: widget.fontSizeOfWeek ?? 12.0,
                              fontWeight:
                                  widget.fontWeightWeek ?? FontWeight.w600),
                        ),
                        const SizedBox(height: 2.0),
                        Text(
                          Utils.getDayOfMonth(date),
                          style: TextStyle(
                            color: diffDays != 0
                                ? widget.colorOfMonth ??
                                    CalenderColors.primaryTextColor
                                : Colors.white,
                            fontSize: widget.fontSizeOfMonth ?? 20.0,
                            fontWeight:
                                widget.fontWeightMonth ?? FontWeight.w700,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              );
            },
          ),
          const SizedBox(
            width: 10,
          ),
          SizedBox(
            // padding: EdgeInsets.only(bottom: 20, top: 8),
            width: 70,
            height: 100,
            // color: CalenderColors.backgroundColor,

            child: InkWell(
              onTap: () async {
                DateTime? date = await selectDate() ?? DateTime.now();
                widget.onDateSelected!(Utils.getDate(date));
                setState(() => selectedCalenderDate = date);
              },
              child: Container(
                height: double.infinity,
                width: (width - 10) * 0.1428,
                decoration: BoxDecoration(
                    color: widget.tableCalenderButtonColor ??
                        CalenderColors.primaryColor,
                    border: Border.all(color: CalenderColors.grey, width: 1),
                    borderRadius: BorderRadius.circular(12.0)),
                child: widget.tableCalenderIcon,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Future<DateTime?> selectDate() async {
    return await showDatePicker(
      context: context,
      initialDatePickerMode: DatePickerMode.day,
      initialDate: selectedCalenderDate,
      builder: (BuildContext context, Widget? child) {
        return Theme(
          data: widget.tableCalenderThemeData ??
              ThemeData.light().copyWith(
                primaryColor: CalenderColors.secondaryColor,
                buttonTheme:
                    const ButtonThemeData(textTheme: ButtonTextTheme.primary),
                colorScheme: const ColorScheme.light(
                        primary: CalenderColors.secondaryColor)
                    .copyWith(secondary: CalenderColors.secondaryColor),
              ),
          child: child ?? const SizedBox(),
        );
      },
      firstDate: widget.initialDate ??
          DateTime.now().subtract(const Duration(days: 30)),
      lastDate: widget.lastDate ?? DateTime.now().add(const Duration(days: 30)),
    );
  }
}
