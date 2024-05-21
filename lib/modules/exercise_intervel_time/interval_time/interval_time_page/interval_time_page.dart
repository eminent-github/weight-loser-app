import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:weight_loss_app/common/app_colors.dart';
import 'package:weight_loss_app/modules/exercise_intervel_time/interval_time/widgets/plan_workouts.dart';
import 'package:weight_loss_app/utils/internet_check_widget.dart';
import 'package:weight_loss_app/widgets/custom_large_button.dart';

import '../../../../common/app_text_styles.dart';
import '../../../../widgets/custom_datetime_calender.dart';
import '../../ready_time/binding/ready_time_binding.dart';
import '../../ready_time/ready_time_page/ready_time_page.dart';
import '../controller/interval_time_controller.dart';

class IntervalTimePage extends GetView<IntervalTimeController> {
  const IntervalTimePage({super.key});

  @override
  Widget build(BuildContext context) {
    var screenSize = MediaQuery.sizeOf(context);
    double height = screenSize.height-kToolbarHeight;
    double width = screenSize.width;
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: AppColors.white,
        iconTheme: const IconThemeData(color: AppColors.black),
        elevation: 0,
        title: Text(
          'Interval Time ',
          style: AppTextStyles.formalTextStyle(
            color: AppColors.buttonColor,
            fontSize: 18,
          ),
        ),
      ),
      body: InternetCheckWidget<ConnectivityService>(
        child: SafeArea(
          child: Column(
            children: [
              SizedBox(
                height: height * 0.01,
              ),
              Container(
                height: height * 0.12,
                color: AppColors.buttonColor.withOpacity(0.10),
                child: Center(
                  child: SizedBox(
                    height: height * 0.085,
                    child: MyCustomCalender(
                      tableCalenderIcon: const Icon(
                        Icons.calendar_today,
                        color: Colors.white,
                      ),
                      date: DateTime.now(),
                      colorOfWeek: AppColors.black,
                      colorOfMonth: AppColors.black,
                      fontSizeOfWeek: 12,
                      fontSizeOfMonth: 18,
                      backgroundColor: Colors.transparent,
                      selectedColor: AppColors.buttonColor,
                      tableCalenderButtonColor: AppColors.buttonColor,
                      onDateSelected: (date) {
                        controller.selectedDate = date;
                      },
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: height * 0.02,
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: width * 0.07),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Plan 1',
                      style: AppTextStyles.formalTextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    Row(
                      children: [
                        Container(
                          width: width * 0.007,
                          height: height * 0.013,
                          color: AppColors.buttonColor,
                        ),
                        SizedBox(
                          width: width * 0.02,
                        ),
                        Text(
                          '20 mints - 6 workout',
                          style: AppTextStyles.formalTextStyle(),
                        ),
                      ],
                    )
                  ],
                ),
              ),
              SizedBox(
                height: height * 0.02,
              ),
              Container(
                height: height * 0.6,
                padding: EdgeInsets.symmetric(horizontal: width * 0.07),
                child: PlanWorkOuts(
                  workoutList: controller.workoutList,
                ),
              ),
              SizedBox(
                height: height * 0.03,
              ),
              CustomLargeButton(
                height: height,
                width: width * 0.6,
                text: "Start",
                borderRadius: BorderRadius.circular(15),
                onPressed: () {
                  Get.to(
                    () => const ReadyTimePage(),
                    binding: ReadyTimeBinding(),
                  );
                },
              )
            ],
          ),
        ),
      ),
    );
  }
}
