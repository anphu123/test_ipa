import 'package:fido_box_demo01/core/assets/locale_keys.g.dart';
import 'package:fido_box_demo01/core/extensions/string_extension.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_typography.dart';
import '../../../router/app_page.dart';
import '../controllers/fido_purchase_controller.dart';
import '../widgets/fido_purchase_bottom_navigation_bar.dart';
import '../widgets/exchange_offer_card.dart';
import '../widgets/fido_purchase_appbar.dart';
import '../widgets/menu_bar.dart';
import '../widgets/purchase_info_widget.dart';
import '../widgets/seller_review_card.dart';

class FidoPurchaseView extends GetView<FidoPurchaseController> {
  const FidoPurchaseView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.white,
      body: CustomScrollView(
        slivers: [
          const FidoPurchaseSliverAppBar(),
          SliverToBoxAdapter(
            child: Transform.translate(
              offset: Offset(0, -20.h),
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: 9.r),
                margin: EdgeInsets.only(top: 16.r),
                child: Padding(
                  padding: EdgeInsets.only(top: 16.h),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      menubar(),
                      SizedBox(height: 16.h),
                      ExchangeOfferCard(),
                      SizedBox(height: 16.h),
                      Text(
                        LocaleKeys.selling_tips.trans(),
                        style: AppTypography.s16.semibold.withColor(
                          AppColors.neutral01,
                        ),
                      ),
                      SizedBox(height: 16.h),
                      PurchaseInfoWidget(),
                      SizedBox(height: 26.h),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            LocaleKeys.user_reviews.trans(),
                            style: AppTypography.s16.semibold.withColor(
                              AppColors.neutral01,
                            ),
                          ),
                          GestureDetector(
                            onTap: () {
                              Get.toNamed(Routes.sellerReview);
                            },
                            child: Text(
                              LocaleKeys.see_more.trans(),
                              style: AppTypography.s14.regular.withColor(
                                AppColors.primary01,
                              ),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 12.h),
                      SellerReviewCard(),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
      bottomNavigationBar: FidoPurchaseBottomNavigationBar(
        currentIndex: 0,
        onTap: (index) {
          // TODO: Navigate based on index
          // Example:
          switch (index) {
            case 0:
              //  Get.offAllNamed(Routes.dashboard);
              break;
            case 1:
              Get.toNamed(Routes.voucherPurchase);
              break; // current page
            case 2:
              // Navigate to favorites or other
              Get.toNamed(Routes.purchase);
              break;
            case 3:
              Get.toNamed(Routes.purchaseOrder);
              break;
          }
        },
      ),
    );
  }
}
