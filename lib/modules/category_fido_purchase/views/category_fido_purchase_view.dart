import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../core/theme/app_colors.dart';
import '../controllers/category_fido_purchase_controller.dart';
import '../widgets/category_sidebar.dart';
import '../widgets/category_main_content.dart';
import '../widgets/search_app_bar.dart';

class CategoryFidoPurchaseView extends GetView<CategoryFidoPurchaseController> {
  const CategoryFidoPurchaseView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.white,
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(kToolbarHeight + 8),
        child: Container(
          margin: EdgeInsets.only(top: 8),
          child: const SearchAppBar(),
        ),
      ),
      body: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CategorySidebar(controller: controller),
          Expanded(child: CategoryMainContent(controller: controller)),
        ],
      ),
    );
  }
}
