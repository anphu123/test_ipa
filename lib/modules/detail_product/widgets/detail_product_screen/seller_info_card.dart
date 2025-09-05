import 'package:fido_box_demo01/core/extensions/string_extension.dart';
import 'package:fido_box_demo01/core/theme/app_colors.dart';
import 'package:fido_box_demo01/core/theme/app_typography.dart';
import 'package:flutter/material.dart';

import '../../../../core/assets/locale_keys.g.dart';

class SellerInfoCard extends StatelessWidget {
  const SellerInfoCard({
    super.key,

    required this.sellerName,
    this.maskName = true,
   this.avatarAsset,
    this.avatarUrl,
    this.onViewDetail,

    this.padding = const EdgeInsets.all(12),
    this.borderRadius = 12,
  }) : assert(
         avatarAsset != null || avatarUrl != null,
         'Provide either avatarAsset or avatarUrl',
       );


  final String sellerName;
  final bool maskName;

  final String? avatarAsset;
  final String? avatarUrl;

  final VoidCallback? onViewDetail;

  final EdgeInsets padding;
  final double borderRadius;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final textColor = theme.colorScheme.onSurface;
    final subColor = theme.textTheme.bodySmall?.color?.withOpacity(0.7);

    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(borderRadius),
        border: Border.all(color: AppColors.neutral06, width: 1.5),
      ),
      child: Padding(
        padding: padding,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Header
            Row(
              children: [
                Expanded(
                  child: Text(
                    LocaleKeys.seller_infor.trans(),
                    style: AppTypography.s16.medium.withColor(
                      AppColors.neutral01,
                    ),
                  ),
                ),
                InkWell(
                  borderRadius: BorderRadius.circular(8),
                  onTap: onViewDetail,
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(LocaleKeys.view_detail.trans(),
                      style: AppTypography.s12.regular.withColor(AppColors.neutral02),
                      ),
                      const SizedBox(width: 2),
                      Icon(Icons.chevron_right, size: 18, color: subColor),
                    ],
                  ),
                ),
              ],
            ),
            const SizedBox(height: 10),
            // Divider(height: 1, color: Colors.grey.shade300),
         //   const SizedBox(height: 10),

            // Body
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                _CircleAvatar(asset: avatarAsset, url: avatarUrl, size: 44),
                const SizedBox(width: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        maskName ? _mask(sellerName) : sellerName,
                       style: AppTypography.s16.medium.withColor(AppColors.neutral01),
                      ),
                      const SizedBox(height: 6),
                      Text(
                        LocaleKeys.seller_info_title.trans(),
                       style: AppTypography.s12.regular.withColor(AppColors.neutral03),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  static String _mask(String input) {
    if (input.length <= 2) return input;
    // Giữ 2 ký tự đầu/cuối, giữa thay bằng **
    final first = input.characters.first;
    final last = input.characters.last;
    return '$first**$last';
  }
}

class _CircleAvatar extends StatelessWidget {
  const _CircleAvatar({this.asset, this.url, this.size = 44})
    : assert(asset != null || url != null);

  final String? asset;
  final String? url;
  final double size;

  @override
  Widget build(BuildContext context) {
    Widget img;
    if (asset != null) {
      img = Image.asset(asset!, fit: BoxFit.cover);
    } else {
      img = Image.network(
        url!,
        fit: BoxFit.cover,
        errorBuilder:
            (_, __, ___) =>
                const Icon(Icons.person, size: 20, color: Colors.grey),
      );
    }
    return ClipRRect(
      borderRadius: BorderRadius.circular(size / 2),
      child: Container(
        width: size,
        height: size,
        color: Colors.grey.shade200,
        child: img,
      ),
    );
  }
}
