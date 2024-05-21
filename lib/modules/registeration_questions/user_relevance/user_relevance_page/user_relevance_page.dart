import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:weight_loss_app/common/app_colors.dart';
import 'package:weight_loss_app/common/app_text_styles.dart';
import 'package:weight_loss_app/modules/page_not_found/not_found_page.dart';
import 'package:weight_loss_app/modules/registeration_questions/deit_goal/binding/goal_diet_binding.dart';
import 'package:weight_loss_app/modules/registeration_questions/deit_goal/goal_diet_page/goal_diet_page.dart';
import 'package:weight_loss_app/modules/registeration_questions/favourite_Rasturants/binding/fav_rasturants_binding.dart';
import 'package:weight_loss_app/modules/registeration_questions/favourite_Rasturants/view/fav_rasturants_page.dart';
import 'package:weight_loss_app/modules/registeration_questions/user_relevance/models/user_relevance_model.dart';
import 'package:weight_loss_app/widgets/app_logo.dart';
import '../../../../widgets/custom_large_button.dart';
import '../../section_change_page/section_change_page.dart';
import '../../widgets/transitions.dart';

class UserRelevancePage extends StatelessWidget {
  const UserRelevancePage({
    super.key,
    required this.userRelevanceModel,
    this.fazoolText = "",
    this.buttonTextColor = AppColors.white,
  });
  final UserRelevanceModel userRelevanceModel;
  final String fazoolText;
  final Color buttonTextColor;
  @override
  Widget build(BuildContext context) {
    var screenSize = MediaQuery.sizeOf(context);
    double height = screenSize.height - kToolbarHeight;
    double width = screenSize.width;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: userRelevanceModel.color,
        iconTheme: IconThemeData(
          color: userRelevanceModel.textColor,
        ),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              Container(
                color: userRelevanceModel.color,
                padding: EdgeInsets.only(bottom: height * 0.06),
                child: Column(
                  // mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const AppLogo(),
                    SizedBox(
                      height: height * 0.05,
                    ),
                    Text(
                      userRelevanceModel.title,
                      textAlign: TextAlign.center,
                      style: AppTextStyles.formalTextStyle(
                        color: userRelevanceModel.textColor,
                        fontSize: height * 0.026,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    SizedBox(
                      height: height * 0.03,
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: width * 0.2),
                      child: Text(
                        userRelevanceModel.subtitle,
                        textAlign: TextAlign.center,
                        style: AppTextStyles.formalTextStyle(
                          color: userRelevanceModel.subTextColor,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: height * 0.05,
              ),
              Container(
                width: width * 0.85,
                height: height * 0.3,
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage(userRelevanceModel.imageUrl),
                  ),
                ),
              ),
              SizedBox(
                height: height * 0.03,
              ),
              SizedBox(
                height: height * 0.025,
                width: width * 0.6,
                child: FittedBox(
                  child: Text(
                    fazoolText,
                    textAlign: TextAlign.center,
                    style: AppTextStyles.formalTextStyle(
                      color: AppColors.blue,
                      fontSize: 16,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: height * 0.06,
              ),
              CustomLargeButton(
                height: height,
                width: width * 0.6,
                color: userRelevanceModel.color,
                // color: AppColors.blue,
                child: AutoSizeText(
                  userRelevanceModel.buttonText,
                  minFontSize: 10,
                  maxLines: 1,
                  style: AppTextStyles.formalTextStyle(
                    color: buttonTextColor,
                    fontSize: 17,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                onPressed: () {
                  switch (userRelevanceModel.id) {
                    case "cuisine":
                      Get.to(
                        const FavRestuarantsPage(),
                        binding: FavRestaurantsBinding(),
                      );
                      break;
                    case "targetWeight":
                      Get.to(
                        const GoalDietPage(),
                        binding: GoalDietBinding(),
                      );
                      break;
                    case "mobility":
                      Navigator.push(
                        context,
                        PageRouteBuilder(
                            pageBuilder:
                                (context, animation, secondaryAnimation) =>
                                    const SectionChangePage(
                                      pageBackColor: AppColors.sleepModuleColor,
                                      module: "sleep",
                                    ),
                            transitionsBuilder: (context, animation,
                                secondaryAnimation, child) {
                              return bottomSlideTransition(animation, child);
                            },
                            transitionDuration:
                                const Duration(milliseconds: 800)),
                      );
                      break;

                    default:
                      Get.off(
                        () => const NotFoundPage(),
                      );
                  }
                },
              )
            ],
          ),
        ),
      ),
    );
  }
}
