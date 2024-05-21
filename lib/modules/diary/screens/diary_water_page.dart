import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:weight_loss_app/common/app_assets.dart';
import 'package:weight_loss_app/common/app_text_styles.dart';

class DiaryWaterPage extends StatelessWidget {
  const DiaryWaterPage({super.key, required this.waterIntake});
  final int waterIntake;
  @override
  Widget build(BuildContext context) {
    var screenSize = MediaQuery.sizeOf(context);
    double height = screenSize.height;

    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          'Water Intake',
          style: AppTextStyles.formalTextStyle(
            color: Theme.of(context).primaryTextTheme.titleMedium!.color!,
            fontSize: 17,
            fontWeight: FontWeight.w400,
          ),
        ),
        Text(
          '$waterIntake',
          style: AppTextStyles.formalTextStyle(
            color: Theme.of(context).primaryTextTheme.titleMedium!.color!,
            fontSize: 17,
            fontWeight: FontWeight.w700,
          ),
        ),
        SizedBox(
          height: height * 0.015,
        ),
        Text(
          'Out of 8 Glass of water',
          style: AppTextStyles.formalTextStyle(
            color: Theme.of(context).primaryTextTheme.titleMedium!.color!,
            fontSize: 17,
            fontWeight: FontWeight.w400,
          ),
        ),
        SizedBox(
          height: height * 0.015,
        ),
        SvgPicture.asset(
          AppAssets.dairyWatertTabSvg,
          height: 80,
          width: 35,
          color: const Color(0xff87CEFA),
        ),
      ],
    );
  }
}
