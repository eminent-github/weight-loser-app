import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:weight_loss_app/common/app_text_styles.dart';

class HealthDataItem extends StatelessWidget {
  const HealthDataItem(
      {super.key,
      required this.time,
      required this.myIcon,
      this.unit,
      this.value,
      this.title});
  final DateTime time;
  final Icon myIcon;
  final String? unit;
  final String? value;
  final String? title;
  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.sizeOf(context);
    double height = size.height;
    double width = size.width;
    return Padding(
      padding: EdgeInsets.symmetric(
          horizontal: width * 0.04, vertical: height * 0.015),
      child: Material(
        elevation: 3,
        borderRadius: BorderRadius.circular(10),
        child: Padding(
          padding: EdgeInsets.symmetric(
              horizontal: width * 0.03, vertical: height * 0.01),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Expanded(
                    flex: 7,
                    child: Row(
                      children: [
                        myIcon,
                        SizedBox(
                          width: width * 0.015,
                        ),
                        Expanded(
                          child: Text(
                            title!,
                            style: AppTextStyles.formalTextStyle(
                              fontWeight: FontWeight.bold,
                              color: const Color(0xffff5107),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    width: width * 0.03,
                  ),
                  Expanded(
                    flex: 3,
                    child: Align(
                      alignment: Alignment.centerRight,
                      child: Text(
                        DateFormat('h:mm a').format(time),
                        style: AppTextStyles.formalTextStyle(),
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: height * 0.04,
              ),
              Text.rich(
                TextSpan(
                  children: [
                    TextSpan(
                      text: value,
                      style: AppTextStyles.formalTextStyle(
                        color: Colors.black,
                        fontSize: 25,
                      ),
                    ),
                    TextSpan(
                      text: unit,
                      style: AppTextStyles.formalTextStyle(
                        color: const Color(0xff828282),
                        fontSize: 15,
                      ),
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
