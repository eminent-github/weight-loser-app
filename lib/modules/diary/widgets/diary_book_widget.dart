import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:weight_loss_app/common/app_assets.dart';
import 'package:weight_loss_app/common/app_colors.dart';
import 'package:weight_loss_app/common/app_text_styles.dart';

class DiaryBookWidget extends StatelessWidget {
  const DiaryBookWidget({
    super.key,
    required this.breakfastCalories,
    required this.lunchCalories,
    required this.snacksCalories,
    required this.dinnerCalories,
  });
  final int breakfastCalories;
  final int lunchCalories;
  final int snacksCalories;
  final int dinnerCalories;
  @override
  Widget build(BuildContext context) {
    var screenSize = MediaQuery.sizeOf(context);
    double height = screenSize.height;
    double width = screenSize.width;
    return Container(
      width: width * 0.9,
      height: 272.35,
      decoration: ShapeDecoration(
        color: AppColors.buttonColor,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(9.39),
        ),
      ),
      child: Stack(
        alignment: Alignment.center,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                width: width * 0.4,
                height: 251.48,
                decoration: ShapeDecoration(
                  color: Colors.white,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(4.17),
                  ),
                ),
              ),
              Container(
                width: width * 0.015,
                height: 251.48,
                color: Colors.transparent,
              ),
              Container(
                width: width * 0.4,
                height: 251.48,
                decoration: ShapeDecoration(
                  color: Colors.white,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(4.17),
                  ),
                ),
                child: Align(
                  alignment: Alignment.bottomRight,
                  child: SizedBox(
                    width: 41,
                    height: 40,
                    child: Image.asset(
                      AppAssets.diaryFlipImgUrl,
                      fit: BoxFit.fill,
                    ),
                  ),
                ),
              ),
            ],
          ),
          Center(
            child: Image.asset(
              AppAssets.diarySpiralImgUrl,
              width: width * 0.04,
              height: 251.48,
              fit: BoxFit.fill,
            ),
          ),
          Positioned(
            top: height * 0.015,
            child: SizedBox(
              width: width * 0.8,
              child: Column(
                children: [
                  ListTile(
                    leading: SvgPicture.asset(
                      AppAssets.dairyCofeeSvg,
                    ),
                    title: Text(
                      'Breakfast',
                      style: AppTextStyles.formalTextStyle(
                        fontSize: 12,
                      ),
                    ),
                    trailing: Text(
                      '$breakfastCalories cal',
                      style: AppTextStyles.formalTextStyle(
                        fontSize: 12,
                      ),
                    ),
                  ),
                  ListTile(
                    leading: Icon(
                      Icons.dining_outlined,
                      color: AppColors.buttonColor,
                    ),
                    title: Text(
                      'Lunch',
                      style: AppTextStyles.formalTextStyle(
                        fontSize: 12,
                      ),
                    ),
                    trailing: Text(
                      '$lunchCalories cal',
                      style: AppTextStyles.formalTextStyle(
                        fontSize: 12,
                      ),
                    ),
                  ),
                  ListTile(
                    leading: SvgPicture.asset(
                      AppAssets.snackDairyIconSvgUrl,
                    ),
                    title: Text(
                      'Snacks',
                      style: AppTextStyles.formalTextStyle(
                        fontSize: 12,
                      ),
                    ),
                    trailing: Text(
                      '$snacksCalories cal',
                      style: AppTextStyles.formalTextStyle(
                        fontSize: 12,
                      ),
                    ),
                  ),
                  ListTile(
                    leading: SvgPicture.asset(
                      AppAssets.dairyDietTabSvg,
                      color: AppColors.buttonColor,
                    ),
                    title: Text(
                      'Dinner',
                      style: AppTextStyles.formalTextStyle(
                        fontSize: 12,
                      ),
                    ),
                    trailing: Text(
                      '$dinnerCalories cal',
                      style: AppTextStyles.formalTextStyle(
                        fontSize: 12,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
