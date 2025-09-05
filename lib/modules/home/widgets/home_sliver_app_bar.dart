import 'package:easy_localization/easy_localization.dart';
import 'package:fido_box_demo01/core/extensions/string_extension.dart';
import 'package:fido_box_demo01/core/theme/app_colors.dart';
import 'package:fido_box_demo01/core/theme/app_typography.dart';
import 'package:fido_box_demo01/modules/home/controllers/home_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import '../../../core/assets/assets.gen.dart';
import '../../../core/assets/locale_keys.g.dart';
import '../../../router/app_page.dart';

class HomeSliverAppBar extends StatelessWidget {
  HomeSliverAppBar({super.key});

  @override
  Widget build(BuildContext context) {
    return SliverToBoxAdapter(
      child: Container(
        color: Colors.white,
        margin: EdgeInsets.only(top: 24.h),
        padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 8.h),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [_TopRow()],
        ),
      ),
    );
  }
}

class _GreetingSection extends StatelessWidget {
  final controller = Get.find<HomeController>();

  @override
  Widget build(BuildContext context) {
    return Obx(
          () => controller.isLoggedIn.value
          ? Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(height: 4.h),
          RichText(
            text: TextSpan(
              style: AppTypography.s16.bold,
              children: [
                TextSpan(
                  text: '${LocaleKeys.hello.trans()}, ',
                  style: AppTypography.s16.bold.copyWith(
                    color: AppColors.neutral02,
                  ),
                ),
                TextSpan(
                  text: '${controller.username.value} !',
                  style: AppTypography.s16.bold.copyWith(
                    color: AppColors.primary01,
                  ),
                ),
              ],
            ),
          ),
          SizedBox(height: 4.h),
          Text(
            LocaleKeys.welcome.trans(),
            style: AppTypography.s12.regular.withColor(AppColors.neutral02),
          ),
        ],
      )
          : const SizedBox.shrink(),
    );
  }
}

class _TopRow extends StatelessWidget {
  final controller = Get.find<HomeController>();
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        _GreetingSection(),
        Row(
          children: [
            // _IconBox(
            //   assetPath: Assets.images.icMessage.path,
            //   onTap: () {
            //     controller.requireLogin(() {
            //       Get.toNamed(Routes.mailbox);
            //     });
            //   },
            // ),
            const _LanguageSelector(),
            // SizedBox(width: 8.w),
            // //   _IconBox(assetPath: Assets.images.icNotification.path),
            //
            // _IconBox(assetPath: Assets.images.icMessage.path),
          ],
        ),
      ],
    );
  }
}

class _IconBox extends StatelessWidget {
  final String assetPath;
  final VoidCallback onTap;

  const _IconBox({required this.assetPath, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 32.w,
      height: 32.w,
      child: DecoratedBox(
        decoration: BoxDecoration(
          color: AppColors.white,
          borderRadius: BorderRadius.circular(8.r),
        ),
        child: InkWell(
          onTap: onTap,
          child: Padding(
            padding: EdgeInsets.all(6.r),
            child: Image.asset(
              assetPath,
              width: 20.w,
              height: 20.h,
              color: AppColors.primary01,
            ),
          ),
        ),
      ),
    );
  }
}
class _LanguageSelector extends StatelessWidget {
  const _LanguageSelector({super.key});

  @override
  Widget build(BuildContext context) {
    final locale = context.locale.languageCode;

    return PopupMenuButton<String>(
      icon: _buildFlagIcon(locale),
      itemBuilder: (_) => [
        _buildLanguageItem(context, 'vi', 'Tiếng Việt', '🇻🇳'),
        _buildLanguageItem(context, 'en', 'Tiếng Anh', '🇺🇸'),
        _buildLanguageItem(context, 'zh', 'Tiếng Trung', '🇨🇳'),
      ],
      onSelected: (langCode) {
        final newLocale = Locale(langCode);
        context.setLocale(newLocale);
        Get.updateLocale(newLocale);
      },
      color: AppColors.white,
    );
  }

  Widget _buildFlagIcon(String langCode) {
    final flagEmoji = {
      'vi': '🇻🇳',
      'en': '🇺🇸',
      'zh': '🇨🇳',
    }[langCode] ?? '🌐';

    return Container(
    //  padding: const EdgeInsets.all(6),
      decoration: BoxDecoration(
      //  color: Colors.red,
        borderRadius: BorderRadius.circular(8),
      ),
      child: Text(flagEmoji, style: const TextStyle(fontSize: 24)),
    );
  }

  PopupMenuItem<String> _buildLanguageItem(
      BuildContext context,
      String langCode,
      String label,
      String emoji,
      ) {
    return PopupMenuItem<String>(
      value: langCode,
      child: Row(
        children: [
          Text(emoji, style: const TextStyle(fontSize: 18)),
          const SizedBox(width: 8),
          Text(label),
        ],
      ),
    );
  }
}
