import 'package:fido_box_demo01/core/extensions/string_extension.dart';
import 'package:fido_box_demo01/modules/home/controllers/home_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:get/get.dart';
import '../../router/app_page.dart';
import '../assets/locale_keys.g.dart';
import '../theme/app_colors.dart';

class CustomSearchBar extends StatelessWidget {
  final List<String> hintSuggestions;
  final ValueChanged<String>? onChanged;
  final VoidCallback? onSearch;
  final TextEditingController? controller;

  const CustomSearchBar({
    Key? key,
    required this.hintSuggestions,
    this.onChanged,
    this.onSearch,
    this.controller,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final homecontroller = Get.find<HomeController>();
    return GestureDetector(
      onTap: () {
        // Hiện thông báo khi nhấp vào TextField
                homecontroller.requireLogin(() {
            Get.toNamed(Routes.mailbox);
          });

        Get.snackbar(
          LocaleKeys.notification.trans(),
          LocaleKeys.feature_not_implemented.trans(),
        );
      },

      child: Container(
        height: 40.h,
        //padding: EdgeInsets.symmetric(horizontal: 8.w),
        decoration: BoxDecoration(
          color: AppColors.white,
          //    color: AppColors.gray10,
          border: Border.all(
            color: AppColors.neutral04,
            width: 1.0, // You can adjust the border width as needed
          ),
          borderRadius: BorderRadius.circular(8.r),
        ),
        child: Row(
          children: [
            Expanded(
              child: Stack(
                alignment: Alignment.centerLeft,
                children: [
                  AbsorbPointer(
                    // Ngăn không cho tương tác với TextField
                    child: TextField(
                      controller: controller,
                      style: TextStyle(fontSize: 14.sp),
                      onChanged: onChanged,
                      readOnly: true,
                      // Ngăn không cho nhập liệu
                      maxLines: 1,
                      // Limit to a single line
                      decoration: const InputDecoration(
                        border: InputBorder.none,
                        contentPadding: EdgeInsets.symmetric(vertical: 8),
                      ),
                    ),
                  ),

                  if ((controller?.text.isEmpty ?? true))
                    Padding(
                      padding: EdgeInsets.only(left: 40.w),
                      child: IgnorePointer(
                        child: AnimatedTextKit(
                          animatedTexts:
                              hintSuggestions
                                  .map(
                                    (text) => FadeAnimatedText(
                                      text,
                                      textStyle: TextStyle(
                                        overflow: TextOverflow.ellipsis,
                                        fontSize: 14.sp,
                                        //  color: Colors.grey[600],
                                        color: AppColors.neutral04,
                                      ),
                                      duration: const Duration(seconds: 3),
                                    ),
                                  )
                                  .toList(),
                          repeatForever: true,
                          isRepeatingAnimation: true,
                          pause: const Duration(seconds: 1),
                          displayFullTextOnTap: false,
                        ),
                      ),
                    ),
                  Positioned(
                    left: 10.h,
                    child: Icon(Icons.search, size: 20.sp, color: Colors.grey),
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
