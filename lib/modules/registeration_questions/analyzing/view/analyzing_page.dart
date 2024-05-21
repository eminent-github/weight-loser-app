import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:weight_loss_app/common/app_colors.dart';
import 'package:weight_loss_app/modules/registeration_questions/analyzing/widget/linearprogress_row_text.dart';
import 'package:weight_loss_app/utils/internet_check_widget.dart';
import 'package:weight_loss_app/utils/shared_prefrence.dart';
import 'package:weight_loss_app/widgets/custom_large_button.dart';

import '../../../../common/app_texts.dart';
import '../../mind_section_active_graph/binding/mind_section_active_graph_binding.dart';
import '../../mind_section_active_graph/mind_section_active_graph_page/mind_section_active_graph_page.dart';
import '../controller/analyzing_controller.dart';

class AnalyzingPage extends GetView<AnalyzingController> {
  const AnalyzingPage({super.key});

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height - kToolbarHeight;
    double width = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(),
      body: InternetCheckWidget<ConnectivityService>(
        child: SafeArea(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Column(
                children: [
                  Text(AppTexts.analyzingYourProfile,
                      style: TextStyle(
                        fontSize: 22,
                        color: AppColors.buttonColor,
                        fontWeight: FontWeight.w700,
                      )),
                  SizedBox(
                    height: height * 0.015,
                  ),
                  const Text(AppTexts.analyzingWeCreate,
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w400,
                      )),
                ],
              ),
              Obx(
                () => ListView.builder(
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: controller.currentIndex.value,
                  shrinkWrap: true,
                  itemBuilder: (context, index) {
                    return LinearProgressRowText(
                      progressModalClass: controller.progressLinear[index],
                    );
                  },
                ),
              ),
              CustomLargeButton(
                text: AppTexts.habitLoopButtonTextNext,
                height: height,
                width: width * 0.5,
                onPressed: () async {
                  Get.to(
                      MindSectionActiveGraphPage(
                        targetWeight:
                            await StorageServivce.getTargetWeight() ?? 0,
                        currentWeight:
                            await StorageServivce.getCurrentWeight() ?? 0,
                        weightUnit: await StorageServivce.getWeightUnit() ?? "",
                      ),
                      binding: MindSectionActiveGraphBinding());
                },
              )
            ],
          ),
        ),
      ),
    );
  }
}
