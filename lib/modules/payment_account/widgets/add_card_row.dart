import 'package:flutter/material.dart';

import '../../../core/assets/assets.gen.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_typography.dart';

class AddCardRow extends StatelessWidget {
  final String label;
  final List<String> icons;
  final double iconSize;

  const AddCardRow({
    required this.label,
    required this.icons,
    this.iconSize = 20,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Row(
          children: [
            Image.asset(Assets.images.icAdd.path, height: 30),
            const SizedBox(width: 8),
            Text(
              label,
              style: AppTypography.s14.regular.withColor(AppColors.neutral01),
            ),
          ],
        ),
        Row(
          children: icons
              .map((path) => Image.asset(path, height: iconSize))
              .toList(),
        ),
      ],
    );
  }
}
