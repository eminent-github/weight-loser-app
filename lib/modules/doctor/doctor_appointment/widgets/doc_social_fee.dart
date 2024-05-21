import 'package:flutter/material.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';

import '../../../../common/app_colors.dart';
import '../controller/doctor_appointment_controller.dart';

class DocSocailFee extends StatelessWidget {
  const DocSocailFee({super.key, required this.controller});

  final DoctorAppointmentController controller;
  @override
  Widget build(BuildContext context) {
    var screenSize = MediaQuery.sizeOf(context);
    double height = screenSize.height;
    double width = screenSize.width;
    return ListView.builder(
      itemCount: controller.docContactList.length,
      physics: const NeverScrollableScrollPhysics(),
      itemBuilder: (context, index) {
        return Obx(
          () => InkWell(
            onTap: () {
              controller.paymentSelectionIndex.value = index;
            },
            borderRadius: BorderRadius.circular(15),
            child: ListTile(
              leading: Container(
                height: height * 0.06,
                width: width * 0.15,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(15),
                    color: AppColors.buttonColor),
                child: Center(
                  child: Icon(
                    controller.docContactList[index].icon,
                    size: 25,
                    color: Colors.white,
                  ),
                ),
              ),
              title: Text(
                controller.docContactList[index].title,
                style: const TextStyle(
                    fontSize: 12,
                    color: Color(0xff354259),
                    fontWeight: FontWeight.w900),
              ),
              subtitle: Text(
                controller.docContactList[index].subTitle,
                style: const TextStyle(
                    fontSize: 11,
                    color: Color(0xff687DA2),
                    fontWeight: FontWeight.w700),
              ),
              trailing: SizedBox(
                width: width * 0.15,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      controller.docContactList[index].price,
                      style: const TextStyle(
                          fontSize: 13,
                          color: Color(0xffFC4B6F),
                          fontWeight: FontWeight.w900),
                    ),
                    SizedBox(
                      width: width * .02,
                    ),
                    controller.paymentSelectionIndex.value == index
                        ? Container(
                            width: 20,
                            height: 20,
                            decoration: const BoxDecoration(
                              shape: BoxShape.circle,
                              color: Color(0xff2F98B9),
                            ),
                            child: const Icon(
                              Icons.check,
                              color: Colors.white,
                              size: 16,
                            ),
                          )
                        : Container(
                            width: 20,
                            height: 20,
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color: Colors.white,
                              border: Border.all(
                                color: const Color(0xff2F98B9),
                                width: 2,
                              ),
                            ),
                          ),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
