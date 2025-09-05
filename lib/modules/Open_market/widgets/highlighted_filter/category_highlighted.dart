import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../../home/domain/model/category_model.dart';
import '../../../home/domain/model/mock_categories.dart';

class CategoryHighLighted extends StatelessWidget {
  CategoryHighLighted({super.key});

  final List<CategoryModel> categories = mockCategories; // Sử dụng dữ liệu mock

  @override
  Widget build(BuildContext context) {
    final filteredCategories = categories.where((e) => e.id != 0 && e.id != 1).toList();

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
            itemCount: filteredCategories.length,
            itemBuilder: (context, index) {
              final category = filteredCategories[index];
              return _buildCategoryItem(category);
            },
          ),
        ),
      ],
    );
  }

  Widget _buildCategoryItem(CategoryModel category) {
    return InkWell(
      borderRadius: BorderRadius.circular(8.r),
      onTap: () {
        print('Selected: ${category.name}');
      },
      child: AnimatedContainer(
        duration: Duration(milliseconds: 250),
        curve: Curves.easeInOut,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image(
              image: category.imgUrlA != null && category.imgUrlA!.startsWith('http')
                  ? NetworkImage(category.imgUrlA!)
                  : AssetImage(category.imgUrlA!) as ImageProvider,
              width: 20.w,
              height: 20.w,
              fit: BoxFit.scaleDown,
              errorBuilder: (_, __, ___) => Icon(Icons.image_not_supported, size: 20.sp),
            ),
            SizedBox(height: 4.h),
            Text(
              category.name['vi'] ?? 'Unknown Category', // Lấy tên danh mục theo ngôn ngữ 'vi' mặc định
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
  }
}
