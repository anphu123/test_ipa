import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_typography.dart';

class CascadeDropdownField extends StatelessWidget {
  final String label;
  final TextEditingController controller;
  final String placeholder;
  final List<String> items;
  final ValueChanged<String?> onChanged;
  final bool isRequired;

  const CascadeDropdownField({
    Key? key,
    required this.label,
    required this.controller,
    required this.placeholder,
    required this.items,
    required this.onChanged,
    this.isRequired = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildLabel(),
        SizedBox(height: 8.h),
        _buildDropdownField(),
      ],
    );
  }

  Widget _buildLabel() {
    return RichText(
      text: TextSpan(
        children: [
          TextSpan(
            text: label,
            style: AppTypography.s14.medium.withColor(AppColors.neutral01),
          ),
          if (isRequired)
            TextSpan(
              text: ' *',
              style: AppTypography.s14.medium.withColor(Colors.red),
            ),
        ],
      ),
    );
  }

  Widget _buildDropdownField() {
    return GestureDetector(
      onTap: items.isNotEmpty ? _showDropdownBottomSheet : null,
      child: Container(
        width: double.infinity,
        padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 12.h),
        decoration: BoxDecoration(
          border: Border.all(
            color: items.isEmpty ? AppColors.neutral05 : AppColors.neutral04,
          ),
          borderRadius: BorderRadius.circular(8.r),
          color: items.isEmpty ? AppColors.neutral06 : Colors.white,
        ),
        child: Row(
          children: [
            Expanded(
              child: Text(
                controller.text.isEmpty ? placeholder : controller.text,
                style: controller.text.isEmpty
                    ? AppTypography.s14.regular.withColor(AppColors.neutral03)
                    : AppTypography.s14.regular.withColor(AppColors.neutral01),
              ),
            ),
            Icon(
              Icons.keyboard_arrow_down,
              color: items.isEmpty ? AppColors.neutral05 : AppColors.neutral03,
            ),
          ],
        ),
      ),
    );
  }

  void _showDropdownBottomSheet() {
    Get.bottomSheet(
      DropdownBottomSheet(
        title: 'Chọn $label',
        items: items,
        selectedValue: controller.text,
        onItemSelected: (value) {
          controller.text = value;
          onChanged(value);
          Get.back();
        },
      ),
      isScrollControlled: true,
    );
  }
}

class DropdownBottomSheet extends StatelessWidget {
  final String title;
  final List<String> items;
  final String selectedValue;
  final ValueChanged<String> onItemSelected;

  const DropdownBottomSheet({
    Key? key,
    required this.title,
    required this.items,
    required this.selectedValue,
    required this.onItemSelected,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      constraints: BoxConstraints(
        maxHeight: MediaQuery.of(context).size.height * 0.7,
      ),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.vertical(top: Radius.circular(16.r)),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          _buildHeader(),
          _buildSearchField(),
          _buildItemList(),
          SizedBox(height: 16.h),
        ],
      ),
    );
  }

  Widget _buildHeader() {
    return Container(
      padding: EdgeInsets.all(16.w),
      decoration: BoxDecoration(
        border: Border(
          bottom: BorderSide(color: AppColors.neutral06, width: 1),
        ),
      ),
      child: Row(
        children: [
          Expanded(
            child: Text(
              title,
              style: AppTypography.s16.bold.withColor(AppColors.neutral01),
            ),
          ),
          IconButton(
            onPressed: () => Get.back(),
            icon: Icon(Icons.close, color: AppColors.neutral03),
            padding: EdgeInsets.zero,
            constraints: BoxConstraints(),
          ),
        ],
      ),
    );
  }

  Widget _buildSearchField() {
    return Padding(
      padding: EdgeInsets.all(16.w),
      child: TextField(
        decoration: InputDecoration(
          hintText: 'Tìm kiếm...',
          hintStyle: AppTypography.s14.regular.withColor(AppColors.neutral03),
          prefixIcon: Icon(Icons.search, color: AppColors.neutral03),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8.r),
            borderSide: BorderSide(color: AppColors.neutral04),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8.r),
            borderSide: BorderSide(color: AppColors.neutral04),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8.r),
            borderSide: BorderSide(color: AppColors.primary01),
          ),
          contentPadding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 12.h),
        ),
        onChanged: (value) {
          // TODO: Implement search functionality
        },
      ),
    );
  }

  Widget _buildItemList() {
    return Flexible(
      child: ListView.separated(
        shrinkWrap: true,
        itemCount: items.length,
        separatorBuilder: (context, index) => 
            Divider(height: 1, color: AppColors.neutral06),
        itemBuilder: (context, index) {
          final item = items[index];
          final isSelected = selectedValue == item;

          return ListTile(
            title: Text(
              item,
              style: AppTypography.s14.regular.withColor(
                isSelected ? AppColors.primary01 : AppColors.neutral01,
              ),
            ),
            trailing: isSelected
                ? Icon(Icons.check, color: AppColors.primary01)
                : null,
            onTap: () => onItemSelected(item),
          );
        },
      ),
    );
  }
}