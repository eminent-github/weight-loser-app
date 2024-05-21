import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';
import 'package:intl/intl.dart';
import 'package:weight_loss_app/common/app_colors.dart';
import 'package:weight_loss_app/common/app_text_styles.dart';
import 'package:weight_loss_app/common/app_texts.dart';
import 'package:weight_loss_app/modules/cheat_food/controller/cheat_food_controller.dart';
import 'package:weight_loss_app/widgets/custom_snackbar.dart';

class CheatFoodDialog extends StatelessWidget {
  const CheatFoodDialog({super.key, required this.controller});
  final CheatFoodController controller;

  @override
  Widget build(BuildContext context) {
    var screenSize = MediaQuery.sizeOf(context);
    double height = screenSize.height;
    double width = screenSize.width;
    return Dialog(
      // backgroundColor: AppColors.white,
      surfaceTintColor: AppColors.white,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
      ),
      child: SizedBox(
        width: width * 0.7,
        height: height * 0.5,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: <Widget>[
            Text(
              'Add what you eat',
              textAlign: TextAlign.center,
              style: AppTextStyles.formalTextStyle(
                fontWeight: FontWeight.w700,
                color: Theme.of(context).primaryTextTheme.titleMedium!.color!,
              ),
            ),
            Container(
              height: height * 0.07,
              width: width,
              padding: EdgeInsets.symmetric(horizontal: width * 0.06),
              margin: EdgeInsets.symmetric(horizontal: width * 0.1),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(12),
                color: AppColors.editProfileFieldColor,
              ),
              child: Center(
                child: TextFormField(
                  style: const TextStyle(
                      fontSize: 12,
                      fontFamily: AppTextStyles.fontFamily,
                      color: AppColors.black),
                  controller: controller.nameController,
                  keyboardType: TextInputType.text,
                  textInputAction: TextInputAction.next,
                  inputFormatters: [
                    FilteringTextInputFormatter.allow(
                      RegExp(r'^[a-zA-Z ]+$'),
                    ),
                    FilteringTextInputFormatter.deny(
                        RegExp(r'^\s')), // Deny leading space
                  ],
                  maxLines: 1,
                  decoration: InputDecoration(
                    hintText: "Name",
                    hintStyle: TextStyle(
                      fontSize: 12,
                      color: AppColors.iconColor,
                      fontFamily: AppTextStyles.fontFamily,
                    ),
                    border: InputBorder.none,
                  ),
                ),
              ),
            ),
            Container(
              height: height * 0.07,
              width: width,
              padding: EdgeInsets.symmetric(horizontal: width * 0.06),
              margin: EdgeInsets.symmetric(horizontal: width * 0.1),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(12),
                color: AppColors.editProfileFieldColor,
              ),
              child: Center(
                child: TextFormField(
                  style: const TextStyle(
                      fontSize: 12,
                      fontFamily: AppTextStyles.fontFamily,
                      color: AppColors.black),
                  controller: controller.caloriesController,
                  textInputAction: TextInputAction.done,
                  keyboardType: TextInputType.number,
                  inputFormatters: [
                    FilteringTextInputFormatter.allow(
                      RegExp(r'^[0-9.]+$'),
                    ),
                  ],
                  decoration: InputDecoration(
                    hintText: "Calories",
                    hintStyle: TextStyle(
                      fontSize: 12,
                      color: AppColors.iconColor,
                      fontFamily: AppTextStyles.fontFamily,
                    ),
                    suffixText: "Kcal",
                    border: InputBorder.none,
                  ),
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: width * 0.1),
              child: Material(
                borderRadius: BorderRadius.circular(12),
                color: AppColors.editProfileFieldColor,
                child: InkWell(
                  onTap: () async {
                    await controller.selectDate(context);
                  },
                  borderRadius: BorderRadius.circular(12),
                  child: Obx(
                    () => Container(
                      height: height * 0.07,
                      width: width,
                      padding: EdgeInsets.symmetric(horizontal: width * 0.06),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            DateFormat("dd MMMM y")
                                .format(controller.selectedDate.value),
                            style: const TextStyle(
                                fontSize: 12,
                                fontFamily: AppTextStyles.fontFamily,
                                color: AppColors.black),
                          ),
                          Icon(
                            Icons.calendar_month,
                            color: AppColors.iconColor,
                          )
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ),
            Material(
              color: AppColors.buttonColor,
              borderRadius: BorderRadius.circular(10),
              child: InkWell(
                onTap: () {
                  if (controller.caloriesController.value.text.isEmpty) {
                    customSnackbar(
                        title: AppTexts.error, message: "Calories Required");
                  } else {
                    controller.postCheatFoodApi();
                    Navigator.pop(
                      context,
                    );
                  }
                },
                borderRadius: BorderRadius.circular(10),
                child: SizedBox(
                  width: width * 0.3,
                  height: height * 0.05,
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
