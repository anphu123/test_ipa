import 'package:fido_box_demo01/modules/home/widgets/sub_category_tab.dart';
import 'package:fido_box_demo01/modules/home/widgets/sub_category_fido_list_brand.dart';
import 'package:fido_box_demo01/modules/home/widgets/sub_category_tab_fido.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import '../controllers/home_controller.dart';
import 'category_tab.dart';
import 'fido_box_tab.dart';

class CategorySection extends StatelessWidget {
  const CategorySection({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SliverToBoxAdapter(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(height: 10.h),
          const CategoryTab(),
          SizedBox(height: 10.h),
          const _ConditionalTab(),
          // SubCategoryTabNew(),
          SizedBox(height: 15.h),
        ],
      ),
    );
  }
}

class _ConditionalTab extends GetView<HomeController> {
  const _ConditionalTab({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Obx(
      () =>
          controller.selectedCategoryId.value == 1
              ? Column(
                children: [
                  SubCategoryTabFido(),

                  FidoBoxtab(),
                  SubCategoryFidoListBrand(),
                ],
              )
              :  SubCategoryTab(),
    );
  }
}
