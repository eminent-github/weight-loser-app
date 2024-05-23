import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../../../common/app_colors.dart';
import '../../../common/app_text_styles.dart';

class CustomTextFormField extends StatelessWidget {
  const CustomTextFormField({
    super.key,
    required this.controller,
    this.validatorFunction,
    required this.labelText,
    required this.prefixIcon,
    this.iconColor,
    this.iconHeight,
    this.hintTextColor,
    this.textInputAction = TextInputAction.done,
    this.keyboardType = TextInputType.text,
    this.focusNode,
    this.inputFormatters,
    this.onChanged,
    this.textCapitalization,
  });
  final TextEditingController controller;
  final String? Function(String? value)? validatorFunction;
  final IconData prefixIcon;
  final String labelText;
  final Color? hintTextColor;
  final Color? iconColor;
  final double? iconHeight;
  final TextInputAction? textInputAction;
  final TextInputType? keyboardType;
  final FocusNode? focusNode;
  final List<TextInputFormatter>? inputFormatters;
  final void Function(String)? onChanged;
  final TextCapitalization? textCapitalization;

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    return SizedBox(
      width: width * 0.8,
      // height: height * 0.1,
      child: Center(
        child: TextFormField(
          textInputAction: textInputAction,
          textCapitalization: textCapitalization ?? TextCapitalization.none,
          keyboardType: keyboardType,
          focusNode: focusNode,
          onChanged: onChanged,
          style: const TextStyle(
            fontSize: 12,
            fontFamily: AppTextStyles.fontFamily,
          ),
          maxLength: 30,
          buildCounter: (context,
                  {required currentLength, required isFocused, maxLength}) =>
              const SizedBox(),
          inputFormatters: inputFormatters,
          controller: controller,
          decoration: InputDecoration(
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(3),
              borderSide: BorderSide(
                color: AppColors.textBorderColor,
                width: 1,
              ),
            ),
            disabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(3),
              borderSide: BorderSide(
                color: AppColors.textBorderColor,
                width: 1,
              ),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(3),
              borderSide: BorderSide(
                color: AppColors.textBorderColor,
                width: 1,
              ),
            ),
            prefixIcon: Icon(
              prefixIcon,
              color: iconColor ?? AppColors.iconColor,
              size: iconHeight ?? height * 0.03,
            ),
            label: Text(
              labelText,
              style: TextStyle(
                fontSize: 12,
                color: hintTextColor ?? AppColors.iconColor,
                fontFamily: AppTextStyles.fontFamily,
              ),
            ),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(3),
              borderSide: BorderSide(
                color: AppColors.textBorderColor,
                width: 1,
              ),
            ),
          ),
        ),
      ),
    );
  }
}

// class CapitalizeFirstWordFormatter extends TextInputFormatter {
//   @override
//   TextEditingValue formatEditUpdate(
//       TextEditingValue oldValue, TextEditingValue newValue) {
//     if (newValue.text.isNotEmpty && newValue.text.length == 1) {
//       // Capitalize the first character if it is the first character of the input
//       return newValue.copyWith(
//         text: newValue.text[0].toUpperCase(),
//         selection: newValue.selection,
//       );
//     } else if (newValue.text.isNotEmpty) {
//       // Capitalize the first word
//       List<String> words = newValue.text.split(' ');
//       if (words.isNotEmpty && words[0].isNotEmpty) {
//         words[0] = words[0][0].toUpperCase() + words[0].substring(1);
//         return newValue.copyWith(
//           text: words.join(' '),
//           selection: newValue.selection,
//         );
//       }
//     }
//     return newValue;
//   }
// }

class CapitalizeAllWordsFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(
      TextEditingValue oldValue, TextEditingValue newValue) {
    if (newValue.text.isNotEmpty) {
      String capitalizedText = newValue.text.split(' ').map((word) {
        if (word.isNotEmpty) {
          return word[0].toUpperCase() + word.substring(1);
        }
        return word;
      }).join(' ');

      return newValue.copyWith(
        text: capitalizedText,
        selection: newValue.selection,
      );
    }
    return newValue;
  }
}
