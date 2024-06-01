import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:weight_loss_app/common/app_colors.dart';
import 'package:weight_loss_app/common/app_text_styles.dart';
import 'package:weight_loss_app/common/app_texts.dart';
import 'package:weight_loss_app/modules/water/controller/water_controller.dart';
import 'package:weight_loss_app/widgets/custom_snackbar.dart';

class WaterIntakeDialog extends StatelessWidget {
  const WaterIntakeDialog({super.key, required this.controller});
  final WaterController controller;

  @override
  Widget build(BuildContext context) {
    var screenSize = MediaQuery.sizeOf(context);
    double height = screenSize.height;
    double width = screenSize.width;
    return Dialog(
      backgroundColor: AppColors.white,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
      ),
      child: SizedBox(
        width: width * 0.7,
        height: height * 0.3,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: <Widget>[
            Text(
              'Water Intake',
              textAlign: TextAlign.center,
              style: AppTextStyles.formalTextStyle(
                fontWeight: FontWeight.w700,
              ),
            ),
            SizedBox(
              width: width * 0.5,
              // height: height * 0.053,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  SizedBox(
                    width: width * 0.22,
                    // decoration: ShapeDecoration(
                    //   color: Colors.white,
                    //   shape: RoundedRectangleBorder(
                    //     side: BorderSide(
                    //         width: 0.50, color: AppColors.buttonColor),
                    //     borderRadius: BorderRadius.circular(3),
                    //   ),
                    // ),
                    child: Center(
                      child: TextField(
                        controller: controller.intakeController,
                        textAlign: TextAlign.center,
                        keyboardType: TextInputType.number,
                        inputFormatters: [
                          FilteringTextInputFormatter.allow(
                            RegExp(r'^[0-9]+$'),
                          ),
                        ],
                        maxLength: 2,
                        buildCounter: (context,
                                {required currentLength,
                                required isFocused,
                                maxLength}) =>
                            const SizedBox(),
                        style: AppTextStyles.formalTextStyle(),
                        decoration: InputDecoration(
                          hintText: "0",
                          hintStyle: AppTextStyles.formalTextStyle(
                            color: AppColors.gray,
                          ),
                          border: const OutlineInputBorder(),
                          fillColor: Colors.white,
                          filled: true,
                          contentPadding: const EdgeInsets.all(0),
                        ),
                      ),
                    ),
                  ),
                  Text(
                    'Glass',
                    style: AppTextStyles.formalTextStyle(
                      fontWeight: FontWeight.w700,
                    ),
                  )
                ],
              ),
            ),
            Material(
              color: AppColors.buttonColor,
              borderRadius: BorderRadius.circular(15),
              child: InkWell(
                onTap: () {
                  Navigator.pop(
                    context,
                  );
                  if (controller.intakeController.text.isEmpty ||
                      controller.intakeController.text == "0") {
                    customSnackbar(
                        title: AppTexts.error, message: "Glass required");
                  } else if (int.parse(controller.intakeController.text) > 30) {
                    customSnackbar(
                        title: AppTexts.error,
                        message:
                            "You are drinking lot more water than prescribed range. Please consult your doctor");
                  } else {
                    controller.saveUserTodayWater(
                        numberOfGlass:
                            int.parse(controller.intakeController.text));
                  }
                },
                borderRadius: BorderRadius.circular(15),
                child: Container(
                  width: width * 0.3,
                  height: height * 0.04,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(15),
                  ),
                  child: Center(
                    child: Text(
                      'Add',
                      textAlign: TextAlign.center,
                      style: AppTextStyles.formalTextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
