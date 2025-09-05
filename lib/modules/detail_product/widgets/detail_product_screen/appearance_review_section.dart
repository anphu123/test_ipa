import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_typography.dart';


class UserReview {
  final String avatarUrl;
  final String title; // ví dụ: "Xia***u 12G + 256G Đăng bán 13-06-2025"
  final String content;
  UserReview({required this.avatarUrl, required this.title, required this.content});
}

class AppearanceReviewSection extends StatelessWidget {
  final String title;                 // "Kiểm tra ngoại hình"
  final int totalReviews;             // 129234
  final int imageCount;               // 365
  final int videoCount;               // 22
  final int positiveCount;            // 128783
  final String aiSummaryTitle;        // "Tổng kết AI :"
  final List<String> aiSummaryLines;  // các dòng tóm tắt
  final String aiDisclaimer;          // "Nội dung do AI tạo..."
  final List<UserReview> reviews;     // danh sách review (hiển thị 1-2 cái đầu)
  final VoidCallback? onTapHeader;    // tap vào header để xem tất cả

  const AppearanceReviewSection({
    super.key,
    this.title = 'Kiểm tra ngoại hình',
    required this.totalReviews,
    required this.imageCount,
    required this.videoCount,
    required this.positiveCount,
    this.aiSummaryTitle = 'Tổng kết AI :',
    required this.aiSummaryLines,
    this.aiDisclaimer = 'Nội dung do AI tạo, công nghệ được cung cấp bởi DeepSeek',
    this.reviews = const [],
    this.onTapHeader,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Header
        InkWell(
          onTap: onTapHeader,
          borderRadius: BorderRadius.circular(8.r),
          child: Row(
            children: [
              Expanded(
                child: Text(title, style: AppTypography.s16.medium.withColor(AppColors.neutral02)),
              ),
              Text('$totalReviews đánh giá',
                  style: AppTypography.s12.regular.withColor(AppColors.neutral02)),
              SizedBox(width: 6.w),
              Icon(Icons.chevron_right, size: 18.w, color: AppColors.neutral03),
            ],
          ),
        ),
        SizedBox(height: 10.h),

        // Chips thống kê
        Row(
          children: [
            _StatChip(text: 'Có hình ảnh $imageCount'),
            _StatChip(text: 'Có video: $videoCount'),
            _StatChip(text: 'Đánh giá tốt: $positiveCount'),

          ],
        ),

        SizedBox(height: 12.h),

        // AI summary card
        _AiSummaryCard(
          title: aiSummaryTitle,
          disclaimer: aiDisclaimer,
          lines: aiSummaryLines,
        ),

        SizedBox(height: 12.h),

        // Reviews (hiển thị 1-2 cái đầu)
        ...reviews.take(2).map((r) => _ReviewItemCard(review: r)).toList(),
      ],
    );
  }
}

class _StatChip extends StatelessWidget {
  final String text;
  const _StatChip({required this.text});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 6.h),
      decoration: BoxDecoration(
        color: AppColors.neutral08,
        borderRadius: BorderRadius.circular(16.r),
      ),
      child: Text(text, style: AppTypography.s12.medium.withColor(AppColors.neutral02)),
    );
  }
}

class _AiSummaryCard extends StatelessWidget {
  final String title;
  final String disclaimer;
  final List<String> lines;

  const _AiSummaryCard({
    required this.title,
    required this.disclaimer,
    required this.lines,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(12.w),
      decoration: BoxDecoration(
        color: AppColors.neutral08,
        borderRadius: BorderRadius.circular(12.r),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(title, style: AppTypography.s14.semibold),
          SizedBox(height: 6.h),
          Text(disclaimer, style: AppTypography.s12.regular.withColor(AppColors.neutral04)),
          SizedBox(height: 8.h),
          ...lines.map((t) => Padding(
            padding: EdgeInsets.only(bottom: 4.h),
            child: Text(
              t,
              style: AppTypography.s14.regular.withColor(AppColors.neutral03),
            ),
          )),
          SizedBox(height: 8.h),

          // Hữu ích? Có/Không (tĩnh, có thể gắn handler sau)
          Row(
            children: [
              Expanded(
                child: Text('Bình luận có hữu ích với bạn ?',
                    style: AppTypography.s12.regular.withColor(AppColors.neutral03)),
              ),
              _VoteChip(icon: Icons.thumb_up_alt_outlined, label: 'Có (0)'),
              SizedBox(width: 8.w),
              _VoteChip(icon: Icons.thumb_down_alt_outlined, label: 'Không (0)'),
              SizedBox(width: 8.w),
              Icon(Icons.more_horiz, size: 18.w, color: AppColors.neutral03),
            ],
          ),
        ],
      ),
    );
  }
}

class _VoteChip extends StatelessWidget {
  final IconData icon;
  final String label;
  const _VoteChip({required this.icon, required this.label});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 6.h),
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(.6),
        borderRadius: BorderRadius.circular(16.r),
        border: Border.all(color: Colors.white10),
      ),
      child: Row(
        children: [
          Icon(icon, size: 14.w, color: AppColors.neutral03),
          SizedBox(width: 4.w),
          Text(label, style: AppTypography.s12.regular.withColor(AppColors.neutral03)),
        ],
      ),
    );
  }
}

class _ReviewItemCard extends StatelessWidget {
  final UserReview review;
  const _ReviewItemCard({required this.review});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            CircleAvatar(
              radius: 14.r,
              backgroundImage: NetworkImage(review.avatarUrl),
              onBackgroundImageError: (_, __) {},
            ),
            SizedBox(width: 8.w),
            Expanded(
              child: Text(review.title,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: AppTypography.s12.medium.withColor(AppColors.neutral02)),
            ),
          ],
        ),
        SizedBox(height: 8.h),
        Text(
          review.content,
          style: AppTypography.s14.regular.withColor(AppColors.neutral02),
        ),
      ],
    );
  }
}
