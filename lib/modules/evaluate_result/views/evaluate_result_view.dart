// import 'package:flutter/material.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';
// import 'package:get/get.dart';
// import 'package:get_storage/get_storage.dart';
// import '../../../core/common_widget/currency_util.dart';
// import '../../../core/theme/app_colors.dart';
// import '../../../core/theme/app_typography.dart';
// import '../controllers/evaluate_result_controller.dart';
// import '../../assessment_evaluation/domain/evaluate_result_model.dart';

// class EvaluateResultView extends StatelessWidget {
//   final EvaluateResultModel? result;

//   const EvaluateResultView({super.key, this.result});

//   @override
//   Widget build(BuildContext context) {
//     // Lấy result từ parameter hoặc từ controller
//     final r =
//         result ??
//         (Get.isRegistered<EvaluateResultController>()
//             ? Get.find<EvaluateResultController>().result
//             : null);

//     if (r == null) {
//       return Container(
//         height: 200,
//         child: Center(child: Text('Không có dữ liệu để hiển thị')),
//       );
//     }

//     return Container(
//       height: MediaQuery.of(context).size.height * 0.9,
//       decoration: BoxDecoration(
//         color: Colors.white,
//         borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
//       ),
//       child: Column(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           // Header
//           Container(
//             padding: EdgeInsets.all(16),
//             child: Column(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: [
//                 Row(
//                   mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                   children: [
//                     Text(
//                       'Lựa chọn của bạn',
//                       style: AppTypography.s16.bold.copyWith(
//                         color: AppColors.neutral01,
//                       ),
//                     ),
//                     GestureDetector(
//                       onTap: () => Get.back(),
//                       child: Icon(
//                         Icons.close,
//                         color: AppColors.neutral03,
//                         size: 24,
//                       ),
//                     ),
//                   ],
//                 ),
//                 SizedBox(height: 8),
//                 Text(
//                   'Mức được đánh giá máy dựa có ảnh hưởng lớn hơn đến giá.',
//                   style: AppTypography.s12.regular.copyWith(
//                     color: AppColors.neutral04,
//                   ),
//                 ),
//               ],
//             ),
//           ),
//           _buildPriceEstimationSection(r),
//           // Content - Model và thông tin trong cùng một section
//           Expanded(
//             child: SingleChildScrollView(
//               child: Container(
//                 margin: EdgeInsets.symmetric(horizontal: 16),
//                 padding: EdgeInsets.all(16),
//                 decoration: BoxDecoration(
//                   color: AppColors.neutral08,
//                   borderRadius: BorderRadius.circular(8),
//                 ),
//                 child: Column(
//                   crossAxisAlignment: CrossAxisAlignment.start,
//                   children: [
//                   // Model name
//                   Text(
//                     r.model,
//                     style: AppTypography.s16.bold.copyWith(
//                       color: AppColors.neutral01,
//                     ),
//                   ),
//                   SizedBox(height: 16),

//                   // Grid layout với full borders - chung một khung
//                   Container(
//                     decoration: BoxDecoration(
//                       border: Border.all(
//                         color: AppColors.primary01,
//                         width: 0.5,
//                       ),
//                     ),
//                     child: Column(
//                       children: [
//                         _buildRow('Dung lượng', r.capacity, isFirst: true),
//                         _buildRow('Phiên bản máy', r.version),
//                         _buildRow('Thời hạn bảo hành', r.warranty),
//                         _buildRow('Tình trạng khối động', r.lockStatus),
//                         _buildRow('Tài khoản cá nhân', r.cloudStatus),
//                         _buildRow('Tình trạng pin', r.batteryStatus),
//                         _buildRow('Vỏ ngoài/ Khung viền', r.appearance),
//                         _buildRow('Ngoại hình', r.display),
//                         _buildRow('Hiển thị', r.display),
//                         _buildRow('Sửa chữa/ thay thế linh kiện', r.repair),
//                         _buildRow('Sửa chữa/ thay thế màn hình', r.screenRepair),
//                         _buildRow(
//                           'Chức năng',
//                           r.functionality.isNotEmpty
//                               ? r.functionality.map((e) => e['label']).join(', ')
//                               : 'Rung bật thường',
//                           isLast: true,
//                         ),
//                       ],
//                     ),
//                   ),
//                     const SizedBox(height: 24),

