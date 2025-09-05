import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../../core/theme/app_colors.dart';
import '../../../core/common_widget/search_bar_sliver_header.dart';
import '../controllers/home_controller.dart';
import '../widgets/banner_sale.dart';
import '../widgets/category_section.dart';
import '../widgets/home_sliver_app_bar.dart';
import '../widgets/list_product.dart';

class HomeView extends GetView<HomeController> {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: AppColors.neutral07,

      child: SafeArea(
        child: Scaffold(
          backgroundColor: Colors.white,
          body: CustomScrollView(
            slivers: [
              // Header đầu: AppBar
              HomeSliverAppBar(),

              // Thanh tìm kiếm dạng SliverPinned với hiệu ứng blur + status bar
              SliverPersistentHeader(
                delegate: SearchBarSliverHeader(
                  unpinnedColor: AppColors.white,
                  pinnedColor: AppColors.primary01.withOpacity(0.5),
                ),
                pinned: true,
              ),
              // Banner quảng cáo (không được ghim)
              BannerSection(), // Use the new BannerSection widget here
              // Danh mục sản phẩm
              CategorySection(),

              // Danh sách sản phẩm
              const SliverToBoxAdapter(child: Column(children: [ListProduct()])),
            ],
          ),
        ),
      ),
    );
  }
}
