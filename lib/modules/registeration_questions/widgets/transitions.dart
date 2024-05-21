import 'package:flutter/material.dart';

int secondModuleTotalScreen = 5;
int thirdModuleTotalScreen = 5;
int fourthModuleTotalScreen = 1;
int fifthModuleTotalScreen = 5;
int totalScreens = secondModuleTotalScreen +
    thirdModuleTotalScreen +
    fourthModuleTotalScreen +
    fifthModuleTotalScreen;

Widget bottomSlideTransition(Animation<double> animation, Widget child) {
  return SlideTransition(
    position: Tween<Offset>(begin: const Offset(0, 1), end: Offset.zero)
        .animate(animation),
    child: child,
  );
}
