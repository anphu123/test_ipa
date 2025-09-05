import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_typography.dart';

class TermsBottomSheet extends StatelessWidget {
  final String title;
  final List<String> contentList;

  const TermsBottomSheet({
    super.key,
    required this.title,
    required this.contentList,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.vertical(top: Radius.circular(16.r)),
      ),
      child: SafeArea(
        top: false,
        child: ConstrainedBox(
          constraints: BoxConstraints(
            maxHeight: 0.55.sh, // Chiều cao tối đa của bottom sheet
          ),
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 12.h),
            child: Column(
              children: [
                /// Header: nút back + tiêu đề
                Row(
                  children: [
                    IconButton(
                      icon: Icon(Icons.arrow_back_ios, color: AppColors.black),
                      onPressed: () => Get.back(),
                    ),
                    Expanded(
                      child: Text(
                        title,
                        textAlign: TextAlign.center,
                        style: AppTypography.s20.semibold.withColor(AppColors.primary01),
                      ),
                    ),
                    SizedBox(width: 48), // để cân icon bên trái
                  ],
                ),
                SizedBox(height: 8.h),

                /// Nội dung cuộn
                Expanded(
                  child: SingleChildScrollView(
                    child: Column(
                      children: [
                        /// Mô tả ngắn
                        Container(
                          width: double.infinity,
                          padding: EdgeInsets.all(12.w),
                          decoration: BoxDecoration(
                            color: AppColors.neutral08,
                            borderRadius: BorderRadius.circular(8.r),
                          ),
                          child: Text(
                            "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam.",
                            style: AppTypography.s12.regular.withColor(AppColors.neutral03),
                            textAlign: TextAlign.justify,
                          ),
                        ),
                        SizedBox(height: 16.h),

                        /// Danh sách điều khoản
                        ...List.generate(contentList.length, (index) {
                          return Padding(
                            padding: EdgeInsets.only(bottom: 12.h),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "${index + 1}. ${contentList[index].split('\n').first}",
                                  style: AppTypography.s14.semibold.withColor(AppColors.neutral01),
                                ),
                                SizedBox(height: 4.h),
                                Text(
                                  contentList[index],
                                  style: AppTypography.s12.regular.withColor(AppColors.neutral03),
                                  textAlign: TextAlign.justify,
                                ),
                              ],
                            ),
                          );
                        }),
                      ],
                    ),
                  ),
                ),

                SizedBox(height: 12.h),


              ],
            ),
          ),
        ),
      ),
    );
  }
}
