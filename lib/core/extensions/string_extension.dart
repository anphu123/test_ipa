import 'package:easy_localization/easy_localization.dart';

extension StringExtension on String {
  String trans({List<String>? args, Map<String, String>? namedArgs, String? gender}) {
    return this.tr(args: args, namedArgs: namedArgs, gender: gender);
  }

  bool isNullOrEmpty(String? value) {
    return value == null || value.isEmpty;
  }
}
