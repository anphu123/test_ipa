import 'package:fido_box_demo01/modules/order_purchase_at_home/views/widgets/order_bottom_sheet.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_typography.dart';
import '../controllers/order_purchase_at_home_controller.dart';
import 'widgets/order_map_widget.dart';

import 'widgets/bottom_button_widget.dart';
import 'widgets/route_progress_widget.dart';

class OrderPurchaseAtHomeView extends GetView<OrderPurchaseAtHomeController> {
  const OrderPurchaseAtHomeView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.white,
      // appBar: AppBar(
      //   backgroundColor: Colors.transparent,
      //   elevation: 0,
      //   leading: IconButton(
      //     icon: Icon(Icons.arrow_back, color: AppColors.neutral01),
      //     onPressed: () => Get.back(),
      //   ),
      //   // title: Text(
      //   //   'Đơn mua',
      //   //   style: AppTypography.s16.bold.copyWith(
      //   //     color: AppColors.neutral01,
      //   //   ),
      //   // ),
      //   centerTitle: true,
      // ),
      body: Stack(
        children: [
          // Full screen map (without overlays)
          const OrderMapWidget(),

          // Route progress indicator (positioned at top)
          Positioned(
            top: 16.h,
            left: 0,
            right: 0,
            child: const RouteProgressWidget(),
          ),

          // Bottom sheet with content - starts at 50% of screen height
          DraggableScrollableSheet(
            initialChildSize: 0.5, // 50% of screen initially
            minChildSize: 0.3, // Minimum 30% of screen
            maxChildSize: 0.9, // Maximum 90% of screen
            snap: true,
            builder: (context, scrollController) {
              return OrderBottomSheet(scrollController: scrollController);
            },
          ),
        ],
      ),
      bottomNavigationBar: const BottomButtonWidget(),
    );
  }
}
