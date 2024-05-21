import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:weight_loss_app/common/api_urls.dart';
import 'package:weight_loss_app/common/app_colors.dart';
import 'package:weight_loss_app/widgets/loading_image.dart';

import '../../../../../../../common/app_text_styles.dart';

class FoodItemLeft extends StatelessWidget {
  const FoodItemLeft({
    super.key,
    this.imageUrl,
    required this.calories,
    required this.foodName,
    this.add,
    required this.replace,
    required this.width,
    required this.istaken,
    required this.imageTap,
    required this.custom,
  });
  final String calories;
  final String? imageUrl;
  final String foodName;
  final String custom;
  final void Function()? add;
  final void Function() replace;
  final double width;
  final bool istaken;
  final void Function() imageTap;

  @override
  Widget build(BuildContext context) {
    print("left : $custom");
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        SizedBox(
          width: width * 0.45,
          height: MediaQuery.of(context).size.height,
          child: istaken
              ? Container(
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(12),
                      color: AppColors.buttonColor),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Icon(
                        Icons.check_circle,
                        color: AppColors.white,
                        size: 50,
                      ),
                      Text(
                        'Done',
                        style: AppTextStyles.formalTextStyle(
                          color: Colors.white,
                          fontSize: 12,
                        ),
                      ),
                    ],
                  ),
                )
              : ClipRRect(
                  borderRadius: BorderRadius.circular(12),
                  child: InkWell(
                    onTap: imageTap,
                    child: imageUrl == null
                        ? Image.asset(
                            "assets/images/fooditem.png",
                            fit: BoxFit.cover,
                          )
                        : custom == "custom"
                            ? LoadingImage(
                                imageUrl: imageUrl!,
                                fit: BoxFit.cover,
                              )
                            : custom == "scanner"
                                ? S3LoadingImage(
                                    imageUrl: imageUrl!,
                                    fit: BoxFit.cover,
                                  )
                                : S3LoadingImage(
                                    imageUrl:
                                        "${ApiUrls.s3ImageBaseUrl}Diet/$imageUrl",
                                    fit: BoxFit.cover,
                                  ),
                  ),
                ),
        ),
        SizedBox(
          width: width * 0.05,
        ),
        Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  width: width * 0.5,
                  child: AutoSizeText(
                    foodName,
                    maxLines: 3,
                    minFontSize: 5,
                    overflow: TextOverflow.ellipsis,
                    style: AppTextStyles.formalTextStyle(
                      fontSize: 12,
                      color: Theme.of(context)
                          .primaryTextTheme
                          .titleMedium!
                          .color!,
                    ),
                  ),
                ),
                AutoSizeText(
                  '$calories Cal',
                  minFontSize: 5,
                  style: AppTextStyles.formalTextStyle(
                    fontSize: 10,
                    color:
                        Theme.of(context).primaryTextTheme.titleMedium!.color!,
                  ),
                )
              ],
            ),
            Row(
              children: [
                InkWell(
                  onTap: add,
                  child: AutoSizeText(
                    'Add',
                    minFontSize: 5,
                    style: AppTextStyles.formalTextStyle(
                      color: AppColors.buttonColor,
                      fontSize: 10,
                    ),
                  ),
                ),
                SizedBox(
                  width: width * 0.02,
                ),
                InkWell(
                  onTap: replace,
                  child: AutoSizeText(
                    'Replace',
                    minFontSize: 5,
                    style: AppTextStyles.formalTextStyle(
                      color: const Color(0xFFB12C2C),
                      fontSize: 10,
                    ),
                  ),
                ),
              ],
            )
          ],
        )
      ],
    );
  }
}

class FoodItemRight extends StatelessWidget {
  const FoodItemRight({
    super.key,
    this.imageUrl,
    required this.calories,
    required this.foodName,
    this.add,
    required this.replace,
    required this.width,
    required this.istaken,
    required this.imageTap,
    required this.custom,
  });
  final String calories;
  final String? imageUrl;
  final String foodName;
  final String custom;
  final void Function()? add;
  final void Function() replace;
  final bool istaken;
  final double width;
  final void Function() imageTap;

