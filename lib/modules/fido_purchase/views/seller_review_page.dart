import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_typography.dart';
import '../../../core/assets/locale_keys.g.dart';
import '../../../core/extensions/string_extension.dart';

import '../controllers/seller_review_page_controller.dart';
import '../widgets/seller_review_card.dart';

class SellerReviewPage extends StatelessWidget {
  const SellerReviewPage({super.key});

  @override
  Widget build(BuildContext context) {
    // BINDING: đảm bảo có đúng 1 instance controller dùng chung
    Get.lazyPut<SellerReviewPageController>(() => SellerReviewPageController(),
        fenix: true);

    return Scaffold(
      backgroundColor: AppColors.white,
      appBar: AppBar(
        surfaceTintColor: Colors.transparent,
        backgroundColor: AppColors.white,
        elevation: 0,
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: AppColors.neutral01),
          onPressed: () => Get.back(),
        ),
        title: Text(
          LocaleKeys.user_reviews.trans(),
          style: AppTypography.s18.semibold.withColor(AppColors.neutral01),
        ),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 12.h),
        child: const SellerReviewCard(),
      ),
    );
  }
}
