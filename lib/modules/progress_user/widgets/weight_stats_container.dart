import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../../common/app_colors.dart';

class WeightStatsContainer extends StatelessWidget {
  final String tileTitle;
  final int weightValue;
  final String dateValue;
  final String weightUnit;
  final String showIcon;
  const WeightStatsContainer({
    super.key,
    required this.weightValue,
    required this.dateValue,
    required this.tileTitle,
    required this.showIcon,
    required this.weightUnit,
  });

  @override
  Widget build(BuildContext context) {
    var screenSize = MediaQuery.sizeOf(context);
    double height = screenSize.height;
    double width = screenSize.width;
    return Padding(
      padding: EdgeInsets.symmetric(
          horizontal: width * 0.05, vertical: height * 0.01),
      child: Container(
        height: height * 0.085,
        decoration: ShapeDecoration(
          color: Colors.white,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(11),
          ),
          shadows: const [
            BoxShadow(
              color: Color(0x3F000000),
              blurRadius: 4,
              offset: Offset(0, 1),
              spreadRadius: 0,
            )
          ],
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            SizedBox(width: width * 0.06, child: SvgPicture.asset(showIcon)),
            SizedBox(width: width * 0.4, child: Text(tileTitle)),
            SizedBox(
              width: width * 0.3,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Text(
                    '$weightValue $weightUnit',
                    style: const TextStyle(
                      color: Color(0xFF146C94),
                      fontSize: 12,
                      fontFamily: 'Inter',
                      fontWeight: FontWeight.w700,
                      letterSpacing: 1,
                    ),
                  ),
                  FittedBox(
                    fit: BoxFit.fitWidth,
                    child: Text.rich(TextSpan(
                      children: [
                        const TextSpan(
                          text: 'Taken Date: ',
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 9,
                            fontFamily: 'Poppins',
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                        TextSpan(
                          text: dateValue,
                          style: const TextStyle(
                            color: AppColors.black,
                            fontSize: 9,
                            fontFamily: 'Poppins',
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                      ],
                    )),
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
