import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../../../core/assets/assets.gen.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_typography.dart';
import '../../controllers/order_purchase_at_home_controller.dart';

class ShipperInfoWidget extends GetView<OrderPurchaseAtHomeController> {
  const ShipperInfoWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      final shipperData = controller.shipper.value;

      if (shipperData == null) {
        return const SizedBox.shrink();
      }

      return Container(
        padding: EdgeInsets.all(16.w),
        decoration: BoxDecoration(
          color: AppColors.white,
          borderRadius: BorderRadius.circular(8.r),
         // border: Border.all(color: AppColors.neutral06),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Header
            // Row(
            //   children: [
            //     Icon(
            //       Icons.delivery_dining,
            //       color: AppColors.primary01,
            //       size: 20.r,
            //     ),
            //     SizedBox(width: 8.w),
            //     Text(
            //       'Shipper đang đến',
            //       style: AppTypography.s14.medium.copyWith(
            //         color: AppColors.neutral01,
            //       ),
            //     ),
            //     const Spacer(),
            //     Container(
            //       padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 4.h),
            //       decoration: BoxDecoration(
            //         color: _getStatusColor(shipperData.statusColor),
            //         borderRadius: BorderRadius.circular(12.r),
            //       ),
            //       child: Row(
            //         mainAxisSize: MainAxisSize.min,
            //         children: [
            //           if (shipperData.status == 'on_the_way') ...[
            //             SizedBox(
            //               width: 8.w,
            //               height: 8.w,
            //               child: CircularProgressIndicator(
            //                 strokeWidth: 1.5,
            //                 valueColor: AlwaysStoppedAnimation<Color>(AppColors.white),
            //               ),
            //             ),
            //             SizedBox(width: 4.w),
            //           ],
            //           Text(
            //             shipperData.statusDisplay,
            //             style: AppTypography.s10.medium.copyWith(
            //               color: AppColors.white,
            //             ),
            //           ),
            //         ],
            //       ),
            //     ),
            //   ],
            // ),
            // SizedBox(height: 12.h),

            // Shipper info
            Column(
              children: [
                Row(
                  children: [
                    // Avatar
                    CircleAvatar(
                      radius: 24.r,
                      backgroundColor: AppColors.neutral07,
                      child:
                          // shipperData.avatar.isNotEmpty
                          //     ?
                               ClipRRect(
                                borderRadius: BorderRadius.circular(24.r),
                                child: Image.asset(
                                  Assets.images.avaShipper.path,
                                  // <-- thay bằng asset thực tế của bạn
                                  width: 48.w,
                                  height: 48.w,
                                  fit: BoxFit.cover,
                                  // errorBuilder: (context, error, stackTrace) {
                                  //   return Icon(
                                  //     Icons.person,
                                  //     color: AppColors.neutral03,
                                  //     size: 24.r,
                                  //   );
                                  // },
                                ),
                              )
                              // : Icon(
                              //   Icons.person,
                              //   color: AppColors.neutral03,
                              //   size: 24.r,
                              // ),
                    ),
                    SizedBox(width: 12.w),

                    // Info
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        // mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          // Hàng 1: Tên shipper và rating
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                shipperData.name,
                                style: AppTypography.s14.medium.copyWith(
                                  color: AppColors.neutral01,
                                ),
                              ),
                              Row(
                                children: [
                                  Text(
                                    '${shipperData.rating}',
                                    style: AppTypography.s14.medium.copyWith(
                                      color: AppColors.neutral01,
                                    ),
                                  ),
                                  SizedBox(width: 4.w),
                                  Icon(
                                    Icons.star,
                                    color: AppColors.AW01,
                                    size: 16.r,
                                  ),
                                ],
                              ),
                            ],
                          ),
                          SizedBox(height: 4.h),

                          // Hàng 2: Mô tả
                          Text(
                            "Quy trình miễn phí, bưu tá sẽ đến tận nơi",
                            style: AppTypography.s12.regular.copyWith(
                              color: AppColors.neutral03,
                            ),
                          ),
                        ],
                      ),
                    ),

                    // Action buttons
                  ],
                ),

                // Hàng 3: Action buttons
                SizedBox(height: 12.h),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    _buildActionButton(
                      Icons.chat_bubble_outline,
                      'Nhắn tin',
                      controller.chatWithShipper,
                    ),
                    _buildActionButton(
                      Icons.phone_outlined,
                      'Gọi điện',
                      controller.callShipper,
                    ),
                    _buildActionButton(
                      Icons.report_problem_outlined,
                      'Khiếu nại',
                      controller.chatWithShipper,
                    ),
                  ],
                ),
              ],
            ),

            // Estimated arrival
            // if (shipperData.estimatedArrival.isNotEmpty) ...[
            //   SizedBox(height: 12.h),
            //   Container(
            //     padding: EdgeInsets.all(12.w),
            //     decoration: BoxDecoration(
            //       color: AppColors.neutral08,
            //       borderRadius: BorderRadius.circular(8.r),
            //     ),
            //     child: Row(
            //       children: [
            //         Icon(
            //           Icons.access_time,
            //           color: AppColors.primary01,
            //           size: 16.r,
            //         ),
            //         SizedBox(width: 8.w),
            //         Text(
            //           'Dự kiến đến trong ${shipperData.estimatedArrival}',
            //           style: AppTypography.s12.medium.copyWith(
            //             color: AppColors.neutral01,
            //           ),
            //         ),
            //       ],
            //     ),
            //   ),
            // ],
          ],
        ),
      );
    });
  }

  Widget _buildActionButton(IconData icon, String label, VoidCallback onTap) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 80.w,
        padding: EdgeInsets.symmetric(vertical: 12.h, horizontal: 8.w),
        decoration: BoxDecoration(
          color: AppColors.white,
          borderRadius: BorderRadius.circular(8.r),
          border: Border.all(
            color: AppColors.neutral06,
            width: 1,
          ),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              icon,
              color: AppColors.neutral02,
              size: 24.r,
            ),
            SizedBox(height: 4.h),
            Text(
              label,
              style: AppTypography.s10.regular.copyWith(
                color: AppColors.neutral02,
              ),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }

  Color _getStatusColor(String statusColor) {
    switch (statusColor) {
      case 'warning':
        return Colors.orange;
      case 'success':
        return AppColors.success;
      case 'info':
        return AppColors.primary01;
      default:
        return Colors.orange;
    }
  }
}
