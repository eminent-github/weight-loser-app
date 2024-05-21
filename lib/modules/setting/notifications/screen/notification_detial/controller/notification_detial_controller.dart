import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:weight_loss_app/common/app_colors.dart';

class NotificationDetialController extends GetxController {
  var selectTime = "".obs;
  void getInitaialTime(String ltime) {
    selectTime.value = ltime;
  }

  Future<void> time(BuildContext context) async {
    final pickedTime = await showTimePicker(
      context: context,
      initialTime: TimeOfDay.now(),
      builder: (context, child) {
        return Theme(
          data: Theme.of(context).copyWith(
            colorScheme: ColorScheme.light(
                primary: AppColors.buttonColor,
                secondary: AppColors.buttonColor,
                onSecondary: AppColors.white
                // onPrimary: Colors.black,
                // onSurface: Colors.black,
                ),
          ),
          child: child!,
        );
      },
    );

    if (pickedTime != null) {
      selectTime.value = pickedTime.format(context);
    }
  }
}
