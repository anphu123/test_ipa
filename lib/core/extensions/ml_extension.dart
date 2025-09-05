// lib/core/extensions/ml_extension.dart
import 'package:get/get.dart';

extension MLMapX on Map<String, String> {
  String trML({String fallback = 'vi'}) {
    final lang = Get.locale?.languageCode ?? fallback;
    return this[lang] ?? this[fallback] ?? this['en'] ?? values.first;
  }
}
