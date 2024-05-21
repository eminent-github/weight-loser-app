import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sp_showcaseview/showcaseview.dart';
import 'package:weight_loss_app/common/app_colors.dart';
import 'package:weight_loss_app/modules/dashbored/screens/drawer/view/drawer_page.dart';
import 'package:weight_loss_app/modules/dashbored/screens/home/widgets/float_water_dialog.dart';
import 'package:weight_loss_app/modules/favourite/binding/favourite_binding.dart';
import 'package:weight_loss_app/modules/favourite/favourite_page/favourite_page.dart';
import 'package:weight_loss_app/modules/recipe/discover_recipe/binding/discover_binding.dart';
import 'package:weight_loss_app/modules/recipe/discover_recipe/view/discover_page.dart';
import 'package:weight_loss_app/modules/ultimate_selfie/binding/ultimate_selfie_binding.dart';
import 'package:weight_loss_app/modules/ultimate_selfie/ultimate_selfie_page/ultimate_selfie_page.dart';
import 'package:weight_loss_app/widgets/floating_action_buttons.dart';
import 'package:weight_loss_app/widgets/overlay_widget.dart';

import '../../../../../common/app_text_styles.dart';
import '../controller/home_controller.dart';

final GlobalKey menueGlobalKey = GlobalKey();
final GlobalKey favoritGlobalKey = GlobalKey();
var scaffoldKey = GlobalKey<ScaffoldState>();

class HomePage extends GetView<HomeController> {
  const HomePage({
    super.key,
    required this.isDrawerHide,
    required this.userName,
    required this.isCallShowcase,
  });
  final RxBool isDrawerHide;
  final RxString userName;
  final bool isCallShowcase;

  @override
  Widget build(BuildContext context) {
    var screenSize = MediaQuery.sizeOf(context);

    var width = screenSize.width;
    var height = screenSize.height;
    return Scaffold(
      key: scaffoldKey,
      drawer: const DrawerPage(),
      // Showcase(
      //     key: menueGlobalKey,
      //     description: 'Tap to see menu options',
      //     disableDefaultTargetGestures: true,
      //     onBarrierClick: () => debugPrint('Barrier clicked'),
      //     child: const DrawerPage()),
      // const ,
      onDrawerChanged: (isOpened) {
        if (isOpened) {
          isDrawerHide.value = true;
        } else {
          isDrawerHide.value = false;
        }
      },
      appBar: AppBar(
        leading: IconButton(
          onPressed: () {
            if (scaffoldKey.currentState != null) {
              scaffoldKey.currentState!.openDrawer();
            }
          },
          icon: Showcase(
              key: menueGlobalKey,
              description:
                  'Tap to access settings, tools, features, and community features instantly.',
              disableDefaultTargetGestures: false,
              // disposeOnTap: true,
              // onTargetClick: () {
              //   Navigator.of(context).pop();
              // },
              onBarrierClick: () => debugPrint('Barrier clicked'),
              child: const Icon(Icons.menu)),
        ),
        backgroundColor: Theme.of(context).appBarTheme.backgroundColor,
        iconTheme: Theme.of(context).iconTheme,
        centerTitle: true,
        elevation: 2,
        shadowColor: AppColors.greyDim.withOpacity(0.3),
        title: Obx(
          () => Text.rich(
            TextSpan(
              children: [
                TextSpan(
                  text: 'Hey, ',
                  style: AppTextStyles.formalTextStyle(
                    fontSize: 16,
                    color:
                        Theme.of(context).primaryTextTheme.titleMedium!.color!,
                  ),
                ),
                TextSpan(
                  text: userName.value.split(" ")[0],
                  style: AppTextStyles.formalTextStyle(
                    color: AppColors.buttonColor,
                    fontSize: 16,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ],
            ),
          ),
        ),
        actions: [
          Showcase(
            key: favoritGlobalKey,
            description: 'See your favorites here.',
            disableDefaultTargetGestures: false,
            onBarrierClick: () => debugPrint('Barrier clicked'),
            child: Padding(
              padding: EdgeInsets.only(right: width * 0.02),
              child: IconButton(
                onPressed: () {
                  Get.to(() => const FavouritePage(),
                      binding: FavouriteBinding());
                },
                icon: const Icon(
                  Icons.favorite,
                  color: Colors.red,
                ),
              ),
            ),
          ),
        ],
        bottom: TabBar(
          controller: controller.tabController,
          // indicatorSize: TabBarIndicatorSize.label,
          // indicatorColor: AppColors.buttonColor,
          labelColor: AppColors.buttonColor,
          indicator: const BoxDecoration(),
          labelStyle: AppTextStyles.formalTextStyle(
            fontSize: height * 0.0175,
            fontWeight: FontWeight.w700,
          ),
          // dividerHeight: 0,
          unselectedLabelColor:
              Theme.of(context).primaryTextTheme.titleMedium!.color!,
          unselectedLabelStyle: AppTextStyles.formalTextStyle(
            fontSize: height * 0.0175,
            fontWeight: FontWeight.w700,
          ),
          tabs: controller.homePageTabsList,
        ),
      ),
      body: Obx(
        () => Stack(
          children: [
            TabBarView(
              controller: controller.tabController,
              children: controller.tabViewScreens,
            ),
            controller.isToadayWaterLoading.value
                ? const OverlayWidget()
                : const SizedBox(),
          ],
        ),
      ),
      floatingActionButton: Obx(
        () => controller.tabItemIndex.value == 0
            ? ExpandableFab(
                key: UniqueKey(),
                distance: 100,
                children: [
                  ActionButton(
                    key: UniqueKey(),
                    onPressed: () => Get.to(() => const DiscoverRecipePage(),
                        binding: DiscoverBinding()),
                    icon: const Icon(Icons.food_bank_outlined),
                  ),
                  ActionButton(
                    key: UniqueKey(),
                    onPressed: () => Get.to(
                      () => const UltimateSelfiePage(),
                      binding: UltimateSelfieBinding(),
                    ),
                    icon: const Icon(Icons.camera_alt_outlined),
                  ),
                  ActionButton(
                    key: UniqueKey(),
                    onPressed: () async => await waterIntakeDialog(context),
                    icon: const Icon(Icons.water_drop_outlined),
                  ),
                ],
              )
            : const SizedBox(),
      ),
    );
  }

  Future<void> waterIntakeDialog(BuildContext context) async {
    await showDialog(
      context: context,
      builder: (BuildContext context) {
        return FloatWaterIntakeDialog(
          controller: controller,
        );
      },
    );
  }
}
