import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:weight_loss_app/common/app_colors.dart';
import 'package:weight_loss_app/common/app_text_styles.dart';
import 'package:weight_loss_app/modules/ultimate_selfie/models/ultimate_selfie_model.dart';
import 'package:weight_loss_app/widgets/loading_image.dart';

class ComaprisionItem extends StatelessWidget {
  const ComaprisionItem({
    super.key,
    required this.ultimateSelfieModel,
    required this.weightUnit,
  });
  final SelfieList ultimateSelfieModel;
  final String weightUnit;
  @override
  Widget build(BuildContext context) {
    var screenSize = MediaQuery.sizeOf(context);
    double height = screenSize.height;
    double width = screenSize.width;
    return SizedBox(
      height: height * 0.6,
      child: Column(
        children: [
          Expanded(
            flex: 6,
            child: Container(
              width: width * 0.4,
              decoration: BoxDecoration(
                color: AppColors.white,
                boxShadow: [
                  BoxShadow(
                    color: AppColors.black.withOpacity(0.2),
                    blurRadius: 5,
                  )
                ],
              ),
              child: ultimateSelfieModel.fileName == null
                  ? const Center(
                      child: Icon(
                        Icons.image,
                        size: 50,
                      ),
                    )
                  : LoadingImage(
                      imageUrl: ultimateSelfieModel.fileName!,
                      fit: BoxFit.cover,
                    ),
            ),
          ),
          Expanded(
            flex: 3,
            child: SizedBox(
              width: width * 0.4,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Text.rich(
                    TextSpan(
                      children: [
                        TextSpan(
                          text: 'Weight: ',
                          style: AppTextStyles.formalTextStyle(
                              color: AppColors.buttonColor),
                        ),
                        TextSpan(
                          text: " ${ultimateSelfieModel.weight}",
                          style: AppTextStyles.formalTextStyle(
                              color: Theme.of(context)
                                  .primaryTextTheme
                                  .titleMedium!
                                  .color!,
                              fontWeight: FontWeight.bold),
                        ),
                        TextSpan(
                          text: " $weightUnit",
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
                  Text.rich(
                    TextSpan(
                      children: [
                        TextSpan(
                          text: 'Waist: ',
                          style: AppTextStyles.formalTextStyle(
                              color: AppColors.buttonColor),
                        ),
                        TextSpan(
                          text: " ${ultimateSelfieModel.waist!.toInt()}",
                          style: AppTextStyles.formalTextStyle(
                              color: Theme.of(context)
                                  .primaryTextTheme
                                  .titleMedium!
                                  .color!,
                              fontWeight: FontWeight.bold),
                        ),
                        TextSpan(
                          text: " inch",
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
                  Text.rich(
                    TextSpan(
                      children: [
                        TextSpan(
                          text: 'Capture Date: ',
                          style: AppTextStyles.formalTextStyle(
                              color: AppColors.buttonColor),
                        ),
                        TextSpan(
                          text: DateFormat("MMM dd, yyyy").format(
                              DateTime.parse(ultimateSelfieModel.dated!)),
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
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
