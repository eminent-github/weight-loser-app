import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:weight_loss_app/common/app_assets.dart';
import 'package:weight_loss_app/common/app_colors.dart';
import 'package:weight_loss_app/common/app_text_styles.dart';

class SubmitReviewDialog extends StatelessWidget {
  const SubmitReviewDialog({super.key});

  @override
  Widget build(BuildContext context) {
    var screenSize = MediaQuery.sizeOf(context);
    double height = screenSize.height;
    double width = screenSize.width;
    return WillPopScope(
      onWillPop: () async {
        return false;
      },
      child: Dialog(
        surfaceTintColor: AppColors.white,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(18),
        ),
        child: SizedBox(
          width: width * 0.8,
          height: height * 0.7,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              SvgPicture.asset(
                AppAssets.submitReviewSvgUrl,
                height: height * 0.25,
              ),
              AutoSizeText(
                'Submit Review',
                minFontSize: 10,
                style: AppTextStyles.formalTextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.w600,
                ),
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: width * 0.1),
                child: SizedBox(
                  height: height * 0.06,
                  child: AutoSizeText(
                    'Enjoying the app? Share your feedback now!',
                    textAlign: TextAlign.center,
                    maxLines: 2,
                    style: AppTextStyles.formalTextStyle(
                      color: const Color(0xFF7E7E7E),
                    ),
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.symmetric(
                  horizontal: width * 0.09,
                ),
                child: Material(
                  shape: RoundedRectangleBorder(
                    side: BorderSide(width: 1, color: AppColors.buttonColor),
                    borderRadius: BorderRadius.circular(33.84),
                  ),
                  child: InkWell(
                    onTap: () {},
                    borderRadius: BorderRadius.circular(33.84),
                    child: SizedBox(
                      height: height * 0.055,
                      width: width,
                      child: Center(
                        child: AutoSizeText(
                          'Skip',
                          textAlign: TextAlign.center,
                          style: AppTextStyles.formalTextStyle(
                            fontSize: 15.23,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.symmetric(
                  horizontal: width * 0.09,
                ),
                child: Material(
                  shape: RoundedRectangleBorder(
                    side: BorderSide(width: 1, color: AppColors.buttonColor),
                    borderRadius: BorderRadius.circular(33.84),
                  ),
                  child: InkWell(
                    onTap: () {},
                    borderRadius: BorderRadius.circular(33.84),
                    child: SizedBox(
                      height: height * 0.055,
                      width: width,
                      child: Center(
                        child: AutoSizeText(
                          'Remind me later',
                          textAlign: TextAlign.center,
                          style: AppTextStyles.formalTextStyle(
                            fontSize: 15.23,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.symmetric(
                  horizontal: width * 0.09,
                ),
                child: Material(
                  color: AppColors.buttonColor,
                  borderRadius: BorderRadius.circular(33.84),
                  child: InkWell(
                    onTap: () {},
                    borderRadius: BorderRadius.circular(33.84),
                    child: SizedBox(
                      height: height * 0.055,
                      width: width,
                      child: Center(
                        child: AutoSizeText(
                          'Submit',
                          textAlign: TextAlign.center,
                          style: AppTextStyles.formalTextStyle(
                            color: Colors.white,
                            fontSize: 15.23,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
