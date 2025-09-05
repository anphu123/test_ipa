import 'package:fido_box_demo01/core/theme/app_colors.dart';
import 'package:fido_box_demo01/modules/category_fido_purchase/widgets/product_model_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../domain/brand_model.dart';
// 📌 import trang đích

class BrandGrid extends StatelessWidget {
  final List<BrandModel> brands;

  const BrandGrid({super.key, required this.brands});

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      physics: const NeverScrollableScrollPhysics(),
      shrinkWrap: true,
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 4,
        mainAxisSpacing: 12,
        crossAxisSpacing: 0,
        childAspectRatio: 1,
      ),
      itemCount: brands.length,
      itemBuilder: (context, index) {
        final brand = brands[index];
        return GestureDetector(
          onTap: () {
            if (brand.products != null && brand.products!.isNotEmpty) {
              Get.to(() => BrandModelView(brand: brand));
            } else {
              Get.snackbar(
                'Thông báo',
                'Thương hiệu này chưa có danh sách sản phẩm',
                snackPosition: SnackPosition.BOTTOM,
              );
            }
          },
          child: Column(
            children: [
              Expanded(
                child: Container(
                  width: 70.r,
                  height: 70.r,
                  decoration: const BoxDecoration(
                    color: AppColors.neutral07,
                    shape: BoxShape.circle,
                  ),
                  child: Center(
                    child: Icon(
                      brand.icon,
                      size: 30.sp,
                      color: Colors.black,
                    ),
                  ),
                ),
              ),
              SizedBox(height: 4.h),
              Text(
                brand.name,
                style: TextStyle(fontSize: 12.sp),
                textAlign: TextAlign.center,
              ),
            ],
          ),
        );
      },
    );
  }
}
