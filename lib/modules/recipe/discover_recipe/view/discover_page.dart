import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:weight_loss_app/common/app_assets.dart';
import 'package:weight_loss_app/common/app_text_styles.dart';
import 'package:weight_loss_app/modules/recipe/discover_recipe/controller/discover_controller.dart';
import 'package:weight_loss_app/utils/internet_check_widget.dart';
import '../../../../common/app_colors.dart';
import '../../../../common/app_texts.dart';

class DiscoverRecipePage extends GetView<DiscoverController> {
  const DiscoverRecipePage({super.key});

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.sizeOf(context);
    double height = size.height;
    double width = size.width;
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        // backgroundColor: Theme.of(context).appBarTheme.backgroundColor,
        // iconTheme: Theme.of(context).iconTheme,
        iconTheme: const IconThemeData(color: AppColors.white),
        centerTitle: true,
        title: Text(
          AppTexts.discoverRecipe,
          // style: Theme.of(context).appBarTheme.titleTextStyle,
          style: AppTextStyles.formalTextStyle(
              color: AppColors.white,
              fontWeight: FontWeight.bold,
              fontSize: 17),
        ),
        systemOverlayStyle: const SystemUiOverlayStyle(
          statusBarIconBrightness: Brightness.light,
        ),
        backgroundColor: Colors.transparent,
        actions: [
          Padding(
            padding: EdgeInsets.only(right: width * 0.02),
            child: IconButton(
              onPressed: () {
                controller.recipeDataApi(type: "all");
              },
              icon: const Icon(
                Icons.refresh_rounded,
              ),
            ),
          )
        ],
      ),
      extendBodyBehindAppBar: true,
      body: InternetCheckWidget<ConnectivityService>(
        child: Column(
          children: [
            Container(
              height: height * 0.3,
              decoration: const BoxDecoration(
                image: DecorationImage(
                    image: AssetImage(
                      AppAssets.dietImgUrl,
                    ),
                    fit: BoxFit.cover),
              ),
              child: Stack(
                children: [
                  Container(
                    color: AppColors.black.withAlpha(110),
                  ),
                  Align(
                    alignment: Alignment.center,
                    child: Container(
                      height: height * 0.06,
                      width: width * 0.8,
                      decoration: ShapeDecoration(
                        color: AppColors.editProfileFieldColor,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(50)),
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
                        children: [
                          SizedBox(
                            width: width * 0.15,
                            child: Icon(
                              Icons.search,
                              color: AppColors.buttonColor,
                            ),
                          ),
                          Expanded(
                            child: GetBuilder(
                              init: controller,
                              builder: (_) {
                                return TextField(
                                  onChanged: (value) {
                                    controller.filterFoods(value);
                                  },
                                  focusNode: controller.searchFocusNode,
                                  decoration: const InputDecoration(
                                      hintText: AppTexts.recipeHintSearch,
                                      hintStyle:
                                          TextStyle(color: Color(0xffB5B5B5)),
                                      border: InputBorder.none),
                                );
                              },
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(
              height: height * 0.02,
            ),
            TabBar(
              controller: controller.tabController,
              indicatorSize: TabBarIndicatorSize.label,
              indicatorColor: AppColors.buttonColor,
              // labelColor:
              //     Theme.of(context).primaryTextTheme.titleMedium!.color!,
              // indicator: const BoxDecoration(),
             // dividerHeight: 0,
              labelStyle: AppTextStyles.formalTextStyle(
                fontWeight: FontWeight.w700,
                fontSize: 12,
                color: Theme.of(context).primaryTextTheme.titleMedium!.color!,
              ),
              labelPadding: const EdgeInsets.all(0),

              // unselectedLabelColor:
              //     Theme.of(context).primaryTextTheme.titleMedium!.color!,
              unselectedLabelStyle: AppTextStyles.formalTextStyle(
                fontWeight: FontWeight.w700,
                fontSize: 12,
                color: Theme.of(context).primaryTextTheme.titleMedium!.color!,
              ),
              tabs: controller.homePageTabsList,
            ),
            SizedBox(
              height: height * 0.02,
            ),
            Expanded(
              child: Obx(
                () => controller.isLoading.value
                    ? Center(
                        child: CircularProgressIndicator(
                          color: AppColors.buttonColor,
                        ),
                      )
                    : Column(
                        children: [
                          SizedBox(
                            height: height * 0.05,
                            child: controller.cuisines.isEmpty
                                ? Center(
                                    child: Text(
                                      "No Cuisine Found",
                                      style: AppTextStyles.formalTextStyle(
                                        color: Theme.of(context)
                                            .primaryTextTheme
                                            .titleMedium!
                                            .color!,
                                      ),
                                    ),
                                  )
                                : ListView.builder(
                                    scrollDirection: Axis.horizontal,
                                    itemCount: controller.cuisines.length,
                                    padding: EdgeInsets.symmetric(
                                        horizontal: width * 0.05),
                                    itemBuilder: (context, index) {
                                      return Obx(
                                        () => Padding(
                                          padding:
                                              const EdgeInsets.only(right: 16),
                                          child: Material(
                                            color:
                                                controller.cousineIndex.value ==
                                                        index
                                                    ? AppColors.buttonColor
                                                    : const Color(0xffF3F3F3),
                                            borderRadius:
                                                BorderRadius.circular(50),
                                            child: InkWell(
                                              onTap: () {
                                                controller.cousineIndex.value =
                                                    index;
                                                controller.filterCousine(
                                                    controller.cuisines[index]);
                                              },
                                              borderRadius:
                                                  BorderRadius.circular(50),
                                              child: Container(
                                                padding: EdgeInsets.symmetric(
                                                    horizontal: width * 0.04),
                                                child: Center(
                                                  child: AutoSizeText(
                                                    controller.cuisines[index],
                                                    maxLines: 1,
                                                    style: AppTextStyles
                                                        .formalTextStyle(
                                                      color: controller
                                                                  .cousineIndex
                                                                  .value ==
                                                              index
                                                          ? AppColors.white
                                                          : AppColors.black,
                                                      fontSize: 12,
                                                      fontWeight:
                                                          FontWeight.w700,
                                                    ),
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ),
                                        ),
                                      );
                                    },
                                  ),
                          ),
                          SizedBox(
                            height: height * 0.02,
                          ),
                          Expanded(
                            child: TabBarView(
                              controller: controller.tabController,
                              children: controller.tabViewScreens,
                            ),
                          ),
                        ],
                      ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
