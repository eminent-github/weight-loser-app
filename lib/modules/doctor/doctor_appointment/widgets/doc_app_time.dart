import 'package:flutter/material.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';

import '../../../../common/app_colors.dart';
import '../../../../common/app_text_styles.dart';
import '../controller/doctor_appointment_controller.dart';

class DocAppTime extends StatelessWidget {
  const DocAppTime({super.key, required this.controller});

  final DoctorAppointmentController controller;

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      shrinkWrap: true,
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 4, childAspectRatio: 2.1),
      physics: const NeverScrollableScrollPhysics(),
      itemCount: controller.timeList.length,
      itemBuilder: (context, index) {
        return Obx(
          () => Material(
            borderRadius: BorderRadius.circular(15),
            color: controller.timeIndex.value == index
                ? AppColors.buttonColor
                : AppColors.white,
            child: InkWell(
              onTap: () {
                controller.timeIndex.value = index;
              },
              borderRadius: BorderRadius.circular(15),
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(15),
                ),
                child: Center(
                  child: Text(
                    controller.timeList[index],
                    style: AppTextStyles.formalTextStyle(
                      color: controller.timeIndex.value == index
                          ? AppColors.white
                          : AppColors.black,
                    ),
                  ),
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
