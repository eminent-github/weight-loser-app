import 'dart:math' as math;

import 'package:flutter/material.dart';
import 'package:weight_loss_app/common/app_colors.dart';
import 'package:weight_loss_app/common/app_text_styles.dart';

class GraphLinePainter extends CustomPainter {
  final int curentWeight;
  final int estimatedWeight;
  final String weightUnit;
  final int month;
  final int totalMonths;
  var monthArr = [
    'Jan',
    'Feb',
    'Mar',
    'Apr',
    'May',
    'Jun',
    'Jul',
    'Aug',
    'Sep',
    'Oct',
    'Nov',
    'Dec'
  ];

  GraphLinePainter({
    required this.month,
    required this.weightUnit,
    super.repaint,
    required this.curentWeight,
    required this.estimatedWeight,
    required this.totalMonths,
  });

  @override
  void paint(Canvas canvas, Size size) {
    // print(totalMonths);
    var width = size.width;
    var height = size.height;
    var weightToLose = curentWeight - estimatedWeight;
    var currentWeight1 = curentWeight;

    // first point
    var first = (weightToLose >= 0 && weightToLose <= 5)
        ? 0.5
        : (weightToLose >= 0 && weightToLose <= 10)
            ? 0.4
            : (weightToLose > 10 && weightToLose <= 30)
                ? 0.3
                : (weightToLose >= 30 && weightToLose <= 50)
                    ? 0.2
                    : (weightToLose >= 50 && weightToLose <= 70)
                        ? 0.1
                        : 0.1;

    // Second point
    var second = (weightToLose >= 0 && weightToLose <= 5)
        ? 0.8
        : (weightToLose >= 0 && weightToLose <= 10)
            ? 0.7
            : (weightToLose > 10 && weightToLose <= 30)
                ? 0.6
                : (weightToLose >= 30 && weightToLose <= 50)
                    ? 0.5
                    : (weightToLose >= 50 && weightToLose <= 70)
                        ? 0.4
                        : 0.4;

    var paint = Paint()
      ..color = AppColors.buttonColor
      ..style = PaintingStyle.stroke
      ..strokeWidth = 4;
    var path = Path()
      ..moveTo(width * 0.13, height * 0.1)
      ..cubicTo(width * 0.5, height * first, width * 0.85, height * second,
          width, height * 0.95);
    canvas.drawPath(path, paint);

    // Draw the tooltip with filled color rectangle and arrow tail
    // double tooltipWidth = 100.0; // Adjust the width of the tooltip rectangle
    double tooltipHeight = 30.0; // Adjust the height of the tooltip rectangle
    // double arrowSize = 5.0; // Adjust the size of the arrow tail

    paint.strokeCap = StrokeCap.butt;
    paint.color = AppColors.blue; // Adjust the color of the tooltip rectangle

    // // Draw the arrow tail at the bottom center
    // var arrowPath = Path()
    //   ..moveTo(width - arrowSize, height)
    //   ..lineTo(width + arrowSize, height)
    //   ..lineTo(width, height + arrowSize)
    //   ..close();

    // canvas.drawPath(arrowPath, paint);
    // Draw the circle dot at the bottom center

    double dotRadius = 8.0; // Adjust the radius of the dot

    paint.color = AppColors.blue; // Adjust the color of the dot
    paint.style = PaintingStyle.fill;

    canvas.drawCircle(
      Offset(width + 2,
          height * 0.95 + dotRadius - 2), // Adjust the position of the dot
      dotRadius,
      paint,
    );
    canvas.drawCircle(
      Offset(width * 0.13, height * 0.1), // Adjust the position of the dot
      dotRadius,
      paint,
    );

    // Draw the text inside the tooltip
    TextPainter textPainter = TextPainter(
        text: TextSpan(
          text: "Goal\n$estimatedWeight $weightUnit",
          style: const TextStyle(
            color: AppColors.white,
            fontSize: 12,
            fontFamily: AppTextStyles.fontFamily,
          ),
        ),
        textDirection: TextDirection.ltr,
        textAlign: TextAlign.center);

    textPainter.layout();
    textPainter.paint(
        canvas,
        Offset(width - textPainter.width / 2,
            height - tooltipHeight - 30 - textPainter.height / 2));

    // double circleRadius = 25.0; // Adjust the radius of the circle

    paint.color = AppColors.blue; // Adjust the color of the circle
    paint.style = PaintingStyle.fill;

    // circle shape
    // canvas.drawCircle(
    //   Offset(
    //       (width - textPainter.width / 2) + textPainter.width / 2,
    //       (height - tooltipHeight - 30 - textPainter.height / 2) +
    //           textPainter.height / 2),
    //   circleRadius,
    //   paint,
    // );

    // hard edges rectangle
    // canvas.drawRect(
    //   Rect.fromCenter(
    //     center: Offset(
    //         (width - textPainter.width / 2) + textPainter.width / 2,
    //         (height - tooltipHeight - 30 - textPainter.height / 2) +
    //             textPainter.height / 2),
    //     width: textPainter.width + 20.0,
    //     height: textPainter.height + 10.0,
    //   ),
    //   paint,
    // );

    RRect roundedRect = RRect.fromRectAndCorners(
      Rect.fromCenter(
        center: Offset(
            (width - textPainter.width / 2) + textPainter.width / 2,
            (height - tooltipHeight - 27 - textPainter.height / 2) +
                textPainter.height / 2),
        width: textPainter.width + 20.0,
        height: textPainter.height + 10.0,
      ),
      topLeft: const Radius.circular(5),
      topRight: const Radius.circular(5),
      bottomLeft: const Radius.circular(5),
      bottomRight: const Radius.circular(5),
    );
    canvas.drawRRect(roundedRect, paint);

    var arrowPath = Path()
      ..moveTo(
          width - 10, height - tooltipHeight - 30 + (textPainter.height - 10.0))
      ..lineTo(
          width + 10, height - tooltipHeight - 30 + (textPainter.height - 10.0))
      ..lineTo(
          width, height - tooltipHeight - 30 + (textPainter.height - 10.0) + 10)
      ..close();

    canvas.drawPath(arrowPath, paint);

    textPainter.paint(
        canvas,
        Offset(width - textPainter.width / 2,
            height - tooltipHeight - 27 - textPainter.height / 2));
    var weightSixthFraction = weightToLose / 5;
    var weightTextHeightSixthFraction = height / 5.7;
    var monthTextWidthSixthFraction = totalMonths == 6
        ? width / 5.7
        : totalMonths == 5
            ? width / 4.5
            : totalMonths == 4
                ? width / 3.4
                : totalMonths == 3
                    ? width / 2.3
                    : totalMonths == 2
                        ? width / 1.1
                        : totalMonths == 1
                            ? width / 1.1
                            : width / 5.6;

    // TextPainter textPainter = TextPainter();
    textPainter.textDirection = TextDirection.ltr;

    // Weight text
    // if (totalMonths != null) {
    //   for (var i = 0; i < totalMonths!; i++) {
    //     textPainter.text = TextSpan(
    //         text:
    //             (currentWeight1 - (weightSixthFraction * i)).toInt().toString(),
    //         style: const TextStyle(
    //           color: Colors.black,
    //           fontSize: 16,
    //           fontFamily: AppTextStyles.fontFamily,
    //         ));
    //     textPainter.layout();
    //     textPainter.paint(
    //         canvas, Offset(0, weightTextHeightSixthFraction * i + 10));
    //   }
    // } else {
    //   for (var i = 0; i < 6; i++) {
    //     textPainter.text = TextSpan(
    //         text:
    //             (currentWeight1 - (weightSixthFraction * i)).toInt().toString(),
    //         style: const TextStyle(
    //           color: Colors.black,
    //           fontSize: 16,
    //           fontFamily: AppTextStyles.fontFamily,
    //         ));
    //     textPainter.layout();
    //     textPainter.paint(
    //         canvas, Offset(0, weightTextHeightSixthFraction * i + 10));
    //   }
    // }
    for (var i = 0; i < 6; i++) {
      textPainter.text = TextSpan(
          text: (currentWeight1 - (weightSixthFraction * i)).toInt().toString(),
          style: const TextStyle(
            color: Colors.black,
            fontSize: 16,
            fontFamily: AppTextStyles.fontFamily,
          ));
      textPainter.layout();
      textPainter.paint(
          canvas, Offset(0, weightTextHeightSixthFraction * i + 10));
    }

    // Months text

    if (totalMonths == 1) {
      for (var i = 0; i < 2; i++,) {
        textPainter.text = TextSpan(
            text: monthArr[(month) % 12],
            style: const TextStyle(
              color: Colors.black,
              fontSize: 16,
              fontFamily: AppTextStyles.fontFamily,
            ));
        textPainter.layout();
        textPainter.paint(
            canvas, Offset(monthTextWidthSixthFraction * i + 20, -20));
      }
    } else if (totalMonths > 6) {
      // log('months are greater than 6');
      // for (var i = 0; i <= totalMonths; i++) {
      //   print(
      //       "init:${i == 0} mid:${i == totalMonths ~/ 2} end:${i == totalMonths - 1}");

      //   textPainter.text = TextSpan(
      //       text: i == 0 || i == totalMonths ~/ 2 || i == totalMonths
      //           ? monthArr[(month + i) % 12]
      //           : "",
      //       style: const TextStyle(
      //         color: Colors.black,
      //         fontSize: 16,
      //         fontFamily: AppTextStyles.fontFamily,
      //       ));
      //   textPainter.layout();
      //   textPainter.paint(canvas, Offset((width / 15.5) * i + 25, -20));
      // }
      // log('this is current year months are greater than 6 and exact value is $totalMonths');
      int middleMonthIndex = (totalMonths - 1) ~/ 2;
      double divisor = width / (totalMonths - 1);
      int startYear = DateTime.now().year;
      // int startMonthIndex = monthArr.indexOf(month.toString());

      for (var i = 0; i < totalMonths; i++) {
        // print("-------------${(month + i) % 12}");
        int currentMonthIndex = (month + i) % 12;
        int currentYear = startYear + ((month + i) ~/ 12);
        if (i > middleMonthIndex) {
          currentYear += (i - middleMonthIndex) ~/ 12;
        }
        // log('this is current year $currentYear and month ${monthArr[currentMonthIndex]}');

        // print(
        //     "init:${i == 0} mid:${i == middleMonthIndex} end:${i == totalMonths - 1}");

        textPainter.text = TextSpan(
          children: [
            TextSpan(
              text: i == 0 || i == middleMonthIndex || i == totalMonths - 1
                  ? monthArr[currentMonthIndex]
                  : "",
              style: const TextStyle(
                color: AppColors.black,
                fontSize: 16,
                fontFamily: AppTextStyles.fontFamily,
              ),
            ),
            TextSpan(
              text: i == 0 || i == middleMonthIndex || i == totalMonths - 1
                  ? ' ($currentYear)'
                  : "",
              style: TextStyle(
                color: AppColors.iconColor,
                fontSize: 12,
                fontFamily: AppTextStyles.fontFamily,
              ),
            ),
          ],
        );

        textPainter.layout();

        double xPos = divisor * i + 25;
        if (i == totalMonths - 1) {
          xPos = math.min(xPos, width - textPainter.width + 20);
        }
        if (i == middleMonthIndex) {
          xPos -= textPainter.width / 2;
        }

        textPainter.paint(canvas, Offset(xPos, -20));
      }
    } else {
      for (var i = 0; i < totalMonths; i++,) {
        // print("-------------${(month + i) % 12}");
        textPainter.text = TextSpan(
            text: monthArr[(month + i) % 12],
            style: const TextStyle(
              color: Colors.black,
              fontSize: 16,
              fontFamily: AppTextStyles.fontFamily,
            ));
        textPainter.layout();
        textPainter.paint(
            canvas, Offset(monthTextWidthSixthFraction * i + 20, -20));
      }
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
}
