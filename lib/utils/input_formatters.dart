import 'package:flutter/services.dart';

class FirstCharacterNoSpaceFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(
      TextEditingValue oldValue, TextEditingValue newValue) {
    if (newValue.text.isNotEmpty && newValue.text[0] == ' ') {
      return TextEditingValue(
        text: newValue.text.replaceFirst(' ', ''),
        selection: newValue.selection.copyWith(
          baseOffset: newValue.selection.baseOffset > 0
              ? newValue.selection.baseOffset - 1
              : 0,
          extentOffset: newValue.selection.extentOffset > 0
              ? newValue.selection.extentOffset - 1
              : 0,
        ),
        composing: TextRange.empty,
      );
    }

    return newValue;
  }
}
