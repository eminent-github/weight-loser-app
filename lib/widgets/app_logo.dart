import 'package:flutter/material.dart';

// import '../common/app_colors.dart';
import '../common/app_text_styles.dart';

class AppLogo extends StatelessWidget {
  const AppLogo({
    super.key,
    this.clipperHeight,
    this.clipperWidth,
    this.fontSize = 25,
  });
  final double? clipperHeight;
  final double? clipperWidth;
  final double fontSize;
  @override
  Widget build(BuildContext context) {
    var screenSize = MediaQuery.of(context).size;
    double height = screenSize.height;
    double width = screenSize.width;
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        SizedBox(
          width: width * 0.58,
          height: height * 0.058,
          child: FittedBox(
            child: Text.rich(
              TextSpan(
                children: [
                  TextSpan(
                    text: 'WEIGHT',
                    style: TextStyle(
                      color:
                          Theme.of(context).primaryTextTheme.titleMedium!.color,
                      fontSize: fontSize,
                      fontFamily: AppTextStyles.fontFamily,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  TextSpan(
                    text: 'LOSER',
                    style: TextStyle(
                      color:
                          Theme.of(context).primaryTextTheme.titleMedium!.color,
                      fontSize: fontSize,
                      fontFamily: AppTextStyles.fontFamily,
                      fontWeight: FontWeight.w300,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
        ClipPath(
          clipper: AppLogoCustomClipper(),
          child: Container(
            height: clipperHeight ?? height * 0.008,
            width: clipperWidth ?? width * 0.58,
            color: Theme.of(context).primaryTextTheme.titleMedium!.color,
          ),
        ),
      ],
    );
  }
}

class AppLogoCustomClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    var height = size.height;
    var width = size.width;

    Path path = Path();
    path.lineTo(0, height);
    path.lineTo(width, height / 2);
    path.close();
    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) => false;
}
