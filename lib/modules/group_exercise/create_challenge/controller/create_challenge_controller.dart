import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../../common/app_colors.dart';

class CreateChallengeController extends GetxController {
  var selectedIndex = 0.obs;
  List<String> cbtQuesList = <String>[
    '2k Running',
    '3k Running',
    '4k Running',
    '5k Running',
    '6k Running',
    '7k Running',
  ];

  var selectedDate = DateTime.now().obs;
  var selectTime = TimeOfDay.now().obs;

  Future<void> selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: selectedDate.value,
      firstDate: selectedDate.value,
      lastDate: DateTime(2101),
      builder: (context, child) {
        return Theme(
          data: Theme.of(context).copyWith(
            colorScheme: ColorScheme.light(
              primary: AppColors.buttonColor,
              onPrimary: Colors.white,
              onSurface: Colors.black,
            ),
            textButtonTheme: TextButtonThemeData(
              style: TextButton.styleFrom(
                foregroundColor: AppColors.buttonColor,
              ),
            ),
          ),
          child: child!,
        );
      },
    );
    if (picked != null && picked != selectedDate.value) {
      selectedDate.value = picked;
    }
  }

  Future<void> time(BuildContext context) async {
    final pickedTime = await showTimePicker(
      context: context,
      initialTime: selectTime.value,
      builder: (context, child) {
        return Theme(
          data: Theme.of(context).copyWith(
            colorScheme: ColorScheme.light(
              primary: AppColors.buttonColor,
              onPrimary: Colors.black,
              onSurface: Colors.black,
            ),
            textButtonTheme: TextButtonThemeData(
              style: TextButton.styleFrom(
                foregroundColor: AppColors.buttonColor,
              ),
            ),
          ),
          child: child!,
        );
      },
    );

    if (pickedTime != null) {
      selectTime.value = pickedTime;
    }
  }
}
