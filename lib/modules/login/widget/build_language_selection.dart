import 'package:easy_localization/easy_localization.dart';
import 'package:fido_box_demo01/modules/login/controllers/login_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

Widget buildLanguageDropdown(BuildContext context) {
  final controller = Get.find<LoginController>();
  final currentLocale = context.locale.languageCode;

  final languages = {
    'vi': 'Tiếng Việt 🇻🇳',
    'en': 'English 🇺🇸',
    'zh': 'China 🇨🇳',
  };

  return DropdownButton<String>(
    value: currentLocale,
    items: languages.entries.map((entry) {
      return DropdownMenuItem<String>(
        value: entry.key,
        child: Text(entry.value),
      );
    }).toList(),
    onChanged: (newLangCode) {
      if (newLangCode != null) {
        final locale = Locale(newLangCode);
        context.setLocale(locale);
        Get.updateLocale(locale);
        // controller.updateLanguage(newLangCode); // Nếu có
      }
    },
    underline: Container(height: 1, color: Colors.grey),
    style: const TextStyle(color: Colors.black, fontSize: 14),
    dropdownColor: Colors.white,
    icon: const Icon(Icons.language),
  );
}
