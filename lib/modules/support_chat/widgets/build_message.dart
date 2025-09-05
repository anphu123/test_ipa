import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:vibration/vibration.dart';
import '../../../core/theme/app_colors.dart';
import '../domain/chat_message_model.dart';

Widget buildMessage(ChatMessage message, {bool isNew = false}) {
  final isUser = message.sender == MessageSender.user;

  // Rung nhẹ nếu là tin mới từ bot
  if (!isUser && isNew) {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _vibrateOnMessage();
    });
  }

  return TweenAnimationBuilder(
    tween: Tween<double>(begin: 0.0, end: 1.0),
    duration: const Duration(milliseconds: 300),
    builder: (context, double opacity, child) {
      return Opacity(
        opacity: opacity,
        child: AnimatedSize(
          duration: const Duration(milliseconds: 300),
          curve: Curves.easeOut,
          child: Align(
            alignment: isUser ? Alignment.centerRight : Alignment.centerLeft,
            child: Container(
              constraints: BoxConstraints(maxWidth: 0.65.sw),
              margin: EdgeInsets.symmetric(vertical: 6.h, horizontal: 8.w),
              padding: EdgeInsets.symmetric(horizontal: 14.w, vertical: 10.h),
              decoration: BoxDecoration(
                color: isUser ? AppColors.neutral07 : AppColors.primary04,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(12.r),
                  topRight: Radius.circular(12.r),
                  bottomLeft: Radius.circular(isUser ? 12.r : 0),
                  bottomRight: Radius.circular(isUser ? 0 : 12.r),
                ),

              ),
              child: Text(
                message.text,
                style: TextStyle(
                  fontSize: 14.sp,
                  color: AppColors.neutral01,
                  height: 1.4,
                ),
              ),
            ),
          ),
        ),
      );
    },
  );
}

Future<void> _vibrateOnMessage() async {
  try {
    if (await Vibration.hasVibrator() ?? false) {
      Vibration.vibrate(duration: 100);
    }
  } catch (e) {
    debugPrint("Vibration error: $e");
  }
}
