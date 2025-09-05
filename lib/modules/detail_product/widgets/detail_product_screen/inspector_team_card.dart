import 'package:fido_box_demo01/core/extensions/string_extension.dart';
import 'package:flutter/material.dart';

import '../../../../core/assets/locale_keys.g.dart';

class InspectorTeamCard extends StatelessWidget {
  const InspectorTeamCard({
    super.key,

    required this.imageUrls, // network urls
    this.onViewDetail,

    this.expertItems = const [],
    this.padding = const EdgeInsets.all(12),
    this.borderRadius = 12,
  });


  final List<String> imageUrls;           // ảnh grid: dùng URL
  final VoidCallback? onViewDetail;

               // tiêu đề list ngang
  final List<ExpertCheckItemData> expertItems; // ảnh item: asset

  final EdgeInsets padding;
  final double borderRadius;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final textColor = theme.colorScheme.onSurface;
    final subColor  = theme.textTheme.bodySmall?.color?.withOpacity(0.7);

    final width = MediaQuery.of(context).size.width;
    final isCompact = width < 360;
    final isWide    = width > 480;

    // Responsive cột cho grid
    final gridCols = isWide ? 6 : (isCompact ? 4 : 5);

    // Kích thước item list ngang (responsive)
    const double _itemWidth    = 150;
    const double _imageHeight  = 84;
    const double _gap          = 6;
    const double _titleLine    = 18;  // xấp xỉ line-height
    const double _subtitleLine = 16;
    final scale = MediaQuery.textScaleFactorOf(context)
        .clamp(1.0, 1.4); // giới hạn để tránh tăng quá đà
    final double horizontalItemHeight =
        _imageHeight + _gap + (_titleLine + _subtitleLine) * scale + 8;

    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(borderRadius),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.04),
            blurRadius: 6,
            offset: const Offset(0, 2),
          ),
        ],
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
                    LocaleKeys.inspection_team.trans(),
                    style: theme.textTheme.titleMedium?.copyWith(
                      fontWeight: FontWeight.w600,
                      color: textColor,
                    ),
                  ),
                ),
                InkWell(
                  borderRadius: BorderRadius.circular(8),
                  onTap: onViewDetail,
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        LocaleKeys.view_detail.trans(),
                        style: theme.textTheme.bodyMedium?.copyWith(
                          color: subColor,
                        ),
                      ),
                      const SizedBox(width: 2),
                      Icon(Icons.chevron_right, size: 18, color: subColor),
                    ],
                  ),
                ),
              ],
            ),
            const SizedBox(height: 10),
            Divider(height: 1, color: Colors.grey.shade300),
            const SizedBox(height: 10),

            // GRID đội ngũ (responsive cột)
            ClipRRect(
              borderRadius: BorderRadius.circular(8),
              child: GridView.builder(
                physics: const NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                itemCount: imageUrls.length,
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: gridCols,
                  mainAxisSpacing: 4,
                  crossAxisSpacing: 4,
                ),
                itemBuilder: (context, index) {
                  return ClipRRect(
                    borderRadius: BorderRadius.circular(6),
                    child: Image.network(
                      imageUrls[index],
                      fit: BoxFit.cover,
                      errorBuilder: (_, __, ___) => Container(
                        color: Colors.grey.shade200,
                        child: const Icon(Icons.person, size: 20),
                      ),
                    ),
                  );
                },
              ),
            ),

            // SECTION: Hơn 2000 chuyên gia …
            if (expertItems.isNotEmpty) ...[
              const SizedBox(height: 16),
              Text(
                LocaleKeys.over_2000_experts.trans(),
                style: theme.textTheme.titleMedium?.copyWith(
                  fontWeight: FontWeight.w600,
                ),
              ),
              const SizedBox(height: 12),

              SizedBox(
                height: horizontalItemHeight, // responsive theo textScale
                child: ListView.separated(
                  scrollDirection: Axis.horizontal,
                  itemCount: expertItems.length,
                  separatorBuilder: (_, __) => const SizedBox(width: 12),
                  itemBuilder: (context, index) {
                    final item = expertItems[index];
                    return SizedBox(
                      width: _itemWidth,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          // Ảnh asset
                          ClipRRect(
                            borderRadius: BorderRadius.circular(10),
                            child: Image.asset(
                              item.assetPath,
                              height: _imageHeight,
                              width: _itemWidth,
                              fit: BoxFit.cover,
                            ),
                          ),
                          const SizedBox(height: _gap),

                          // Text: dùng Flexible để không đòi thêm chiều cao
                          Flexible(
                            child: Text(
                              item.titleKey,
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                              style: theme.textTheme.bodyMedium?.copyWith(
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ),
                          Flexible(
                            child: Text(
                              item.subtitleKey,
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                              style: theme.textTheme.bodySmall?.copyWith(
                                color: Colors.grey[600],
                              ),
                            ),
                          ),
                        ],
                      ),
                    );
                  },
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }
}

/// Dữ liệu cho item cuộn ngang (ảnh dùng asset)
class ExpertCheckItemData {
  final String assetPath;
  final String titleKey;     // đổi thành key
  final String subtitleKey;  // đổi thành key

  const ExpertCheckItemData({
    required this.assetPath,
    required this.titleKey,
    required this.subtitleKey,
  });
}
