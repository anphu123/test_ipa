import 'package:fido_box_demo01/core/extensions/string_extension.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../core/assets/assets.gen.dart';
import '../../../core/assets/locale_keys.g.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_typography.dart';
import '../../support_center/widgets/support_more_info_section.dart';
import '../controllers/answer_detail_controller.dart';

class AnswerDetailView extends GetView<AnswerDetailController> {
  AnswerDetailView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.neutral08,
      appBar: AppBar(
        backgroundColor: AppColors.white,
        surfaceTintColor: Colors.transparent,
        elevation: 0.5,
        centerTitle: true,
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios_new_rounded),
          onPressed: () => Get.back(),
        ),
        title: Container(
          decoration: BoxDecoration(
            color: AppColors.white,
            borderRadius: BorderRadius.circular(8),
            border: Border.all(color: AppColors.neutral04),
          ),
          child: TextField(
            style: AppTypography.s14.regular.withColor(AppColors.neutral01),
            decoration: InputDecoration(
              hintText: LocaleKeys.search_placeholder.trans(),
              hintStyle: AppTypography.s14.regular.withColor(
                AppColors.neutral04,
              ),
              border: InputBorder.none,
              icon: Padding(
                padding: EdgeInsets.only(left: 4),
                child: Image.asset(
                  Assets.images.icSearch.path,
                  width: 20,
                  height: 20,
                  color: AppColors.neutral04,
                ),
              ),
            ),
          ),
        ),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // 🧭 Breadcrumb
            Text(
            LocaleKeys.support_path.trans(),
              style: AppTypography.s12.regular.withColor(AppColors.primary01),
            ),
            SizedBox(height: 12),

            // 📰 Tiêu đề
            Text(
                LocaleKeys.scam_alert.trans(),
              style: AppTypography.s20.bold.withColor(AppColors.neutral02),
            ),
            SizedBox(height: 16),

            // 📄 Danh sách bài viết gợi ý
            ListView.separated(
              shrinkWrap: true,
              physics: NeverScrollableScrollPhysics(),
              itemCount: 3,
              separatorBuilder: (_, __) => SizedBox(height: 12),
              itemBuilder:
                  (_, index) => Container(
                    padding: EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      color: AppColors.white,
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Row(
                      children: [
                        CircleAvatar(
                          backgroundImage: AssetImage(Assets.images.bear1.path),
                          radius: 28,
                          backgroundColor: AppColors.neutral05,
                        ),
                        SizedBox(width: 12),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                LocaleKeys.account_support.trans(),
                                style: AppTypography.s14.medium.withColor(
                                  AppColors.neutral01,
                                ),
                              ),
                              SizedBox(height: 4),
                              Text(
                                'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua',
                                style: AppTypography.s12.regular.withColor(
                                  AppColors.neutral03,
                                ),
                                maxLines: 2,
                                overflow: TextOverflow.ellipsis,
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
            ),
            SizedBox(height: 24),

            // 📚 Bài viết liên quan
            Container(
              padding: EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: AppColors.white,
                borderRadius: BorderRadius.circular(12),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    LocaleKeys.related_articles.trans(),
                    style: AppTypography.s14.medium.withColor(
                      AppColors.neutral01,
                    ),
                  ),
                  SizedBox(height: 12),
                  ...List.generate(
                    4,
                    (index) => Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: EdgeInsets.symmetric(vertical: 12),
                          child: Text(
                            'Lorem ipsum dolor sit amet consectetur',
                            style: AppTypography.s12.regular.withColor(
                              AppColors.neutral01,
                            ),
                          ),
                        ),
                        if (index != 3)
                          Divider(color: AppColors.neutral07, height: 1),
                      ],
                    ),
                  ),


                ],
              ),
            ),
            SizedBox(height: 24),
            SupportMoreInfoSection(),
          ],
        ),
      ),
    );
  }
}
