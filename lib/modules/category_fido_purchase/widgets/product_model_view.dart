import 'package:fido_box_demo01/core/assets/locale_keys.g.dart';
import 'package:fido_box_demo01/core/extensions/string_extension.dart';
import 'package:fido_box_demo01/core/theme/app_colors.dart';
import 'package:fido_box_demo01/core/theme/app_typography.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import '../../../core/assets/assets.gen.dart';
import '../../../router/app_page.dart';
import '../../home/domain/model/category_model.dart';
import '../domain/brand_model.dart';
import '../domain/model_variant.dart';
import '../domain/product_model.dart';

class BrandModelView extends StatefulWidget {
  final BrandModel brand;

  const BrandModelView({super.key, required this.brand});

  @override
  State<BrandModelView> createState() => _BrandModelViewState();
}

class _BrandModelViewState extends State<BrandModelView> {
  final TextEditingController _searchController = TextEditingController();

  int selectedTabIndex = 0;
  String? selectedProductName;
  String searchQuery = '';

  @override
  Widget build(BuildContext context) {
    final allProducts = widget.brand.products ?? [];

    // Filter theo dòng máy được chọn
    List<ModelVariant> flatModelList = [];

    for (var product in allProducts) {
      if (selectedProductName == null || product.name == selectedProductName) {
        flatModelList.addAll(product.variants);
      }
    }

    // Filter theo tìm kiếm
    final displayedModels =
        flatModelList.where((v) {
          return v.name.toLowerCase().contains(searchQuery.toLowerCase());
        }).toList();

    return Scaffold(
      backgroundColor: AppColors.neutral08,
      appBar: AppBar(
        title: Text(LocaleKeys.used_machine_valuation.trans()),
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios),
          onPressed: () => Get.back(),
        ),
        centerTitle: true,
      ),
      body: Column(
        children: [
          _buildSearchBar(),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Align(
              alignment: Alignment.centerLeft,
              child: Text(LocaleKeys.hot_model_purchased.trans(),style: AppTypography.s16.semibold.withColor(AppColors.neutral01),),
            ),
          ),
          _buildTopPopularModels(flatModelList),
          SizedBox(height: 16.h),
          _buildGenerationTabs(allProducts),
          const SizedBox(height: 8),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Align(
              alignment: Alignment.centerLeft,
              child: Text(LocaleKeys.all_orders.trans(),style: AppTypography.s16.semibold.withColor(AppColors.neutral01),),
            ),
          ),

          Expanded(child: _buildModelList(displayedModels)),
        ],
      ),
    );
  }

  Widget _buildSearchBar() {
    return Padding(
      padding: const EdgeInsets.all(12),
      child: TextField(
        controller: _searchController,
        onChanged: (val) {
          setState(() => searchQuery = val);
        },
        decoration: InputDecoration(
          hintText: 'Tìm mẫu máy...',
          prefixIcon: const Icon(Icons.search),
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
        ),
      ),
    );
  }
  Widget _buildTopPopularModels(List<ModelVariant> models) {
  final topModels = models.take(3).toList();

  final badgeAssets = [
    Assets.images.icTop1.path,
    Assets.images.icTop2.path,
    Assets.images.icTop3.path,
  ];

  return SizedBox(
    height: 150,
    child: ListView.builder(
      padding: const EdgeInsets.symmetric(horizontal: 12),
      scrollDirection: Axis.horizontal,
      itemCount: topModels.length,
      itemBuilder: (_, index) {
        final model = topModels[index];
        final badgeImage = badgeAssets[index % badgeAssets.length];

        return Padding(
          padding: const EdgeInsets.only(right: 12),
          child: GestureDetector(
            onTap: () {
              Get.toNamed(
                Routes.evaluateProduct,
                arguments: model,
              );
            },
            child: Container(
              width: 117,
              decoration: BoxDecoration(
                border: Border.all(color: AppColors.neutral06),
                borderRadius: BorderRadius.circular(8.r),
                color: AppColors.white,
              ),
              child: Stack(
                alignment: Alignment.center,
                children: [
                  Padding(
                    padding:  EdgeInsets.only(
                      top: 8,
                      left: 6,
                      right: 6,
                      bottom: 8,
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        model.imageUrl != null
                            ? Image.network(
                          model.imageUrl!,
                          height: 70,
                          fit: BoxFit.contain,
                          errorBuilder: (_, __, ___) => Image.asset(
                            Assets.images.pXiaomi15.path,
                            height: 70,
                            fit: BoxFit.contain,
                          ),
                        )
                            : Image.asset(
                          Assets.images.pXiaomi15.path,
                          height: 70,
                          fit: BoxFit.contain,
                        ),
                        const SizedBox(height: 6),
                        Text(
                          model.name,
                          style: AppTypography.s12.regular.withColor(AppColors.neutral01),
                          textAlign: TextAlign.center,
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ],
                    ),
                  ),
                  Positioned(
                    top: -5,
                    left: -5,
                    child: Image.asset(badgeImage, width: 30, height: 30),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    ),
  );
}

  Widget _buildGenerationTabs(List<ProductModelp> products) {
    final tabs = ['Tất cả', ...products.map((p) => p.name).toList()];

    return SizedBox(
      height: 38.h,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        padding: const EdgeInsets.symmetric(horizontal: 12),
        itemCount: tabs.length,
        itemBuilder: (_, index) {
          final isSelected = index == selectedTabIndex;

          return Padding(
            padding: const EdgeInsets.only(right: 12),
            child: GestureDetector(
              onTap: () {
                setState(() {
                  selectedTabIndex = index;
                  selectedProductName = index == 0 ? null : tabs[index];
                });
              },
              child: Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 8,
                  //  vertical: 8,
                ),
                decoration: BoxDecoration(
                  color: isSelected ? AppColors.primary01 : AppColors.neutral07,
                  // borderRadius: BorderRadius.circular(20),
                  borderRadius: BorderRadius.circular(isSelected ? 4 : 0),
                ),
                child: Center(
                  child: Text(
                    tabs[index],
                    style: AppTypography.s16.regular.withColor(
                      isSelected ? AppColors.white : AppColors.neutral04,
                    ),
                    // style: TextStyle(
                    //   color: isSelected ? Colors.white : Colors.black,
                    //   fontWeight: FontWeight.w500,
                    // ),
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  Widget _buildModelList(List<ModelVariant> models) {
    return ListView.builder(
      padding: const EdgeInsets.all(12),
      itemCount: models.length,
      itemBuilder: (_, index) {
        final model = models[index];
        return GestureDetector(
          onTap: () {
            Get.toNamed(
              Routes.evaluateProduct,
              arguments: model,
            );
          },
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: [
                Container(
                  width: 60,
                  height: 60,
                  decoration: BoxDecoration(
                    color: AppColors.white,
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(8),
                    child: model.imageUrl != null
                        ? Image.network(
                      model.imageUrl!,
                      width: 60,
                      height: 60,
                      fit: BoxFit.contain,
                      errorBuilder: (_, __, ___) => Image.asset(
                        Assets.images.pXiaomi15.path,
                        width: 60,
                        height: 60,
                        fit: BoxFit.contain,
                      ),
                    )
                        : Image.asset(
                      Assets.images.pXiaomi15.path,
                      width: 60,
                      height: 60,
                      fit: BoxFit.contain,
                    ),
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Text(
                    model.name,
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

}
