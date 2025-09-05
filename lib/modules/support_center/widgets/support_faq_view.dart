import 'package:fido_box_demo01/core/extensions/string_extension.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../core/assets/locale_keys.g.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_typography.dart';
import '../../../router/app_page.dart';
import '../controllers/support_center_controller.dart';

class SupportFaqView extends GetView<SupportCenterController> {
  const SupportFaqView({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
     // margin: const EdgeInsets.all(16),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildHeader(),
          const SizedBox(height: 8),
          TabBar(
            tabAlignment: TabAlignment.start,
            controller: controller.tabController,
            isScrollable: true,
            labelColor: AppColors.primary01,
            unselectedLabelColor: AppColors.neutral03,
            indicatorColor: AppColors.primary01,
            labelStyle: AppTypography.s14.bold,
            tabs: controller.tabs.map((tab) => Tab(text: tab)).toList(),
            onTap: (index) => controller.currentTabIndex.value = index,
          ),
          const SizedBox(height: 8),
          Obx(() {
            final faqs = controller.getFaqsByTabIndex(controller.currentTabIndex.value);
            final isExpandable = faqs.length > 4;
            final displayFaqs = isExpandable && !controller.isExpanded.value
                ? faqs.take(4).toList()
                : faqs;

            return Column(
              children: [
                ListView.separated(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: displayFaqs.length,
                  separatorBuilder: (_, __) => Container(
                    height: 1,
                    width: double.infinity,
                    color: AppColors.neutral06,
                  ),
                  itemBuilder: (_, i) {
                    final faq = displayFaqs[i];
                    return ListTile(
                      title: Text(
                        faq.question,
                        style: AppTypography.s12.regular.withColor(AppColors.neutral01),
                      ),
                      onTap: () {
                        // 👇 Mở bottom sheet để xem chi tiết
                        Get.toNamed(Routes.answerDetails);
                      },
                    );
                  },
                ),

                if (isExpandable)
                                    GestureDetector(
                    onTap: controller.toggleExpand,
                    child: Container(
                      padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Icon(
                            controller.isExpanded.value
                                ? Icons.expand_less
                                : Icons.expand_more,
                            size: 18,
                            color: AppColors.neutral04,
                          ),
                          const SizedBox(width: 4),
                          Text(
                            controller.isExpanded.value ? 'Thu gọn' :  LocaleKeys.see_more.trans(),
                            style: AppTypography.s10.regular.withColor(AppColors.neutral04),
                          ),
                        ],
                      ),
                    ),
                  )
              ],
            );
          }),
        ],
      ),
    );
  }

  Widget _buildHeader() {
    return Row(
      children: [
        Text( LocaleKeys.faq.trans(), style: AppTypography.s16.bold),
        const Spacer(),
        Text( LocaleKeys.category.trans(), style: AppTypography.s14.withColor(AppColors.neutral03)),
        const Icon(Icons.arrow_forward_ios_rounded, size: 16, color: AppColors.neutral03),
      ],
    );
  }
}
