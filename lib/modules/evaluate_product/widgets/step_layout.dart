import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:fido_box_demo01/core/theme/app_colors.dart';
import 'package:fido_box_demo01/core/theme/app_typography.dart';

class StepLayout extends StatelessWidget {
  final String title;
  final String description;
  final List<String> options;
  final Function(String) onSelected;
  final String? selectedValue;

  const StepLayout({
    super.key,
    required this.title,
    required this.description,
    required this.options,
    required this.onSelected,
    this.selectedValue,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(height: 12),
          Row(
            children: [
              Text(
                title,
                style: AppTypography.s14.regular.withColor(AppColors.neutral01),
              ),
              const SizedBox(width: 4),
              GestureDetector(
                  onTap: () => Get.dialog(
                    AlertDialog(
                      backgroundColor: AppColors.white,
                      title: Text(title),
                      content: Text(description),
                      actions: [
                        TextButton(
                          onPressed: () => Get.back(),
                          child: const Text('OK'),
                        ),
                      ],
                    ),
                  ),
                child: const Icon(Icons.help_outline, size: 16, color: Colors.grey),
              ),
            ],
          ),
          const SizedBox(height: 16),
          Column(
            children: options.map((option) {
              final isSelected = selectedValue == option;
              return GestureDetector(
                onTap: () => onSelected(option),
                child: Container(
                  width: double.infinity,
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  margin: const EdgeInsets.only(bottom: 12),
                  decoration: BoxDecoration(
                    color: isSelected ? AppColors.primary03 : AppColors.neutral08,
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(
                      color: isSelected ? AppColors.primary01 : Colors.transparent,
                      width: 1.5,
                    ),
                  ),
                  alignment: Alignment.center,
                  child: Text(
                    option,
                    style: AppTypography.s16.medium.copyWith(
                      color: isSelected ? AppColors.primary01 : AppColors.neutral01,
                    ),
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
