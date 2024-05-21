import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:weight_loss_app/common/api_urls.dart';
import 'package:weight_loss_app/common/app_assets.dart';
import 'package:weight_loss_app/common/app_colors.dart';
import 'package:weight_loss_app/common/app_text_styles.dart';
import 'package:weight_loss_app/modules/diary/models/diary_model.dart';
import 'package:weight_loss_app/widgets/loading_image.dart';

class DiaryBreakFastItem extends StatelessWidget {
  const DiaryBreakFastItem({super.key, required this.breakfastList});
  final List<BreakfastList> breakfastList;
  @override
  Widget build(BuildContext context) {
    var screenSize = MediaQuery.sizeOf(context);
    double height = screenSize.height;
    double width = screenSize.width;
    return breakfastList.isEmpty
        ? SliverToBoxAdapter(
            child: Center(
              child: Text(
                "No breakfast items are found",
                style: AppTextStyles.formalTextStyle(
                  color: Theme.of(context).primaryTextTheme.titleMedium!.color!,
                ),
              ),
            ),
          )
        : SliverPadding(
            padding: EdgeInsets.symmetric(vertical: height * 0.02),
            sliver: SliverList.builder(
              itemCount: breakfastList.length,
              itemBuilder: (context, index) {
                BreakfastList breakfastItem = breakfastList[index];
                return SizedBox(
                  height: height * 0.1,
                  width: width,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      SizedBox(
                        width: 14,
                        child: Stack(
                          children: [
                            Center(
                              child: Container(
                                width: width * 0.005,
                                color: const Color(0xFFD0D0D0),
                              ),
                            ),
                            Center(
                              child: Container(
                                width: 14,
                                height: 14,
                                decoration: BoxDecoration(
                                  color: AppColors.buttonColor,
                                  shape: BoxShape.circle,
                                ),
                              ),
                            )
                          ],
                        ),
                      ),
                      Expanded(
                        child: ListTile(
                          leading: Container(
                            width: width * 0.14,
                            height: height * 0.07,
                            decoration: const BoxDecoration(
                              color: Color(0xFFD9D9D9),
                              shape: BoxShape.circle,
                            ),
                            child: breakfastItem.imageName == null
                                ? ClipOval(
                                    child: Image.asset(AppAssets.dietImgUrl,
                                        fit: BoxFit.cover),
                                  )
                                : ClipOval(
                                    child: breakfastItem.custom == "custom"
                                        ? LoadingImage(
                                            imageUrl: breakfastItem.imageName!,
                                            fit: BoxFit.cover,
                                          )
                                        : breakfastItem.custom == "scanner"
                                            ? S3LoadingImage(
                                                imageUrl:
                                                    breakfastItem.imageName!,
                                                fit: BoxFit.cover,
                                              )
                                            : S3LoadingImage(
                                                imageUrl:
                                                    "${ApiUrls.s3ImageBaseUrl}Diet/${breakfastItem.imageName}",
                                                fit: BoxFit.cover),
                                  ),
                          ),
                          title: AutoSizeText(
                            breakfastItem.fName!,
                            minFontSize: 8,
                            maxLines: 2,
                            style: AppTextStyles.formalTextStyle(
                              color: Theme.of(context)
                                  .primaryTextTheme
                                  .titleMedium!
                                  .color!,
                            ),
                          ),
                          // subtitle: Text(
                          //   '${(breakfastItem.consCalories! / 4).ceilToDouble()} grams',
                          //   style: AppTextStyles.formalTextStyle(
                          //     color: const Color(0xFFB3B3B3),
                          //     fontSize: 12,
                          //   ),
                          // ),
                          trailing: Text(
                            '${breakfastItem.consCalories} cal',
                            style: AppTextStyles.formalTextStyle(
                              color: Theme.of(context)
                                  .primaryTextTheme
                                  .titleMedium!
                                  .color!,
                            ),
                          ),
                        ),
                      )
                    ],
                  ),
                );
              },
            ),
          );
  }
}

