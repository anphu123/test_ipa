import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../../core/assets/assets.gen.dart';
import '../../../core/theme/app_colors.dart';
import '../controllers/home_controller.dart';
import 'banner_purchase_widget.dart';

class SubCategoryAll extends StatelessWidget {
  SubCategoryAll({super.key});

  final controller = Get.find<HomeController>();
  // ImageProvider getImageProvider(String path) {
  //   if (path.startsWith('http') || path.startsWith('https')) {
  //     return NetworkImage(path);
  //   } else {
  //     return AssetImage(path);
  //   }
  // }

  @override
  Widget build(BuildContext context) {
    final filteredCategories =
        controller.categories.where((e) => e.id != 0 && e.id != 1).toList();

    return Column(
      children: [
        Container(
          height: 146.h, // Adjust this height as needed
          child: GridView.builder(
            physics: NeverScrollableScrollPhysics(),
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 4,
              childAspectRatio: 1.2,
              crossAxisSpacing: 8.w,
              mainAxisSpacing: 8.h,
            ),
            itemCount: 8, // 2 rows * 4 items
            itemBuilder: (context, index) {
              if (index < filteredCategories.length) {
                final category = filteredCategories[index];
                return _buildCategoryItem(category);
              } else if (index == 7) {
                // Last item
                return _buildSeeMoreButton();
              } else {
                return SizedBox(); // Empty space for remaining slots
              }
            },
          ),
        ),
        //CustomHeaderBox()
        //BannerThuMuaWidget()
        BannerPurchaseWidget(),
      ],
    );
  }





  Widget _buildCategoryItem(dynamic category) {
    return Obx(() {
      final isSelected = controller.selectedCategoryId.value == category.id;

      return InkWell(
        borderRadius: BorderRadius.circular(8.r),
        onTap: () {
          controller.selectCategory(category.id);
          print('Selected: ${category.name}');
        },
        child: AnimatedContainer(
          duration: Duration(milliseconds: 250),
          curve: Curves.easeInOut,

          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image(
                image:
                category.imgUrlA.startsWith('http')
                    ? NetworkImage(category.imgUrlA)
                    : AssetImage(category.imgUrlA) as ImageProvider,
                width: 30.w,
                height: 30.w,
                fit: BoxFit.scaleDown
                ,
                errorBuilder:
                    (_, __, ___) => Icon(Icons.image_not_supported, size: 20.sp),
              ),
              // Replace with actual category icon
              SizedBox(height: 4.h),
              Text(
                controller.getTranslatedSubCategoryName(category.name),
                style: TextStyle(
                  fontSize: 10.sp,
                  fontWeight: FontWeight.w500,
                  color: Colors.black87,
                ),
                textAlign: TextAlign.center,
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
              ),
            ],
          ),
        ),
      );
    });
  }

  Widget _buildSeeMoreButton() {
    return InkWell(
      onTap: () {
        print("Xem thêm clicked");
        // TODO: Implement navigation or modal
      },
      borderRadius: BorderRadius.circular(8.r),
      child: Container(
        // decoration: BoxDecoration(
        //   borderRadius: BorderRadius.circular(8.r),
        //   color: AppColors.neutral07,
        // ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.more_horiz, size: 24.sp),
            SizedBox(height: 4.h),
            Text(
              'Xem thêm',
              style: TextStyle(
                fontSize: 10.sp,
                fontWeight: FontWeight.w500,
                color: Colors.black87,
              ),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
}
