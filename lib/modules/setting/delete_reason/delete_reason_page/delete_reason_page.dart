import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:weight_loss_app/common/app_colors.dart';
import 'package:weight_loss_app/common/app_text_styles.dart';
import 'package:weight_loss_app/modules/setting/delete_reason/controller/delete_reason_controller.dart';

class DeleteReasonPage extends GetView<DeleteReasonController> {
  const DeleteReasonPage({super.key});

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    double height = size.height;
    double width = size.width;
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Delete Account',
          style: AppTextStyles.formalTextStyle(fontSize: 16),
        ),
      ),
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(
              horizontal: width * 0.05, vertical: height * 0.03),
          child: Obx(
            () => Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "We're sorry to see\nyou go",
                  style: AppTextStyles.formalTextStyle(
                      fontSize: 28, fontWeight: FontWeight.bold),
                ),
                SizedBox(
                  height: height * 0.04,
                ),
                Text(
                  "Let us know why you'd like to delete",
                  style: AppTextStyles.formalTextStyle(),
                ),
                SizedBox(
                  height: height * 0.04,
                ),
                Expanded(
                  child: ListView.builder(
                    padding: EdgeInsets.symmetric(vertical: height * 0.03),
                    itemCount: controller.optionList.length,
                    itemBuilder: (context, index) {
                      return Obx(
                        () => RadioListTile(
                          value: index,
                          groupValue: controller.selectedIndex.value,
                          onChanged: (value) {
                            controller.selectedIndex.value = index;
                          },
                          title: Text(
                            controller.optionList[index],
                            style: AppTextStyles.formalTextStyle(),
                          ),
                        ),
                      );
                    },
                  ),
                ),
                SizedBox(
                  height: height * 0.06,
                  child: Material(
                    elevation: 3,
                    color: AppColors.buttonColor,
                    borderRadius: BorderRadius.circular(5),
                    child: InkWell(
                      onTap: controller.isLoading.value
                          ? () {}
                          : () {
                              controller.reviewApi(controller
                                  .optionList[controller.selectedIndex.value]);
                            },
                      borderRadius: BorderRadius.circular(5),
                      child: Center(
                        child: controller.isLoading.value
                            ? const CircularProgressIndicator.adaptive(
                                backgroundColor: AppColors.white,
                              )
                            : Text(
                                "CONTINUE",
                                style: AppTextStyles.formalTextStyle(
                                  color: AppColors.white,
                                  fontSize: 16,
                                ),
                              ),
                      ),
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
