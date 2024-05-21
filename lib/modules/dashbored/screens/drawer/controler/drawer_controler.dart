import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:weight_loss_app/common/app_assets.dart';
import 'package:weight_loss_app/modules/dashbored/screens/drawer/modalClass/container_shadow_modal_class.dart';

class MyDrawerController extends GetxController {
  List<ContainerModalClass> drwerContainersList = [
    ContainerModalClass(
        iconImage: "",
        text: 'Profile',
        isIcon: true,
        icon: Icons.person_outline_rounded),
    ContainerModalClass(
      iconImage: AppAssets.wlCommunitySvg,
      text: 'WL Community',
      isIcon: false,
    ),
    ContainerModalClass(
      iconImage: AppAssets.cbt,
      text: 'Cognitive Behavioral Technique',
      isIcon: false,
    ),
    ContainerModalClass(
      iconImage: AppAssets.sleep,
      text: 'Sleep Detail',
      isIcon: false,
    ),
    ContainerModalClass(
      iconImage: AppAssets.water,
      text: 'Water',
      isIcon: false,
    ),
    // ContainerModalClass(iconImage: AppAssets.challenge, text: 'Challenge'),
    ContainerModalClass(
      iconImage: AppAssets.recipe,
      text: 'Recipes',
      isIcon: false,
    ),
    ContainerModalClass(
      iconImage: AppAssets.selfie,
      text: 'Ultimate Selfie',
      isIcon: false,
    ),
    ContainerModalClass(
      iconImage: AppAssets.watch,
      text: 'Connected Devices',
      isIcon: false,
    ),
    ContainerModalClass(
        iconImage: "",
        text: 'Grocery',
        isIcon: true,
        icon: Icons.local_grocery_store_outlined),
  ];
}
