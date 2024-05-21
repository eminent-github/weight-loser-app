import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:weight_loss_app/common/app_assets.dart';
import 'package:weight_loss_app/modules/registeration_questions/analyzing/binding/analyzing_binding.dart';
import 'package:weight_loss_app/modules/registeration_questions/analyzing/view/analyzing_page.dart';
import 'package:weight_loss_app/utils/internet_check_widget.dart';

import 'package:weight_loss_app/widgets/custom_large_button.dart';

import '../../../../common/app_colors.dart';
import '../../../../common/app_texts.dart';
import '../controller/habit_loop_controller.dart';

class HabitLoopPage extends GetView<HabitLoopController> {
  const HabitLoopPage({super.key});

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height - kToolbarHeight;
    double width = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(),
      body: InternetCheckWidget<ConnectivityService>(
        child: SafeArea(
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(
                  height: height * 0.5,
                  width: width * 0.8,
                  child: SvgPicture.asset(AppAssets.habitLoopIconUrl),
                ),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: width * 0.15),
                  child: AutoSizeText(
                    AppTexts.habitLoopKeepEye,
                    textAlign: TextAlign.center,
                    maxLines: 2,
                    minFontSize: 15,
                    style: TextStyle(
                      fontSize: 26,
                      color: AppColors.buttonColor,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ),
                SizedBox(
                  height: height * 0.01,
                ),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: width * 0.2),
                  child: const Text(
                    AppTexts.habitLoopLogReminder,
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w400,
                        color: Color(0xff707070)),
                  ),
                ),
                SizedBox(
                  height: height * 0.05,
                ),
                CustomLargeButton(
                  width: width * 0.5,
                  height: height,
                  onPressed: () {
                    Get.to(() => const AnalyzingPage(),
                        binding: AnalyzingBinding());
                  },
                  text: AppTexts.habitLoopButtonTextNext,
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
