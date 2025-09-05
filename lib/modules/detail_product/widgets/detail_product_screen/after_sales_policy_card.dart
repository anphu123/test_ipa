import 'package:fido_box_demo01/core/extensions/string_extension.dart';
import 'package:fido_box_demo01/core/theme/app_colors.dart';
import 'package:fido_box_demo01/core/theme/app_typography.dart';
import 'package:flutter/material.dart';

import '../../../../core/assets/locale_keys.g.dart';

class AfterSalesPolicyCard extends StatelessWidget {
  const AfterSalesPolicyCard({
    super.key,

    required this.items,
    this.onViewDetail,
    this.padding = const EdgeInsets.all(12),
    this.borderRadius = 12,
  });


  final List<AfterSalesItem> items; // nên truyền 4 item
  final VoidCallback? onViewDetail;
  final EdgeInsets padding;
  final double borderRadius;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final textColor = theme.colorScheme.onSurface;
    final subColor  = theme.textTheme.bodySmall?.color?.withOpacity(0.7);

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
            // Header
            Row(
              children: [
                Expanded(
                  child: Text(
            LocaleKeys.after_sales_service.trans(),
                    style: AppTypography.s16.medium.withColor(AppColors.neutral01),
                  ),
                ),
                InkWell(
                  onTap: onViewDetail,
                  borderRadius: BorderRadius.circular(8),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text( LocaleKeys.view_detail.trans(),
                          style: AppTypography.s12.regular.withColor(AppColors.neutral02),),
                      const SizedBox(width: 2),
                      Icon(Icons.chevron_right, size: 18, color: subColor),
                    ],
                  ),
                ),
              ],
            ),
            const SizedBox(height: 10),

            // Body: khung xám bo góc + 4 cột
            Container(
              padding: const EdgeInsets.symmetric(vertical: 0, horizontal: 8),
              decoration: BoxDecoration(
                color: AppColors.white,
                borderRadius: BorderRadius.circular(12),
              ),
              child: _FourColumns(items: items),
            ),
          ],
        ),
      ),
    );
  }
}

/// 1 hàng 4 cột, nếu >4 sẽ tự xuống dòng nhưng vẫn đều nhau
class _FourColumns extends StatelessWidget {
  const _FourColumns({required this.items});
  final List<AfterSalesItem> items;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    // Dùng Grid để phân cột đều, không scroll
    return GridView.builder(
      physics: const NeverScrollableScrollPhysics(),
      shrinkWrap: true,
      itemCount: items.length,
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 4,             // đúng như thiết kế
        mainAxisExtent: 78,            // cố định chiều cao mỗi ô
        crossAxisSpacing: 8,
        mainAxisSpacing: 8,
      ),
      itemBuilder: (_, i) {
        final it = items[i];
        return Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            // Icon đơn giản, canh giữa
            SizedBox(
              width: 24, height: 24,
              child: it.icon != null
                  ? Icon(it.icon, size: 24, color:AppColors.neutral01)
                  : (it.assetIcon != null
                  ? Image.asset(it.assetIcon!, width: 24, height: 24)
                  : const Icon(Icons.help_outline, size: 24)),
            ),
            const SizedBox(height: 8),
            Text(
              it.text,
              textAlign: TextAlign.center,
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
             style: AppTypography.s10.regular.withColor(AppColors.neutral01),
            ),
          ],
        );
      },
    );
  }
}

class AfterSalesItem {
  final IconData? icon;   // dùng 1 trong 2
  final String? assetIcon;
  final String text;

  const AfterSalesItem.icon({required this.icon, required this.text})
      : assetIcon = null;

  const AfterSalesItem.asset({required this.assetIcon, required this.text})
      : icon = null;
}
