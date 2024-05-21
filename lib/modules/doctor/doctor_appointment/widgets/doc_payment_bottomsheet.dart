import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:weight_loss_app/common/app_assets.dart';
import 'package:weight_loss_app/modules/doctor/add_card/add_card_page/add_card_page.dart';
import 'package:weight_loss_app/modules/doctor/add_card/binding/add_card_binding.dart';
import 'package:weight_loss_app/modules/doctor/waiting_area/binding/waiting_area_binding.dart';
import 'package:weight_loss_app/modules/doctor/waiting_area/waiting_area_page/waiting_area_page.dart';

import '../../../../common/app_colors.dart';
import '../../../../common/app_text_styles.dart';
import '../controller/doctor_appointment_controller.dart';

class DocPaymentBottomSheet extends StatelessWidget {
  const DocPaymentBottomSheet({
    super.key,
    required this.controller,
  });

  final DoctorAppointmentController controller;

  @override
  Widget build(BuildContext context) {
    var screenSize = MediaQuery.sizeOf(context);
    double height = screenSize.height;
    double width = screenSize.width;
    return Container(
      height: height * 0.4,
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.only(
          topRight: Radius.circular(20),
          topLeft: Radius.circular(20),
        ),
      ),
      child: Column(
        children: [
          SizedBox(
            height: height * 0.06,
          ),
          Text(
            "Payment Method",
            style: AppTextStyles.formalTextStyle(
              fontSize: 22,
              color: AppColors.buttonColor,
            ),
          ),
          SizedBox(
            height: height * 0.01,
          ),
          Text(
            "Select your Preferable Payment Method",
            style: AppTextStyles.formalTextStyle(),
          ),
          SizedBox(
            height: height * 0.03,
          ),
          SizedBox(
              height: height * 0.22,
              width: width * 0.8,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Material(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                      side:
                          BorderSide(width: 0.7, color: AppColors.buttonColor),
                    ),
                    elevation: 30,
                    shadowColor: const Color.fromARGB(50, 0, 0, 0),
                    child: InkWell(
                      onTap: () {
                        Navigator.pop(context);
                        Get.to(
                            () => WaitingAreaPage(
                                contactType: controller
                                    .docContactList[
                                        controller.paymentSelectionIndex.value]
                                    .title),
                            binding: WaitingAreaBinding());
                      },
                      borderRadius: BorderRadius.circular(10),
                      child: ListTile(
                        leading: Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(8),
                          ),
                          height: height * 0.04,
                          width: width * 0.09,
                          child: Center(
                            child: SvgPicture.asset(
                              AppAssets.googlepayIconSvgUrl,
                            ),
                          ),
                        ),
                        title: Text(
                          'G Pay',
                          style: AppTextStyles.formalTextStyle(
                            fontSize: 13,
                            fontWeight: FontWeight.w500,
                            color: Colors.black,
                          ),
                        ),
                        trailing: Icon(
                          Icons.arrow_forward_ios,
                          size: 17,
                          color: AppColors.buttonColor,
                        ),
                      ),
                    ),
                  ),
                  Material(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                      side:
                          BorderSide(width: 0.7, color: AppColors.buttonColor),
                    ),
                    elevation: 30,
                    shadowColor: const Color.fromARGB(50, 0, 0, 0),
                    child: InkWell(
                      onTap: () {
                        Navigator.pop(context);

                        Get.to(
                            () => AddCardPage(
                                contactType: controller
                                    .docContactList[
                                        controller.paymentSelectionIndex.value]
                                    .title),
                            binding: AddCardBinding());
                      },
                      borderRadius: BorderRadius.circular(10),
                      child: ListTile(
                        leading: Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(8),
                          ),
                          height: height * 0.04,
                          width: width * 0.09,
                          child: Center(
                            child: SvgPicture.asset(
                              AppAssets.addcardIconSvgUrl,
                            ),
                          ),
                        ),
                        title: Text(
                          'Credit/Master',
                          style: AppTextStyles.formalTextStyle(
                            fontSize: 13,
                            fontWeight: FontWeight.w500,
                            color: Colors.black,
                          ),
                        ),
                        trailing: Icon(
                          Icons.arrow_forward_ios,
                          size: 17,
                          color: AppColors.buttonColor,
                        ),
                      ),
                    ),
                  ),
                ],
              ))
        ],
      ),
    );
  }
}
