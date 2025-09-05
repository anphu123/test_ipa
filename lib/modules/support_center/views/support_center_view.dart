import 'package:fido_box_demo01/core/extensions/string_extension.dart';
import 'package:fido_box_demo01/modules/support_center/controllers/support_center_controller.dart';
import 'package:fido_box_demo01/modules/support_center/widgets/support_faq_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../../core/assets/assets.gen.dart';
import '../../../core/assets/locale_keys.g.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_typography.dart';
import '../widgets/support_account_help_section.dart';
import '../widgets/support_greeting_section.dart';
import '../widgets/support_highlight_button.dart';
import '../widgets/support_more_info_section.dart';
import '../widgets/support_search_box.dart';

class SupportCenterView extends GetView<SupportCenterController> {
  const SupportCenterView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.neutral08,
      appBar: AppBar(
        title: Text(
            LocaleKeys.support_center.trans(),
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
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: const [
            SupportGreetingSection(),
            SizedBox(height: 16),
            SupportSearchBox(),
            SizedBox(height: 16),
            SupportHighlightButton(),
            SizedBox(height: 24),
            SupportAccountHelpSection(),
            SizedBox(height: 24),
            SupportFaqView(),
            SizedBox(height: 24),
            SupportMoreInfoSection(),
          ],
        ),
      ),
    );
  }
}
