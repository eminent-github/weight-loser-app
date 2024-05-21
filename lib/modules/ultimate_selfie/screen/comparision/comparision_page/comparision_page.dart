import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:timeline_tile/timeline_tile.dart';
import 'package:weight_loss_app/common/app_colors.dart';
import 'package:weight_loss_app/common/app_text_styles.dart';
import 'package:weight_loss_app/modules/ultimate_selfie/models/ultimate_selfie_model.dart';
import 'package:weight_loss_app/modules/ultimate_selfie/screen/comparision/controller/comparision_controller.dart';
import 'package:weight_loss_app/modules/ultimate_selfie/screen/comparision/widget/comparision_item.dart';

class ComparisionPage extends GetView<ComparisionController> {
  const ComparisionPage({
    super.key,
    required this.firtstUltimateSelfieModel,
    required this.lastUltimateSelfieModel,
    required this.weightUnit,
  });
  final SelfieList firtstUltimateSelfieModel;
  final SelfieList lastUltimateSelfieModel;
  final String weightUnit;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        title: Text(
          'Comparison',
          style: Theme.of(context).appBarTheme.titleTextStyle,
        ),
        centerTitle: true,
        iconTheme: Theme.of(context).iconTheme,
        backgroundColor: Theme.of(context).appBarTheme.backgroundColor,
      ),
      body: SafeArea(
        child: Column(
          children: [
            SizedBox(
              height: MediaQuery.sizeOf(context).height * 0.05,
            ),
            TimelineTile(
              alignment: TimelineAlign.manual,
              lineXY: 0.5,
              startChild: ComaprisionItem(
                ultimateSelfieModel: firtstUltimateSelfieModel,
                weightUnit: weightUnit,
              ),
              endChild: ComaprisionItem(
                ultimateSelfieModel: lastUltimateSelfieModel,
                weightUnit: weightUnit,
              ),
              //  isLast: true,
              beforeLineStyle:
                  LineStyle(color: AppColors.buttonColor, thickness: 2),
              indicatorStyle: IndicatorStyle(
                color: AppColors.buttonColor,
                height: 20,
                width: 20,
              ),
            ),
            SizedBox(
              height: MediaQuery.sizeOf(context).height * 0.1,
            ),
            Container(
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                  border: Border.all(color: AppColors.buttonColor, width: 2)),
              child: Text.rich(
                TextSpan(
                  children: [
                    TextSpan(
                      text: (lastUltimateSelfieModel.weight!) -
                                  (firtstUltimateSelfieModel.weight!) <
                              0
                          ? "Oh No! You Lost"
                          : 'Congratulation You Lost',
                      style: AppTextStyles.formalTextStyle(
                        color: Theme.of(context)
                            .primaryTextTheme
                            .titleMedium!
                            .color!,
                      ),
                    ),
                    TextSpan(
                      text: (lastUltimateSelfieModel.weight!) -
                                  (firtstUltimateSelfieModel.weight!) <
                              0
                          ? " 0"
                          : " ${(lastUltimateSelfieModel.weight!) - (firtstUltimateSelfieModel.weight!)}",
                      style: AppTextStyles.formalTextStyle(
                          color: Theme.of(context)
                              .primaryTextTheme
                              .titleMedium!
                              .color!,
                          fontWeight: FontWeight.bold),
                    ),
                    TextSpan(
                      text: ' $weightUnit',
                      style: AppTextStyles.formalTextStyle(
                        color: Theme.of(context)
                            .primaryTextTheme
                            .titleMedium!
                            .color!,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