//                     // Ước tính giá section
//                     _buildPriceEstimationSection(r),
//                     const SizedBox(height: 24),
//                     ElevatedButton(
//                       onPressed: () => Get.back(),
//                       style: ElevatedButton.styleFrom(
//                         backgroundColor: AppColors.primary01,
//                         minimumSize: const Size.fromHeight(50),
//                       ),
//                       child: const Text('Đóng'),
//                     ),
//                   ],
//                 ),
//               ),
//             ),
//           ),
//         ],
//       ),
//     );
//   }

//   Widget _buildRow(String label, String value, {bool isFirst = false, bool isLast = false}) {
//     return Container(
//       height: 50, // Fixed height để vertical line liên tục
//       decoration: BoxDecoration(
//         border: Border(
//           bottom: isLast ? BorderSide.none : BorderSide(
//             color: AppColors.primary01,
//             width: 0.5,
//           ),
//         ),
//       ),
//       child: Row(
//         children: [
//           // Left cell
//           Expanded(
//             flex: 2,
//             child: Container(
//               height: double.infinity,
//               padding: EdgeInsets.symmetric(horizontal: 12, vertical: 16),
//               decoration: BoxDecoration(
//                 border: Border(
//                   right: BorderSide(
//                     color: AppColors.primary01,
//                     width: 0.5,
//                   ),
//                 ),
//               ),
//               child: Align(
//                 alignment: Alignment.centerLeft,
//                 child: Text(
//                   label,
//                   style: AppTypography.s14.regular.copyWith(
//                     color: AppColors.neutral01,
//                   ),
//                 ),
//               ),
//             ),
//           ),
//           // Right cell
//           Expanded(
//             flex: 3,
//             child: Container(
//               height: double.infinity,
//               padding: EdgeInsets.symmetric(horizontal: 12, vertical: 16),
//               child: Align(
//                 alignment: Alignment.centerRight,
//                 child: Text(
//                   value,
//                   style: AppTypography.s14.regular.copyWith(
//                     color: AppColors.neutral04,
//                   ),
//                   textAlign: TextAlign.right,
//                 ),
//               ),
//             ),
//           ),
//         ],
//       ),
//     );
//   }

//   Widget _buildPriceEstimationSection(EvaluateResultModel result) {
//     return Container(
//       padding: EdgeInsets.all(16),
//       decoration: BoxDecoration(
//         color: Colors.white,
//         borderRadius: BorderRadius.circular(8),
//         border: Border.all(
//           color: AppColors.neutral06,
//           width: 0.5,
//         ),
//       ),
//       child: Column(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           // Title
//           Text(
//             'Ước tính giá',
//             style: AppTypography.s16.bold.copyWith(
//               color: AppColors.neutral01,
//             ),
//           ),
//           SizedBox(height: 16),

//           // Price rows
//           _buildPriceRow('Giá ước tính của sản phẩm', formatCurrency(result.evaluatedPrice), AppColors.neutral03),

//           // Voucher section
//           _buildVoucherSection(),

//           SizedBox(height: 12),
//           Divider(color: AppColors.neutral06, thickness: 0.5),
//           SizedBox(height: 12),

//           // Total price
//           _buildPriceRow('Giá thu mua ước tính', 'd36.850.000', AppColors.neutral01, isBold: true),

//           SizedBox(height: 16),

//           // Note
//           Container(
//             padding: EdgeInsets.all(12),
//             decoration: BoxDecoration(
//               color: AppColors.neutral08,
//               borderRadius: BorderRadius.circular(6),
//             ),
//             child: Column(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: [
//                 Text(
//                   'Giá thu hồi ước tính được đưa ra dựa trên thông tin ước tính bạn đã chọn. 2Hand sẽ cung cấp báo giá thu hồi chính xác sau khi kiểm tra chất lượng.',
//                   style: AppTypography.s12.regular.copyWith(
//                     color: AppColors.neutral03,
//                   ),
//                 ),
//                 SizedBox(height: 8),
//                 Text(
//                   'Nếu kết quả kiểm tra chất lượng khác với thông tin ước tính bạn đã chọn, số tiền trừ cấp và báo giá thu hồi có thể thay đổi.',
//                   style: AppTypography.s12.regular.copyWith(
//                     color: AppColors.error,
//                   ),
//                 ),
//               ],
//             ),
//           ),
//         ],
//       ),
//     );
//   }