  @override
  Widget build(BuildContext context) {
    print("right : $imageUrl");
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  width: width * 0.5,
                  child: AutoSizeText(
                    foodName,
                    maxLines: 3,
                    minFontSize: 5,
                    style: AppTextStyles.formalTextStyle(
                      color: Theme.of(context)
                          .primaryTextTheme
                          .titleMedium!
                          .color!,
                      fontSize: 12,
                    ),
                  ),
                ),
                Text(
                  '$calories Cal',
                  style: AppTextStyles.formalTextStyle(
                    fontSize: 10,
                    color:
                        Theme.of(context).primaryTextTheme.titleMedium!.color!,
                  ),
                )
              ],
            ),
            Row(
              children: [
                InkWell(
                  onTap: add,
                  child: Text(
                    'Add',
                    style: AppTextStyles.formalTextStyle(
                      color: AppColors.buttonColor,
                      fontSize: 10,
                    ),
                  ),
                ),
                SizedBox(
                  width: width * 0.02,
                ),
                InkWell(
                  onTap: replace,
                  child: Text(
                    'Replace',
                    style: AppTextStyles.formalTextStyle(
                      color: const Color(0xFFB12C2C),
                      fontSize: 10,
                    ),
                  ),
                ),
              ],
            )
          ],
        ),
        SizedBox(
          width: width * 0.05,
        ),
        SizedBox(
          width: width * 0.45,
          height: MediaQuery.of(context).size.height,
          child: istaken
              ? Container(
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(12),
                      color: AppColors.buttonColor),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Icon(
                        Icons.check_circle,
                        color: AppColors.white,
                        size: 50,
                      ),
                      Text(
                        'Done',
                        style: AppTextStyles.formalTextStyle(
                          color: Colors.white,
                          fontSize: 12,
                        ),
                      ),
                    ],
                  ),
                )
              : ClipRRect(
                  borderRadius: BorderRadius.circular(12),
                  child: InkWell(
                    onTap: imageTap,
                    child: imageUrl == null
                        ? Image.asset(
                            "assets/images/fooditem2.png",
                            fit: BoxFit.cover,
                          )
                        : custom == "custom"
                            ? LoadingImage(
                                imageUrl: imageUrl!,
                                fit: BoxFit.cover,
                              )
                            : custom == "scanner"
                                ? S3LoadingImage(
                                    imageUrl: imageUrl!,
                                    fit: BoxFit.cover,
                                  )
                                : S3LoadingImage(
                                    imageUrl:
                                        "${ApiUrls.s3ImageBaseUrl}Diet/$imageUrl",
                                    fit: BoxFit.cover,
                                  ),
                  ),
                ),
        ),
      ],
    );
  }
}

class PlanWater extends StatelessWidget {
  const PlanWater({
    super.key,
    this.imageUrl,
    required this.width,
    required this.imageTap,
  });

  final String? imageUrl;
  final double width;
  final void Function() imageTap;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        Expanded(
          flex: 1,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              AutoSizeText(
                "Add Water",
                maxLines: 3,
                minFontSize: 5,
                style: AppTextStyles.formalTextStyle(
                  color: Theme.of(context).primaryTextTheme.titleMedium!.color!,
                  fontSize: 12,
                ),
              ),
              Text(
                '8 Glasses per day',
                style: AppTextStyles.formalTextStyle(
                  fontSize: 10,
                  color: Theme.of(context).primaryTextTheme.titleMedium!.color!,
                ),
              )
            ],
          ),
        ),
        SizedBox(
          width: width * 0.05,
        ),
        Expanded(
          flex: 1,
          child: ClipRRect(
            borderRadius: BorderRadius.circular(12),
            child: InkWell(
              onTap: imageTap,
              child: Image.asset(
                imageUrl!,
                fit: BoxFit.cover,
                height: MediaQuery.of(context).size.height,
              ),
            ),
          ),
        ),
      ],
    );
  }
}
