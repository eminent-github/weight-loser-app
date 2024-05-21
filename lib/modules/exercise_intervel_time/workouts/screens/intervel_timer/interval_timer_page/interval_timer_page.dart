import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:stop_watch_timer/stop_watch_timer.dart';

import '../../../../../../common/app_assets.dart';
import '../../../../../../common/app_colors.dart';
import '../../../../../../common/app_text_styles.dart';
import '../../../../done_page/workout_complete_page.dart';
import '../../../controller/workout_controller.dart';
import '../../rest/break_page.dart';

class IntervalTimerPage extends StatefulWidget {
  const IntervalTimerPage({
    super.key,
  });

  @override
  State<IntervalTimerPage> createState() => _IntervalTimerPageState();
}

class _IntervalTimerPageState extends State<IntervalTimerPage> {
  final WorkoutController workoutController = Get.find<WorkoutController>();
  late StopWatchTimer stopWatchTimer;
  var isRunning = true;

  @override
  void initState() {
    stopWatchTimer = StopWatchTimer(
      mode: StopWatchMode.countDown,
      presetMillisecond: 20 * 1000,
      onEnded: () async {
        if (workoutController.currentPage.value + 1 <
            workoutController.workoutList.length) {
          await Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => const RestPage(),
            ),
          );
          workoutController.pageController
              .jumpToPage(workoutController.currentPage.value + 1);
        } else if (workoutController.currentPage.value + 1 ==
            workoutController.workoutList.length) {
          Get.to(const WorkoutCompletePage());
        }
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
    return SafeArea(
      child: Column(
        children: [
          SizedBox(
            height: height * 0.07,
          ),
          SvgPicture.asset(
            AppAssets.exerciseSvgUrl,
            height: height * 0.35,
          ),
          SizedBox(
            height: height * 0.07,
          ),
          Text(
            'Jumping Jacks',
            style: AppTextStyles.formalTextStyle(
              color: AppColors.buttonColor,
              fontSize: 28,
              fontWeight: FontWeight.w700,
            ),
          ),
          SizedBox(
            height: height * 0.02,
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
                  fontSize: 20,
                  fontWeight: FontWeight.w700,
                ),
              );
            },
          ),
          SizedBox(
            height: height * 0.07,
          ),
          Material(
            color: AppColors.buttonColor,
            borderRadius: BorderRadius.circular(15),
            child: InkWell(
              onTap: () {
                if (!isRunning) {
                  stopWatchTimer.onStartTimer();

                  isRunning = true;
                } else {
                  stopWatchTimer.onStopTimer();

                  isRunning = false;
                }
                setState(() {});
              },
              borderRadius: BorderRadius.circular(15),
              child: Container(
                width: width * 0.65,
                height: height * 0.075,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(15),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      isRunning
                          ? Icons.pause_outlined
                          : Icons.play_arrow_rounded,
                      color: Colors.white,
                    ),
                    Text(
                      isRunning ? 'Played' : "Stoped",
                      style: AppTextStyles.formalTextStyle(
                        color: Colors.white,
                        fontSize: 20,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
