import 'package:fido_box_demo01/core/extensions/string_extension.dart';
import 'package:fido_box_demo01/core/theme/app_typography.dart';
import 'package:flutter/material.dart';

import '../../../../core/assets/locale_keys.g.dart';
import '../../../../core/theme/app_colors.dart';

class BrandStoreCard extends StatelessWidget {
  const BrandStoreCard({
    super.key,
    required this.brandName,
    this.logoAsset,
    this.logoUrl,
    this.productAsset,
    this.productUrl,
    this.onViewDetail,
    this.onGoToStore,
    this.margin = const EdgeInsets.all(12),
    this.padding = const EdgeInsets.all(12),
    this.accentColor = AppColors.primary01,
    this.borderRadius = 12,
    this.elevation = 4,
  }) : assert(
         logoAsset != null || logoUrl != null,
         'Provide either logoAsset or logoUrl',
       ),
       assert(
         productAsset != null || productUrl != null,
         'Provide either productAsset or productUrl',
       );

  final String brandName;

  // Logo
  final String? logoAsset;
  final String? logoUrl;

  // Ảnh sản phẩm
  final String? productAsset;
  final String? productUrl;

  // Hành động
  final VoidCallback? onViewDetail;
  final VoidCallback? onGoToStore;

  // Style
  final EdgeInsets margin;
  final EdgeInsets padding;
  final Color accentColor;
  final double borderRadius;
  final double elevation;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: AppColors.neutral08,
        borderRadius: BorderRadius.circular(borderRadius),
      ),
      child: Padding(
        padding: padding,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Row trên: Logo + Tên + Xem chi tiết
            Row(
              children: [
                _SquareImage(
                  asset: logoAsset,
                  url: logoUrl,
                  size: 36,
                  radius: 8,
                  placeholder: const Icon(Icons.image, size: 16),
                ),
                const SizedBox(width: 8),
                Expanded(
                  child: Text(
                    brandName,
                    style: AppTypography.s16.medium.withColor(
                      AppColors.neutral01,
                    ),
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
                InkWell(
                  onTap: onViewDetail,
                  borderRadius: BorderRadius.circular(8),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        LocaleKeys.view_detail.trans(),
                        style: AppTypography.s12.regular.withColor(
                          AppColors.neutral02,
                        ),
                      ),
                      const SizedBox(width: 2),
                      Icon(
                        Icons.chevron_right,
                        size: 18,
                        color: Colors.grey.shade600,
                      ),
                    ],
                  ),
                ),
              ],
            ),

            const SizedBox(height: 10),
            Divider(height: 1, color: Colors.grey.shade300),
            const SizedBox(height: 10),

            // Row dưới: Ảnh + tên + nút
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _SquareImage(
                  asset: productAsset,
                  url: productUrl,
                  size: 88,
                  radius: 8,
                  placeholder: const Icon(Icons.smartphone),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        brandName,
                        style: AppTypography.s16.medium.withColor(
                          AppColors.neutral01,
                        ),
                      ),
                      const SizedBox(height: 8),
                      OutlinedButton(
                        onPressed: onGoToStore,
                        style: OutlinedButton.styleFrom(
                          minimumSize: const Size(0, 36),
                          // chiều cao tối thiểu nút
                          side: BorderSide(color: accentColor),
                          foregroundColor: accentColor,
                          padding: const EdgeInsets.symmetric(
                            horizontal: 12,
                            vertical: 6,
                          ),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),
                        child:  Text(LocaleKeys.go_to_store.trans(),),
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
}

/// Ảnh vuông bo góc, hỗ trợ asset hoặc network, có placeholder/fallback.
class _SquareImage extends StatelessWidget {
  const _SquareImage({
    required this.size,
    required this.radius,
    this.asset,
    this.url,
    this.placeholder,
  }) : assert(asset != null || url != null);

  final double size;
  final double radius;
  final String? asset;
  final String? url;
  final Widget? placeholder;

  @override
  Widget build(BuildContext context) {
    Widget child;
    if (asset != null) {
      child = Image.asset(asset!, fit: BoxFit.cover);
    } else {
      child = Image.network(
        url!,
        fit: BoxFit.contain,
        errorBuilder:
            (_, __, ___) =>
                Center(child: placeholder ?? const Icon(Icons.broken_image)),
        loadingBuilder: (ctx, w, ev) {
          if (ev == null) return w;
          return Center(
            child: SizedBox(
              width: 18,
              height: 18,
              child: const CircularProgressIndicator(strokeWidth: 2),
            ),
          );
        },
      );
    }

    return ClipRRect(
      borderRadius: BorderRadius.circular(radius),
      child: Container(
        width: size,
        height: size,
        color: Colors.grey.shade100,
        child: child,
      ),
    );
  }
}
