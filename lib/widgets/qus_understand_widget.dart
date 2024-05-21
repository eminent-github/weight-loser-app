import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';

import '../common/app_colors.dart';
import '../common/app_text_styles.dart';

class UnderstandWidget extends StatelessWidget {
  const UnderstandWidget(
      {super.key,
      required this.headerText,
      required this.requestText,
      required this.height,
      required this.width,
      this.color = AppColors.understandWidgetColor,
      this.fontWeight = FontWeight.w700,
      this.discriptionText,
      this.isShowDiscription = false,
      this.textColor = AppColors.black});
  final String headerText;
  final String requestText;
  final double height;
  final double width;
  final Color? color;
  final Color? textColor;
  final FontWeight? fontWeight;
  final String? discriptionText;
  final bool isShowDiscription;
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Stack(
        children: [
          Container(
            height: height * 0.65,
            width: width,
            decoration: BoxDecoration(
              color: color,
              borderRadius: const BorderRadius.vertical(
                bottom: Radius.circular(25),
              ),
            ),
          ),
          Positioned(
            top: height * 0.12,
            left: 0,
            right: 0,
            child: Text(
              headerText,
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 15,
                color: textColor,
                fontWeight: FontWeight.w700,
              ),
            ),
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: Container(
              width: width * 0.8,
              height: height * 0.7,
              padding: EdgeInsets.symmetric(horizontal: width * 0.03),
              decoration: BoxDecoration(
                color: AppColors.white,
                borderRadius: const BorderRadius.all(
                  Radius.circular(20),
                ),
                border: Border.all(
                  color: AppColors.understandWidgetBorderColor,
                  width: 0.5,
                ),
              ),
              child: Stack(
                children: [
                  Center(
                    child: AutoSizeText(
                      requestText,
                      textAlign: TextAlign.center,
                      minFontSize: 12,
                      maxLines: 4,
                      style: TextStyle(
                        fontSize: 18,
                        fontFamily: AppTextStyles.fontFamily,
                        fontWeight: fontWeight,
                      ),
                    ),
                  ),
                  isShowDiscription
                      ? Column(
                          children: [
                            const Expanded(
                              flex: 1,
                              child: SizedBox(),
                            ),
                            Expanded(
                              flex: 1,
                              child: Center(
                                child: AutoSizeText(
                                  discriptionText!,
                                  maxLines: 1,
                                  minFontSize: 5,
                                  textAlign: TextAlign.center,
                                  style: const TextStyle(
                                    color: AppColors.black,
                                    fontSize: 11,
                                    fontFamily: AppTextStyles.fontFamily,
                                    fontWeight: FontWeight.w400,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        )
                      : const SizedBox.shrink(),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
