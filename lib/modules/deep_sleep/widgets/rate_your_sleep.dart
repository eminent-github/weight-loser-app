import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';
import 'package:weight_loss_app/common/app_colors.dart';
import 'package:weight_loss_app/common/app_text_styles.dart';
import 'package:weight_loss_app/modules/deep_sleep/controller/deep_sleep_controller.dart';

class RateYourSleep extends StatelessWidget {
  const RateYourSleep({
    super.key,
    required this.deepSleepController,
  });
  final DeepSleepController deepSleepController;

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      itemCount: deepSleepController.emojiIconList.length,
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 5,
      ),
      itemBuilder: (context, index) {
        return Padding(
          padding: const EdgeInsets.symmetric(horizontal: 4.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Obx(
                () => Material(
                  color: deepSleepController.emogiSelectedIndex.value == index
                      ? AppColors.white
                      : const Color(0xFF151B4A),
                  borderRadius: BorderRadius.circular(9),
                  child: InkWell(
                    onTap: () {
                      if (deepSleepController.filterDate.value.isBefore(
                          DateTime.now().subtract(const Duration(days: 1)))) {
                      } else {
                        deepSleepController.emogiSelectedIndex.value = index;
                        deepSleepController.postSleepMoodApi(
                            moodType:
                                deepSleepController.emojiIconList[index].text);
                      }
                    },
                    borderRadius: BorderRadius.circular(9),
                    child: Container(
                      width: 40,
                      height: 40,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(9),
                      ),
                      child: Center(
                        child: Image.asset(
                          deepSleepController.emojiIconList[index].imageUrl,
                          width: 25,
                          height: 25,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
              Expanded(
                child: AutoSizeText(
                  deepSleepController.emojiIconList[index].text,
                  minFontSize: 6,
                  maxLines: 1,
                  style: AppTextStyles.formalTextStyle(
                    color: AppColors.white,
                    fontSize: 11,
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
