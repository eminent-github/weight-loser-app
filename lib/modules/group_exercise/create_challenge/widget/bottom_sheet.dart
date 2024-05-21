import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import '../../../../../common/app_colors.dart';
import '../../../../../common/app_text_styles.dart';
import '../../../../../common/app_texts.dart';
import '../controller/create_challenge_controller.dart';

class BottomSheetDesign extends GetView<CreateChallengeController> {
  const BottomSheetDesign({super.key});

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.sizeOf(context);
    double height = size.height;
    double width = size.width;

    return Container(
      height: height * 0.4,
      padding: EdgeInsets.symmetric(horizontal: width * 0.08),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          const Text(
            AppTexts.scheduleChallenge,
            style: TextStyle(
                color: AppColors.blue,
                fontFamily: AppTextStyles.fontFamily,
                fontSize: 12,
                fontWeight: FontWeight.w400),
          ),
          Column(
            children: [
              Material(
                color: AppColors.white,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20),
                  side: const BorderSide(
                    color: AppColors.blue,
                    width: 0.2,
                  ),
                ),
                child: InkWell(
                  onTap: () async {
                    await controller.selectDate(context);
                  },
                  borderRadius: const BorderRadius.all(Radius.circular(20)),
                  child: Obx(
                    () => SizedBox(
                      height: height * 0.075,
                      child: Center(
                        child: ListTile(
                          leading: Icon(
                            Icons.calendar_month_outlined,
                            color: AppColors.blue,
                            size: height * 0.035,
                          ),
                          title: Text(
                            DateFormat("MMMM d, y")
                                .format(controller.selectedDate.value),
                            style: const TextStyle(
                                fontFamily: AppTextStyles.fontFamily,
                                fontSize: 12,
                                fontWeight: FontWeight.w400,
                                color: AppColors.blue),
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: height * 0.01,
              ),
              Material(
                color: AppColors.white,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20),
                  side: const BorderSide(
                    color: AppColors.blue,
                    width: 0.2,
                  ),
                ),
                child: InkWell(
                  onTap: () async {
                    await controller.time(context);
                  },
                  child: Obx(() {
                    return SizedBox(
                        height: height * 0.075,
                        child: Center(
                          child: ListTile(
                            leading: Icon(
                              Icons.watch_later_outlined,
                              size: height * 0.035,
                              color: AppColors.blue,
                            ),
                            title: Text(
                              controller.selectTime.value.format(context),
                              style: const TextStyle(
                                  color: AppColors.blue,
                                  fontFamily: AppTextStyles.fontFamily,
                                  fontSize: 12,
                                  fontWeight: FontWeight.w400),
                            ),
                          ),
                        ));
                  }),
                ),
              ),
            ],
          ),
          Material(
            color: AppColors.blue,
            child: InkWell(
              onTap: () {
                Get.back();
              },
              child: SizedBox(
                height: height * 0.06,
                width: width * 0.57,
                child: const Center(
                  child: Text(
                    AppTexts.setSchedule,
                    style: TextStyle(
                      fontFamily: AppTextStyles.fontFamily,
                      fontSize: 16,
                      fontWeight: FontWeight.w400,
                      color: AppColors.white,
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
}
