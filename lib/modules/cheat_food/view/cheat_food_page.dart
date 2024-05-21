import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';
import 'package:get/get_state_manager/src/simple/get_view.dart';
import 'package:intl/intl.dart';
import 'package:weight_loss_app/common/app_text_styles.dart';
import 'package:weight_loss_app/modules/cheat_food/controller/cheat_food_controller.dart';
import 'package:weight_loss_app/modules/cheat_food/model/cheat_food_model.dart';
import 'package:weight_loss_app/modules/cheat_food/widgets/cheat_food_dialog.dart';
import 'package:weight_loss_app/utils/internet_check_widget.dart';
import 'package:weight_loss_app/widgets/overlay_widget.dart';

import '../../../common/app_colors.dart';
import '../../../common/app_texts.dart';

class CheatFoodPage extends GetView<CheatFoodController> {
  const CheatFoodPage({
    super.key,
    required this.cheatScore,
  });
  final double cheatScore;
  @override
  Widget build(BuildContext context) {
    var screenHeight = MediaQuery.sizeOf(context);
    double height = screenHeight.height - kToolbarHeight;
    double width = screenHeight.width;
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Theme.of(context).appBarTheme.backgroundColor,
        iconTheme: Theme.of(context).iconTheme,
        title: Text(
          AppTexts.cheatFoodText,
          style: Theme.of(context).appBarTheme.titleTextStyle,
        ),
        centerTitle: true,
      ),
      body: InternetCheckWidget<ConnectivityService>(
        child: Obx(
          () => Stack(
            children: [
              SafeArea(
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: width * 0.085),
                  child: Column(
                    children: [
                      SizedBox(
                        height: height * 0.05,
                      ),
                      Align(
                        alignment: Alignment.centerLeft,
                        child: Text(
                          AppTexts.previousCheatFoodText,
                          style: TextStyle(
                            color: Theme.of(context)
                                .primaryTextTheme
                                .titleMedium!
                                .color!,
                            fontSize: 13,
                            fontFamily: AppTextStyles.fontFamily,
                            fontWeight: FontWeight.w600,
                            letterSpacing: 1.84,
                          ),
                        ),
                      ),
                      SizedBox(
                        height: height * 0.03,
                      ),
                      SizedBox(
                        height: height * 0.6,
                        child: controller.isLoading.value
                            ? Center(
                                child: CircularProgressIndicator(
                                  color: AppColors.buttonColor,
                                ),
                              )
                            : controller.cheatFoodModel.value.cheatFoodVM ==
                                    null
                                ? Center(
                                    child: Text(
                                      "No Record Found",
                                      style: AppTextStyles.formalTextStyle(
                                        color: Theme.of(context)
                                            .primaryTextTheme
                                            .titleMedium!
                                            .color!,
                                      ),
                                    ),
                                  )
                                : controller.cheatFoodModel.value.cheatFoodVM!
                                        .isEmpty
                                    ? Center(
                                        child: Text(
                                          "No Cheat Food Found",
                                          style: AppTextStyles.formalTextStyle(
                                            color: Theme.of(context)
                                                .primaryTextTheme
                                                .titleMedium!
                                                .color!,
                                          ),
                                        ),
                                      )
                                    : ListView.builder(
                                        itemCount: controller.cheatFoodModel
                                            .value.cheatFoodVM!.length,
                                        itemBuilder: (context, index) {
                                          CheatFoodVM cheatFoodModel =
                                              controller.cheatFoodModel.value
                                                  .cheatFoodVM![index];
                                          return Padding(
                                            padding: EdgeInsets.symmetric(
                                              vertical: height * 0.0125,
                                            ),
                                            child: Container(
                                              decoration: ShapeDecoration(
                                                color: Colors.white,
                                                shape: RoundedRectangleBorder(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            7)),
                                                shadows: const [
                                                  BoxShadow(
                                                    color: Color(0x3F000000),
                                                    blurRadius: 4,
                                                    offset: Offset(0, 0),
                                                    spreadRadius: 0,
                                                  )
                                                ],
                                              ),
                                              child: ListTile(
                                                title: Text(
                                                  'Food Name',
                                                  style: AppTextStyles
                                                      .formalTextStyle(
                                                    fontSize: 12,
                                                    fontWeight: FontWeight.w700,
                                                  ),
                                                ),
                                                subtitle: AutoSizeText(
                                                  DateFormat("dd MMMM, y")
                                                      .format(DateTime.parse(
                                                          cheatFoodModel
                                                              .foddTakenDate!)),
                                                  minFontSize: 8,
                                                  style: AppTextStyles
                                                      .formalTextStyle(
                                                    fontSize: 12,
                                                  ),
                                                ),
                                                trailing: AutoSizeText(
                                                  "${cheatFoodModel.totalCalories} Kcal",
                                                  maxLines: 1,
                                                  minFontSize: 5,
                                                  style: AppTextStyles
                                                      .formalTextStyle(
                                                    fontSize: 12,
                                                    fontWeight: FontWeight.w700,
                                                  ),
                                                ),
                                              ),
                                            ),
                                          );
                                        },
                                      ),
                      ),
                      SizedBox(
                        height: height * 0.05,
                      ),
                      cheatScore == 0.0
                          ? const SizedBox.shrink()
                          : cheatScore / 7.0 == 1
                              ? Column(
                                  children: [
                                    Material(
                                      color: AppColors.buttonColor,
                                      child: InkWell(
                                        onTap: () {
                                          cheatFoodDialog(context);
                                        },
                                        child: SizedBox(
                                          height: height * 0.055,
                                          width: width * 0.11,
                                          child: Center(
                                            child: Icon(
                                              Icons.add,
                                              color: Colors.white,
                                              size: height * 0.045,
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                    SizedBox(
                                      height: height * 0.04,
                                    ),
                                    Text(
                                      AppTexts.addWhatYouText,
                                      style: TextStyle(
                                        color: Theme.of(context)
                                            .primaryTextTheme
                                            .titleMedium!
                                            .color!,
                                        fontSize: 12,
                                        fontFamily: AppTextStyles.fontFamily,
                                        fontWeight: FontWeight.w400,
                                        letterSpacing: 1.84,
                                      ),
                                    ),
                                  ],
                                )
                              : const SizedBox.shrink(),
                    ],
                  ),
                ),
              ),
              controller.isPostFoodLoading.value
                  ? const OverlayWidget()
                  : const SizedBox()
            ],
          ),
        ),
      ),
    );
  }

  Future<void> cheatFoodDialog(BuildContext context) async {
    await showDialog(
      context: context,
      builder: (BuildContext context) {
        return CheatFoodDialog(
          controller: controller,
        );
      },
    );
  }
}
