import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:weight_loss_app/common/app_colors.dart';

import '../../../../common/app_text_styles.dart';
import '../controller/doctors_list_controller.dart';
import '../widgets/doctor_list_item.dart';

class DoctorsListPage extends GetView<DoctorsListController> {
  const DoctorsListPage({super.key});

  @override
  Widget build(BuildContext context) {
    var screenSize = MediaQuery.sizeOf(context);
    double screenHeight = screenSize.height;
    double height = screenSize.height - kToolbarHeight;
    double width = screenSize.width;
    return Scaffold(
      resizeToAvoidBottomInset: true,
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: AppColors.white,
        iconTheme: const IconThemeData.fallback(),
        elevation: 0,
        toolbarHeight: screenHeight * 0.1,
        title: Text(
          'Find Verified Specialists',
          style: AppTextStyles.formalTextStyle(
            color: AppColors.buttonColor,
            fontSize: 18,
            fontWeight: FontWeight.w700,
          ),
        ),
      ),
      body: SafeArea(
        child: Column(
          children: [
            Container(
              width: width * 0.8,
              height: height * 0.07,
              margin: EdgeInsets.only(top: height * 0.005),
              padding: EdgeInsets.symmetric(horizontal: width * 0.03),
              decoration: ShapeDecoration(
                color: Colors.white,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
                shadows: const [
                  BoxShadow(
                    color: Color(0x3F000000),
                    blurRadius: 4,
                    offset: Offset(0, 1),
                    spreadRadius: 0,
                  )
                ],
              ),
              child: Center(
                child: TextField(
                  controller: controller.searhController,
                  style: AppTextStyles.formalTextStyle(
                    fontSize: 12,
                  ),
                  onChanged: (value) {
                    controller.searchQuery.value = value;
                  },
                  decoration: InputDecoration(
                    hintText: "Search for doctors",
                    hintStyle: AppTextStyles.formalTextStyle(
                      fontSize: 12,
                    ),
                    border: InputBorder.none,
                    prefixIcon: Icon(
                      Icons.search_rounded,
                      color: AppColors.buttonColor,
                    ),
                  ),
                ),
              ),
            ),
            SizedBox(
              height: height * 0.05,
            ),
            Expanded(
              child: DoctorsListItem(
                doctorsList: controller.filteredDoctorsList,
                controller: controller,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
