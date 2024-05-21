import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';
import 'package:intl/intl.dart';
import 'package:weight_loss_app/common/app_colors.dart';
import 'package:weight_loss_app/common/app_text_styles.dart';
import 'package:weight_loss_app/modules/ultimate_selfie/controller/ultimate_selfie_controller.dart';

class UserDateBottomsheet extends StatelessWidget {
  const UserDateBottomsheet({
    super.key,
    required this.controller,
    required this.weightUnit,
  });
  final UltimateSelfieController controller;
  final String weightUnit;
  @override
  Widget build(BuildContext context) {
    var screenSize = MediaQuery.sizeOf(context);
    double height = screenSize.height;
    double width = screenSize.width;
    return SizedBox(
      height: height * 0.8,
      width: width,
      child: Scaffold(
        backgroundColor: Colors.transparent,
        body: ListView(
          children: [
            SizedBox(
              height: height * 0.02,
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: width * 0.25),
              child: SizedBox(
                height: height * 0.2,
                child: Obx(
                  () {
                    final imagePath = controller.imagePath.value;
                    return imagePath.isEmpty
                        ? const Center(
                            child: Text('No image selected'),
                          )
                        : ClipRRect(
                            borderRadius: BorderRadius.circular(10),
                            child: Image.file(
                              File(imagePath),
                              fit: BoxFit.fill,
                            ),
                          );
                  },
                ),
              ),
            ),
            SizedBox(
              height: height * 0.02,
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: width * 0.15),
              child: TextField(
                controller: controller.weightController,
                keyboardType: TextInputType.number,
                style: AppTextStyles.formalTextStyle(),
                inputFormatters: [
                  FilteringTextInputFormatter.allow(
                    RegExp(r'^[1-9][0-9]*0*$'),
                  ),
                ],
                decoration: InputDecoration(
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(
                      color: AppColors.buttonColor,
                    ),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(
                      color: AppColors.buttonColor,
                    ),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  label: Text(
                    "Add Weight",
                    style: AppTextStyles.formalTextStyle(color: AppColors.gray),
                  ),
                  suffixText: weightUnit,
                  suffixStyle: AppTextStyles.formalTextStyle(),
                ),
              ),
            ),
            SizedBox(
              height: height * 0.02,
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: width * 0.15),
              child: TextField(
                controller: controller.waistController,
                keyboardType: TextInputType.number,
                style: AppTextStyles.formalTextStyle(),
                inputFormatters: [
                  FilteringTextInputFormatter.allow(
                    RegExp(r'^[1-9][0-9]*0*$'),
                  ),
                ],
                decoration: InputDecoration(
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(
                      color: AppColors.buttonColor,
                    ),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(
                      color: AppColors.buttonColor,
                    ),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  label: Text(
                    "Add Waist",
                    style: AppTextStyles.formalTextStyle(color: AppColors.gray),
                  ),
                  suffixText: "In",
                  suffixStyle: AppTextStyles.formalTextStyle(),
                ),
              ),
            ),
            SizedBox(
              height: height * 0.02,
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: width * 0.15),
              child: Material(
                shape: RoundedRectangleBorder(
                  side: BorderSide(
                    color: AppColors.buttonColor,
                  ),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: InkWell(
                  onTap: () async {
                    await controller.pickDate(context);
                  },
                  borderRadius: BorderRadius.circular(10),
                  child: SizedBox(
                    height: height * 0.07,
                    child: Padding(
                      padding: EdgeInsets.only(left: width * 0.03),
                      child: Align(
                        alignment: Alignment.centerLeft,
                        child: Obx(
                          () {
                            final selectedDate = controller.selectedDate.value;
                            return Text(
                              selectedDate != null
                                  ? 'Date: ${DateFormat("MMMM d, y").format(selectedDate)}'
                                  : 'Selecte Date',
                              style: AppTextStyles.formalTextStyle(
                                color: Theme.of(context)
                                    .primaryTextTheme
                                    .titleMedium!
                                    .color!,
                              ),
                            );
                          },
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ),
            SizedBox(
              height: height * 0.02,
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: width * 0.15),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  ElevatedButton(
                    style: ButtonStyle(
                        backgroundColor:
                            MaterialStatePropertyAll(AppColors.buttonColor)),
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                    child: const Text(
                      'Discard',
                      style: TextStyle(
                        color: AppColors.white,
                      ),
                    ),
                  ),
                  ElevatedButton(
                    style: ButtonStyle(
                        backgroundColor:
                            MaterialStatePropertyAll(AppColors.buttonColor)),
                    onPressed: () async {
                      controller.validateAndPost(
                        context,
                        controller.userSelfieData.value.userDto!.height!,
                        weightUnit,
                      );
                    },
                    child: const Text(
                      'Save',
                      style: TextStyle(
                        color: AppColors.white,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
