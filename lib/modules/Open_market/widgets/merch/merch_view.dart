import 'package:fido_box_demo01/modules/Open_market/widgets/merch/verified_market_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import '../../../../core/common_widget/currency_util.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_typography.dart';
import '../../controllers/open_market_controller.dart';
import '../../domain/model/merch_product_model.dart';
import 'artist_filter.dart';
import 'artist_list_view.dart';

class MerchView extends GetView<OpenMarketController> {
  const MerchView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CustomScrollView(
      slivers: [
        SliverToBoxAdapter(
          child: Column(
            children: [
              ArtistListView(),
              SizedBox(height: 18.h),
              VerifiedMarketView(),
              SizedBox( height: 12.h),
              ArtistFilter(),
              SizedBox( height: 12.h),
              Obx(() {
                final filtered = controller.filteredProducts;
                return Padding(
                  // padding: const EdgeInsets.all(8.0),
                  padding: EdgeInsets.symmetric(horizontal: 12.w),
                  child: GridView.builder(
                    shrinkWrap: true,
                    physics: NeverScrollableScrollPhysics(),
                    itemCount: filtered.length,
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 3,
                      mainAxisSpacing: 10.h,
                      crossAxisSpacing: 12.w,
                      childAspectRatio: 0.80,
                    ),
                    itemBuilder: (context, index) {
                      final product = filtered[index];
                      return _buildMerchItem(product);
                    },
                  ),
                );
              }),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildMerchItem(MerchProduct products) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        AspectRatio(
          aspectRatio: 1,
          child: ClipRRect(
            borderRadius: BorderRadius.circular(8.r),
            child: Image.network(
              products.imageUrl,
              fit: BoxFit.cover,
              errorBuilder: (_, __, ___) => const Icon(Icons.error),
            ),
          ),
        ),
        SizedBox(height: 6.h),
        Text(
          formatCurrency(products.price),
          style: AppTypography.s12.bold.withColor(AppColors.neutral01),
        ),
      ],
    );
  }
}
