import 'package:fido_box_demo01/core/assets/locale_keys.g.dart';
import 'package:fido_box_demo01/core/extensions/string_extension.dart';
import 'package:fido_box_demo01/core/theme/app_typography.dart';
import 'package:fido_box_demo01/router/app_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import '../../../core/assets/assets.gen.dart';
import '../../../core/theme/app_colors.dart';
import '../controllers/for_sale_controller.dart';
import '../widgets/purchase_category.dart';

class ForSaleView extends GetView<ForSaleController> {
  const ForSaleView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.white,
      appBar: AppBar(
        surfaceTintColor: Colors.transparent,
        backgroundColor: AppColors.white,
        title: Text(
          "© 2HAND",
          style: AppTypography.s14.semibold.withColor(AppColors.neutral01),
        ),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.only(bottom: 16.h),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Tiêu đề
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 12.h),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    LocaleKeys.main_slogan.trans(),
                    style: AppTypography.s16.bold.withColor(
                      AppColors.neutral01,
                    ),
                  ),
                  SizedBox(height: 4.h),
                  Text.rich(
                    TextSpan(
                      text: LocaleKeys.total_sold_text.trans(),
                      children: [
                        TextSpan(
                          text: ' 97.917.770 ',
                          style: AppTypography.s14.bold.withColor(
                            AppColors.neutral01,
                          ),
                        ),
                        TextSpan(text: LocaleKeys.items_text.trans()),
                      ],
                    ),
                    style: AppTypography.s12.regular.withColor(
                      AppColors.neutral01,
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: 40.h),

            // Box phương thức bán hàng
            Column(
              children: [
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 16.w),
                  child: Container(
                    decoration: BoxDecoration(
                      color: AppColors.white,
                      borderRadius: BorderRadius.circular(8.r),
                      border: Border.all(color: AppColors.neutral07),
                    ),
                    child: Column(
                      children: [
                        _buildSaleMethodHeader(),
                        _buildSaleMethodItem(
                          imagePath: Assets.images.ic2handthumua.path,
                          title: LocaleKeys.purchase_method.trans(),
                          tag: LocaleKeys.inspection.trans(),
                          description: LocaleKeys.sell_now_description.trans(),
                          onTap: () => Get.toNamed(Routes.fidoPurchase),
                        ),
                        Container(
                          height: 1.h,
                          width: 280.w,
                          color: AppColors.neutral07,
                        ),
                        _buildSaleMethodItem(
                          imagePath: Assets.images.icKygui.path,
                          title: LocaleKeys.consignment.trans(),
                          tag: LocaleKeys.inspection.trans(),
                          description:
                              LocaleKeys.self_pricing_description.trans(),
                          onTap: () => Get.toNamed(Routes.comingSoon),
                        ),
                      ],
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.symmetric(
                    horizontal: 16.w,
                    vertical: 12.h,
                  ),
                  child: Container(
                    decoration: BoxDecoration(
                      color: AppColors.white,
                      borderRadius: BorderRadius.circular(8.r),
                      border: Border.all(color: AppColors.neutral07),
                    ),
                    child: Column(
                      children: [
                        _buildSaleMethodItem(
                          title: LocaleKeys.self_posting.trans(),
                          description: '',
                          onTap: () => Get.toNamed(Routes.comingSoon),
                          imagePath: Assets.images.icTudangban.path,
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),

            // Danh mục sản phẩm
            Padding(
              padding: EdgeInsets.symmetric(vertical: 8.h),
              child: _buildBottomCategoryBar(),
            ),
            SizedBox(height: 12.h),
          ],
        ),
      ),

      bottomNavigationBar: Container(
        height: 70.h,
        color: AppColors.white,
        padding: EdgeInsets.symmetric(vertical: 8.h),
        child: Center(
          child: InkWell(
            onTap: () => Get.back(),
            borderRadius: BorderRadius.circular(30),
            child: Container(
              width: 35.w,
              height: 35.w,
              decoration: BoxDecoration(
                color: AppColors.neutral05,
                shape: BoxShape.circle,
              ),
              child: Icon(Icons.close, color: AppColors.neutral01, size: 24.sp),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildSaleMethodHeader() {
    return Container(
      height: 46.h,
      padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 1.h),
      decoration: BoxDecoration(
        color: AppColors.AB02,
        borderRadius: BorderRadius.vertical(top: Radius.circular(12.r)),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            LocaleKeys.sales_methods.trans(),
            style: AppTypography.s12.semibold.withColor(AppColors.AB01),
          ),
          Row(
            children: [
              Icon(Icons.add_alarm_sharp, color: AppColors.AB01),
              TextButton(
                onPressed: () {},
                child: Text(
                  LocaleKeys.learn_more_sales.trans(),
                  style: AppTypography.s12.regular.withColor(AppColors.AB01),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildSaleMethodItem({
    required String imagePath,
    required String title,
    String? tag,
    required String description,
    //    required Color iconColor,
    required VoidCallback onTap,
  }) {
    return ListTile(
      onTap: onTap,
      contentPadding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 25.h),
      leading: Image.asset(imagePath),
      //size: 30),
      title: Row(
        children: [
          Text(
            title,
            style: AppTypography.s16.semibold.withColor(AppColors.neutral01),
          ),
          if (tag != null) ...[
            SizedBox(width: 8.w),
            Container(
              padding: EdgeInsets.symmetric(horizontal: 6.w, vertical: 2.h),
              decoration: BoxDecoration(
                color: AppColors.AB02,
                borderRadius: BorderRadius.circular(4.r),
              ),
              child: Text(
                tag,
                style: AppTypography.s12.regular.withColor(AppColors.AB01),
              ),
            ),
          ],
        ],
      ),
      subtitle:
          description.isNotEmpty
              ? Text(
                description,
                style: AppTypography.s12.regular.withColor(AppColors.neutral01),
              )
              : null,
      trailing: const Icon(Icons.chevron_right),
    );
  }
  Widget _buildBottomCategoryBar() {
    final items = [
      {
        'label': LocaleKeys.phone_category.trans(),
        'image': Assets.images.ctDienthoai.path,
        'id': 0,
      },
      {
        'label': LocaleKeys.tablet_category.trans(),
        'image': Assets.images.ctTablet.path,
        'id': 1,
      },
      {
        'label': LocaleKeys.laptop_category.trans(),
        'image': Assets.images.ctLaptop.path,
        'id': 2,
      },
      {
        'label': LocaleKeys.clock.trans(),
        'image': Assets.images.ctDongho.path,
        'id': 3,
      },
      {
        'label': LocaleKeys.category_title.trans(),
        'icon': Icons.apps,
      },
    ];

    return SizedBox(
      height: 80.h,
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        physics: NeverScrollableScrollPhysics(),
        padding: EdgeInsets.symmetric(horizontal: 8.w),
        itemCount: items.length,
        separatorBuilder: (_, __) => SizedBox(width: 12.w),
        itemBuilder: (context, index) {
          final category = items[index];

          // Lấy categoryId từ dữ liệu thực tế thay vì tính toán
          final categoryId = category['id'] as int?;

          // Kiểm tra xem category này có được chọn không
          final isSelected = categoryId != null && controller.selectedIndex.value == categoryId;

          return GestureDetector(
            onTap: () {
              // Nếu không có categoryId (dành cho mục "Tất cả danh mục")
              if (categoryId == null) {
                // Thực hiện hành động mặc định khi không có categoryId
                // Ví dụ: Chuyển tới trang danh mục chính hoặc làm gì đó khác
                Get.toNamed(
                    Routes.categoryFidoPurchase);
                // Không cần điều hướng vì đây là mục không có id
              } else {
                // Khi người dùng chọn category, cập nhật selectedIndex
                controller.selectedIndex.value = categoryId;

                // Điều hướng tới trang PurchaseCategory và truyền categoryId
                Get.toNamed(
                  Routes.categoryFidoPurchase,
                  arguments: {'id': categoryId}, // Truyền tham số id thay vì categoryId
                );
              }
            },
            child: Container(
              width: 62.w,
              height: 62.h,
              decoration: BoxDecoration(
                color: AppColors.neutral08,
                borderRadius: BorderRadius.circular(8.r),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  // Kiểm tra nếu có image thì hiển thị ảnh, nếu không thì hiển thị icon
                  category.containsKey('image')
                      ? Image.asset(
                    category['image'] as String,
                    width: 35.w,
                    height: 35.w,
                  )
                      : Icon(
                    category['icon'] as IconData,
                    color: AppColors.neutral02,
                    size: 28,
                  ),
                  SizedBox(height: 8.h),
                  Text(
                    category['label'] as String,
                    overflow: TextOverflow.ellipsis,
                    maxLines: 1,
                    style: AppTypography.s12.regular.withColor(AppColors.neutral01),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }

}
