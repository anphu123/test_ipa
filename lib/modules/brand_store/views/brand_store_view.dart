import 'package:fido_box_demo01/core/extensions/string_extension.dart';
import 'package:fido_box_demo01/core/theme/app_colors.dart';
import 'package:fido_box_demo01/core/theme/app_typography.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../../core/assets/assets.gen.dart';
import '../../../core/assets/locale_keys.g.dart';
import '../../../core/common_widget/currency_util.dart';
import '../controllers/brand_store_controller.dart';
import '../widgets/sort_tabs_row.dart';

class BrandStoreView extends GetView<BrandStoreController> {
  const BrandStoreView({super.key});

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      return Scaffold(
        backgroundColor: AppColors.white,
        body: CustomScrollView(
          slivers: [
            SliverAppBar(
              systemOverlayStyle: SystemUiOverlayStyle.light,
              expandedHeight: 300,
              pinned: false,
              backgroundColor: Colors.transparent,
              elevation: 0,
              shadowColor: Colors.transparent,
              surfaceTintColor: Colors.transparent,
              centerTitle: false,
              leading: IconButton(
                icon: const Icon(Icons.arrow_back_ios),
                color: Colors.white,
                onPressed: Get.back,
              ),
              title: Text(
                controller.brandName,
                style: AppTypography.s16.medium.withColor(AppColors.white),
              ),
              actions: [
                const Icon(Icons.search, color: Colors.white),
                const SizedBox(width: 12),
                Image.asset(Assets.images.icMore.path, color: AppColors.white),
                const SizedBox(width: 8),
              ],
              flexibleSpace: FlexibleSpaceBar(
                collapseMode: CollapseMode.parallax,
                background: _BannerHeader(controller: controller),
              ),
              titleTextStyle: const TextStyle(color: Colors.white, fontSize: 16),
              iconTheme: const IconThemeData(color: Colors.white),
            ),

            // Dải danh mục con (ngang)
            SliverToBoxAdapter(child: SizedBox(height: 24.w)),
            SliverToBoxAdapter(child: _SubCategories(controller: controller)),
            const SliverToBoxAdapter(child: Divider(height: 16)),

            // Tabs chính
            SliverToBoxAdapter(child: _TabsRow(controller: controller)),
            const SliverToBoxAdapter(child: SizedBox(height: 14)),

            // Hàng "Tổng hợp | Mẫu sản phẩm | Giá cả | Lọc"
            const SliverToBoxAdapter(child: SortTabsRow()),
            const SliverToBoxAdapter(child: SizedBox(height: 8)),

            // Filter chips
            SliverToBoxAdapter(child: _FilterRow(controller: controller)),
            const SliverToBoxAdapter(child: SizedBox(height: 8)),

            // Danh sách sản phẩm
            SliverList(
              delegate: SliverChildBuilderDelegate(
                    (context, i) => _ProductItem(
                  product: controller.products[i],
               //   formatCurrency: controller.formatCurrency,
                ),
                childCount: controller.products.length,
              ),
            ),
            const SliverToBoxAdapter(child: SizedBox(height: 16)),
          ],
        ),
      );
    });
  }
}

// ================== Banner ==================
class _BannerHeader extends StatelessWidget {
  const _BannerHeader({required this.controller});
  final BrandStoreController controller;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Positioned.fill(
          child: Image.network(
            controller.brandBanner,
            fit: BoxFit.cover,
            errorBuilder: (_, __, ___) => Container(color: Colors.grey.shade300),
          ),
        ),
        Positioned.fill(child: Container()),
        Positioned.fill(
          child: Padding(
            padding: const EdgeInsets.fromLTRB(16, 0, 16, 14),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.end,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      controller.brandName,
                      style: const TextStyle(
                          color: Colors.white, fontSize: 28, fontWeight: FontWeight.w700),
                    ),
                  ],
                ),
                Text(
                  LocaleKeys.welcome_message.trans(),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  textAlign: TextAlign.center,
                  style: TextStyle(color: Colors.white.withOpacity(0.9)),
                ),
                const SizedBox(height: 12),
                OutlinedButton.icon(
                  onPressed: () {},
                  icon: const Icon(Icons.add, size: 18),
                  label:  Text( LocaleKeys.follow.trans(), style: TextStyle(fontSize: 14, fontWeight: FontWeight.w500)),
                  style: OutlinedButton.styleFrom(
                    side: const BorderSide(color: Colors.white, width: 1.2),
                    foregroundColor: Colors.white,
                    padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}

// ================== Sub-categories ==================
class _SubCategories extends StatelessWidget {
  const _SubCategories({required this.controller});
  final BrandStoreController controller;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 92,
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        padding: const EdgeInsets.symmetric(horizontal: 12),
        itemCount: controller.subCats.length,
        separatorBuilder: (_, __) => const SizedBox(width: 10),
        itemBuilder: (_, i) {
          final it = controller.subCats[i];
          return Column(
            children: [
              SizedBox(
                width: 46, height: 46,
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(10),
                  child: Image.network(
                    it['icon']!, fit: BoxFit.contain,
                    errorBuilder: (_, __, ___) => Container(color: Colors.grey.shade200),
                  ),
                ),
              ),
              const SizedBox(height: 6),
              Text(it['name']!, style: AppTypography.s12.semibold.withColor(AppColors.neutral02)),
            ],
          );
        },
      ),
    );
  }
}

