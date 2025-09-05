import 'package:fido_box_demo01/core/extensions/string_extension.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fido_box_demo01/core/theme/app_colors.dart';
import 'package:fido_box_demo01/core/theme/app_typography.dart';
import 'package:get/get.dart';
import '../../../core/assets/assets.gen.dart';
import '../../../core/assets/locale_keys.g.dart';
import '../../../router/app_page.dart';
class PurchaseInfoWidget extends StatefulWidget {
  const PurchaseInfoWidget({Key? key}) : super(key: key);
  @override
  State<PurchaseInfoWidget> createState() => _PurchaseInfoWidgetState();
}

class _PurchaseInfoWidgetState extends State<PurchaseInfoWidget> {
  int _selectedIndex = 0;
  List<bool> _isExpanded = [false, false, false];

  final tabs = [
    LocaleKeys.purchase_in_store.trans(),
    LocaleKeys.purchase_at_home.trans(),
    LocaleKeys.send_purchase.trans(),
  ];

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [_buildCustomTabBar(), _buildTabContent()],
    );
  }
  Widget _buildCustomTabBar() {
    return Container(
      height: 55.h,
      decoration: BoxDecoration(
        color: AppColors.neutral07,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(12.r),
          topRight: Radius.circular(12.r),
        ),
      ),
      child: Row(
        children: List.generate(tabs.length, (index) {
          final isSelected = index == _selectedIndex;
          return Expanded(
            child: GestureDetector(
              onTap: () {
                setState(() {
                  _selectedIndex = index;
                  _isExpanded = [false, false, false];
                });
              },
              child: Container(
               // margin: EdgeInsets.all(4.w),
                decoration: BoxDecoration(
                  //color: isSelected ? AppColors.white : Colors.transparent,
                  // borderRadius: BorderRadius.only(
                  //   topLeft: Radius.circular(8.r),
                  //   topRight: Radius.circular(8.r),
                  // ),
                  image: isSelected ? DecorationImage(
                    image: AssetImage(Assets.images.bgSelecttab.path), // Add your background image
                    fit: BoxFit.fill,
                  ) : null,
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      tabs[index],
                      textAlign: TextAlign.center,
                      style: AppTypography.s12.copyWith(
                        fontWeight: isSelected ? FontWeight.w700 : FontWeight.w500,
                        color: isSelected ? AppColors.neutral01 : AppColors.neutral03,
                      ),
                    ),
                    SizedBox(height: 4.h),
                    Container(
                      height: 3.h,
                      width: 40.w,
                      decoration: BoxDecoration(
                        color: isSelected ? AppColors.primary01 : Colors.transparent,
                        borderRadius: BorderRadius.circular(2.r),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
        }),
      ),
    );
  }
  Widget _buildTabContent() {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.symmetric(vertical: 12.h, horizontal: 16.w),
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.only(
          bottomLeft: Radius.circular(12.r),
          bottomRight: Radius.circular(12.r),
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.shade300,
            blurRadius: 8.r,
            offset: Offset(0, 2.h),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (_selectedIndex == 0) _buildInStoreContent(),
          if (_selectedIndex == 1) _buildAtHomeContent(),
          if (_selectedIndex == 2) _buildShippingContent(),
        ],
      ),
    );
  }

  // ===== IN-STORE =====
  Widget _buildInStoreContent() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(LocaleKeys.instore_section_title.trans(),  // <— i18n
                style: AppTypography.s14.regular),
            Container(
              padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 2.w),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(4.r),
                  color: AppColors.primary01),
              child: GestureDetector(
                onTap: () => Get.toNamed(Routes.listStore),
                child: Row(
                  children: [
                    Icon(Icons.location_on_outlined,
                        size: 16, color: AppColors.white),
                    Text(LocaleKeys.nearby_stores.trans(),
                        style: AppTypography.s12.regular
                            .withColor(AppColors.white)),
                  ],
                ),
              ),
            )
          ],
        ),
        SizedBox(height: 8.h),
        _buildStepIndicator([
          LocaleKeys.instore_step_1.trans(),
          LocaleKeys.instore_step_2.trans(),
          LocaleKeys.instore_step_3.trans(),
        ]),
        SizedBox(height: 8.h),
        Image.asset(Assets.images.bannerXiaomi1.path,
            height: 180.h, width: double.infinity, fit: BoxFit.cover),
        SizedBox(height: 8.h),
        _buildFAQSection(),
      ],
    );
  }

  // ===== AT-HOME =====
  Widget _buildAtHomeContent() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(LocaleKeys.athome_section_title.trans(),  // <— i18n
                style: AppTypography.s14.regular),
            Container(
              padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 2.w),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(4.r),
                  color: AppColors.primary01),
              child: GestureDetector(
                onTap: () => Get.toNamed(Routes.homePickupZone),
                child: Row(
                  children: [
                    Icon(Icons.location_on_outlined,
                        size: 16, color: AppColors.white),
                    Text(LocaleKeys.nearby_stores.trans(),
                        style: AppTypography.s12.regular
                            .withColor(AppColors.white)),
                  ],
                ),
              ),
            )
          ],
        ),
        SizedBox(height: 8.h),
        _buildStepIndicator([
          LocaleKeys.athome_step_1.trans(),
          LocaleKeys.athome_step_2.trans(),
          LocaleKeys.athome_step_3.trans(),
        ]),
        SizedBox(height: 8.h),
        Image.asset(Assets.images.bannerXiaomi1.path,
            height: 180.h, width: double.infinity, fit: BoxFit.cover),
        SizedBox(height: 8.h),
        Text(LocaleKeys.athome_advantage_note.trans(),   // <— i18n
            style: AppTypography.s12.regular),
        SizedBox(height: 8.h),
        _buildFAQSection(),
      ],
    );
  }

  // ===== SHIPPING =====
  Widget _buildShippingContent() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(LocaleKeys.coverage_service.trans(),
            style: AppTypography.s14.regular),
        SizedBox(height: 8.h),
        _buildStepIndicator([
          LocaleKeys.shipping_step_1.trans(),
          LocaleKeys.shipping_step_2.trans(),
          LocaleKeys.shipping_step_3.trans(),
        ]),
        SizedBox(height: 8.h),
        Image.asset(Assets.images.bannerXiaomi1.path,
            height: 180.h, width: double.infinity, fit: BoxFit.cover),
        SizedBox(height: 8.h),
        Text(LocaleKeys.shipping_photo_note.trans(),  // <— i18n
            style: AppTypography.s12.regular),
        SizedBox(height: 8.h),
        _buildFAQSection(),
      ],
    );
  }


  Widget _buildStepIndicator(List<String> steps) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: List.generate(steps.length * 2 - 1, (index) {
        if (index.isOdd) {
          return Padding(
            padding: EdgeInsets.symmetric(horizontal: 6.w),
            child: Icon(
              Icons.arrow_forward_ios,
              size: 12.sp,
              color: Colors.grey.shade400,
            ),
          );
        } else {
          return Expanded(
            child: Text(
              steps[index ~/ 2],
              style: AppTypography.s10.regular.copyWith(
                color: AppColors.neutral03,
              ),
              textAlign: TextAlign.center,
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
            ),
          );
        }
      }),
    );
  }
  Widget _buildFAQSection() {
    final questions = [
      LocaleKeys.what_is_home_purchase.trans(),
      LocaleKeys.how_to_cancel_service.trans(),
      LocaleKeys.how_to_delete_private_data.trans(),
    ];

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: List.generate(questions.length, (index) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            InkWell(
              onTap: () =>
                  setState(() => _isExpanded[index] = !_isExpanded[index]),
              child: Padding(
                padding: EdgeInsets.symmetric(vertical: 8.h),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(child: Text(questions[index],
                        style: AppTypography.s14.regular)),
                    Icon(_isExpanded[index]
                        ? Icons.keyboard_arrow_up
                        : Icons.keyboard_arrow_down,
                        size: 24.sp, color: AppColors.neutral03),
                  ],
                ),
              ),
            ),
            AnimatedCrossFade(
              firstChild: const SizedBox.shrink(),
              secondChild: Padding(
                padding: EdgeInsets.only(bottom: 12.h),
                child: Text(
        LocaleKeys.faq_answer_for.trParams({"q": questions[index]}),
        // <— i18n + params
                  style: AppTypography.s12.regular
                      .copyWith(color: AppColors.neutral03),
                ),
              ),
              crossFadeState: _isExpanded[index]
                  ? CrossFadeState.showSecond
                  : CrossFadeState.showFirst,
              duration: const Duration(milliseconds: 150),
            ),
          ],
        );
      })
        ..add(SizedBox(height: 12.h))
        ..add(GestureDetector(
          onTap: () => Get.toNamed(Routes.supportCenter),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(LocaleKeys.see_more_questions.trans(),
                  style: AppTypography.s12.regular
                      .copyWith(color: AppColors.neutral04)),
              Icon(Icons.arrow_forward_ios,
                  size: 18.sp, color: AppColors.neutral04),
            ],
          ),
        )),
    );
  }
}


