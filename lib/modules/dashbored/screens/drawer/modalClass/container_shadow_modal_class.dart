import 'package:flutter/material.dart';

class ContainerModalClass {
  final String iconImage;
  final String text;
  final bool isIcon;
  final IconData? icon;

  ContainerModalClass({
    required this.iconImage,
    required this.text,
    required this.isIcon,
    this.icon,
  });
}
