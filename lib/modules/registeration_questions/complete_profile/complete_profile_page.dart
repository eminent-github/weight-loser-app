import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:weight_loss_app/common/app_assets.dart';
import 'package:weight_loss_app/common/app_colors.dart';
import 'package:weight_loss_app/common/app_text_styles.dart';
import 'package:weight_loss_app/modules/registeration_questions/eating_habits/binding/eating_habits_binding.dart';
import 'package:weight_loss_app/modules/registeration_questions/eating_habits/eating_habits_page/eating_habits_page.dart';
import 'package:weight_loss_app/modules/registeration_questions/widgets/qus_next_button.dart';

class CompleteProfilePage extends StatelessWidget {
  const CompleteProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    var screenSize = MediaQuery.sizeOf(context);
    double height = screenSize.height - kToolbarHeight;
    double width = screenSize.width;
    return Scaffold(
      appBar: AppBar(),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SvgPicture.asset(AppAssets.completeProfileSvgUrl),
          SizedBox(
            height: height * 0.03,
          ),
          Text(
            "Let's Complete Your Profile",
            textAlign: TextAlign.center,
            style: AppTextStyles.formalTextStyle(
              color: AppColors.buttonColor,
              fontSize: 20,
              fontWeight: FontWeight.w700,
            ),
          ),
          SizedBox(
            height: height * 0.03,
          ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: width * 0.07),
            child: Text(
              'We appreciate your interest in your well-being and encourage you to keep pursuing your goals.',
              textAlign: TextAlign.center,
              style: AppTextStyles.formalTextStyle(
                color: AppColors.buttonColor,
              ),
            ),
          ),
          SizedBox(
            height: height * 0.1,
          ),
          QusNextButton(
            callBack: () {
              Get.to(
                () => const EatingHabitsPage(),
                binding: EatingHabitsBinding(),
              );
            },
            text: "Let's Start",
            height: height * 0.06,
            width: width * 0.5,
          ),
        ],
      ),
    );
  }
}
