import 'package:flutter/material.dart';
import 'package:weight_loss_app/common/api_urls.dart';
import 'package:weight_loss_app/common/app_assets.dart';
import 'package:weight_loss_app/common/app_text_styles.dart';
import 'package:weight_loss_app/modules/dashbored/screens/home/screens/home_inner_today/controller/home_inner_today_controller.dart';
import 'package:weight_loss_app/modules/dashbored/screens/home/screens/home_inner_today/models/today_diet_model.dart';
import 'package:weight_loss_app/widgets/loading_image.dart';

class ReplaceDialogWidget extends StatelessWidget {
  const ReplaceDialogWidget(
      {super.key,
      required this.replecedItemsList,
      required this.replecedItemId,
      required this.homeInnerTodayController,
      required this.planId,
      required this.mealType});
  final List<ActiveFoodPlanVM> replecedItemsList;
  final String replecedItemId;
  final int planId;
  final HomeInnerTodayController homeInnerTodayController;
  final String mealType;
  @override
  Widget build(BuildContext context) {
    var screenSize = MediaQuery.sizeOf(context);
    var height = screenSize.height;
    var width = screenSize.width;
    return AlertDialog(
      title: Center(
          child: Text(
        mealType,
        style: AppTextStyles.formalTextStyle(
          fontSize: 20,
          color: Theme.of(context).primaryTextTheme.titleMedium!.color!,
        ),
      )),
      content: SizedBox(
        width: double.maxFinite,
        height: height * 0.43,
        child: ListView.builder(
          itemCount: replecedItemsList.length,
          itemBuilder: (context, index) {
            return Padding(
              padding: EdgeInsets.symmetric(vertical: height * 0.01),
              child: Material(
                color: Colors.white,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(7),
                ),
                elevation: 3,
                child: InkWell(
                  onTap: () {
                    Navigator.of(context).pop();
                    homeInnerTodayController.addReplacedFood(
                      planFoodId: replecedItemId,
                      repFoodId: replecedItemsList[index].foodId!,
                      planId: planId,
                    );
                  },
                  child: SizedBox(
                    height: height * 0.07,
                    child: Row(
                      children: [
                        SizedBox(
                          height: height * 0.07,
                          width: width * 0.14,
                          child: ClipRRect(
                            borderRadius: const BorderRadius.only(
                              topLeft: Radius.circular(7),
                              bottomLeft: Radius.circular(7),
                            ),
                            child: replecedItemsList[index].foodImage == null
                                ? Image.asset(
                                    AppAssets.dietImgUrl,
                                    fit: BoxFit.cover,
                                  )
                                : S3LoadingImage(
                                    imageUrl:
                                        "${ApiUrls.s3ImageBaseUrl}Diet/${replecedItemsList[index].foodImage!}",
                                    fit: BoxFit.cover,
                                  ),
                          ),
                        ),
                        Expanded(
                          child: Padding(
                            padding: EdgeInsets.symmetric(
                              horizontal: width * 0.025,
                            ),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  children: [
                                    Expanded(
                                      child: SizedBox(
                                        height: height * 0.02,
                                        child: FittedBox(
                                          alignment: Alignment.centerLeft,
                                          child: Text(
                                            "${replecedItemsList[index].name}",
                                            style:
                                                AppTextStyles.formalTextStyle(
                                              fontSize: 12,
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                                SizedBox(
                                  height: height * 0.005,
                                ),
                                Text(
                                  '${replecedItemsList[index].calories!} kcl',
                                  style: AppTextStyles.formalTextStyle(
                                    color: const Color(0xFF6C6C6C),
                                    fontSize: 8,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                ),
              ),
            );
          },
        ),
      ),
      actions: [
        TextButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          child: const Text('Close'),
        ),
      ],
    );
  }
}
