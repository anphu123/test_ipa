import 'package:fido_box_demo01/core/extensions/string_extension.dart';
import 'package:fido_box_demo01/modules/detail_product/widgets/faq_screen/faq_screen.dart';
import 'package:flutter/foundation.dart'
    show kIsWeb, defaultTargetPlatform, TargetPlatform;
import 'package:fido_box_demo01/core/theme/app_colors.dart';
import 'package:fido_box_demo01/core/theme/app_typography.dart';

import 'package:fido_box_demo01/modules/detail_product/widgets/detail_product_screen/bottom_action_bar.dart';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:share_plus/share_plus.dart';
import '../../../core/assets/assets.gen.dart';
import '../../../core/assets/locale_keys.g.dart';
import '../../../router/app_page.dart';
import '../widgets/detail_product_screen/after_sales_policy_card.dart';
import '../widgets/detail_product_screen/appearance_review_section.dart';
import '../widgets/detail_product_screen/brand_store_card.dart';
import '../widgets/detail_product_screen/configuration_options.dart';
import '../widgets/detail_product_screen/faq_card.dart';
import '../widgets/detail_product_screen/inspector_team_card.dart';
import '../widgets/detail_product_screen/product_detail_section.dart';
import '../widgets/detail_product_screen/product_header.dart';
import '../widgets/detail_product_screen/product_image_section.dart';
import '../widgets/detail_product_screen/quality_card.dart';
import '../widgets/detail_product_screen/seller_info_card.dart';
import 'inspection_report_screen.dart';

import '../controllers/detail_product_controller.dart';

class DetailProductScreen extends GetView<DetailProductController> {
  const DetailProductScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.white,
      body: Obx(() {
        // Chuẩn bị dữ liệu share an toàn (fallback rỗng nếu chưa có)
        final productName = (controller.product.name).toString();
        final productUrl = 'https://www.facebook.com/an.phu.783147/';

        if (controller.isLoading.value) {
          return Column(
            children: [
              _HeaderBar(productName: productName, productUrl: productUrl),
              const Expanded(child: Center(child: CircularProgressIndicator())),
            ],
          );
        }

        if (controller.errorMessage.value.isNotEmpty) {
          return Column(
            children: [
              _HeaderBar(productName: productName, productUrl: productUrl),
              Expanded(
                child: Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        Icons.error_outline,
                        size: 64.sp,
                        color: Colors.grey,
                      ),
                      SizedBox(height: 16.h),
                      Text(
                        controller.errorMessage.value,
                        style: AppTypography.s16.medium.withColor(Colors.grey),
                      ),
                      SizedBox(height: 16.h),
                      ElevatedButton(
                        onPressed: Get.back,
                        child: const Text('Quay lại'),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          );
        }

        return Column(
          children: [
            _HeaderBar(productName: productName, productUrl: productUrl),
            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    ProductImageSection(images: controller.productImages),
                    Padding(
                      padding: EdgeInsets.all(16.w),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const ConfigurationOptions(),
                          const SizedBox(height: 16),
                          const ProductHeader(),
                          const SizedBox(height: 16),
                          const QualityCard(),
                          const SizedBox(height: 16),
                          // const ProductDetailSection(
                          //   description:
                          //   "The new Gucci Jackie is crafted from premium fine leather which highlights the craftsmanship, crescent shape, and sleek silhouette of the House's iconic design.",
                          // ),
                          const SizedBox(height: 16),
                          const InspectionReportScreen(),
                          const SizedBox(height: 16),
                          // AppearanceReviewSection(
                          //   totalReviews: 129234,
                          //   imageCount: 365,
                          //   videoCount: 22,
                          //   positiveCount: 128783,
                          //   aiSummaryLines: const [
                          //     'Tổng kết đánh giá AI:',
                          //     'Ưu điểm: Ngoại hình đẹp, hiệu năng mượt mà...',
                          //     'Sáng sủa: Độ chính xác kiểm định cao (92% hài lòng)',
                          //     'Tình trạng sửa chữa: Bao phủ tốt',
                          //     'Ngoại hình: Trông gần như mới (85% chấp nhận được)',
                          //   ],
                          //   reviews: [
                          //     UserReview(
                          //       avatarUrl: 'https://i.pravatar.cc/100?img=12',
                          //       title: 'Xia***u 12G + 256G Đăng bán 13-06-2025',
                          //       content:
                          //       'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt...',
                          //     ),
                          //   ],
                          //   onTapHeader: () {
                          //     // TODO: điều hướng tới trang đánh giá chi tiết
                          //
                          //     Get.toNamed(Routes.sellerReview);
                          //   },
                          // ),
                          const SizedBox(height: 16),
                          GestureDetector(
                            onTap: ()=>Get.toNamed(Routes.brandStore),
                            child: BrandStoreCard(
                              brandName: 'Xiaomi',
                              logoAsset: Assets.images.logoXiaomi.path,
                              productAsset: Assets.images.pXiaomi15.path,
                              padding: EdgeInsets.all(8.r),
                              onViewDetail: () {
                                /* điều hướng chi tiết */
                              },
                              onGoToStore: () {
                                Get.toNamed(Routes.brandStore);
                                /* mở trang cửa hàng */
                              },
                              // accentColor: AppColors.red, // nếu bạn có màu hệ thống
                            ),
                          ),
                          const SizedBox(height: 16),
                          SellerInfoCard(
                            sellerName: 'Xi*u',
                            avatarAsset: Assets.images.avaShipper.path,
                            // hoặc avatarUrl: 'https://...'
                            onViewDetail: () {
                              // điều hướng trang chi tiết
                            },
                          ),

                          const SizedBox(height: 16),


                          const SizedBox(height: 16),
                          AfterSalesPolicyCard(
                            items: [
                              AfterSalesItem.asset(
                                assetIcon: Assets.images.icChothanhtoan.path,
                                text: LocaleKeys.free_return_shipping.trans(),
                              ),
                              AfterSalesItem.asset(
                                assetIcon: Assets.images.icChonhanhang.path,
                                text: LocaleKeys.one_year_warranty.trans(),
                              ),
                              AfterSalesItem.asset(
                                assetIcon: Assets.images.icDanggiaohang.path,
                                text: LocaleKeys.return_within_7_days.trans(),
                              ),
                              AfterSalesItem.asset(
                                assetIcon: Assets.images.icHoantien.path,
                                text: LocaleKeys.fast_refund.trans(),
                              ),
                            ],
                            onViewDetail: () {
                              /* điều hướng */
                            },
                          ),
                          const SizedBox(height: 16),
                          FaqListCard(
                            items:  [
                              FaqItemData(
                                question:
                                LocaleKeys.faq_hot_phone.trans(),
                                answer:
                                LocaleKeys.faq_hot_phone_answer.trans(),
                              ),
                              FaqItemData(
                                question:
                                LocaleKeys.faq_fast_battery_drain.trans(),
                                answer:
                                LocaleKeys.faq_fast_battery_drain_answer.trans(),
                              ),
                              FaqItemData(
                                question: LocaleKeys.faq_no_signal.trans(),
                                answer:
                                LocaleKeys.faq_no_signal_answer.trans(),
                              ),
                            ],
                            onViewDetail: () {
                              /* điều hướng chi tiết */
                              Get.to(FaqScreen());
                            },
                          ),

                          const SizedBox(height: 16),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
            const BottomActionBar(),
          ],
        );
      }),
    );
  }
}

class _HeaderBar extends StatelessWidget {
  final String productName;
  final String productUrl; // có thể rỗng nếu chưa có link

