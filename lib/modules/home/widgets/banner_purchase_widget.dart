import 'package:fido_box_demo01/core/assets/locale_keys.g.dart';
import 'package:fido_box_demo01/core/extensions/string_extension.dart';
import 'package:fido_box_demo01/core/theme/app_colors.dart';
import 'package:fido_box_demo01/core/theme/app_typography.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../../core/assets/assets.gen.dart';

class BannerPurchaseWidget extends StatelessWidget {
  const BannerPurchaseWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Get.snackbar(
          LocaleKeys.notification.trans(),
          LocaleKeys.feature_not_implemented.trans(),
          duration: Duration(milliseconds: 2000),
          snackPosition: SnackPosition.TOP,
        );
      },
      child: Container(
        height: 125.h,
        margin: EdgeInsets.all(16.w),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8.r),
          // border: Border.all(color: AppColors.neutral04, width: 1.w),
          image: DecorationImage(
            image: AssetImage(Assets.images.bannerPurchase.path),
            // Replace with your image path
            fit: BoxFit.cover,
          ),
        ),
        child: Stack(
          children: [
            // Add a gradient overlay to ensure text visibility
            Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20.r),
              ),
            ),
            // Add your banner content here
            Padding(
              padding: EdgeInsets.symmetric(vertical: 3.0.w, horizontal: 16.h),
              child: Column(
                children: [
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          Text(
                            '2Hand \nthu mua',
                            style: AppTypography.s16.semibold.withColor(
                              AppColors.neutral01,
                            ),
                          ),
                          SizedBox(width: 8.w),
                          Icon(Icons.arrow_forward, color: AppColors.neutral01),
                        ],
                      ),
                      SizedBox(height: 6.h),
                      Padding(
                        padding: EdgeInsets.only(right: 15.w,top: 5.h),
                        child: Text(
                          'Giao dịch trong 24H',
                          style: AppTypography.s12.regular.withColor(
                            AppColors.neutral03,
                          ),
                        ),
                      ),
                    ],
                  ),
                  //  SizedBox(height: 8.h),
                  Row(
                    children: [
                      Row(
                        children: [
                          Image.asset(
                            Assets.images.pXiaomi15.path,
                            // Replace with your actual asset
                            width: 45.w,
                            height: 45.h,
                          ),
                          SizedBox(width: 8.w),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              Text(
                                'Xiaomi 15 Ultra             ',
                                style: AppTypography.s9.regular.withColor(
                                  AppColors.neutral03,
                                ),
                              ),
                              Column(
                                children: [
                                  Text(
                                    'đ 42.000.000',
                                    style: AppTypography.s10.regular.withColor(
                                      AppColors.neutral02,
                                    ),
                                  ),
                                  SizedBox(height: 2.h),
                                  Container(
                                    width: 70.w,
                                    height: 20.h,
                                    padding: EdgeInsets.symmetric(
                                      horizontal: 4.h,
                                    ),
                                    decoration: BoxDecoration(
                                      color: AppColors.AE01,
                                      borderRadius: BorderRadius.only(
                                        topLeft: Radius.circular(8.r),
                                        topRight: Radius.circular(8.r),
                                        bottomRight: Radius.circular(8.r),
                                      ),
                                    ),
                                    child: Center(
                                      child: Text(
                                        'Ưu đãi giới hạn ...',
                                        textAlign: TextAlign.center,
                                        maxLines: 1,
                                        overflow: TextOverflow.ellipsis,
                                        style: AppTypography.s8.regular
                                            .withColor(AppColors.white),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                          SizedBox(width: 2.w),
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            //mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              // Đồng hồ (Text + 1 ảnh)
                              Container(
                                width: 65.w,
                                height: 65.h,
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Text(
                                      "Đồng hồ",
                                      style: AppTypography.s10.medium.withColor(
                                        AppColors.neutral01,
                                      ),
                                    ),
                                    SizedBox(height: 4.h),
                                    Image.asset(
                                      Assets.images.pXiaomi15.path,
                                      width: 45.w,
                                      height: 45.h,
                                    ),
                                  ],
                                ),
                              ),

                              SizedBox(width: 12.w),

                              // Grid 2x2 ảnh nhỏ
                              SizedBox(
                                width: 80.w,
                                height: 60.h,
                                child: GridView.count(
                                  crossAxisCount: 2,
                                  mainAxisSpacing: 4.h,
                                  crossAxisSpacing: 4.w,
                                  padding: EdgeInsets.zero,
                                  physics: NeverScrollableScrollPhysics(),
                                  // Tắt scroll
                                  children: List.generate(4, (index) {
                                    return Image.asset(
                                      Assets.images.ctDongho.path,
                                      width: 28.w,
                                      height: 28.h,
                                    );
                                  }),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// class BannerThuMuaCustomShape extends StatelessWidget {
//   const BannerThuMuaCustomShape({super.key});
//
//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       margin: EdgeInsets.all(16.w),
//       height: 120.h,
//       decoration: BoxDecoration(
//         borderRadius: BorderRadius.circular(20.r),
//         gradient: LinearGradient(
//           begin: Alignment.topLeft,
//           end: Alignment.bottomRight,
//           colors: [
//             Colors.red,
//             Colors.blue,
//             Colors.green,
//           ],
//         ),
//       ),
//       child: Stack(
//         children: [
//           // Nền được bo góc và có hình dạng custom
//           ClipPath(
//             clipper: CustomCornerClipper(),
//             child: Container(
//               decoration: BoxDecoration(
//                borderRadius: BorderRadius.circular(20.r),
//                 gradient: LinearGradient(
//                   begin: Alignment.topLeft,
//                   end: Alignment.bottomRight,
//                   colors: const [
//                     Color(0xFFEAF0FF),
//                     Color(0xFFFFFFFF),
//                     Color(0xFFF3F0FF),
//                   ],
//                 ),
//               ),
//             ),
//           ),
//           // Nội dung bên trong banner
//           Padding(
//             padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 16.h),
//             child: Row(
//               mainAxisAlignment: MainAxisAlignment.spaceBetween,
//               children: [
//                 // Bên trái
//                 Row(
//                   children: [
//                     Column(
//                       crossAxisAlignment: CrossAxisAlignment.start,
//                       children: [
//                         Text(
//                           'Fidobox',
//                           style: TextStyle(
//                             fontSize: 18.sp,
//                             fontWeight: FontWeight.bold,
//                           ),
//                         ),
//                         Text(
//                           'thu mua',
//                           style: TextStyle(
//                             fontSize: 18.sp,
//                             fontWeight: FontWeight.bold,
//                           ),
//                         ),
//                       ],
//                     ),
//                     SizedBox(width: 8.w),
//                     Icon(Icons.arrow_right_alt, size: 24.sp),
//                   ],
//                 ),
//                 // Bên phải
//                 Text(
//                   'Giao dịch trong 24H',
//                   style: TextStyle(
//                     fontSize: 14.sp,
//                     color: Colors.grey[700],
//                   ),
//                 ),
//               ],
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }
//
// class CustomCornerClipper extends CustomClipper<Path> {
//   @override
//   Path getClip(Size size) {
//     final radius = 20.r;
//     final tabWidth = size.width * 0.54;
//     final tabHeight = 30.h;
//
//     final path = Path();
//
//     // Góc trên trái
//     path.moveTo(0, radius);
//     path.quadraticBezierTo(0, 0, radius, 0);
//
//     // Đến trước phần tab
//     path.lineTo(size.width - tabWidth - radius, 0);
//
//     // Phần tab
//     path.lineTo(size.width - tabWidth, tabHeight);
//     path.lineTo(size.width, tabHeight);
//     path.lineTo(size.width, 0);
//
//     // Góc trên phải
//     path.lineTo(size.width, size.height - radius);
//     path.quadraticBezierTo(size.width, size.height, size.width - radius, size.height);
//
//     // Đáy
//     path.lineTo(radius, size.height);
//     path.quadraticBezierTo(0, size.height, 0, size.height - radius);
//
//     path.close();
//     return path;
//   }
//
//   @override
//   bool shouldReclip(covariant CustomClipper<Path> oldClipper) => false;
// }
