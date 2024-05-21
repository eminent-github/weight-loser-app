import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:stop_watch_timer/stop_watch_timer.dart';

import '../../../../../common/app_colors.dart';
import '../../../../../common/app_text_styles.dart';
import '../../controller/workout_controller.dart';

class RestPage extends StatefulWidget {
  const RestPage({
    super.key,
  });

  @override
  State<RestPage> createState() => _RestPageState();
}

class _RestPageState extends State<RestPage> {
  late StopWatchTimer stopWatchTimer;
  final WorkoutController workoutController = Get.find<WorkoutController>();
  @override
  void initState() {
    stopWatchTimer = StopWatchTimer(
      mode: StopWatchMode.countDown,
      presetMillisecond: 5 * 1000,
      onEnded: () {
        Navigator.pop(context);
      },
    );
    stopWatchTimer.onStartTimer();
    super.initState();
  }

  @override
  void dispose() async {
    super.dispose();
    await stopWatchTimer.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var screenSize = MediaQuery.sizeOf(context);
    double height = screenSize.height;
    double width = screenSize.width;
    int nextPageIndex = workoutController.pageController.page!.toInt() + 1;
    return WillPopScope(
      onWillPop: () async => false,
      child: Scaffold(
        backgroundColor: AppColors.buttonColor,
        appBar: AppBar(
          backgroundColor: AppColors.buttonColor,
          automaticallyImplyLeading: false,
          elevation: 0,
        ),
        body: Column(
          children: [
            const Expanded(
              flex: 1,
              child: SizedBox(),
            ),
            Expanded(
              flex: 2,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Text(
                    'Rest',
                    style: AppTextStyles.formalTextStyle(
                      color: AppColors.white,
                      fontSize: 34,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  StreamBuilder<int>(
                    stream: stopWatchTimer.rawTime,
                    initialData: 0,
                    builder: (context, snapshot) {
                      final value = snapshot.data;
                      final displayTime = StopWatchTimer.getDisplayTime(value!,
                          milliSecond: false, hours: false);
                      return Text(
                        displayTime,
                        style: AppTextStyles.formalTextStyle(
                          color: AppColors.white,
                          fontSize: 28,
                          fontWeight: FontWeight.w700,
                        ),
                      );
                    },
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      GestureDetector(
                        onTap: () {
                          // print(stopWatchTimer.secondTime.value);
                          stopWatchTimer.setPresetTime(
                            mSec: 20 * 1000,
                            // add: true,
                          );
                        },
                        child: Container(
                          width: width * 0.29,
                          height: height * 0.052,
                          decoration: ShapeDecoration(
                            color: const Color(0xFFAFD3E2),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(15),
                            ),
                          ),
                          child: Center(
                            child: Text(
                              '+20s',
                              style: AppTextStyles.formalTextStyle(
                                color: AppColors.buttonColor,
                                fontSize: 20,
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                          ),
                        ),
                      ),
                      GestureDetector(
                        onTap: () {
                          Navigator.pop(context);
                        },
                        child: Container(
                          width: width * 0.29,
                          height: height * 0.052,
                          decoration: ShapeDecoration(
                            color: Colors.white,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(15),
                            ),
                          ),
                          child: Center(
                            child: Text(
                              'Skip',
                              style: AppTextStyles.formalTextStyle(
                                color: AppColors.buttonColor,
                                fontSize: 20,
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  )
                ],
              ),
            ),
            const Expanded(
              flex: 1,
              child: SizedBox(),
            ),
            Expanded(
              flex: 3,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  SizedBox(
                    width: width * 0.85,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Next ${nextPageIndex + 1}/${workoutController.workoutList.length}",
                          style: AppTextStyles.formalTextStyle(
                            color: AppColors.white,
                            fontSize: 16,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              workoutController
                                  .workoutList[nextPageIndex].title,
                              style: AppTextStyles.formalTextStyle(
                                color: AppColors.white,
                                fontSize: 24,
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                            Text(
                              workoutController
                                      .workoutList[nextPageIndex].isDuration
                                  ? "00:${workoutController.workoutList[nextPageIndex].duration}"
                                  : "X ${workoutController.workoutList[nextPageIndex].duration}",
                              style: AppTextStyles.formalTextStyle(
                                color: AppColors.white,
                                fontSize: 16,
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                          ],
                        )
                      ],
                    ),
                  ),
                  Container(
                    width: width,
                    height: height * 0.25,
                    decoration: const ShapeDecoration(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(15),
                            topRight: Radius.circular(15)),
                      ),
                    ),
                    child: ClipRRect(
                      borderRadius: const BorderRadius.only(
                          topLeft: Radius.circular(15),
                          topRight: Radius.circular(15)),
                      child: SvgPicture.asset(
                        workoutController.workoutList[nextPageIndex].imageUrl,
                        fit: BoxFit.fill,
                      ),
                    ),
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
