
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../core/theme/app_colors.dart';
class CustomTabBarMyOrderPurchase extends StatelessWidget {
  final TabController controller;
  final int processingCount;

  const CustomTabBarMyOrderPurchase({
    super.key,
    required this.controller,
    required this.processingCount,
  });

  @override
  Widget build(BuildContext context) {
    return TabBar(
      controller: controller,
      isScrollable: true,
      tabAlignment: TabAlignment.start,
      dividerColor: Colors.transparent,
      indicatorColor: Colors.transparent, // ✅ Xoá gạch dưới
      labelColor: AppColors.primary01,
      splashFactory: NoSplash.splashFactory,
      unselectedLabelColor: Colors.grey,
      labelStyle: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
      unselectedLabelStyle: const TextStyle(
        fontWeight: FontWeight.normal,
        fontSize: 16,
      ),
      tabs: [
        const Tab(text: 'Tất cả'),
        Tab(
          child: Stack(
            clipBehavior: Clip.none,
            children: [
              const Text('Đang xử lý'),
              if (processingCount > 0)
                Positioned(
                  top: -6,
                  right: -18,
                  child: Container(
                    width: 16,
                    height: 16,
                    decoration: const BoxDecoration(
                      color: Colors.red,
                      shape: BoxShape.circle,
                    ),
                    alignment: Alignment.center,
                    child: Text(
                      '$processingCount',
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 10,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
            ],
          ),
        ),
        const Tab(text: 'Hoàn thành'),
        const Tab(text: 'Đã huỷ'),
      ],
    );
  }
}