class DiaryLunchItem extends StatelessWidget {
  const DiaryLunchItem({super.key, required this.luncheList});
  final List<LuncheList> luncheList;
  @override
  Widget build(BuildContext context) {
    var screenSize = MediaQuery.sizeOf(context);
    double height = screenSize.height;
    double width = screenSize.width;
    return luncheList.isEmpty
        ? SliverToBoxAdapter(
            child: Center(
              child: Text(
                "No lunch items are found",
                style: AppTextStyles.formalTextStyle(
                  color: Theme.of(context).primaryTextTheme.titleMedium!.color!,
                ),
              ),
            ),
          )
        : SliverPadding(
            padding: EdgeInsets.symmetric(vertical: height * 0.02),
            sliver: SliverList.builder(
              itemCount: luncheList.length,
              itemBuilder: (context, index) {
                LuncheList lunchItem = luncheList[index];
                return SizedBox(
                  height: height * 0.1,
                  width: width,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      SizedBox(
                        width: 14,
                        child: Stack(
                          children: [
                            Center(
                              child: Container(
                                width: width * 0.005,
                                color: const Color(0xFFD0D0D0),
                              ),
                            ),
                            Center(
                              child: Container(
                                width: 14,
                                height: 14,
                                decoration: BoxDecoration(
                                  color: AppColors.buttonColor,
                                  shape: BoxShape.circle,
                                ),
                              ),
                            )
                          ],
                        ),
                      ),
                      Expanded(
                        child: ListTile(
                          leading: Container(
                            width: width * 0.14,
                            height: height * 0.07,
                            decoration: const BoxDecoration(
                              color: Color(0xFFD9D9D9),
                              shape: BoxShape.circle,
                            ),
                            child: lunchItem.imageName == null
                                ? ClipOval(
                                    child: Image.asset(AppAssets.dietImgUrl,
                                        fit: BoxFit.cover),
                                  )
                                : ClipOval(
                                    child: lunchItem.custom == "custom"
                                        ? LoadingImage(
                                            imageUrl: lunchItem.imageName!,
                                            fit: BoxFit.cover,
                                          )
                                        : lunchItem.custom == "scanner"
                                            ? S3LoadingImage(
                                                imageUrl: lunchItem.imageName!,
                                                fit: BoxFit.cover,
                                              )
                                            : S3LoadingImage(
                                                imageUrl:
                                                    "${ApiUrls.s3ImageBaseUrl}Diet/${lunchItem.imageName}",
                                                fit: BoxFit.cover),
                                  ),
                          ),
                          title: AutoSizeText(
                            lunchItem.fName!,
                            minFontSize: 8,
                            maxLines: 2,
                            style: AppTextStyles.formalTextStyle(
                              color: Theme.of(context)
                                  .primaryTextTheme
                                  .titleMedium!
                                  .color!,
                            ),
                          ),
                          // subtitle: Text(
                          //   '${(lunchItem.consCalories! / 4).ceilToDouble()} grams',
                          //   style: AppTextStyles.formalTextStyle(
                          //     color: const Color(0xFFB3B3B3),
                          //     fontSize: 12,
                          //   ),
                          // ),
                          trailing: Text(
                            '${lunchItem.consCalories} cal',
                            style: AppTextStyles.formalTextStyle(
                              color: Theme.of(context)
                                  .primaryTextTheme
                                  .titleMedium!
                                  .color!,
                            ),
                          ),
                        ),
                      )
                    ],
                  ),
                );
              },
            ),
          );
  }
}

class DiarySnackItem extends StatelessWidget {
  const DiarySnackItem({super.key, required this.snackList});
  final List<SnackList> snackList;
  @override
  Widget build(BuildContext context) {
    var screenSize = MediaQuery.sizeOf(context);
    double height = screenSize.height;
    double width = screenSize.width;
    return snackList.isEmpty
        ? SliverToBoxAdapter(
            child: Center(
              child: Text(
                "No snack items are found",
                style: AppTextStyles.formalTextStyle(
                  color: Theme.of(context).primaryTextTheme.titleMedium!.color!,
                ),
              ),
            ),
          )
        : SliverPadding(
            padding: EdgeInsets.symmetric(vertical: height * 0.02),
            sliver: SliverList.builder(
              itemCount: snackList.length,
              itemBuilder: (context, index) {
                SnackList snackItem = snackList[index];
                return SizedBox(
                  height: height * 0.1,
                  width: width,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      SizedBox(
                        width: 14,
                        child: Stack(
                          children: [
                            Center(
                              child: Container(
                                width: width * 0.005,
                                color: const Color(0xFFD0D0D0),
                              ),
                            ),
                            Center(
                              child: Container(
                                width: 14,
                                height: 14,
                                decoration: BoxDecoration(
                                  color: AppColors.buttonColor,
                                  shape: BoxShape.circle,
                                ),
                              ),
                            )
                          ],
                        ),
                      ),
                      Expanded(
                        child: ListTile(
                          leading: Container(
                            width: width * 0.14,
                            height: height * 0.07,
                            decoration: const BoxDecoration(
                              color: Color(0xFFD9D9D9),
                              shape: BoxShape.circle,
                            ),
                            child: snackItem.imageName == null
                                ? ClipOval(
                                    child: Image.asset(AppAssets.dietImgUrl,
                                        fit: BoxFit.cover),
                                  )
                                : ClipOval(
                                    child: snackItem.custom == "custom"
                                        ? LoadingImage(
                                            imageUrl: snackItem.imageName!,
                                            fit: BoxFit.cover,
                                          )
                                        : snackItem.custom == "scanner"
                                            ? S3LoadingImage(
                                                imageUrl: snackItem.imageName!,
                                                fit: BoxFit.cover,
                                              )
                                            : S3LoadingImage(
                                                imageUrl:
                                                    "${ApiUrls.s3ImageBaseUrl}Diet/${snackItem.imageName}",
                                                fit: BoxFit.cover),
                                  ),
                          ),
                          title: AutoSizeText(
                            snackItem.fName!,
                            minFontSize: 8,
                            maxLines: 2,
                            style: AppTextStyles.formalTextStyle(
                              color: Theme.of(context)
                                  .primaryTextTheme
                                  .titleMedium!
                                  .color!,
                            ),
                          ),
                          // subtitle: Text(
                          //   '${(snackItem.consCalories! / 4).ceilToDouble()} grams',
                          //   style: AppTextStyles.formalTextStyle(
                          //     color: const Color(0xFFB3B3B3),
                          //     fontSize: 12,
                          //   ),
                          // ),
                          trailing: Text(
                            '${snackItem.consCalories} cal',
                            style: AppTextStyles.formalTextStyle(
                              color: Theme.of(context)
                                  .primaryTextTheme
                                  .titleMedium!
                                  .color!,
                            ),
                          ),
                        ),
                      )
                    ],
                  ),
                );
              },
            ),
          );
  }
}

