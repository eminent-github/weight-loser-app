import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../../../../common/app_colors.dart';
import '../../../../common/app_text_styles.dart';

class CustomChangePasswordTextField extends StatefulWidget {
  const CustomChangePasswordTextField({
    super.key,
    required this.controller,
    required this.labelText,
    required this.prefixIcon,
    this.suffixIcon,
    this.iconColor,
    this.iconHeight,
    this.hintTextColor,
    this.inputFormatters,
    this.textInputAction,
    this.focusNode,
    required this.obscuringCharacter,
  });
  final TextEditingController controller;

  final IconData prefixIcon;
  final Widget? suffixIcon;
  final String labelText;
  final Color? hintTextColor;
  final Color? iconColor;
  final List<TextInputFormatter>? inputFormatters;
  final TextInputAction? textInputAction;
  final FocusNode? focusNode;
  final String obscuringCharacter;
  final double? iconHeight;

  @override
  State<CustomChangePasswordTextField> createState() =>
      _CustomChangePasswordTextFieldState();
}

class _CustomChangePasswordTextFieldState
    extends State<CustomChangePasswordTextField> {
  bool _obscureText = true;
  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    return Container(
      height: height * 0.07,
      width: width * 0.8,
      decoration: BoxDecoration(
        color: const Color(0xFFffffff),
        borderRadius: BorderRadius.circular(8),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.shade300,
            blurRadius: 2.0, // soften the shadow
            spreadRadius: 1.0, //extend the shadow
            offset: const Offset(
              1.0, // Move to right 5  horizontally
              1.0, // Move to bottom 5 Vertically
            ),
          )
        ],
      ),
      child: Row(
        children: [
          SizedBox(
            width: width * 0.03,
          ),
          Padding(
            padding: EdgeInsets.only(top: height * 0.0),
            child: Icon(
              widget.prefixIcon,
              color: widget.iconColor ?? AppColors.iconColor,
              size: widget.iconHeight ?? height * 0.03,
            ),
          ),
          SizedBox(
            width: width * 0.03,
          ),
          Expanded(
            child: TextFormField(
              style: const TextStyle(
                fontSize: 12,
                fontFamily: AppTextStyles.fontFamily,
              ),
              obscureText: _obscureText,
              obscuringCharacter: widget.obscuringCharacter,
              controller: widget.controller,
              focusNode: widget.focusNode,
              textInputAction: widget.textInputAction ?? TextInputAction.next,
              inputFormatters: widget.inputFormatters,
              keyboardType: TextInputType.visiblePassword,
              decoration: InputDecoration(
                  // suffixIcon: widget.suffixIcon,
                  hintText: widget.labelText,
                  hintStyle: TextStyle(
                    fontSize: 12,
                    color: widget.hintTextColor ?? AppColors.iconColor,
                    fontFamily: AppTextStyles.fontFamily,
                  ),
                  border: InputBorder.none),
            ),
          ),
          SizedBox(
            width: width * 0.03,
          ),
          IconButton(
            onPressed: () {
              setState(() {
                _obscureText = !_obscureText;
              });
            },
            icon: Icon(
              _obscureText ? Icons.visibility_off : Icons.visibility,
              color: AppColors.iconColor,
            ),
          ),
          SizedBox(
            width: width * 0.01,
          ),
        ],
      ),
    );
  }
}
