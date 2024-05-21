import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:get/get_core/get_core.dart';
import 'package:get/get_instance/get_instance.dart';
import 'package:intl/intl.dart';
import 'package:weight_loss_app/modules/dashbored/screens/grocery/controller/grocery_controller.dart';

import '../../../../../common/app_colors.dart';
import '../../../../../common/app_text_styles.dart';
import '../models/grocery_items_model.dart';
import '../models/user_grocery_model.dart';

class UserGroceryLoadedUI extends StatelessWidget {
  UserGroceryLoadedUI({
    super.key,
    required this.userGroceryModel,
  });
  final UserGroceryModel userGroceryModel;
  final contrller = Get.find<GroceryController>();
  @override
  Widget build(BuildContext context) {
    var screenSize = MediaQuery.sizeOf(context);
    double height = screenSize.height;
    double width = screenSize.width;
    Iterable<GroceryItemsModel> pendingItems =
        userGroceryModel.groceryList == null
            ? []
            : userGroceryModel.groceryList!.expand(
                (e) => e.items!.where(
                  (element) => element.purchased == false,
                ),
              );
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: width * 0.05),
      child: Column(
        children: [
          SizedBox(
            height: height * 0.01,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                children: [
                  Text(
                    // "Today - ${DateFormat("d MMM").format(DateTime.parse(userGroceryModel.startDate!))}",
                    "Today - ${DateFormat("d MMM").format(DateTime.now())}",
                    textAlign: TextAlign.center,
                    style: AppTextStyles.formalTextStyle(
                        color: Theme.of(context)
                            .primaryTextTheme
                            .titleMedium!
                            .color!,
                        fontSize: 11,
                        fontWeight: FontWeight.bold),
                  ),
                  Text(
                    '${calculateRemainingDays(
                      DateTime.parse(userGroceryModel.startDate ??
                          DateTime.now().toString()),
                      DateTime.parse(userGroceryModel.endDate ??
                          DateTime.now().toString()),
                    )} Days remaining',
                    textAlign: TextAlign.center,
                    style: AppTextStyles.formalTextStyle(
                      fontSize: 9,
                      color: Theme.of(context)
                          .primaryTextTheme
                          .titleMedium!
                          .color!,
                    ),
                  ),
                ],
              ),
              Column(
                children: [
                  Text(
                    pendingItems.length.toString(),
                    textAlign: TextAlign.center,
                    style: AppTextStyles.formalTextStyle(
                        color: Theme.of(context)
                            .primaryTextTheme
                            .titleMedium!
                            .color!,
                        fontSize: 11,
                        fontWeight: FontWeight.bold),
                  ),
                  Text(
                    'items pending',
                    textAlign: TextAlign.center,
                    style: AppTextStyles.formalTextStyle(
                      fontSize: 9,
                      color: Theme.of(context)
                          .primaryTextTheme
                          .titleMedium!
                          .color!,
                    ),
                  ),
                ],
              ),
            ],
          ),
          SizedBox(
            height: height * 0.03,
          ),
          Expanded(
            child: userGroceryModel.groceryList == null
                ? Center(
                    child: Text(
                      'No items Found',
                      textAlign: TextAlign.center,
                      style: AppTextStyles.formalTextStyle(),
                    ),
                  )
                : userGroceryModel.groceryList!.isEmpty
                    ? Center(
                        child: Text(
                          'No items Found',
                          textAlign: TextAlign.center,
                          style: AppTextStyles.formalTextStyle(),
                        ),
                      )
                    : ListView.builder(
                        itemCount: userGroceryModel.groceryList!.length,
                        itemBuilder: (context, index) {
                          int remainingItems = userGroceryModel
                              .groceryList![index].items!
                              .where((element) => element.purchased == false)
                              .length;
                          // int addedItems = userGroceryModel
                          //     .groceryList![index].items!
                          //     .where((element) => element.purchased == true)
                          //     .length;
                          return Padding(
                            padding: EdgeInsets.only(top: height * 0.02),
                            child: Container(
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(3),
                                boxShadow: const [
                                  BoxShadow(
                                    color: Color(0xFFD3D3D3),
                                    blurRadius: 3,
                                    offset: Offset(
                                        0, 2), // changes position of shadow
                                  )
                                ],
                              ),
                              child: ExpansionTile(
                                childrenPadding:
                                    EdgeInsets.only(bottom: height * 0.02),
                                collapsedIconColor: AppColors.buttonColor,
                                iconColor: AppColors.buttonColor,
                                collapsedBackgroundColor: AppColors.white,
                                shape: const RoundedRectangleBorder(),
                                leading: SizedBox(
                                  width: width * 0.3,
                                  child: AutoSizeText(
                                    userGroceryModel
                                        .groceryList![index].category!,
                                    maxLines: 2,
                                    minFontSize: 5,
                                    style: AppTextStyles.formalTextStyle(
                                      color: AppColors.buttonColor,
                                    ),
                                  ),
                                ),
                                title: AutoSizeText(
                                  'Items Remaining: $remainingItems',
                                  minFontSize: 4,
                                  style: AppTextStyles.formalTextStyle(
                                    color: const Color(0xFF6D6D6D),
                                    fontSize: 12,
                                    // fontWeight: FontWeight.w700,
                                  ),
                                ),
                                children: userGroceryModel
                                    .groceryList![index].items!
                                    .asMap()
                                    .entries
                                    .map(
                                  (e) {
                                    final index = e.key;
                                    final value = e.value;

                                    return Padding(
                                      padding:
                                          EdgeInsets.only(top: height * .01),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceEvenly,
                                        children: [
                                          Container(
                                            width: width * 0.6,
                                            // height: height * 0.032,
                                            padding: EdgeInsets.only(
                                              left: width * 0.02,
                                              top: height * 0.008,
                                              bottom: height * 0.008,
                                            ),
                                            decoration: ShapeDecoration(
                                              shape: RoundedRectangleBorder(
                                                side: BorderSide(
                                                  width: 0.25,
                                                  color: AppColors.buttonColor,
                                                ),
                                                borderRadius:
                                                    BorderRadius.circular(3),
                                              ),
                                            ),
                                            child: Align(
                                              alignment: Alignment.centerLeft,
                                              child: Text(
                                                '${index + 1}: ${value.item}',
                                                style: AppTextStyles
                                                    .formalTextStyle(
                                                  color: AppColors.buttonColor,
                                                  fontSize: 9,
                                                ),
                                              ),
                                            ),
                                          ),
                                          value.purchased == false
                                              ? IconButton(
                                                  onPressed: () {
                                                    contrller
                                                        .groceryPurchasedApi(
                                                      listId: value.listId!,
                                                      isPurchased: true,
                                                    );
                                                  },
                                                  icon: Icon(
                                                    Icons.circle_outlined,
                                                    size: 25,
                                                    color:
                                                        AppColors.buttonColor,
                                                  ),
                                                )
                                              : IconButton(
                                                  onPressed: () {
                                                    contrller
                                                        .groceryPurchasedApi(
                                                      listId: value.listId!,
                                                      isPurchased: false,
                                                    );
                                                  },
                                                  icon: Icon(
                                                    Icons.check_circle_rounded,
                                                    size: 25,
                                                    color:
                                                        AppColors.buttonColor,
                                                  ),
                                                ),
                                        ],
                                      ),
                                    );
                                  },
                                ).toList(),
                              ),
                            ),
                          );
                        },
                      ),
          )
        ],
      ),
    );
  }

  int calculateRemainingDays(DateTime startDate, DateTime targetDate) {
    // print("start date :${startDate}end date :$targetDate");
    final difference = targetDate.difference(startDate);

    return difference.inDays;
  }
}
