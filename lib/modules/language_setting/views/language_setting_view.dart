import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:easy_localization/easy_localization.dart';

import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_typography.dart';
import '../../../core/assets/locale_keys.g.dart';
import '../../../core/extensions/string_extension.dart';
import '../controllers/language_setting_controller.dart';

class LanguageSettingView extends GetView<LanguageSettingController> {
  const LanguageSettingView({super.key});

  @override
  Widget build(BuildContext context) {
    final currentLang = context.locale.languageCode;

    return Scaffold(
      backgroundColor: AppColors.neutral08,
      appBar: AppBar(
        title: Text(
          LocaleKeys.language.trans(),
          style: AppTypography.s20.medium.withColor(AppColors.neutral01),
        ),
        centerTitle: true,
        backgroundColor: AppColors.white,
        surfaceTintColor: Colors.transparent,
        elevation: 0.5,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_new_rounded),
          onPressed: () => Get.back(),
        ),
      ),
      body: _buildSection(
        title: '',
        child: Container(
          padding: EdgeInsets.symmetric(vertical: 16),
          decoration: BoxDecoration(
            color: AppColors.white,
            borderRadius: BorderRadius.circular(12),
          ),
          child: Column(
            children: [
              _buildLanguageTile(context, 'vi', '🇻🇳', LocaleKeys.vietnam.trans(), '+84', currentLang == 'vi'),
              _buildDivider(),
              _buildLanguageTile(context, 'zh', '🇨🇳', LocaleKeys.china.trans(), '+86', currentLang == 'zh'),
              _buildDivider(),
              // _buildLanguageTile(context, 'ja', '🇯🇵', 'Nhật Bản', '+81', currentLang == 'ja'),
              // _buildDivider(),
              // _buildLanguageTile(context, 'ko', '🇰🇷', 'Hàn Quốc', '+82', currentLang == 'ko'),
              // _buildDivider(),
              _buildLanguageTile(context, 'en', '🇬🇧', LocaleKeys.english.trans(), '+44', currentLang == 'en'),
            ],
          ),
        ),
      ),

    );
  }

  Widget _buildDivider() {
    return Container(
      height: 1,
      color: AppColors.neutral07,
      margin: const EdgeInsets.symmetric(horizontal: 16),
    );
  }
  Widget _buildSection({required String title, required Widget child}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: AppTypography.s14.medium.withColor(AppColors.neutral02),
        ),
        child,
      ],
    );
  }

  Widget _buildLanguageTile(
      BuildContext context,
      String langCode,
      String flag,
      String title,
      String dialCode,
      bool isSelected,
      ) {
    return InkWell(
      onTap: () {
        final locale = Locale(langCode);
        context.setLocale(locale);
        Get.updateLocale(locale);
      },
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        child: Row(
          children: [
            Icon(
              isSelected
                  ? Icons.radio_button_checked
                  : Icons.radio_button_unchecked,
              color: isSelected ? AppColors.primary01 : AppColors.neutral04,
            ),
            const SizedBox(width: 12),
            Text(flag, style: const TextStyle(fontSize: 24)),
            const SizedBox(width: 12),
            Expanded(child: Text(title, style: AppTypography.s16)),
            Text(dialCode, style: AppTypography.s16.withColor(AppColors.neutral04)),
          ],
        ),
      ),
    );
  }
}
