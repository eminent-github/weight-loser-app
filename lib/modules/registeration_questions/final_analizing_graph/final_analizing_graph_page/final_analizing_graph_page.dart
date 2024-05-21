import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:sp_showcaseview/showcaseview.dart';
import 'package:weight_loss_app/common/app_assets.dart';
import 'package:weight_loss_app/modules/dashbored/binding/dashboared_binding.dart';
import 'package:weight_loss_app/modules/dashbored/dashboared_page/dashboared_page.dart';
import 'package:weight_loss_app/utils/internet_check_widget.dart';
import 'package:weight_loss_app/widgets/app_logo.dart';

import '../../../../common/app_text_styles.dart';
import '../../widgets/qus_next_button.dart';
import '../controller/final_analizing_graph_controller.dart';

class FinalAnalizingGraphPage extends GetView<FinalAnalizingGraphController> {
  const FinalAnalizingGraphPage({super.key});

  @override
  Widget build(BuildContext context) {
    var screenSize = MediaQuery.sizeOf(context);
    double height = screenSize.height - kToolbarHeight;
    double width = screenSize.width;
    return Scaffold(
      appBar: AppBar(),
      body: InternetCheckWidget<ConnectivityService>(
        child: SafeArea(
          child: SingleChildScrollView(
            child: Column(
              children: [
                const AppLogo(),
                SizedBox(
                  height: height * 0.03,
                ),
                SizedBox(
                  width: width * 0.95,
                  child: const AutoSizeText.rich(
                    textAlign: TextAlign.center,
                    TextSpan(
                      children: [
                        TextSpan(
                          text: 'We got you covered!',
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 18,
                            fontFamily: 'Poppins',
                            fontWeight: FontWeight.w400,
                            height: 0,
                          ),
                        ),
                      ],
                    ),
                    maxLines: 1,
                    minFontSize: 12,
                  ),
                ),
                SizedBox(
                  height: height * 0.03,
                ),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: width * 0.035),
                  child: SizedBox(
                    height: height * 0.15,
                    child: const AutoSizeText.rich(
                      TextSpan(
                        children: [
                          TextSpan(
                            text:
                                'We celebrate your individuality by providing tailored diet plans personalized by Nutritionists, Psychologists, and Exercise physiologists.\nGet ready to embrace a thriving and wholesome lifestyle to be a',
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: 16,
                              fontFamily: 'Poppins',
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                          TextSpan(
                            text: ' WeightLoser!',
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: 16,
                              fontFamily: 'Poppins',
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                        ],
                      ),
                      textAlign: TextAlign.justify,
                      minFontSize: 10,
                    ),
                  ),
                ),
                SizedBox(
                  height: height * 0.02,
                ),
                SizedBox(
                  height: height * 0.35,
                  width: width * 0.85,
                  child: SvgPicture.asset(AppAssets.personGraphSvgUrl),
                ),
                SizedBox(
                  height: height * 0.04,
                ),
                QusNextButton(
                  callBack: () {
                    Get.offAll(
                        () => ShowCaseWidget(builder: Builder(
                              builder: (context) {
                                return const DashboaredPage();
                              },
                            )),
                        binding: DashboaredBinding());
                  },
                  height: height * 0.07,
                  width: width * 0.5,
                ),
                SizedBox(
                  height: height * 0.05,
                ),
                Stack(
                  children: [
                    Container(
                      height: height * 0.055,
                      width: width * 0.85,
                      decoration: BoxDecoration(
                        color: Colors.pink.shade100,
                        borderRadius: BorderRadius.circular(5),
                      ),
                    ),
                    AnimatedBuilder(
                      animation: controller.animationController,
                      builder: (context, child) {
                        return Container(
                          height: height * 0.055,
                          width: controller.animationController.value *
                              width *
                              0.85,
                          decoration: BoxDecoration(
                            color: const Color(0xffF4C2AB),
                            borderRadius: BorderRadius.circular(5),
                          ),
                          child: const Center(
                            child: Text(
                              '100%',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 21,
                                fontFamily: AppTextStyles.fontFamily,
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                          ),
                        );
                      },
                    ),
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
