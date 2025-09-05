import 'package:fido_box_demo01/core/common_widget/search_bar_2.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:marquee/marquee.dart';

import '../../../../core/common_widget/currency_util.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_typography.dart';
import '../../../home/widgets/banner_sale.dart';
import '../../controllers/open_market_controller.dart';
import '../../domain/model/highlighted_model.dart';
import 'category_highlighted.dart';

class HighlightedFilterView extends StatefulWidget {
  const HighlightedFilterView({super.key});

  @override
  State<HighlightedFilterView> createState() => _HighlightedFilterViewState();
}

class _HighlightedFilterViewState extends State<HighlightedFilterView> {
  final controller = Get.find<OpenMarketController>();

  @override
  Widget build(BuildContext context) {
    return CustomScrollView(
      slivers: [
        // Search bar
        SliverToBoxAdapter(
          child: Padding(
            padding: EdgeInsets.symmetric(vertical: 8.h, horizontal: 12.w),
            child: CustomSearchBar2(),
          ),
        ),

        // Banner + Category
        SliverToBoxAdapter(
          child: Padding(
            padding: EdgeInsets.symmetric(vertical: 8.h, horizontal: 12.w),
            child: Column(
              children: [
                SizedBox(height: 8.h),
                _buildFollowBanner(),

                CategoryHighLighted(),
              ],
            ),
          ),
        ),

        // Banner
        const BannerSection(),

        // Grid Items
        SliverToBoxAdapter(
          child: Column(
            children: [
              SizedBox(height: 20.h),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 8.h),
                child: GridView.builder(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: controller.highlightedItems.length,
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 3,
                    mainAxisSpacing: 10.h,
                    crossAxisSpacing: 12.w,
                    childAspectRatio: 0.80,
                  ),
                  itemBuilder: (context, index) {
                    final highlighted = controller.highlightedItems[index];
                    return _buildHighlightedItem(highlighted);
                  },
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildHighlightedItem(HighlightedModel item) {
    return Column(
//      crossAxisAlignment: CrossAxisAlignment.start,

      children: [
        //SizedBox(height: 6.h),
        AspectRatio(
          aspectRatio: 1,
          child: ClipRRect(
            borderRadius: BorderRadius.circular(8.r),
            child: Image(
              image:
                  item.imageUrl.startsWith('http')
                      ? NetworkImage(item.imageUrl)
                      : AssetImage(item.imageUrl) as ImageProvider,
              width: 30.w,
              height: 30.w,
              fit: BoxFit.cover,
              errorBuilder:
                  (_, __, ___) => Icon(Icons.image_not_supported, size: 20.sp),
            ),
            // child: Image.network(
            //   item.imageUrl,
            //   fit: BoxFit.cover,
            //   errorBuilder: (_, __, ___) => const Icon(Icons.error),
            // ),
          ),
        ),
        SizedBox(height: 6.h),

        Text(
          formatCurrency(item.price),
          style: AppTypography.s12.bold.withColor(AppColors.neutral01),
        ),
      ],
    );
  }

  Widget _buildFollowBanner() {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 2.h, horizontal: 12.w),
      decoration: BoxDecoration(
        color: AppColors.AW02,
        borderRadius: BorderRadius.circular(4.r),
      ),
      child: Row(
        children: [
          Expanded(
            child: SizedBox(
              height: 20.h,
              child: Marquee(
                text:
                    'Cửa hàng mua bán tự do, chưa qua kiểm định. Mọi người giao dịch vui lòng chú ý.',
                style: AppTypography.s12.regular.withColor(AppColors.AW01),
                velocity: 30.0,
                blankSpace: 40.0,
                startPadding: 10.0,
                pauseAfterRound: const Duration(seconds: 1),
                fadingEdgeStartFraction: 0.1,
                fadingEdgeEndFraction: 0.1,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
