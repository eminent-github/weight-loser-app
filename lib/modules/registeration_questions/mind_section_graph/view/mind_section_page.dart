import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get_state_manager/src/simple/get_view.dart';
import 'package:weight_loss_app/common/app_text_styles.dart';
import 'package:weight_loss_app/utils/internet_check_widget.dart';

import '../../../../common/app_assets.dart';
import '../../../../common/app_colors.dart';
import '../../../../common/app_texts.dart';
import '../../../../widgets/custom_large_button.dart';
import '../../section_change_page/section_change_page.dart';
import '../../widgets/transitions.dart';
import '../controller/mind_section_controller.dart';

class MindSectionPage extends GetView<MindSectionController> {
  const MindSectionPage({super.key});

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
      ),
      extendBodyBehindAppBar: true,
      body: InternetCheckWidget<ConnectivityService>(
        child: SingleChildScrollView(
          child: Column(
            children: [
              Container(
                height: height * 0.5,
                color: AppColors.mindModuleColor,
                child: Center(
                  child: SvgPicture.asset(
                    AppAssets.mindSvgUrl,
                    height: height * 0.37,
                  ),
                ),
              ),
              SizedBox(
                height: height * 0.05,
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: width * 0.14),
                child: AutoSizeText(
                  AppTexts.mindSectionYourMind,
                  minFontSize: 15,
                  maxLines: 3,
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
                padding: EdgeInsets.symmetric(horizontal: width * 0.14),
                child: AutoSizeText(
                  AppTexts.mindSectionStrengthenYour,
                  textAlign: TextAlign.center,
                  minFontSize: 10,
                  maxLines: 2,
                  style: AppTextStyles.formalTextStyle(
                    color: AppColors.understandWidgetBorderColor,
                    fontSize: 16,
                    fontWeight: FontWeight.w400,
                  ),
                ),
              ),
              SizedBox(
                height: height * 0.1,
              ),
              CustomLargeButton(
                text: "Unlock your potential",
                height: height,
                width: width * 0.6,
                onPressed: () {
                  Navigator.push(
                    context,
                    PageRouteBuilder(
                        pageBuilder: (context, animation, secondaryAnimation) =>
                            const SectionChangePage(
                              pageBackColor: AppColors.mindModuleColor,
                              module: "mind",
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
      ),
    );
  }
}