// ================== Tabs chính ==================
class _TabsRow extends StatelessWidget {
  const _TabsRow({required this.controller});
  final BrandStoreController controller;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 12.r),
      child: SizedBox(
        height: 40,
        child: SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Obx(() => Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: List.generate(controller.tabs.length, (i) {
              final isActive = controller.selectedMainTab.value == i;
              return Padding(
                padding: EdgeInsets.only(right: i == controller.tabs.length - 1 ? 0 : 16),
                child: InkWell(
                  onTap: () => controller.changeMainTab(i),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Text(
                        controller.tabs[i],
                        style: isActive
                            ? AppTypography.s16.semibold.withColor(AppColors.primary01)
                            : AppTypography.s16.semibold.withColor(AppColors.neutral02),
                      ),
                      const SizedBox(height: 6),
                      Container(
                        width: 28, height: 2,
                        color: isActive ? AppColors.primary01 : Colors.transparent,
                      ),
                    ],
                  ),
                ),
              );
            }),
          )),
        ),
      ),
    );
  }
}

// ================== Filter row & Product item (giữ nguyên) ==================
class _FilterRow extends StatelessWidget {
  const _FilterRow({required this.controller});
  final BrandStoreController controller;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      padding: const EdgeInsets.symmetric(horizontal: 12),
      child: Row(
        children: [
          for (final f in controller.filters)
            Padding(
              padding: const EdgeInsets.only(right: 8),
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
                decoration: BoxDecoration(
                  color: AppColors.neutral07,
                  borderRadius: BorderRadius.circular(4.r),
                ),
                child: Text(f, style: AppTypography.s16.regular.withColor(AppColors.neutral04)),
              ),
            ),
        ],
      ),
    );
  }
}

class _ProductItem extends StatelessWidget {
  const _ProductItem({required this.product,});
  final Map<String, dynamic> product;

  @override
  Widget build(BuildContext context) {

    final discount = product['discountPercent'] as int?;

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      child: Card(
        color: Colors.white,
        clipBehavior: Clip.antiAlias,
        elevation: 0.6,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        child: Padding(
          padding: const EdgeInsets.all(10),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(8),
                child: Image.network(
                  product['image'], width: 86, height: 86, fit: BoxFit.cover,
                  errorBuilder: (_, __, ___) => Container(width: 86, height: 86, color: Colors.grey.shade200),
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // tiêu đề
                    Text(product['name'],
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                        style: AppTypography.s14.semibold.withColor(AppColors.neutral02),),
                    const SizedBox(height: 6),
                    Text(product['variant'],
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      style: AppTypography.s14.semibold.withColor(AppColors.neutral02),),
                    const SizedBox(height: 6),
                    Text(
                      product['desc'],
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                        style: AppTypography.s12.regular.withColor(AppColors.neutral04)
                    ),
                    const SizedBox(height: 8),
                    Row(
                      children: [
                        Text(formatCurrency(product['price'] as num),
                            style:AppTypography.s20.bold.withColor(AppColors.primary01)),
                        if (discount != null) ...[
                          const SizedBox(width: 8),
                          Container(
                            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                            decoration: BoxDecoration(
                              color: AppColors.AE02,
                              borderRadius: BorderRadius.circular(14),
                            ),
                            child: Text('${  LocaleKeys.discount_price.trans()} $discount%',
                                style:AppTypography.s10.bold.withColor(AppColors.AE01)),
                          ),
                        ],
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
