import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../core/assets/assets.gen.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_typography.dart';

class VoucherCard extends StatelessWidget {
  final String value;
  final String condition;

  const VoucherCard({
    super.key,
    required this.value,
    required this.condition,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 180.w,
      height: 80.h,
      child: Stack(
        fit: StackFit.expand,
        children: [
          // 🎨 Hình nền của phiếu giảm giá
          Image.asset(
            Assets.images.voucherItem.path,
            fit: BoxFit.contain,
            width: 200.w,
            height: 100.h,
          ),

          // 🧾 Nội dung văn bản
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    value,
                    style: AppTypography.s20.bold.withColor(
                      AppColors.neutral01,
                    ),
                  ),
                  SizedBox(height: 4.h),
                  Text(
                    condition,
                    textAlign: TextAlign.center,
                    style: AppTypography.s10.regular.withColor(
                      AppColors.neutral03,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

// class VoucherCard extends StatelessWidget {
//   final String value;
//   final String condition;
//
//   const _VoucherCard({required this.value, required this.condition});
//
//   @override
//   Widget build(BuildContext context) {
//     //  final clipper = DolDurmaClipper(right: 30, holeRadius: 20);
//     return SizedBox(
//       width: 160.w,
//       height: 80.h, // 👈 nhớ đặt height cụ thể hoặc dùng LayoutBuilder
//       child: Stack(
//         children: [
//           ClipPath(
//             clipper: DolDurmaClipper(right: 30, holeRadius: 20),
//             child: Container(color: AppColors.primary04),
//           ),
//
//           // 🧾 Layer nội dung với clip
//           CustomPaint(
//             painter: VoucherClipBorderPainter(
//               clipper: DolDurmaClipper(right: 30, holeRadius: 20),
//               color: AppColors.primary01,
//               strokeWidth: 1.5,
//             ),
//             child: ClipPath(
//               clipper: DolDurmaClipper(right: 30, holeRadius: 20),
//               child: Padding(
//                 padding: const EdgeInsets.all(8.0),
//                 child: Container(
//                   //margin: EdgeInsets.all(10.r),
//                   //   width: 145.h,
//                   child: Center(
//                     child: Column(
//                       mainAxisAlignment: MainAxisAlignment.center,
//                       children: [
//                         Text(
//                           value,
//                           style: AppTypography.s20.bold.withColor(
//                             AppColors.neutral01,
//                           ),
//                         ),
//                         SizedBox(height: 4.h),
//                         Text(
//                           condition,
//                           textAlign: TextAlign.center,
//                           style: AppTypography.s10.regular.withColor(
//                             AppColors.neutral03,
//                           ),
//                         ),
//                       ],
//                     ),
//                   ),
//                 ),
//               ),
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }
