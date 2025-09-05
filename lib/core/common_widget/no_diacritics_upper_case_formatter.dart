import 'package:flutter/services.dart';

class NoDiacriticsUpperCaseFormatter extends TextInputFormatter {
  static const vietnamese = 'áàạảãâấầậẩẫăắằặẳẵ'
      'ÁÀẠẢÃÂẤẦẬẨẪĂẮẰẶẲẴ'
      'éèẹẻẽêếềệểễ'
      'ÉÈẸẺẼÊẾỀỆỂỄ'
      'óòọỏõôốồộổỗơớờợởỡ'
      'ÓÒỌỎÕÔỐỒỘỔỖƠỚỜỢỞỠ'
      'úùụủũưứừựửữ'
      'ÚÙỤỦŨƯỨỪỰỬỮ'
      'íìịỉĩ'
      'ÍÌỊỈĨ'
      'đĐ'
      'ýỳỵỷỹ'
      'ÝỲỴỶỸ';

  static const latin = 'aaaaaaaaaaaaaaaaa'
      'AAAAAAAAAAAAAAAAA'
      'eeeeeeeeeee'
      'EEEEEEEEEEE'
      'ooooooooooooooooooo'
      'OOOOOOOOOOOOOOOOOOO'
      'uuuuuuuuuuu'
      'UUUUUUUUUUU'
      'iiiii'
      'IIIII'
      'dD'
      'yyyyy'
      'YYYYY';

  String removeDiacriticsAndUpper(String input) {
    for (int i = 0; i < vietnamese.length; i++) {
      input = input.replaceAll(vietnamese[i], latin[i]);
    }
    return input.toUpperCase();
  }

  @override
  TextEditingValue formatEditUpdate(
      TextEditingValue oldValue,
      TextEditingValue newValue,
      ) {
    final transformed = removeDiacriticsAndUpper(newValue.text);
    return TextEditingValue(
      text: transformed,
      selection: newValue.selection.copyWith(
        baseOffset: transformed.length,
        extentOffset: transformed.length,
      ),
    );
  }
}
