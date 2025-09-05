import 'package:fido_box_demo01/modules/purchase/widgets/purchase_price_tags.dart';
import 'package:fido_box_demo01/modules/purchase/widgets/purchase_pricing_history.dart';
import 'package:fido_box_demo01/modules/purchase/widgets/purchase_product_list.dart';
import 'package:fido_box_demo01/modules/purchase/widgets/purchase_warning_banner.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

Widget PurchaseContent() {
  return Container(

    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
            margin: EdgeInsets.symmetric(horizontal: 8.w),
            padding: EdgeInsets.all(16.w),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(8.r),
            ),
            child: Column(
              children: [
                PurchaseWaringBanner(),
                SizedBox(height: 40.h),
                PurchasePriceTag(),
                SizedBox(height: 12.h),
                //_buildAddProductButton(),
                SizedBox(height: 12.h),
                Container(child: PurchaseProductList()),
              ],
            )),

        SizedBox(height: 12.h),
        Container(
            margin: EdgeInsets.symmetric(horizontal: 8.w),
            padding: EdgeInsets.all(16.w),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(8.r),
            ),
            child: PurchaseHistory())
      ],
    ),
  );
}
