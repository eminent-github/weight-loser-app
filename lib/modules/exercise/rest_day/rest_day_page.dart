import 'package:flutter/material.dart';
import 'package:weight_loss_app/common/app_assets.dart';
import 'package:weight_loss_app/common/app_colors.dart';
import 'package:weight_loss_app/common/app_text_styles.dart';

class RestDayPage extends StatelessWidget {
  const RestDayPage({super.key});

  @override
  Widget build(BuildContext context) {
    var screenSize = MediaQuery.sizeOf(context);
    // double height = screenSize.height;
    double width = screenSize.width;
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Theme.of(context).appBarTheme.backgroundColor,
        iconTheme: Theme.of(context).iconTheme,
        centerTitle: true,
        title: Text(
          "Rest Day",
          style: Theme.of(context).appBarTheme.titleTextStyle,
        ),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Padding(
            padding: EdgeInsets.symmetric(
              horizontal: width * 0.1,
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  width: 16.70,
                  height: 25.83,
                  child: Align(
                    alignment: Alignment.topCenter,
                    child: Image.asset(
                      "assets/images/commas.png",
                      height: 11.83,
                      color: AppColors.buttonColor,
                    ),
                  ),
                ),
                Container(
                  width: 5,
                ),
                Expanded(
                  child: Text(
                    'As you slow down, relish the accomplishment of pushing boundaries.',
                    textAlign: TextAlign.justify,
                    style: TextStyle(
                      fontSize: 21,
                      color: AppColors.buttonColor,
                      fontWeight: FontWeight.bold,
                      fontFamily: AppTextStyles.fontFamily,
                      fontStyle: FontStyle.italic,
                    ),
                  ),
                ),
              ],
            ),
          ),
          Image.asset(
            AppAssets.restDayGifUrl,
          ),
        ],
      ),
    );
  }
}
