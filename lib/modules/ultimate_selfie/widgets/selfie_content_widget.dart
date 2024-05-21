import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:weight_loss_app/common/api_urls.dart';
import 'package:weight_loss_app/common/app_colors.dart';
import 'package:weight_loss_app/common/app_text_styles.dart';
import 'package:weight_loss_app/modules/ultimate_selfie/controller/ultimate_selfie_controller.dart';
import 'package:weight_loss_app/modules/ultimate_selfie/models/ultimate_selfie_model.dart';
import 'package:weight_loss_app/widgets/loading_image.dart';

class SelfieContentWidget extends StatelessWidget {
  const SelfieContentWidget({
    super.key,
    required this.ultimateSelfieModel,
    required this.onTap,
    required this.controller,
    required this.weightUnit,
  });
  final SelfieList ultimateSelfieModel;
  final VoidCallback onTap;
  final UltimateSelfieController controller;
  final String weightUnit;
  @override
  Widget build(BuildContext context) {
    log('this is image path = ${ultimateSelfieModel.fileName!}');
    var screenSize = MediaQuery.sizeOf(context);
    double height = screenSize.height;
    double width = screenSize.width;
    return Row(
      children: [
        Expanded(
          flex: 2,
          child: Container(
            height: height * 0.1,
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
          child: Padding(
            padding: EdgeInsets.only(left: width * 0.02),
            child: SizedBox(
              height: height * 0.1,
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
                              fontSize: 8, color: AppColors.buttonColor),
                        ),
                        TextSpan(
                          text: " ${ultimateSelfieModel.weight} $weightUnit",
                          style: AppTextStyles.formalTextStyle(
                            color: Theme.of(context)
                                .primaryTextTheme
                                .titleMedium!
                                .color!,
                            fontSize: 8,
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
                              fontSize: 8, color: AppColors.buttonColor),
                        ),
                        TextSpan(
                          text: " ${ultimateSelfieModel.waist} inch",
                          style: AppTextStyles.formalTextStyle(
                            color: Theme.of(context)
                                .primaryTextTheme
                                .titleMedium!
                                .color!,
                            fontSize: 8,
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
                              fontSize: 8, color: AppColors.buttonColor),
                        ),
                        TextSpan(
                          text: DateFormat("MMM dd, yyyy").format(
                              DateTime.parse(ultimateSelfieModel.dated!)),
                          style: AppTextStyles.formalTextStyle(
                            color: Theme.of(context)
                                .primaryTextTheme
                                .titleMedium!
                                .color!,
                            fontSize: 8,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Material(
                        color: AppColors.buttonColor,
                        borderRadius: BorderRadius.circular(2),
                        child: InkWell(
                          onTap: () => controller.downloadImage(
                              url: ApiUrls.imageBaseUrl +
                                  ultimateSelfieModel.fileName!,
                              context: context),
                          borderRadius: BorderRadius.circular(2),
                          child: Container(
                            width: width * 0.11,
                            height: height * 0.018,
                            decoration: ShapeDecoration(
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(2)),
                            ),
                            child: Center(
                              child: Text(
                                'Download',
                                style: AppTextStyles.formalTextStyle(
                                  color: Colors.white,
                                  fontSize: 7,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                      Material(
                        shape: RoundedRectangleBorder(
                          side: BorderSide(
                            width: 0.5,
                            color: AppColors.buttonColor,
                          ),
                          borderRadius: BorderRadius.circular(2),
                        ),
                        child: InkWell(
                          onTap: onTap,
                          borderRadius: BorderRadius.circular(2),
                          child: SizedBox(
                            width: width * 0.11,
                            height: height * 0.018,
                            child: Center(
                              child: Text(
                                'Compare',
                                style: AppTextStyles.formalTextStyle(
                                  color: AppColors.buttonColor,
                                  fontSize: 7,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  )
                ],
              ),
            ),
          ),
        )
      ],
    );
  }
}
