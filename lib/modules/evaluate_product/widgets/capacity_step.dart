import 'package:fido_box_demo01/core/extensions/string_extension.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../core/assets/locale_keys.g.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_typography.dart';

class CapacityStep extends StatelessWidget {
  final Function(String label, int priceOffset) onSelected;

  const CapacityStep({super.key, required this.onSelected});

  @override
  Widget build(BuildContext context) {
    final options = [
      {'label': '128G', 'offset': 0},
      {'label': '256G', 'offset': 300000},
      {'label': '512G', 'offset': 500000},
    ];

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(height: 12),
          Row(
            children: [
              Text(LocaleKeys.capacity.trans(), style: AppTypography.s14.regular.withColor(AppColors.neutral01)),
              const SizedBox(width: 4),
              GestureDetector(
                onTap: () => Get.dialog(
                  AlertDialog(
                    backgroundColor: AppColors.white,
                    title:  Text(LocaleKeys.capacity.trans()),
                    content: const Text('Chọn dung lượng bộ nhớ của thiết bị.'),
                    actions: [
                      TextButton(onPressed: () => Get.back(), child:  Text('OK')),
                    ],
                  ),
                ),
                child: const Icon(Icons.help_outline, size: 16, color: Colors.grey),
              ),
            ],
          ),
          const SizedBox(height: 16),
          Column(
            children: options.map((item) {
              final label = item['label'] as String;
              final offset = item['offset'] as int;

              return GestureDetector(
                onTap: () => onSelected(label, offset),
                child: Container(
                  width: double.infinity,
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  margin: const EdgeInsets.only(bottom: 12),
                  decoration: BoxDecoration(
                    color: AppColors.neutral08,
                    borderRadius: BorderRadius.circular(12),
                  ),
                  alignment: Alignment.center,
                  child: Text(
                    label,
                    style: const TextStyle(fontSize: 16),
                  ),
                ),
              );
            }).toList(),
          ),
        ],
      ),
    );
  }
}
