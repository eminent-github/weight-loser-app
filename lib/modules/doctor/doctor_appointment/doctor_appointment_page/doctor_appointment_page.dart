import 'package:expandable_text/expandable_text.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:weight_loss_app/widgets/custom_large_button.dart';

import '../../../../common/app_colors.dart';
import '../../../../common/app_text_styles.dart';
import '../../../../widgets/custom_datetime_calender.dart';
import '../../doctors_list/models/doctor_model.dart';
import '../controller/doctor_appointment_controller.dart';
import '../widgets/doc_app_time.dart';
import '../widgets/doc_avialability.dart';
import '../widgets/doc_payment_bottomsheet.dart';
import '../widgets/doc_social_fee.dart';

class DoctorAppointmentPage extends GetView<DoctorAppointmentController> {
  const DoctorAppointmentPage({
    super.key,
    required this.doctorData,
  });
  final DoctorModel doctorData;

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
        title: Text(
          'Book An Appointment',
          style: AppTextStyles.formalTextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w700,
          ),
        ),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                width: width,
                height: height * 0.15,
                margin: EdgeInsets.symmetric(horizontal: width * 0.05),
                child: Row(
                  children: [
                    Expanded(
                      flex: 3,
                      child: Container(
                        decoration: ShapeDecoration(
                          image: DecorationImage(
                            image: AssetImage(doctorData.imagUrl),
                            fit: BoxFit.fill,
                          ),
                          shape: RoundedRectangleBorder(
                            side: const BorderSide(
                                width: 0.50, color: Color(0xFFE8E8E8)),
                            borderRadius: BorderRadius.circular(12),
                          ),
                        ),
                      ),
                    ),
                    Expanded(
                      flex: 7,
                      child: Padding(
                        padding: EdgeInsets.only(left: width * 0.04),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              doctorData.name,
                              style: AppTextStyles.formalTextStyle(
                                fontSize: 18,
                              ),
                            ),
                            Text(
                              doctorData.specialization,
                              style: AppTextStyles.formalTextStyle(
                                color: const Color(0xFF444343),
                                fontSize: 14,
                              ),
                            ),
                            Text(
                              doctorData.avialability,
                              style: AppTextStyles.formalTextStyle(
                                color: const Color(0xFF444343),
                                fontSize: 14,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: height * 0.04,
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: width * 0.07),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Biography',
                      style: AppTextStyles.formalTextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    SizedBox(
                      height: height * 0.02,
                    ),
                    ExpandableText(
                      "Dr. Anna Baker is an Indonesian specialist She pratices general at Hospital in Semarang Dr. Anna Baker is an Indonesian specialist She pratices general at Hospital in Semarang Dr. Anna Baker is an Indonesian specialist She pratices general at Hospital in Semarang",
                      expandText: 'show more',
                      collapseText: 'show less',
                      maxLines: 3,
                      linkColor: AppColors.buttonColor,
                      style: AppTextStyles.formalTextStyle(
                        color: const Color(0xFF79869F),
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: height * 0.04,
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: width * 0.05),
                child: Text(
                  'Schedule',
                  style: AppTextStyles.formalTextStyle(
                    fontSize: 16.70,
                  ),
                ),
              ),
              SizedBox(
                height: height * 0.02,
              ),
              SizedBox(
                height: height * 0.1,
                child: MyCustomCalender(
                  tableCalenderIcon: const Icon(
                    Icons.calendar_today,
                    color: Colors.white,
                  ),
                  date: DateTime.now(),
                  colorOfWeek: AppColors.black,
                  colorOfMonth: AppColors.black,
                  fontSizeOfWeek: 12,
                  fontSizeOfMonth: 18,
                  backgroundColor: Colors.transparent,
                  selectedColor: AppColors.buttonColor,
                  tableCalenderButtonColor: AppColors.buttonColor,
                  borderRadius: 15,
                  onDateSelected: (date) {
                    controller.selectedDate = date;
                  },
                ),
              ),
              SizedBox(
                height: height * .04,
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: width * 0.07),
                child: SizedBox(
                  height: height * 0.08,
                  child: DocAvailability(
                    controller: controller,
                  ),
                ),
              ),
              SizedBox(
                height: height * .04,
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: width * 0.05),
                child: SizedBox(
                  height: height * 0.15,
                  child: DocAppTime(
                    controller: controller,
                  ),
                ),
              ),
              SizedBox(
                height: height * .02,
              ),
              Padding(
                padding: EdgeInsets.only(left: width * 0.05),
                child: Text(
                  "Fees Information:",
                  style: AppTextStyles.formalTextStyle(
                      fontWeight: FontWeight.w900),
                ),
              ),
              SizedBox(
                height: height * .02,
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: width * 0.03),
                child: SizedBox(
                  height: height * .3,
                  child: DocSocailFee(
                    controller: controller,
                  ),
                ),
              ),
              SizedBox(
                height: height * .05,
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: width * 0.1),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Describe your health issue',
                      style: AppTextStyles.formalTextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    SizedBox(
                      height: height * .02,
                    ),
                    Container(
                      height: height * 0.18,
                      decoration: ShapeDecoration(
                        color: Colors.white,
                        shape: RoundedRectangleBorder(
                          side: const BorderSide(width: 0.50),
                          borderRadius: BorderRadius.circular(20.88),
                        ),
                      ),
                      padding: EdgeInsets.symmetric(
                          horizontal: width * 0.05, vertical: height * 0.01),
                      child: TextField(
                        controller: controller.detialController,
                        style: AppTextStyles.formalTextStyle(
                          fontSize: 15,
                        ),
                        maxLines: 5,
                        decoration: InputDecoration(
                          hintText: "Write your issue details here",
                          hintStyle: AppTextStyles.formalTextStyle(
                            color: AppColors.gray,
                            fontSize: 15,
                          ),
                          border: InputBorder.none,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: height * .08,
              ),
              Container(
                height: height * 0.15,
                decoration: const BoxDecoration(
                  color: AppColors.white,
                  boxShadow: [
                    BoxShadow(
                      color: Color(0x3F707070),
                      blurRadius: 31.32,
                      offset: Offset(0, -5.22),
                      spreadRadius: 0,
                    )
                  ],
                ),
                child: Center(
                  child: CustomLargeButton(
                    width: width * 0.8,
                    height: height,
                    onPressed: () {
                      showModalBottomSheet(
                          context: context,
                          builder: (BuildContext context) {
                            return DocPaymentBottomSheet(
                              controller: controller,
                            );
                          },
                          backgroundColor: Colors.transparent);
                    },
                    borderRadius: BorderRadius.circular(16),
                    text: "Book Appointment",
                  ),
                ),
              ),
              
            ],
          ),
        ),
      ),
    );
  }
}