//   Widget _buildPriceRow(String label, String price, Color priceColor, {bool isBold = false}) {
//     return Padding(
//       padding: EdgeInsets.symmetric(vertical: 4),
//       child: Row(
//         mainAxisAlignment: MainAxisAlignment.spaceBetween,
//         children: [
//           Text(
//             label,
//             style: (isBold ? AppTypography.s14.bold : AppTypography.s14.regular).copyWith(
//               color: AppColors.neutral01,
//             ),
//           ),
//           Text(
//             price,
//             style: (isBold ? AppTypography.s14.bold : AppTypography.s14.regular).copyWith(
//               color: priceColor,
//             ),
//           ),
//         ],
//       ),
//     );
//   }

//   Widget _buildVoucherSection() {
//     return Column(
//       children: [
//         SizedBox(height: 8),

//         // Voucher 1: Phiếu ưu đãi +5%
//         _buildVoucherRow(
//           'Phiếu ưu đãi +5%',
//           'd1.750.000',
//           'SAVE5PERCENT',
//           isApplied: false,
//         ),

//         SizedBox(height: 8),

//         // Voucher 2: Phiếu ưu đãi 2Hand
//         _buildVoucherRow(
//           'Phiếu ưu đãi 2Hand',
//           'd100.000',
//           '2HAND2024',
//           isApplied: false,
//         ),
//       ],
//     );
//   }

//   Widget _buildVoucherRow(String title, String discount, String code, {bool isApplied = false}) {
//     return Container(
//       padding: EdgeInsets.all(12),
//       decoration: BoxDecoration(
//         color: isApplied ? AppColors.primary01.withValues(alpha: 0.1) : AppColors.neutral08,
//         borderRadius: BorderRadius.circular(8),
//         border: Border.all(
//           color: isApplied ? AppColors.primary01 : AppColors.neutral06,
//           width: 1,
//         ),
//       ),
//       child: Row(
//         children: [
//           // Voucher info
//           Expanded(
//             child: Column(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: [
//                 Text(
//                   title,
//                   style: AppTypography.s14.medium.copyWith(
//                     color: AppColors.neutral01,
//                   ),
//                 ),
//                 SizedBox(height: 4),
//                 Text(
//                   'Mã: $code',
//                   style: AppTypography.s12.regular.copyWith(
//                     color: AppColors.neutral03,
//                   ),
//                 ),
//               ],
//             ),
//           ),

//           // Discount amount
//           Text(
//             discount,
//             style: AppTypography.s14.bold.copyWith(
//               color: AppColors.error,
//             ),
//           ),

//           SizedBox(width: 12),

//           // Apply/Remove button
//           GestureDetector(
//             onTap: () => _toggleVoucher(code),
//             child: Container(
//               padding: EdgeInsets.symmetric(horizontal: 12, vertical: 6),
//               decoration: BoxDecoration(
//                 color: isApplied ? AppColors.error : AppColors.primary01,
//                 borderRadius: BorderRadius.circular(4),
//               ),
//               child: Text(
//                 isApplied ? 'Bỏ' : 'Áp dụng',
//                 style: AppTypography.s12.medium.copyWith(
//                   color: Colors.white,
//                 ),
//               ),
//             ),
//           ),
//         ],
//       ),
//     );
//   }

//   void _toggleVoucher(String voucherCode) {
//     // Logic để toggle voucher
//     // Có thể lưu vào GetStorage hoặc state management
//     final storage = GetStorage();
//     List<String> appliedVouchers = storage.read('applied_vouchers') ?? [];

//     if (appliedVouchers.contains(voucherCode)) {
//       appliedVouchers.remove(voucherCode);
//     } else {
//       appliedVouchers.add(voucherCode);
//     }

//     storage.write('applied_vouchers', appliedVouchers);

//     // Refresh UI (có thể dùng setState hoặc GetX reactive)
//     // Tạm thời log để test
//     print('Voucher $voucherCode toggled. Applied vouchers: $appliedVouchers');
//   }
// }
