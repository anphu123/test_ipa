import 'package:fido_box_demo01/core/assets/locale_keys.g.dart';
import 'package:fido_box_demo01/core/extensions/string_extension.dart';
import 'package:fido_box_demo01/modules/home/widgets/product_card.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_typography.dart';
import '../controllers/home_controller.dart';

class ListProduct extends StatelessWidget {
  const ListProduct({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<HomeController>();
    return Obx(() {
      final products = controller.filteredProducts;
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildFilterBar(controller),
          AnimatedSwitcher(
            duration: const Duration(milliseconds: 400),
            transitionBuilder: (Widget child, Animation<double> animation) {
              return FadeTransition(opacity: animation, child: child);
            },
            child: products.isEmpty
                ? SizedBox(
              key: const ValueKey('empty'),
              child: Center(
                child: Text(
                  LocaleKeys.no_product.trans(),
                  style: TextStyle(fontSize: 14.sp, color: Colors.grey),
                ),
              ),
            )
                : GridView.builder(
              key: ValueKey(products.length),
              physics: const NeverScrollableScrollPhysics(),
              shrinkWrap: true,
              padding: EdgeInsets.symmetric(
                horizontal: 16.w,
                vertical: 8.h,
              ),
              itemCount: products.length,
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                mainAxisSpacing: 16.h,
                crossAxisSpacing: 8.w,
                childAspectRatio: 0.69,
              ),
              itemBuilder: (context, index) {
                final product = products[index];
                return TweenAnimationBuilder<double>(
                  key: ValueKey(product.id),
                  tween: Tween<double>(begin: 0.5, end: 1.0),
                  duration: Duration(milliseconds: 350 + index * 50),
                  curve: Curves.easeOutBack,
                  builder: (context, scale, child) {
                    return Transform.scale(scale: scale, child: child);
                  },
                  child: GestureDetector(
                    onTap: () {
                      Get.toNamed('/product/${product.id}');
                    },
                    child: ProductCard(product: product),
                  ),
                );
              },
            ),
          ),
        ],
      );
    });
  }

  Widget _buildFilterBar(HomeController controller) {
    final RxString selectedFilter = 'tong_hop'.obs;
    final RxBool isPriceAsc = true.obs;

    return Container(
      padding: EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      color: Colors.white,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          _buildTab(
            label: 'Tổng hợp',
            // isSelected: selectedFilter.value == 'tong_hop',
            // onTap: () => selectedFilter.value = 'tong_hop',
          ),
          _buildTab(
            label: 'Mẫu sản phẩm',
            // isSelected: selectedFilter.value == 'mau_san_pham',
            // onTap: () => selectedFilter.value = 'mau_san_pham',
          ),
          GestureDetector(
            onTap: () {
              // isPriceAsc.toggle();
              // selectedFilter.value = 'gia_ca';
            },
            child: Row(
              children: [
                Text(
                  'Giá cả',
                  style: TextStyle(
                    //  color: selectedFilter.value == 'gia_ca'
                    //    ? Colors.orange
                    color  : Colors.grey,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                Icon(
                  isPriceAsc.value
                      ? Icons.arrow_drop_up
                      : Icons.arrow_drop_down,
                  color: Colors.grey,
                  size: 20,
                ),
              ],
            ),
          ),
          GestureDetector(
            onTap: () {
              // TODO: Show bottom sheet lọc
            },
            child: Row(
              children: const [
                Text(
                  'Lọc',
                  style: TextStyle(color: Colors.grey),
                ),
                SizedBox(width: 4),
                Icon(
                  Icons.filter_alt_outlined,
                  color: Colors.grey,
                  size: 20,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTab({
    required String label,
    // required bool isSelected,
    // required VoidCallback onTap,
  }) {
    return GestureDetector(
      //onTap: onTap,
      onTap: (){},
      child: Text(
        label,
        style: TextStyle(
          // color: isSelected ? Colors.orange : Colors.grey,
          color: AppColors.neutral03,
          fontWeight: FontWeight.w500,
        ),
      ),
    );
  }
}