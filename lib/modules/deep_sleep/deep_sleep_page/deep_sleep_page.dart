import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:weight_loss_app/common/app_assets.dart';
import 'package:weight_loss_app/common/app_colors.dart';
import 'package:weight_loss_app/common/app_text_styles.dart';
import 'package:weight_loss_app/modules/deep_sleep/controller/deep_sleep_controller.dart';
import 'package:weight_loss_app/modules/deep_sleep/widgets/column_sleep_chart.dart';
import 'package:weight_loss_app/modules/deep_sleep/widgets/rate_your_sleep.dart';
import 'package:weight_loss_app/modules/deep_sleep/widgets/sleep_type.dart';
import 'package:weight_loss_app/modules/deep_sleep/widgets/sleep_videos.dart';
import 'package:weight_loss_app/utils/internet_check_widget.dart';
import 'package:weight_loss_app/widgets/custom_datetime_calender.dart';
import 'package:weight_loss_app/widgets/overlay_widget.dart';

class DeepSleepPage extends GetView<DeepSleepController> {
  const DeepSleepPage({super.key});

  @override
  Widget build(BuildContext context) {
    var screenSize = MediaQuery.sizeOf(context);
    double height = screenSize.height;
    double width = screenSize.width;
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: AppColors.buttonColor,
        title: Text(
          "Sleep Detail",
          style: AppTextStyles.formalTextStyle(
              color: AppColors.white, fontSize: 16),
        ),
        centerTitle: true,
        iconTheme: const IconThemeData(color: AppColors.white),
        systemOverlayStyle: const SystemUiOverlayStyle(
          statusBarIconBrightness: Brightness.light,
        ),
      ),
      body: InternetCheckWidget<ConnectivityService>(
        child: Obx(
          () => Stack(
            children: [
              SafeArea(
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        width: width,
                        // height: height * 0.55,
                        decoration: ShapeDecoration(
                          color: AppColors.buttonColor,
                          shape: const RoundedRectangleBorder(
                            borderRadius: BorderRadius.only(
                              bottomLeft: Radius.circular(20),
                              bottomRight: Radius.circular(20),
                            ),
                          ),
                        ),
                        child: Column(
                          children: [
                            SizedBox(
                              height: height * 0.085,
                              child: MyCustomCalender(
                                  tableCalenderIcon: Icon(
                                    Icons.calendar_today,
                                    color: AppColors.buttonColor,
                                  ),
                                  date: DateTime.now(),
                                  lastDate: DateTime.now(),
                                  colorOfWeek: AppColors.white,
                                  colorOfMonth: AppColors.white,
                                  fontSizeOfWeek: 12,
                                  fontSizeOfMonth: 18,
                                  selectedTextColor: AppColors.buttonColor,
                                  backgroundColor: Colors.transparent,
                                  selectedColor: AppColors.white,
                                  tableCalenderButtonColor: AppColors.white,
                                  onDateSelected: (date) {
                                    controller
                                        .getDeepSleepApi(DateTime.parse(date));
                                    controller.filterDate.value =
                                        DateTime.parse(date);
                                  }),
                            ),
                            SizedBox(
                              height: height * 0.03,
                            ),
                            Padding(
                              padding: EdgeInsets.symmetric(
                                  horizontal: width * 0.05),
                              child: SizedBox(
                                height: height * 0.11,
                                child: RateYourSleep(
                                  deepSleepController: controller,
                                ),
                              ),
                            ),
                            SizedBox(
                              height: height * 0.01,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                SleepType(
                                    imagUrl: AppAssets.deepSvgUrl,
                                    type: "Bed Time",
                                    time:
                                        controller.deepSleepData.value.sleep ==
                                                null
                                            ? "Time"
                                            : controller
                                                .deepSleepData.value.sleep!),
                                SleepType(
                                    imagUrl: AppAssets.awakeSvgUrl,
                                    type: "Awake Time",
                                    time:
                                        controller.deepSleepData.value.awake ==
                                                null
                                            ? "Time"
                                            : controller
                                                .deepSleepData.value.awake!),
                              ],
                            ),
                            SizedBox(
                              height: height * 0.05,
                            ),
                          ],
                        ),
                      ),
                      SizedBox(
                        height: height * 0.05,
                      ),
                      Container(
                        height: height * 0.35,
                        decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            border: Border.all(
                                width: 8, color: AppColors.buttonColor)),
                        child: Center(
                          child: SizedBox(
                            width: width * 0.6,
                            child: Column(
                              // mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Expanded(
                                  flex: 5,
                                  child: Center(
                                    child: Text(
                                      "${controller.userName.value.split(" ")[0]}'s Sleep",
                                      style: AppTextStyles.formalTextStyle(
                                        fontWeight: FontWeight.w700,
                                        color: Theme.of(context)
                                            .primaryTextTheme
                                            .titleMedium!
                                            .color!,
                                      ),
                                    ),
                                  ),
                                ),
                                Expanded(
                                  flex: 6,
                                  child: Row(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Expanded(
                                        flex: 4,
                                        child: InkWell(
                                          onTap: () {
                                            controller.deepSelectTime(context);
                                          },
                                          child: Column(
                                            mainAxisSize: MainAxisSize.min,
                                            children: <Widget>[
                                              AutoSizeText(
                                                'Sleep',
                                                style: TextStyle(
                                                  fontWeight: FontWeight.w700,
                                                  fontSize: height * 0.02,
                                                  color: AppColors.buttonColor,
                                                ),
                                              ),
                                              SizedBox(height: height * 0.01),
                                              Text(
                                                controller.deepSleepTime.value
                                                    .format(context),
                                                style: TextStyle(
                                                    color:
                                                        AppColors.buttonColor,
                                                    fontWeight: FontWeight.w400,
                                                    fontSize: height * 0.016),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                      Expanded(
                                        flex: 2,
                                        child: Text(
                                          '-',
                                          textAlign: TextAlign.center,
                                          style: TextStyle(
                                            fontSize: height * 0.04,
                                            color: AppColors.buttonColor,
                                          ),
                                        ),
                                      ),
                                      Expanded(
                                        flex: 4,
                                        child: InkWell(
                                          onTap: () {
                                            controller.awakeSelectTime(context);
                                          },
                                          child: Column(
                                            mainAxisSize: MainAxisSize.min,
                                            children: <Widget>[
                                              AutoSizeText(
                                                'Awake',
                                                maxLines: 1,
                                                style: TextStyle(
                                                  fontWeight: FontWeight.w700,
                                                  fontSize: height * 0.022,
                                                  color: AppColors.buttonColor,
                                                ),
                                              ),
                                              SizedBox(height: height * 0.01),
                                              Text(
                                                controller.awakeTime.value
                                                    .format(context),
                                                style: TextStyle(
                                                    fontWeight: FontWeight.w400,
                                                    color:
                                                        AppColors.buttonColor,
                                                    fontSize: height * 0.016),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: height * 0.03,
                      ),
                      Center(
                        child: Text(
                          controller.calTotalTime(controller.awakeTime.value,
                              controller.deepSleepTime.value),
                          style: AppTextStyles.formalTextStyle(
                            fontWeight: FontWeight.w700,
                            color: Theme.of(context)
                                .primaryTextTheme
                                .titleMedium!
                                .color!,
                          ),
                        ),
                      ),
                      SizedBox(
                        height: height * 0.02,
                      ),
                      Center(
                        child: Text(
                          'Total sleep time',
                          style: AppTextStyles.formalTextStyle(
                            fontSize: 13,
                            color: AppColors.buttonColor,
                          ),
                        ),
                      ),
                      SizedBox(
                        height: height * 0.02,
                      ),
                      Center(
                        child: SizedBox(
                          height: height * 0.05,
                          width: width * 0.3,
                          child: Material(
                            color: AppColors.buttonColor,
                            borderRadius: BorderRadius.circular(8),
                            child: InkWell(
                              onTap: () {
                                if (DateTime.now().isBefore(controller
                                    .filterDate.value
                                    .add(const Duration(days: 1)))) {
                                  // log("bedtime: ${controller.deepSleepTime.value.format(context)} awakeTime: ${controller.awakeTime.value.format(context)}");
                                  // print(controller.calHourTime(
                                  //     controller.awakeTime.value,
                                  //     controller.deepSleepTime.value));
                                  print(DateTime.now());
                                  controller.postDeepSleepApi(
                                    totalSleep: controller.calHourTime(
                                                controller.awakeTime.value,
                                                controller
                                                    .deepSleepTime.value) <
                                            10
                                        ? "${DateFormat("yyyy-MM-ddT").format(DateTime.now())}0${controller.calHourTime(controller.awakeTime.value, controller.deepSleepTime.value)}:00:0000"
                                        : "${DateFormat("yyyy-MM-ddT").format(DateTime.now())}${controller.calHourTime(controller.awakeTime.value, controller.deepSleepTime.value)}:00:0000",
                                    awakeTime: controller.awakeTime.value
                                        .format(context),
                                    deepTime: controller.deepSleepTime.value
                                        .format(context),
                                  );
                                }
                              },
                              borderRadius: BorderRadius.circular(50),
                              child: Center(
                                child: Text(
                                  "Save",
                                  style: AppTextStyles.formalTextStyle(
                                      color: AppColors.white,
                                      fontWeight: FontWeight.bold),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                      SizedBox(height: height * 0.02),
                      Padding(
                        padding: EdgeInsets.only(left: width * 0.07),
                        child: Text(
                          'Overall progress',
                          style: AppTextStyles.formalTextStyle(
                              color: Theme.of(context)
                                  .primaryTextTheme
                                  .titleMedium!
                                  .color!,
                              fontWeight: FontWeight.w700,
                              fontSize: 17),
                        ),
                      ),
                      SizedBox(
                        height: height * 0.035,
                      ),
                      SizedBox(
                        height: height * 0.38,
                        child: controller.isLoading.value
                            ? Center(
                                child: CircularProgressIndicator(
                                  color: AppColors.buttonColor,
                                ),
                              )
                            : Padding(
                                padding: EdgeInsets.only(
                                    left: width * 0.02, right: width * 0.07),
                                child: ColumnSleepChart(
                                    sleepTimeList: controller.weekDayList),
                              ),
                      ),
                      SizedBox(
                        height: height * 0.035,
                      ),
                      Padding(
                        padding: EdgeInsets.only(left: width * 0.07),
                        child: Text(
                          'Bedtime Stories',
                          style: AppTextStyles.formalTextStyle(
                            color: Theme.of(context)
                                .primaryTextTheme
                                .titleMedium!
                                .color!,
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                      SizedBox(
                        height: height * 0.02,
                      ),
                      Padding(
                        padding: EdgeInsets.symmetric(
                            horizontal: width * 0.07, vertical: height * 0.02),
                        child: controller.isLoading.value
                            ? Center(
                                child: CircularProgressIndicator(
                                  color: AppColors.buttonColor,
                                ),
                              )
                            : controller.deepSleepData.value.sleepVedios == null
                                ? Center(
                                    child: Text(
                                      "No Sleep Video Available.",
                                      style: AppTextStyles.formalTextStyle(
                                        color: Theme.of(context)
                                            .primaryTextTheme
                                            .titleMedium!
                                            .color!,
                                      ),
                                    ),
                                  )
                                : SleepVideos(
                                    sleepVideosList: controller
                                        .deepSleepData.value.sleepVedios!,
                                    controller: controller,
                                  ),
                      )
                    ],
                  ),
                ),
              ),
              controller.isTimeLoading.value
                  ? const OverlayWidget()
                  : const SizedBox()
            ],
          ),
        ),
      ),
    );
  }
}


/*
Row(
                                children: [
                                  const Expanded(
                                    flex: 1,
                                    child: Column(
                                      children: [
                                        Expanded(
                                          flex: 9,
                                          child: Column(
                                            mainAxisAlignment:
                                                MainAxisAlignment
                                                    .spaceBetween,
                                            children: [
                                              Text("24"),
                                              Text("20"),
                                              Text("16"),
                                              Text("12"),
                                              Text("8"),
                                              Text("4"),
                                              Text("0"),
                                            ],
                                          ),
                                        ),
                                        Expanded(
                                          flex: 1,
                                          child: SizedBox(),
                                        ),
                                      ],
                                    ),
                                  ),
                                  Expanded(
                                    flex: 9,
                                    child: ListView.builder(
                                      physics:
                                          const NeverScrollableScrollPhysics(),
                                      scrollDirection: Axis.horizontal,
                                      itemCount:
                                          controller.weekDayList.length,
                                      itemBuilder: (context, index) {
                                        // BedTime bedTime = controller
                                        //     .deepSleepData
                                        //     .value
                                        //     .bedTime![index];
                                        return Column(
                                          children: [
                                            Expanded(
                                              flex: 9,
                                              child: Align(
                                                alignment: Alignment.bottomCenter,
                                                child: Container(
                                                  height: 12 /height,
                                                  width: width * 0.084,
                                                  margin: EdgeInsets.symmetric(horizontal: width*0.013),
                                                  decoration: BoxDecoration(
                                                    color:
                                                        AppColors.buttonColor,
                                                    borderRadius:
                                                        const BorderRadius
                                                            .vertical(
                                                      top: Radius.circular(15),
                                                    ),
                                                  ),
                                                ),
                                              ),
                                            ),
                                            Expanded(
                                              flex: 1,
                                              child: Center(
                                                child: Text(
                                                  controller.weekDayList[index],
                                                  style: AppTextStyles
                                                      .formalTextStyle(
                                                    fontSize: 12,
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ],
                                        );
                                      },
                                    ),
                                  ),
                                ],
                              ),

*/