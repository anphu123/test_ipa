import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../../core/assets/assets.gen.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_typography.dart';
import '../controllers/purchase_order_controller.dart';
import '../domain/purchase_order_model.dart';
import '../widgets/custom_tab_bar_my_order_purchase.dart';

class PurchaseOrderView extends GetView<PurchaseOrderController> {
  const PurchaseOrderView({super.key});

  @override
  Widget build(BuildContext context) {
    String titleText = 'titleText';
    String searchField = 'searchField';
    return Scaffold(
      backgroundColor: AppColors.neutral08,
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(kToolbarHeight),
        child: Obx(() {
          return AppBar(
            centerTitle: true,
            backgroundColor: AppColors.white,
            surfaceTintColor: Colors.transparent,
            elevation: 0,
            leading: IconButton(
              icon: const Icon(Icons.arrow_back_ios_new_rounded),
              onPressed: () {
                if (controller.isSearching.value) {
                  controller.isSearching.value = false;
                } else {
                  Get.back();
                }
              },
            ),
            title: AnimatedSwitcher(
              duration: const Duration(milliseconds: 300),
              transitionBuilder:
                  (child, animation) => FadeTransition(
                    opacity: animation,
                    child: SizeTransition(
                      sizeFactor: animation,
                      axis: Axis.horizontal,
                      child: child,
                    ),
                  ),
              child:
                  controller.isSearching.value
                      ? TextField(
                        key: ValueKey(searchField),
                        // 💡 rất quan trọng cho switcher
                        autofocus: true,
                        decoration: InputDecoration(
                          hintText: 'Tìm kiếm đơn hàng...',
                          hintStyle: AppTypography.s14.regular,
                          border: InputBorder.none,
                          suffixIcon: IconButton(
                            icon: const Icon(Icons.close),
                            onPressed: () {
                              controller.searchQuery.value = '';
                              controller.isSearching.value = false;
                            },
                          ),
                        ),
                        style: AppTypography.s14,
                        onChanged: (value) {
                          controller.searchQuery.value = value;
                        },
                      )
                      : Text(
                        'Đơn hàng của tôi',
                        key: ValueKey(titleText),
                        // 💡 bắt buộc để Flutter biết khác nhau
                        style: AppTypography.s20.medium.withColor(
                          AppColors.neutral01,
                        ),
                      ),
            ),

            actions: [
              if (!controller.isSearching.value)
                Padding(
                  padding: EdgeInsets.only(right: 12.w),
                  child: GestureDetector(
                    onTap: controller.toggleSearch,
                    child: Row(
                      children: [
                        Image.asset(Assets.images.icSearch.path),
                        SizedBox(width: 4.w),
                        Text(
                          'Sửa',
                          style: AppTypography.s14.regular.withColor(
                            AppColors.neutral01,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
            ],
          );
        }),
      ),

      body: Column(
        children: [
          CustomTabBarMyOrderPurchase(
            controller: controller.tabController,
            processingCount: controller.processingCount,
          ),

          //          🧭 Tab content
          Expanded(
            child: Obx(
              () => TabBarView(
                controller: controller.tabController,
                children: [
                  _buildOrderList(OrderStatus.all),
                  _buildOrderList(OrderStatus.processing),
                  _buildOrderList(OrderStatus.completed),
                  _buildOrderList(OrderStatus.canceled),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildOrderList(OrderStatus status) {
    final orders = controller.filteredOrders;

    return AnimatedSwitcher(
      duration: const Duration(milliseconds: 300),
      child:
          orders.isEmpty
              ? const Center(
                key: ValueKey('empty'),
                child: Text('Không có đơn hàng phù hợp'),
              )
              : ListView.builder(
                key: const ValueKey('list'),
                padding: EdgeInsets.all(16.r),
                itemCount: orders.length,
                itemBuilder: (context, index) {
                  return Padding(
                    padding: EdgeInsets.only(
                      bottom: index == orders.length - 1 ? 0 : 16.h,
                    ),
                    child: _buildOrderItem(orders[index]),
                  );
                },
              ),
    );
  }

  Widget _buildOrderItem(PurchaseOrderModel order) {
    return Container(
      padding: EdgeInsets.all(16.r),
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(8.r),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // 🔹 Header row
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  order.source == PurchaseSource.twoHand
                      ? Image.asset(Assets.images.icMobile.path)
                      : Image.asset(Assets.images.icDonhang.path),
                  SizedBox(width: 12.w),
                  Text(order.source.label),
                ],
              ),
              Text(
                order.statusText,
                style: AppTypography.s12.regular.withColor(AppColors.primary01),
              ),
            ],
          ),
          SizedBox(height: 12.h),

          // 🔹 Product Info
          Row(
            children: [
              Container(
                width: 60.w,
                height: 60.h,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8.r),
                  image: DecorationImage(
                    image: AssetImage(order.productImage),
                    fit: BoxFit.contain,
                  ),
                ),
              ),
              SizedBox(width: 12.w),
              Expanded(
                child: Text(order.productName, style: AppTypography.s14.medium),
              ),
            ],
          ),

          SizedBox(height: 12.h),

          // 🔹 Action Buttons
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              _buildActionButton(
                order.status == OrderStatus.canceled
                    ? 'Định giá lại'
                    : 'Liên hệ',
              ),
              SizedBox(width: 12.w),
              _buildRightActionButton(order),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildRightActionButton(PurchaseOrderModel order) {
    if (order.source == PurchaseSource.twoHand &&
        order.status == OrderStatus.processing) {
      return _buildActionButton('Gửi hàng', isPrimary: true);
    } else {
      return SizedBox(width: 0);
    }
  }

  Widget _buildActionButton(String text, {bool isPrimary = false}) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 8.h),
      decoration: BoxDecoration(
        border: Border.all(
          color: isPrimary ? AppColors.primary01 : AppColors.neutral04,
        ),
        borderRadius: BorderRadius.circular(8.r),
      ),
      child: Text(
        text,
        style: AppTypography.s14.regular.withColor(
          isPrimary ? AppColors.primary01 : AppColors.neutral01,
        ),
      ),
    );
  }
}
