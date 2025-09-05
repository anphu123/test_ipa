import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../../core/assets/assets.gen.dart';
import '../../../core/theme/app_colors.dart';
import '../../../router/app_page.dart';
import '../../category_fido_purchase/controllers/category_fido_purchase_controller.dart';
import '../../category_fido_purchase/domain/category_mock_data.dart';
import '../../category_fido_purchase/views/category_fido_purchase_view.dart';

class PurchasePriceTag extends StatelessWidget {
  final int selectedStepIndex;

  PurchasePriceTag({this.selectedStepIndex = 2});

  final List<String> labels = ['50K', '100K', '200K', '300K', '500K'];

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: Container(
            height: 60.h,

            child: Stack(
              alignment: Alignment.center,
              children: [
                // Timeline line
                Positioned(
                  top: 15.h,
                  left: 0.w,
                  right: 0.w,
                  child: Row(
                    children: List.generate(labels.length - 1, (index) {
                      final isActive = index < selectedStepIndex;
                      return Expanded(
                        child: Container(
                         // width: 10.w,
                          height: 1.h,
                          color: isActive ? Colors.red : Colors.grey.shade300,
                        ),
                      );
                    }),
                  ),
                ),

                // Flag icons and labels
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: List.generate(labels.length, (index) {
                    final isActive = index <= selectedStepIndex;
                    return Column(
                      children: [
                        isActive
                            ? Container(
                          width: 30.w,
                          height: 30.h,
                          child: Image.asset(
                            Assets.images.icLixipurchase.path,
                            fit: BoxFit.contain,
                          ),
                        )
                            : Container(
                          width: 30.w,
                          height: 30.h,
                          child: Image.asset(
                            Assets.images.icLixipurchase1.path,
                            fit: BoxFit.contain,
                          ),
                        ),


                        // Container(
                        //   padding: EdgeInsets.all(6.r),
                        //   decoration: BoxDecoration(
                        //     shape: BoxShape.circle,
                        //     color: isActive ? Colors.red : Colors.grey.shade300,
                        //   ),
                        //   child: Icon(
                        //     Icons.flag,
                        //     size: 16.sp,
                        //     color: Colors.white,
                        //   ),
                        // ),
                        SizedBox(height: 6.h),
                        Text(
                          labels[index],
                          style: TextStyle(
                            fontSize: 12.sp,
                            color: isActive ? Colors.black : Colors.grey,
                            fontWeight: isActive ? FontWeight.w600 : FontWeight.normal,
                          ),
                        ),
                      ],
                    );
                  }),
                ),
              ],
            ),
          ),
        ),
        SizedBox(width: 18.w),
        GestureDetector(
          onTap: () {
            Get.toNamed(
               Routes.categoryFidoPurchase,
            );
          },
          child: Container(
            padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 8.h),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(40.r),
              border: Border.all(color: AppColors.neutral05),
            ),
            child: Text(
              "Thêm sản phẩm",
              style: TextStyle(
                fontSize: 13.sp,
                fontWeight: FontWeight.w500,
                color: AppColors.neutral02,
              ),
            ),
          ),
        ),
      ],
    );
  }
}


Widget _showBottomSheet() {
  final controller = Get.put(CategoryFidoPurchaseController(mockCategoryList));
  controller.selectedIndex.value = 0;

  return Container(
    padding: EdgeInsets.all(16.w),
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.vertical(top: Radius.circular(16.r)),
    ),
    height: 600.h,
    child: CategoryFidoPurchaseView(),
  );
}
