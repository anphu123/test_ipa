import 'package:fido_box_demo01/core/assets/locale_keys.g.dart';
import 'package:fido_box_demo01/core/extensions/string_extension.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_typography.dart';
import 'pickup_booking_form.dart';

/// Widget hiển thị danh sách địa chỉ đã lưu trong bottom sheet
class BookingAddressListWidget extends StatelessWidget {
  final List<Map<String, dynamic>> bookingList;
  final Function(Map<String, dynamic>) onAddressSelected;
  final Function(String) onAddressDeleted;
  final Function(String) onSetDefault;
  final Function() onClearAll;
  final Function() onAddNew;
  final Function() onUseCurrentLocation;
  final Function() onShowForm;
  final bool isSelectionMode;
  final Set<String> selectedIds;
  final Function() onToggleSelectionMode;
  final Function(String) onToggleSelection;
  final Function() onDeleteSelected;
  final Function(String, Map<String, dynamic>)? onAddressUpdated;

  const BookingAddressListWidget({
    super.key,
    required this.bookingList,
    required this.onAddressSelected,
    required this.onAddressDeleted,
    required this.onSetDefault,
    required this.onClearAll,
    required this.onAddNew,
    required this.onUseCurrentLocation,
    required this.onShowForm,
    required this.isSelectionMode,
    required this.selectedIds,
    required this.onToggleSelectionMode,
    required this.onToggleSelection,
    required this.onDeleteSelected,
    this.onAddressUpdated,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildHeader(),
          const SizedBox(height: 16),
          if (bookingList.isEmpty) _buildEmptyState() else _buildAddressList(),
          _buildActionButtons(),
        ],
      ),
    );
  }

  Widget _buildHeader() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          LocaleKeys.delivery_area.trans(),
          style: AppTypography.s18.bold.copyWith(color: AppColors.neutral01),
        ),
        GestureDetector(
          onTap: () => Get.back(),
          child: Icon(Icons.close, color: AppColors.neutral03, size: 24.sp),
        ),
      ],
    );
  }

  Widget _buildEmptyState() {
    return Column(
      children: [
        Text(
          LocaleKeys.add_address_info.trans(),
          style: AppTypography.s14.medium.copyWith(color: AppColors.neutral02),
        ),
        const SizedBox(height: 24),
        Container(
          padding: EdgeInsets.all(16.w),
          decoration: BoxDecoration(
            color: AppColors.neutral07,
            borderRadius: BorderRadius.circular(8.r),
          ),
          child: Row(
            children: [
              Icon(Icons.location_on, color: AppColors.neutral03, size: 20.sp),
              SizedBox(width: 12.w),
              Expanded(
                child: Text(
                  LocaleKeys.current_address.trans(),
                  style: AppTypography.s14.regular.copyWith(
                    color: AppColors.neutral02,
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildAddressList() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          constraints: const BoxConstraints(maxHeight: 500),
          child: ListView.separated(
            shrinkWrap: true,
            itemCount: bookingList.length,
            separatorBuilder: (_, __) => const SizedBox(height: 8),
            itemBuilder: (context, index) {
              final booking = bookingList[index];
              return _buildAddressItem(booking);
            },
          ),
        ),
        if (isSelectionMode && selectedIds.isNotEmpty) ...[
          const SizedBox(height: 12),
          _buildSelectionActions(),
        ],
        const SizedBox(height: 16),
      ],
    );
  }

  Widget _buildAddressItem(Map<String, dynamic> booking) {
    final isSelected = selectedIds.contains(booking['id']);
    final isDefault = booking['isDefault'] == true;

    return GestureDetector(
      onTap: () {
        if (isSelectionMode) {
          onToggleSelection(booking['id']);
        } else {
          onAddressSelected(booking);
        }
      },
      onLongPress: !isSelectionMode ? onToggleSelectionMode : null,
      child: Container(
        padding: EdgeInsets.all(16.w),
        decoration: BoxDecoration(borderRadius: BorderRadius.circular(8.r)),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            if (isSelectionMode) ...[
              Icon(
                isSelected ? Icons.check_circle : Icons.radio_button_off,
                color: isSelected ? AppColors.primary01 : AppColors.neutral04,
                size: 20.sp,
              ),
              SizedBox(width: 12.w),
            ] else ...[
              Tooltip(
                message: isDefault
                    ? LocaleKeys.address_default.trans()
                    : LocaleKeys.address_set_default_action.trans(),
                child: GestureDetector(
                  onTap: () => onSetDefault(booking['id']),
                  child: Icon(
                    isDefault
                        ? Icons.radio_button_checked
                        : Icons.radio_button_off,
                    color:
                    isDefault ? AppColors.primary01 : AppColors.neutral04,
                    size: 20.sp,
                  ),
                ),
              ),
              SizedBox(width: 12.w),
            ],
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            // Tên liên hệ
                            Row(
                              children: [
                                Text(
                                  (booking['contactName'] as String?)
                                      ?.trim()
                                      .isNotEmpty ==
                                      true
                                      ? booking['contactName']
                                      : LocaleKeys.address_no_name.trans(),
                                  style: AppTypography.s13.bold,
                                ),
                              ],
                            ),
                            SizedBox(height: 6.h),

                            // Số điện thoại
                            Row(
                              children: [
                                Icon(Icons.phone,
                                    size: 14.sp, color: AppColors.neutral03),
                                SizedBox(width: 6.w),
                                Text(
                                  (booking['phoneNumber'] as String?)
                                      ?.trim()
                                      .isNotEmpty ==
                                      true
                                      ? booking['phoneNumber']
                                      : LocaleKeys.address_no_phone.trans(),
                                  style: AppTypography.s12.regular.copyWith(
                                    color: AppColors.neutral02,
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(height: 6.h),

                            // Địa chỉ
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    if ((booking['street'] as String?)
                                        ?.trim()
                                        .isNotEmpty ==
                                        true)
                                      ...[
                                        Text(
                                          booking['street'],
                                          style: AppTypography.s12.regular
                                              .copyWith(
                                            color: AppColors.neutral01,
                                          ),
                                        ),
                                        const SizedBox(height: 2),
                                      ],
                                    Text(
                                      _buildLocationString(booking),
                                      style: AppTypography.s11.regular.copyWith(
                                        color: AppColors.neutral02,
                                      ),
                                      maxLines: 2,
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                      IconButton(
                        onPressed: () => _showEditAddressDialog(booking),
                        icon: Icon(Icons.mode_edit_outlined,
                            size: 16.sp, color: AppColors.primary01),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSelectionActions() {
    return Row(
      children: [
        Expanded(
          child: ElevatedButton.icon(
            onPressed: onDeleteSelected,
            icon: Icon(Icons.delete_outline, size: 16.sp),
            label: Text(
              // “Xóa đã chọn (n)”
              '${LocaleKeys.selection_delete_selected.trans()} (${selectedIds.length})',
            ),
            style: ElevatedButton.styleFrom(
              backgroundColor: AppColors.error,
              foregroundColor: Colors.white,
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildActionButtons() {
    return Column(
      children: [
        const SizedBox(height: 24),
        Row(
          children: [
            Expanded(
              child: OutlinedButton(
                onPressed: onUseCurrentLocation,
                style: OutlinedButton.styleFrom(
                  side: BorderSide(color: AppColors.neutral04),
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8.r),
                  ),
                ),
                child: Text(
                  LocaleKeys.address_use_current_location.trans(),
                  style: AppTypography.s14.medium
                      .copyWith(color: AppColors.neutral01),
                ),
              ),
            ),
            SizedBox(width: 12.w),
            Expanded(
              child: ElevatedButton(
                onPressed: onShowForm,
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.primary01,
                  foregroundColor: Colors.white,
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8.r),
                  ),
                ),
                child: Text(
                  LocaleKeys.address_add_new.trans(),
                  style: AppTypography.s14.medium,
                ),
              ),
            ),
          ],
        ),

        // Button tạo địa chỉ mẫu (khi rỗng)
        if (bookingList.isEmpty) ...[
          SizedBox(height: 12.h),
          OutlinedButton.icon(
            onPressed: _createSampleAddress,
            icon: Icon(Icons.auto_awesome, size: 18.sp),
            label: Text(LocaleKeys.address_create_sample.trans()),
            style: OutlinedButton.styleFrom(
              foregroundColor: AppColors.success,
              side: BorderSide(color: AppColors.success),
              padding: const EdgeInsets.symmetric(vertical: 12),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8.r),
              ),
            ),
          ),
        ],
      ],
    );
  }

  String _buildLocationString(Map<String, dynamic> booking) {
    final List<String> parts = [];

    if ((booking['ward'] as String?)?.trim().isNotEmpty == true) {
      parts.add(booking['ward']);
    }
    if ((booking['district'] as String?)?.trim().isNotEmpty == true) {
      parts.add(booking['district']);
    }
    if ((booking['city'] as String?)?.trim().isNotEmpty == true) {
      parts.add(booking['city']);
    }

    if (parts.isEmpty) {
      return LocaleKeys.address_no_address.trans();
    }
    return parts.join(', ');
  }

  void _showEditAddressDialog(Map<String, dynamic> booking) {
    // Đóng bottom sheet hiện tại
    Get.back();
    // Mở form edit với data được fill sẵn
    _showEditForm(booking);
  }

  void _showEditForm(Map<String, dynamic> booking) {
    Get.bottomSheet(
      PickupBookingForm(
        editMode: true,
        editData: booking,
        onSubmit: () {},
        onUpdate: (updatedData) {
          _handleAddressUpdate(booking['id'], updatedData);
        },
      ),
      isScrollControlled: true,
    );
  }

  void _handleAddressUpdate(
      String addressId,
      Map<String, dynamic> updatedData,
      ) {
    final fullAddress =
        '${updatedData['street']}, ${updatedData['ward']}, ${updatedData['district']}, ${updatedData['city']}';

    final completeData = {
      ...updatedData,
      'fullAddress': fullAddress,
      'id': addressId,
    };

    if (onAddressUpdated != null) {
      onAddressUpdated!(addressId, completeData);
    }
  }

  /// Tạo địa chỉ mẫu cố định
  void _createSampleAddress() {
    final sampleAddress = {
      'id': DateTime.now().millisecondsSinceEpoch.toString(),
      'contactName': 'xiaoyu',
      'phoneNumber': '0123456789',
      'fullAddress': '21 Tân Cảng, Phường 25, Bình Thạnh, Hồ Chí Minh',
      'street': '21 Tân Cảng',
      'ward': 'Phường 25',
      'district': 'Bình Thạnh',
      'city': 'Hồ Chí Minh',
      'note': '',
      'latitude': 10.8014,
      'longitude': 106.7109,
      'distance': '3.5',
      'createdAt': DateTime.now().millisecondsSinceEpoch,
      'isDefault': true,
    };

    Get.dialog(
      AlertDialog(
        title: Row(
          children: [
            Icon(Icons.auto_awesome, color: AppColors.success),
            const SizedBox(width: 8),
            Text(LocaleKeys.sample_address_add_title.trans()),
          ],
        ),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              LocaleKeys.sample_address_add_question.trans(),
              style:
              AppTypography.s14.regular.copyWith(color: AppColors.neutral02),
            ),
            const SizedBox(height: 16),
            Container(
              padding: EdgeInsets.all(12.w),
              decoration: BoxDecoration(
                color: AppColors.neutral08,
                borderRadius: BorderRadius.circular(8.r),
                border: Border.all(color: AppColors.neutral06),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      CircleAvatar(
                        radius: 16.r,
                        backgroundColor: AppColors.primary01.withOpacity(0.1),
                        child: Text(
                          'X',
                          style: TextStyle(
                            color: AppColors.primary01,
                            fontWeight: FontWeight.bold,
                            fontSize: 14.sp,
                          ),
                        ),
                      ),
                      SizedBox(width: 12.w),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(sampleAddress['contactName'].toString(),
                                style: AppTypography.s14.medium),
                            Text(
                              sampleAddress['phoneNumber'].toString(),
                              style: AppTypography.s12.regular
                                  .copyWith(color: AppColors.neutral03),
                            ),
                          ],
                        ),
                      ),
                      Container(
                        padding:
                        EdgeInsets.symmetric(horizontal: 6.w, vertical: 2.h),
                        decoration: BoxDecoration(
                          color: AppColors.error.withOpacity(0.1),
                          borderRadius: BorderRadius.circular(8.r),
                        ),
                        child: Text(
                          LocaleKeys.address_default.trans(),
                          style: AppTypography.s10.medium
                              .copyWith(color: AppColors.error),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 8),
                  Text(
                    sampleAddress['fullAddress'].toString(),
                    style: AppTypography.s12.regular
                        .copyWith(color: AppColors.neutral02),
                  ),
                ],
              ),
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Get.back(),
            child: Text(LocaleKeys.common_cancel.trans()),
          ),
          ElevatedButton(
            onPressed: () {
              Get.back();
              _addSampleAddress(sampleAddress);
            },
            style:
            ElevatedButton.styleFrom(backgroundColor: AppColors.success),
            child: Text(LocaleKeys.common_add.trans(),
                style: const TextStyle(color: Colors.white)),
          ),
        ],
      ),
    );
  }

  void _addSampleAddress(Map<String, dynamic> sampleAddress) {
    onAddressSelected(sampleAddress);
    Get.snackbar(
      LocaleKeys.success.trans(),
      LocaleKeys.address_sample_added.trans().replaceAll('{name}', 'xiaoyu'),
      snackPosition: SnackPosition.BOTTOM,
      backgroundColor: AppColors.success,
      colorText: Colors.white,
      duration: const Duration(seconds: 2),
    );
  }
}
