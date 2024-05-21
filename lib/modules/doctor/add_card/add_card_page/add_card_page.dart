import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:weight_loss_app/common/app_colors.dart';
import 'package:weight_loss_app/common/app_text_styles.dart';
import 'package:weight_loss_app/modules/doctor/add_card/widgets/card_custom_field.dart';
import 'package:weight_loss_app/modules/doctor/waiting_area/binding/waiting_area_binding.dart';
import 'package:weight_loss_app/modules/doctor/waiting_area/waiting_area_page/waiting_area_page.dart';
import 'package:weight_loss_app/widgets/custom_large_button.dart';

import '../controller/add_card_controller.dart';

class AddCardPage extends GetView<AddCardController> {
  const AddCardPage({
    super.key,
    required this.contactType,
  });
  final String contactType;
  @override
  Widget build(BuildContext context) {
    var screenSize = MediaQuery.sizeOf(context);
    double screenHeight = screenSize.height;
    double height = screenSize.height - kToolbarHeight;
    double width = screenSize.width;
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: AppColors.white,
        iconTheme: const IconThemeData.fallback(),
        elevation: 0,
        toolbarHeight: screenHeight * 0.1,
      ),
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: width * 0.08),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  height: height * 0.05,
                ),
                Text(
                  'Add Credit Card',
                  style: AppTextStyles.formalTextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w800,
                  ),
                ),
                SizedBox(
                  height: height * 0.02,
                ),
                CardCustomField(
                  controller: controller.nameController,
                  hintText: "Enter Card Holder Full Name",
                  title: "Full Name*",
                ),
                SizedBox(
                  height: height * 0.02,
                ),
                CardCustomField(
                  controller: controller.cardNumberController,
                  hintText: "Enter Card Number",
                  title: "Credit Card Number*",
                  keyboardType: TextInputType.number,
                ),
                SizedBox(
                  height: height * 0.02,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    SizedBox(
                      width: width * 0.4,
                      child: CardCustomField(
                        controller: controller.expiryDateController,
                        hintText: "MM / YY",
                        title: "Expiry Date:",
                        keyboardType: TextInputType.number,
                        maxLength: 5,
                      ),
                    ),
                    SizedBox(
                      width: width * 0.4,
                      child: CardCustomField(
                        controller: controller.cvvController,
                        hintText: "Enter CVV Number",
                        title: "CVV:",
                        maxLength: 3,
                        keyboardType: TextInputType.number,
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: height * 0.1,
                ),
                Center(
                  child: CustomLargeButton(
                    width: width * 0.84,
                    height: height,
                    onPressed: () {
                      Get.to(() => WaitingAreaPage(contactType: contactType),
                          binding: WaitingAreaBinding());
                    },
                    borderRadius: BorderRadius.circular(50),
                    text: "Pay now",
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
