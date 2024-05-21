import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:weight_loss_app/utils/internet_check_widget.dart';

import '../../../../common/app_colors.dart';
import '../../../../common/app_text_styles.dart';
import '../../../../widgets/custom_large_button.dart';
import '../../../../widgets/custom_datetime_calender.dart';
import '../controller/meditation_interval_controller.dart';
import '../widgets/plan_yoga.dart';

class MeditationIntervalPage extends GetView<MeditationIntervalController> {
  const MeditationIntervalPage({super.key});

  @override
  Widget build(BuildContext context) {
    var screenSize = MediaQuery.sizeOf(context);
    double height = screenSize.height;
    double width = screenSize.width;
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          'Meditation Interval',
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
                height: height * 0.03,
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
                height: height * 0.03,
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
                height: height * 0.03,
              ),
              Container(
                height: height * 0.53,
                padding: EdgeInsets.symmetric(horizontal: width * 0.07),
                child: PlanYogas(
                  yogaList: controller.yogaList,
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
                onPressed: () {},
              )
            ],
          ),
        ),
      ),
    );
  }
}