// class TrapezoidClipper extends CustomClipper<Path> {
//   final double radius;
//   final double topWidth;
//
//   TrapezoidClipper({this.radius = 8.0, this.topWidth = 0.8});
//
//   @override
//   Path getClip(Size size) {
//     final path = Path();
//
//     final topWidthActual = size.width * topWidth;
//     final sideOffset = (size.width - topWidthActual) / 2;
//
//     path.moveTo(sideOffset, 0); // Top-left
//     path.lineTo(size.width - sideOffset, 0); // Top-right
//     path.lineTo(size.width, size.height - radius); // Bottom-right
//     path.quadraticBezierTo(
//       size.width,
//       size.height,
//       size.width - radius,
//       size.height,
//     ); // Bottom-right curve
//     path.lineTo(radius, size.height); // Bottom-left
//     path.quadraticBezierTo(
//       0,
//       size.height,
//       0,
//       size.height - radius,
//     ); // Bottom-left curve
//     path.close();
//     return path;
//   }
//
//   @override
//   bool shouldReclip(CustomClipper<Path> oldClipper) => false;
// }
//
// class TabBarBackground extends StatelessWidget {
//   final int selectedIndex;
//
//   const TabBarBackground({Key? key, required this.selectedIndex})
//     : super(key: key);
//
//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       height: 55.h,
//       decoration: BoxDecoration(
//         color: AppColors.neutral07,
//         borderRadius: BorderRadius.only(
//           topLeft: Radius.circular(12.r),
//           topRight: Radius.circular(12.r),
//         ),
//         boxShadow: [
//           BoxShadow(
//             color: Colors.grey.shade200,
//             blurRadius: 4.r,
//             offset: Offset(0, -2.h),
//           ),
//         ],
//       ),
//       child: Stack(
//         children: [
//           // Background indicators
//           Row(
//             children: List.generate(3, (index) {
//               return Expanded(
//                 child: AnimatedContainer(
//                   duration: Duration(milliseconds: 300),
//                   margin: EdgeInsets.symmetric(horizontal: 4.w, vertical: 4.h),
//                   decoration: BoxDecoration(
//                     color:
//                         selectedIndex == index
//                             ? AppColors.white
//                             : Colors.transparent,
//                     borderRadius: BorderRadius.only(
//                       topLeft: Radius.circular(8.r),
//                       topRight: Radius.circular(8.r),
//                     ),
//                     // boxShadow:
//                     //     selectedIndex == index
//                     //         ? [
//                     //           BoxShadow(
//                     //             color: Colors.grey.shade300,
//                     //             blurRadius: 4.r,
//                     //             offset: Offset(0, -1.h),
//                     //           ),
//                     //         ]
//                     //         : null,
//                   ),
//                 ),
//               );
//             }),
//           ),
//           // Bottom border
//           Positioned(
//             bottom: 0,
//             left: 0,
//             right: 0,
//             child: Container(height: 1.h, color: Colors.grey.shade300),
//           ),
//         ],
//       ),
//     );
//   }
// }
