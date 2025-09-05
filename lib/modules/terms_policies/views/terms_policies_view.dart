import 'package:fido_box_demo01/core/extensions/string_extension.dart';
import 'package:fido_box_demo01/modules/support_center/widgets/support_more_info_section.dart';
import 'package:fido_box_demo01/modules/terms_policies/controllers/terms_policies_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../core/assets/locale_keys.g.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_typography.dart';

class TermsPoliciesView extends GetView<TermsPoliciesController> {
  const TermsPoliciesView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.white,
      appBar: AppBar(
        title: Text(
          LocaleKeys.privacy_policy.trans(),
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
            // Breadcrumb
            Text(
              LocaleKeys.support_path_policy.trans(),
              style: AppTypography.s12.regular.withColor(AppColors.primary01),
            ),
            const SizedBox(height: 16),

            // Main content container
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Title
                Text(
                  LocaleKeys.terms_2hand.trans(),
                  style: AppTypography.s20.bold.withColor(AppColors.neutral02),
                ),
                const SizedBox(height: 16),

                // Subtitle
                Text(
                  LocaleKeys.general_terms.trans(),
                  style: AppTypography.s16.semibold.withColor(
                    AppColors.neutral02,
                  ),
                ),
                const SizedBox(height: 12),

                // Terms list
                ...List.generate(
                  10,
                  (index) => Padding(
                    padding: const EdgeInsets.symmetric(
                      vertical: 8,
                      horizontal: 12,
                    ),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          width: 4,
                          height: 4,
                          margin: const EdgeInsets.only(top: 8, right: 8),
                          decoration: BoxDecoration(
                            color: AppColors.AB01,
                            shape: BoxShape.circle,
                          ),
                        ),
                        Expanded(
                          child: GestureDetector(
                            onTap: () {
                              // Navigate to detail
                            },
                            child: Text(
                              _getTermTitle(index),
                              style: AppTypography.s12.regular.withColor(
                                AppColors.AB01,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),

                const SizedBox(height: 32),
                SupportMoreInfoSection(),
              ],
            ),
          ],
        ),
      ),
    );
  }

  String _getTermTitle(int index) {
    final titles = [
      LocaleKeys.service_terms.trans(),
      LocaleKeys.service_terms.trans(),
      LocaleKeys.service_terms.trans(),
      LocaleKeys.service_terms.trans(),
      'Chính sách bảo mật',
      LocaleKeys.operating_regulations.trans(),
    LocaleKeys.product_posting_rules.trans(),

    ];
    return titles[index % titles.length];
  }
}