class DiaryDinnerItem extends StatelessWidget {
  const DiaryDinnerItem({super.key, required this.dinnerList});
  final List<DinnerList> dinnerList;
  @override
  Widget build(BuildContext context) {
    var screenSize = MediaQuery.sizeOf(context);
    double height = screenSize.height;
    double width = screenSize.width;
    return dinnerList.isEmpty
        ? SliverToBoxAdapter(
            child: Center(
              child: Text(
                "No dinner items are found",
                style: AppTextStyles.formalTextStyle(
                  color: Theme.of(context).primaryTextTheme.titleMedium!.color!,
                ),
              ),
            ),
          )
        : SliverPadding(
            padding: EdgeInsets.symmetric(vertical: height * 0.02),
            sliver: SliverList.builder(
              itemCount: dinnerList.length,
              itemBuilder: (context, index) {
                DinnerList dinnerItem = dinnerList[index];
                return SizedBox(
                  height: height * 0.1,
                  width: width,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      SizedBox(
                        width: 14,
                        child: Stack(
                          children: [
                            Center(
                              child: Container(
                                width: width * 0.005,
                                color: const Color(0xFFD0D0D0),
                              ),
                            ),
                            Center(
                              child: Container(
                                width: 14,
                                height: 14,
                                decoration: BoxDecoration(
                                  color: AppColors.buttonColor,
                                  shape: BoxShape.circle,
                                ),
                              ),
                            )
                          ],
                        ),
                      ),
                      Expanded(
                        child: ListTile(
                          leading: Container(
                            width: width * 0.14,
                            height: height * 0.07,
                            decoration: const BoxDecoration(
                              color: Color(0xFFD9D9D9),
                              shape: BoxShape.circle,
                              // image: dinnerItem.imageName == null
                              //     ? const DecorationImage(
                              //         image: AssetImage(AppAssets.dietImgUrl),
                              //         fit: BoxFit.cover)
                              //     : DecorationImage(
                              //         image: NetworkImage(dinnerItem.imageName!
                              //                 .startsWith("https")
                              //             ? dinnerItem.imageName!
                              //             : "${ApiUrls.s3ImageBaseUrl}Diet/${dinnerItem.imageName}"),
                              //         fit: BoxFit.cover),
                            ),
                            child: dinnerItem.imageName == null
                                ? ClipOval(
                                    child: Image.asset(AppAssets.dietImgUrl,
                                        fit: BoxFit.cover),
                                  )
                                : ClipOval(
                                    child: dinnerItem.custom == "custom"
                                        ? LoadingImage(
                                            imageUrl: dinnerItem.imageName!,
                                            fit: BoxFit.cover,
                                          )
                                        : dinnerItem.custom == "scanner"
                                            ? S3LoadingImage(
                                                imageUrl: dinnerItem.imageName!,
                                                fit: BoxFit.cover,
                                              )
                                            : S3LoadingImage(
                                                imageUrl:
                                                    "${ApiUrls.s3ImageBaseUrl}Diet/${dinnerItem.imageName}",
                                                fit: BoxFit.cover,
                                              ),
                                  ),
                          ),
                          title: AutoSizeText(
                            dinnerItem.fName!,
                            minFontSize: 8,
                            maxLines: 2,
                            style: AppTextStyles.formalTextStyle(
                              color: Theme.of(context)
                                  .primaryTextTheme
                                  .titleMedium!
                                  .color!,
                            ),
                          ),
                          // subtitle: Text(
                          //   '${(dinnerItem.consCalories! / 4).ceilToDouble()} grams',
                          //   style: AppTextStyles.formalTextStyle(
                          //     color: const Color(0xFFB3B3B3),
                          //     fontSize: 12,
                          //   ),
                          // ),
                          trailing: Text(
                            '${dinnerItem.consCalories} cal',
                            style: AppTextStyles.formalTextStyle(
                              color: Theme.of(context)
                                  .primaryTextTheme
                                  .titleMedium!
                                  .color!,
                            ),
                          ),
                        ),
                      )
                    ],
                  ),
                );
              },
            ),
          );
  }
}