  const _HeaderBar({
    Key? key,
    required this.productName,
    required this.productUrl,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(
        top: MediaQuery.of(context).padding.top + 8.h,
        left: 16.w,
        right: 16.w,
        bottom: 8.h,
      ),
      color: AppColors.white,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          GestureDetector(
            onTap: Get.back,
            child: Icon(Icons.arrow_back_ios, size: 20.sp, color: AppColors.neutral01),
          ),
          Row(
            children: [
              SizedBox(width: 8.w),
              GestureDetector(
                onTap: () => _shareProduct(context),
                child: _iconBox(Assets.images.icShareproduct.path),
              ),
              SizedBox(width: 8.w),
              _iconBox(Assets.images.icGiohang.path),
              SizedBox(width: 8.w),
              _iconBox(Assets.images.icMore.path),
            ],
          ),
        ],
      ),
    );
  }

  Future<void> _shareProduct(BuildContext context) async {
    // Nội dung chia sẻ: nếu có link thì kèm link, không có thì chỉ tên
    final linkweb = "https://web.bendeptrai.com/";
    final text =
        productUrl.trim().isNotEmpty
            ? 'Xem sản phẩm $productName tại:2hand app nay  $productUrl xem tai web: $linkweb  ***test tính năng chia sẻ sản phẩm '
            : 'Xem sản phẩm $productName';

    // iPad/iOS cần origin rect để hiển thị popover đúng vị trí
    final renderBox = context.findRenderObject() as RenderBox?;
    final origin =
        renderBox != null
            ? renderBox.localToGlobal(Offset.zero) & renderBox.size
            : const Rect.fromLTWH(0, 0, 0, 0);

    try {
      if (kIsWeb) {
        await Share.share(text, subject: LocaleKeys.share_product.trans());
        return;
      }

      // Android/iOS/macOS/Windows/Linux — share_plus sẽ mở menu share hệ thống
      // Với iOS (đặc biệt iPad), thêm sharePositionOrigin để tránh crash/hiển thị sai
      if (defaultTargetPlatform == TargetPlatform.iOS) {
        await Share.share(
          text,
          subject: LocaleKeys.share_product.trans(),
          sharePositionOrigin: origin,
        );
      } else {
        await Share.share(text, subject: LocaleKeys.share_product.trans());
      }
    } catch (_) {
      // Fallback an toàn
      await Share.share(text, subject:  LocaleKeys.share_product.trans());
    }
  }

  Widget _iconBox(String assetPath) => Container(
    padding: EdgeInsets.all(8.w),
    // decoration: BoxDecoration(
    //   color: Colors.grey[100],
    //   borderRadius: BorderRadius.circular(8.r),
    // ),
    child: Image.asset(assetPath,width: 24.h,height: 24.w,color: AppColors.neutral01,),
  );
}
