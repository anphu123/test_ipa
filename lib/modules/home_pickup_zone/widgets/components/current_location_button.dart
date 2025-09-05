// import 'package:flutter/material.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';
// import '../../../../core/theme/app_colors.dart';
// import '../../../../core/theme/app_typography.dart';

// class CurrentLocationButton extends StatelessWidget {
//   final VoidCallback? onPressed;
//   final bool isLoading;

//   const CurrentLocationButton({
//     Key? key,
//     this.onPressed,
//     this.isLoading = false,
//   }) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       width: double.infinity,
//       child: OutlinedButton.icon(
//         onPressed: isLoading ? null : onPressed,
//         icon: isLoading 
//             ? SizedBox(
//                 width: 18.sp,
//                 height: 18.sp,
//                 child: CircularProgressIndicator(
//                   strokeWidth: 2,
//                   color: AppColors.primary01,
//                 ),
//               )
//             : Icon(Icons.gps_fixed, size: 18.sp),
//         label: Text(
//           isLoading ? 'Đang lấy vị trí...' : 'Sử dụng vị trí hiện tại',
//           style: AppTypography.s14.medium,
//         ),
//         style: OutlinedButton.styleFrom(
//           foregroundColor: AppColors.primary01,
//           side: BorderSide(color: AppColors.primary01),
//           shape: RoundedRectangleBorder(
//             borderRadius: BorderRadius.circular(8.r),
//           ),
//           padding: EdgeInsets.symmetric(vertical: 12.h),
//         ),
//       ),
//     );
//   }
// }