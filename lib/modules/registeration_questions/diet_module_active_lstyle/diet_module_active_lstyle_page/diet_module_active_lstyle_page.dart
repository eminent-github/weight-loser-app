import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:weight_loss_app/utils/internet_check_widget.dart';

import '../../../../common/app_assets.dart';
import '../../../../common/app_colors.dart';
import '../../../../common/app_text_styles.dart';
import '../../../../common/app_texts.dart';
import '../../../../widgets/custom_large_button.dart';
import '../../section_change_page/section_change_page.dart';
import '../../widgets/transitions.dart';
import '../controller/diet_module_active_lstyle_controller.dart';

class DietModuleActiveStylePage
    extends GetView<DietModuleActiveStyleController> {
  const DietModuleActiveStylePage({super.key});

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height - kToolbarHeight;
    double width = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.dietModuleColor,
      ),
      body: InternetCheckWidget<ConnectivityService>(
        child: Column(
          children: [
            Container(
              height: height * 0.5,
              color: AppColors.dietModuleColor,
              child: Center(
                child: SvgPicture.asset(
                  AppAssets.energizeSvg,
                  height: height * 0.37,
                ),
              ),
            ),
            SizedBox(
              height: height * 0.08,
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: width * 0.05),
              child: Text(
                AppTexts.dietSectionYourLifeStyle,
                textAlign: TextAlign.center,
                style: AppTextStyles.formalTextStyle(
                  color: AppColors.buttonColor,
                  fontSize: 22,
                  fontWeight: FontWeight.w700,
                ),
              ),
            ),
            SizedBox(
              height: height * 0.03,
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: width * 0.13),
              child: AutoSizeText(
                AppTexts.dietSectionStrengthenYour,
                textAlign: TextAlign.center,
                maxLines: 2,
                minFontSize: 10,
                style: AppTextStyles.formalTextStyle(
                  color: AppColors.understandWidgetBorderColor,
                  fontSize: 16,
                ),
              ),
            ),
            SizedBox(
              height: height * 0.1,
            ),
            CustomLargeButton(
              text: AppTexts.energizeButtonText,
              height: height,
              width: width * 0.6,
              onPressed: () {
                Navigator.push(
                  context,
                  PageRouteBuilder(
                      pageBuilder: (context, animation, secondaryAnimation) =>
                          const SectionChangePage(
                            pageBackColor: AppColors.exerciseModuleColor,
                            module: "exercise",
                          ),
                      transitionsBuilder:
                          (context, animation, secondaryAnimation, child) {
                        return bottomSlideTransition(animation, child);
                      },
                      transitionDuration: const Duration(milliseconds: 800)),
                );
              },
            )
          ],
        ),
      ),
    );
  }
}
