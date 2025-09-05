import 'package:fido_box_demo01/core/extensions/string_extension.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../../core/assets/assets.gen.dart';
import '../../../core/assets/locale_keys.g.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_typography.dart';
import '../controllers/support_chat_controller.dart';

class WelcomeCard extends StatefulWidget {
  @override
  _WelcomeCardState createState() => _WelcomeCardState();
}

class _WelcomeCardState extends State<WelcomeCard> {
  final controller = Get.find<SupportChatController>();
  final TextEditingController textController = TextEditingController();

  void _sendMessage(String text) {
    if (text.trim().isEmpty) return;
    controller.sendMessage(text.trim());
    textController.clear();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      clipBehavior: Clip.none,
      children: [
        // === CARD CHÍNH ===
        Container(
          width: double.infinity,
          margin: EdgeInsets.only(top: 40.h),
          padding: EdgeInsets.all(16.w),
          decoration: BoxDecoration(
            color: const Color(0xFFFFF4EC),
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(40.r),
              topRight: Radius.circular(40.r),
              bottomLeft: Radius.circular(16.r),
              bottomRight: Radius.circular(16.r),
            ),
            border: Border(
              top: BorderSide(color: AppColors.primary01, width: 3.0),
            ),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // === HEADER VỚI TEXT CHÀO HỎI ===
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(width: 72.w), // Chừa không gian cho bear
                  Expanded(
                    child: Text.rich(
                      TextSpan(
                        children: [
                          TextSpan(
                            text: 'Xin chào !\n',
                            style: AppTypography.s16.bold.withColor(
                              AppColors.primary01,
                            ),
                          ),
                          TextSpan(
                            text: 'Bạn có câu hỏi gì cần giải đáp không?',
                            style: AppTypography.s12.regular.withColor(
                              AppColors.neutral01,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),

              SizedBox(height: 20.h),

              // === SUGGESTIONS ===
              Text(
                'Mọi người cũng hỏi những câu này',
                style: AppTypography.s14.semibold.withColor(
                  AppColors.primary01,
                ),
              ),
              ...controller.suggestions.map(
                (s) => ListTile(
                  dense: true,
                  contentPadding: EdgeInsets.zero,
                  title: Text(s, style: TextStyle(fontSize: 13.sp)),
                  trailing: Icon(Icons.arrow_forward_ios, size: 14.sp),
                  onTap: () => _sendMessage(s),
                ),
              ),

              // === BUTTON ===
              Align(
                alignment: Alignment.center,
                child: OutlinedButton(
                  onPressed: () {
                    Get.snackbar(
                      LocaleKeys.notification.trans(),
                      LocaleKeys.feature_not_implemented.trans(),
                      duration: 3.seconds,
                      snackPosition: SnackPosition.TOP,
                    );
                  },
                  child: Text(
                    'Dịch vụ khác',
                    style: TextStyle(fontSize: 13.sp),
                  ),
                ),
              ),
            ],
          ),
        ),

        // === HÌNH BEAR NỔI TRÊN GÓC TRÁI ===
        Positioned(
          top: 20.h,
          left: 8.w,
          child: Image.asset(
            Assets.images.bear1.path,
            width: 80.w,
            height: 80.w,
          ),
        ),
      ],
    );
  }
}
