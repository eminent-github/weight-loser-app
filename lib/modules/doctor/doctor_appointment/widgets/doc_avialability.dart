import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';

import '../../../../common/app_colors.dart';
import '../../../../common/app_text_styles.dart';
import '../controller/doctor_appointment_controller.dart';

class DocAvailability extends StatelessWidget {
  const DocAvailability({super.key, required this.controller});

  final DoctorAppointmentController controller;

  @override
  Widget build(BuildContext context) {
    var screenSize = MediaQuery.sizeOf(context);
    // double height = screenSize.height;
    double width = screenSize.width;
    return GridView.builder(
      itemCount: controller.daytimeList.length,
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2, childAspectRatio: 2.7, crossAxisSpacing: 20),
      physics: const NeverScrollableScrollPhysics(),
      itemBuilder: (context, index) {
        return Obx(
          () => Material(
            color: controller.isDayNight.value == index
                ? AppColors.buttonColor
                : const Color(0xffEFF4F8),
            borderRadius: BorderRadius.circular(20),
            child: InkWell(
              onTap: () {
                controller.isDayNight.value = index;
              },
              borderRadius: BorderRadius.circular(20),
              child: Container(
                width: width * 0.425,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  border: Border.all(width: 0.7, color: AppColors.buttonColor),
                ),
                child: Center(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SvgPicture.asset(
                        controller.daytimeList[index].imageUrl,
                        height: 22,
                        width: 22,
                        color: controller.isDayNight.value == index
                            ? AppColors.white
                            : AppColors.black,
                      ),
                      SizedBox(
                        width: width * .02,
                      ),
                      Text(
                        controller.daytimeList[index].title,
                        style: AppTextStyles.formalTextStyle(
                          color: controller.isDayNight.value == index
                              ? AppColors.white
                              : AppColors.black,
                          fontSize: 12.45,
                          fontWeight: FontWeight.w800,
                        ),
                      ),
                    ],
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
