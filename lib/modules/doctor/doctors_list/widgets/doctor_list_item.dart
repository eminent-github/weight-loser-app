import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:weight_loss_app/modules/doctor/doctor_appointment/binding/doctor_appointment_binding.dart';

import '../../../../common/app_colors.dart';
import '../../../../common/app_text_styles.dart';
import '../../doctor_appointment/doctor_appointment_page/doctor_appointment_page.dart';
import '../controller/doctors_list_controller.dart';
import '../models/doctor_model.dart';

class DoctorsListItem extends StatelessWidget {
  const DoctorsListItem(
      {super.key, required this.doctorsList, required this.controller});
  final List<DoctorModel> doctorsList;
  final DoctorsListController controller;
  @override
  Widget build(BuildContext context) {
    var screenSize = MediaQuery.sizeOf(context);
    double height = screenSize.height;
    double width = screenSize.width;
    return Obx(
      () {
        return ListView.builder(
          padding: EdgeInsets.symmetric(horizontal: width * 0.1),
          itemCount: doctorsList.length,
          itemBuilder: (context, index) {
            return InkWell(
              onTap: () {
                Get.to(
                    () => DoctorAppointmentPage(doctorData: doctorsList[index]),
                    binding: DoctorAppointmentBinding());
              },
              child: Container(
                width: width,
                height: 106,
                margin: EdgeInsets.symmetric(vertical: height * 0.02),
                decoration: ShapeDecoration(
                  color: Colors.white,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(21),
                  ),
                  shadows: const [
                    BoxShadow(
                      color: Color(0x3F000000),
                      blurRadius: 4,
                      offset: Offset(0, 0),
                      spreadRadius: 0,
                    )
                  ],
                ),
                child: Row(
                  children: [
                    Expanded(
                      flex: 3,
                      child: Container(
                        decoration: ShapeDecoration(
                          image: DecorationImage(
                            image: AssetImage(doctorsList[index].imagUrl),
                            fit: BoxFit.fill,
                          ),
                          shape: RoundedRectangleBorder(
                            side: const BorderSide(
                                width: 0.50, color: Color(0xFFE8E8E8)),
                            borderRadius: BorderRadius.circular(21),
                          ),
                        ),
                      ),
                    ),
                    Expanded(
                      flex: 6,
                      child: Padding(
                        padding: EdgeInsets.only(left: width * 0.04),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              doctorsList[index].name,
                              style: AppTextStyles.formalTextStyle(
                                color: AppColors.buttonColor,
                                fontSize: 14,
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                            Text(
                              doctorsList[index].specialization,
                              style: AppTextStyles.formalTextStyle(
                                fontSize: 12,
                              ),
                            ),
                            Text.rich(
                              TextSpan(
                                children: [
                                  TextSpan(
                                    text: 'Available: ',
                                    style: AppTextStyles.formalTextStyle(
                                      fontSize: 12,
                                    ),
                                  ),
                                  TextSpan(
                                    text: doctorsList[index].avialability,
                                    style: AppTextStyles.formalTextStyle(
                                      color: AppColors.buttonColor,
                                      fontSize: 12,
                                      fontWeight: FontWeight.w700,
                                    ),
                                  ),
                                ],
                              ),
                            )
                          ],
                        ),
                      ),
                    ),
                    Expanded(
                      flex: 1,
                      child: Visibility(
                        visible: doctorsList[index].available,
                        child: Align(
                          alignment: Alignment.topLeft,
                          child: Container(
                            width: 18,
                            height: 18,
                            margin: EdgeInsets.only(top: height * 0.01),
                            decoration: const BoxDecoration(
                              color: Color(0xFF94B986),
                              shape: BoxShape.circle,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            );
          },
        );
      },
    );
  }
}
