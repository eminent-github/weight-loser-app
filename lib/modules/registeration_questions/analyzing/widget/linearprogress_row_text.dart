import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';

import '../../../../common/app_colors.dart';
import '../modalclass/progress_modal_class.dart';

class LinearProgressRowText extends StatelessWidget {
  const LinearProgressRowText({
    super.key,
    this.heightLinear,
    this.widthLinear,
    required this.progressModalClass,
  });

  final double? heightLinear;
  final double? widthLinear;
  final ProgressModalClass progressModalClass;

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    return Center(
      child: Padding(
        padding: EdgeInsets.symmetric(vertical: height * 0.008),
        child: Container(
          height: height * 0.09,
          width: width * 0.8,
          decoration: BoxDecoration(
              border: Border.all(
                color: AppColors.analyzingContainerBorder,
                width: width * 0.002,
              ),
              borderRadius: BorderRadius.circular(4)),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              SvgPicture.asset(progressModalClass.iconImage),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Row(
                    children: [
                      Text(
                        progressModalClass.text,
                        style: const TextStyle(
                          color: Color(0xFF5B5B5B),
                          fontSize: 18,
                          fontFamily: 'Poppins',
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                      SizedBox(width: width * 0.015),
                      Text(
                        progressModalClass.progressText,
                        style: const TextStyle(
                          fontSize: 10,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: height * 0.01,
                  ),
                  LinearPercentIndicator(
                    width: widthLinear ?? width * 0.6,
                    animation: true,
                    lineHeight: heightLinear ?? height * 0.009,
                    animationDuration: 1000,
                    percent: progressModalClass.percentage,
                    backgroundColor: Colors.grey.shade300,
                    barRadius: const Radius.circular(20),
                    progressColor: progressModalClass.colorProgress,
                    alignment: MainAxisAlignment.center,
                    padding: const EdgeInsets.all(0),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
