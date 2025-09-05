import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../core/common_widget/currency_util.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_typography.dart';
import '../../domain/viewed_product_model.dart';

class ViewedProductCard extends StatelessWidget {
  final ViewedProductModel product;
  final bool isSelected;
  final VoidCallback onChanged;
  final bool showCheckbox;

  const ViewedProductCard({
    super.key,
    required this.product,
    required this.isSelected,
    required this.onChanged,
    required this.showCheckbox,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(8.w),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          if (showCheckbox)
            Checkbox(
              value: isSelected,
              onChanged: (_) => onChanged(),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(4.r),
              ),
              activeColor: AppColors.primary01,
            ),
          if (showCheckbox) SizedBox(width: 8.w),
          Expanded(
            child: Container(
              padding: EdgeInsets.all(12.w),
              decoration: BoxDecoration(
                color:AppColors.white,
                borderRadius: BorderRadius.circular(12.r),
              ),
              child: Row(
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(8.r),
                    child: Image.network(
                      product.imageUrl,
                      width: 100.w,
                      height: 100.w,
                      fit: BoxFit.cover,
                    ),
                  ),
                  SizedBox(width: 12.w),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            _buildChip("C", color: AppColors.AS01),
                            SizedBox(width: 4.w),
                            Expanded(
                              child: Text(
                                "${product.conditionLabel} ${product.name}",
                                maxLines: 2,
                                overflow: TextOverflow.ellipsis,
                                style: AppTypography.s14.medium,
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: 8.h),
                        Text(
                          formatCurrency(product.price),
                          style: TextStyle(
                            fontSize: 16.sp,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildChip(String label, {Color? color}) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 6.w, vertical: 2.h),
      decoration: BoxDecoration(
        color: color ?? AppColors.neutral03,
        borderRadius: BorderRadius.circular(6.r),
      ),
      child: Text(
        label,
        style: AppTypography.s9.bold.copyWith(color: Colors.white),
      ),
    );
  }
}
