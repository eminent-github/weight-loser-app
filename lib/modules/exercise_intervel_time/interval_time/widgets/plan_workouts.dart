import 'package:flutter/material.dart';

import '../../../../common/app_text_styles.dart';

class PlanWorkOuts extends StatelessWidget {
  const PlanWorkOuts({
    super.key,
    required this.workoutList,
  });
  final List<String> workoutList;

  @override
  Widget build(BuildContext context) {
    var screenSize = MediaQuery.sizeOf(context);
    double height = screenSize.height;
    // double width = screenSize.width;
    return ListView.builder(
      itemCount: workoutList.length,
      itemBuilder: (context, index) {
        return Padding(
          padding:  EdgeInsets.symmetric(vertical: height*0.01),
          child: SizedBox(
            height: height * 0.11,
            child: Row(
              children: [
                Expanded(
                  flex: 2,
                  child: Container(
                    decoration: ShapeDecoration(
                      color: const Color(0xFFD9D9D9),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(11),
                      ),
                    ),
                  ),
                ),
                const Expanded(
                  flex: 1,
                  child: SizedBox(),
                ),
                Expanded(
                  flex: 4,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Workout ${index + 1}',
                        style: AppTextStyles.formalTextStyle(
                          fontSize: 18,
                        ),
                      ),
                      Text(
                        '00:20',
                        style: AppTextStyles.formalTextStyle(
                          fontSize: 16,
                        ),
                      )
                    ],
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
