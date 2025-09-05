import 'package:fido_box_demo01/core/assets/locale_keys.g.dart';
import 'package:fido_box_demo01/core/extensions/string_extension.dart';
import 'package:fido_box_demo01/modules/community_standards/controllers/community_standards_controller.dart';
import 'package:fido_box_demo01/modules/support_center/widgets/support_more_info_section.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_typography.dart';
import '../domain/community_standard_model.dart';

class CommunityStandardsView extends GetView<CommunityStandardsController> {
  const CommunityStandardsView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.white,
      appBar: AppBar(
        title: Text(
          LocaleKeys.community_standards.trans(),
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
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // 📌 Breadcrumb
            Text(
              LocaleKeys.seller_channel.trans(),
              style: AppTypography.s12.regular.withColor(AppColors.primary01),
            ),
            const SizedBox(height: 12),

            // 📌 Tiêu đề chính
            Text(
              LocaleKeys.community_standards.trans(),
              style: AppTypography.s20.bold.withColor(AppColors.neutral02),
            ),
            const SizedBox(height: 12),

            // 📌 Giới thiệu
            Text(
              controller.introText,
              style: AppTypography.s12.regular.withColor(AppColors.neutral01),
            ),
            const SizedBox(height: 12),

            // ✅ Những việc nên làm
            _buildSectionTitle(  LocaleKeys.things_to_do.trans(), AppColors.AS01),
            const SizedBox(height: 12),
            ...controller.shouldDo.map(_buildItem).toList(),

            const SizedBox(height: 24),

            // ❌ Những việc không nên làm
            _buildSectionTitle(  LocaleKeys.things_not_to_do.trans(), AppColors.AS01),
            const SizedBox(height: 12),
            ...controller.shouldNotDo.map(_buildItem).toList(),
            const SizedBox(height: 24),
            SupportMoreInfoSection(),
          ],
        ),
      ),
    );
  }

  Widget _buildSectionTitle(String text, Color color) {
    return Column(
      children: [
        //  _DashedDivider(),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8),
          child: Text(
            text,
            style: AppTypography.s20.bold.copyWith(color: color),
          ),
        ),
        const SizedBox(height: 12),
        _DashedDivider(),
      ],
    );
  }


  Widget _buildItem(CommunityStandardModel item) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 12),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            item.title,
            style: AppTypography.s14.bold.withColor(AppColors.neutral01),
          ),
          const SizedBox(height: 4),
          Text(
            item.description,
            style: AppTypography.s13.regular.withColor(AppColors.neutral03),
          ),
        ],
      ),
    );
  }
}
class _DashedDivider extends StatelessWidget {
  const _DashedDivider();

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final dashWidth = 5.0;
        final dashSpace = 3.0;
        final dashCount = (constraints.maxWidth / (dashWidth + dashSpace)).floor();

        return Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: List.generate(dashCount, (_) {
            return Container(
              width: dashWidth,
              height: 1,
              color: AppColors.neutral05,
            );
          }),
        );
      },
    );
  }
}
