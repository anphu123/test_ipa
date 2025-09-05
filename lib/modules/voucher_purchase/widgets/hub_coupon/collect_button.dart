import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_typography.dart';

class CollectButton extends StatefulWidget {
  const CollectButton({super.key});

  @override
  State<CollectButton> createState() => _CollectButtonState();
}

class _CollectButtonState extends State<CollectButton> {
  bool isCollected = false;
  Duration countdownDuration = const Duration(
    days: 2,
    hours: 12,
    minutes: 6,
    seconds: 5,
  );
  late Timer timer;

  @override
  void initState() {
    super.initState();
    if (isCollected) {
      startCountdown();
    }
  }

  void startCountdown() {
    timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (countdownDuration.inSeconds > 0) {
        setState(() {
          countdownDuration -= const Duration(seconds: 1);
        });
      } else {
        timer.cancel();
      }
    });
  }

  @override
  void dispose() {
    timer.cancel();
    super.dispose();
  }

  String formatDuration(Duration duration) {
    final days = duration.inDays;
    final hours = duration.inHours % 24;
    final minutes = duration.inMinutes % 60;
    final seconds = duration.inSeconds % 60;
    return "${days} ngày ${hours.toString().padLeft(2, '0')}:${minutes.toString().padLeft(2, '0')}:${seconds.toString().padLeft(2, '0')}";
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        setState(() {
          isCollected = true;
          startCountdown();
        });
      },
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 300),
        width: double.infinity,
        padding: EdgeInsets.symmetric(vertical: 8.h, horizontal: 2.w),
        decoration: BoxDecoration(
          color: isCollected ? Colors.white : AppColors.primary01,
          borderRadius: BorderRadius.circular(12.r),
          border: Border.all(color: AppColors.primary01, width: 1.5),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              isCollected ? "Sử dụng ngay" : "Thu thập",
              style: AppTypography.s16.regular.withColor(
                isCollected ? AppColors.primary01 : AppColors.white,
              ),
            ),
            if (isCollected) ...[
              //  SizedBox(height: 4.h),
              Text(
                "Hiệu lực còn ${formatDuration(countdownDuration)}",
                style: TextStyle(fontSize: 12.sp, color: Colors.redAccent),
              ),
            ],
          ],
        ),
      ),
    );
  }
}
