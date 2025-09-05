import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_typography.dart';
import '../../list_store/controllers/list_store_controller.dart';
import '../controllers/assessment_evaluation_controller.dart';
import 'store_selection_bottom_sheet.dart';

// i18n
import '../../../core/assets/locale_keys.g.dart';
import 'package:fido_box_demo01/core/extensions/string_extension.dart';

class StoreContentWidget extends StatelessWidget {
  final Function(String, bool) buildTimeSlot;

  const StoreContentWidget({super.key, required this.buildTimeSlot});

  @override
  Widget build(BuildContext context) {
    final assessmentController = Get.find<AssessmentEvaluationController>();

    // Try to find controller, if not found create one
    ListStoreController storeController;
    try {
      storeController = Get.find<ListStoreController>();
    } catch (e) {
      storeController = Get.put(ListStoreController());
    }

    return Container(
      padding: EdgeInsets.all(12.w),
      decoration: BoxDecoration(
        color: AppColors.neutral08,
        borderRadius: BorderRadius.circular(8.r),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Obx(() {
            if (storeController.filteredStores.isEmpty) {
              return _buildEmptyStore();
            }

            // Cửa hàng đã chọn hoặc cửa hàng gần nhất
            final selectedStore =
                assessmentController.selectedStore.value ??
                    storeController.filteredStores.first;

            return Row(
              children: [
                Icon(
                  Icons.radio_button_off,
                  size: 16.sp,
                  color: AppColors.AB01,
                ),
                SizedBox(width: 12.w),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        selectedStore.name,
                        style: AppTypography.s14.medium,
                        maxLines: 2,
                      ),
                      SizedBox(height: 4.h),
                      Text(
                        '${selectedStore.district} ${selectedStore.distance}km',
                        style: AppTypography.s12.regular.copyWith(
                          color: AppColors.neutral03,
                        ),
                      ),
                      GestureDetector(
                        onTap: () => _showStoreSelectionBottomSheet(
                          context,
                          assessmentController,
                        ),
                        child: Text(
                          '${LocaleKeys.store_view_all.trans()} >',
                          style: AppTypography.s12.regular.copyWith(
                            color: AppColors.primary01,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                Container(
                  width: 60.w,
                  height: 60.w,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8.r),
                    color: Colors.grey.shade300,
                  ),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(8.r),
                    child: Image.network(
                      selectedStore.imageUrl,
                      fit: BoxFit.cover,
                      errorBuilder: (context, error, stackTrace) =>
                          Icon(Icons.store, color: Colors.grey.shade600),
                    ),
                  ),
                ),
              ],
            );
          }),
          SizedBox(height: 20.h),
          Row(
            children: [
              Icon(Icons.radio_button_off, size: 16.sp, color: AppColors.AB01),
              SizedBox(width: 12.w),
              Expanded(
                child: GestureDetector(
                  onTap: () => _showDateTimePickerBottomSheet(
                    context,
                    assessmentController,
                  ),
                  child: Row(
                    children: [
                      Expanded(
                        child: Obx(
                              () => Text(
                            assessmentController.selectedStoreDateTime.value ??
                                _getDefaultDateTime(),
                            style: AppTypography.s12.regular.copyWith(
                              color: AppColors.neutral01,
                            ),
                          ),
                        ),
                      ),
                      Icon(
                        Icons.keyboard_arrow_right,
                        size: 16.sp,
                        color: AppColors.neutral04,
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
          SizedBox(height: 20.h),
          _buildPhoneNumberSection(context, assessmentController),
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: EdgeInsets.only(top: 12.h),
                child: Icon(
                  Icons.radio_button_off,
                  size: 16.sp,
                  color: AppColors.primary01,
                ),
              ),
              SizedBox(height: 20.h),
              Expanded(
                child: TextField(
                  decoration: InputDecoration(
                    hintText: LocaleKeys.add_note_hint.trans(),
                    hintStyle:
                    AppTypography.s12.regular.withColor(AppColors.neutral04),
                    border: InputBorder.none,
                    enabledBorder: InputBorder.none,
                    focusedBorder: InputBorder.none,
                    contentPadding: EdgeInsets.symmetric(
                      horizontal: 12.w,
                      vertical: 8.h,
                    ),
                  ),
                  style:
                  AppTypography.s12.regular.withColor(AppColors.neutral01),
                  maxLines: 2,
                  onChanged: (value) {
                    // Handle text input
                  },
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  void _showStoreSelectionBottomSheet(
      BuildContext context,
      AssessmentEvaluationController assessmentController,
      ) {
    Get.bottomSheet(
      StoreSelectionBottomSheet(
        onStoreSelected: (store) {
          assessmentController.selectStore(store);
        },
      ),
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
    );
  }

  Widget _buildEmptyStore() {
    return Row(
      children: [
        Container(
          width: 60.w,
          height: 60.w,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(8.r),
            color: Colors.grey.shade300,
          ),
          child: Icon(Icons.store, color: Colors.grey.shade600),
        ),
        SizedBox(width: 12.w),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                LocaleKeys.loading_store_info.trans(),
                style: AppTypography.s14.medium,
                maxLines: 2,
              ),
              SizedBox(height: 4.h),
              Text(
                LocaleKeys.please_wait.trans(),
                style: AppTypography.s12.regular.copyWith(
                  color: AppColors.neutral03,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  void _showDateTimePickerBottomSheet(
      BuildContext context,
      AssessmentEvaluationController assessmentController,
      ) {
    if (assessmentController.selectedCustomDate.value == null) {
      assessmentController.selectCustomDate(DateTime.now());
    }

    Get.bottomSheet(
      Container(
        height: 450.h,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.vertical(top: Radius.circular(16.r)),
        ),
        child: Column(
          children: [
            Container(
              padding: EdgeInsets.all(16.w),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  TextButton(
                    onPressed: () => Get.back(),
                    child: Text(
                      LocaleKeys.cancel.trans(),
                      style: AppTypography.s16.medium.copyWith(
                        color: AppColors.neutral03,
                      ),
                    ),
                  ),
                  Text(LocaleKeys.choose_time.trans(),
                      style: AppTypography.s16.bold),
                  TextButton(
                    onPressed: () => Get.back(),
                    child: Text(
                      LocaleKeys.done.trans(),
                      style: AppTypography.s16.medium.copyWith(
                        color: AppColors.primary01,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            const Divider(height: 1),
            Expanded(
              child: ListView(
                padding: EdgeInsets.all(16.w),
                children: [
                  _buildDatePickerSection(context, assessmentController),
                  SizedBox(height: 16.h),
                  _buildTimeSlotSection(context, assessmentController),
                  SizedBox(height: 16.h),
                ],
              ),
            ),
          ],
        ),
      ),
      isScrollControlled: true,
    );
  }

  Widget _buildDatePickerSection(
      BuildContext context,
      AssessmentEvaluationController controller,
      ) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          LocaleKeys.choose_date.trans(),
          style: AppTypography.s14.medium.copyWith(color: AppColors.neutral02),
        ),
        SizedBox(height: 8.h),
        GestureDetector(
          onTap: () => _showDatePicker(context, controller),
          child: Container(
            padding: EdgeInsets.symmetric(vertical: 12.h, horizontal: 16.w),
            decoration: BoxDecoration(
              border: Border.all(color: AppColors.neutral06),
              borderRadius: BorderRadius.circular(8.r),
              color: Colors.white,
            ),
            child: Row(
              children: [
                Icon(Icons.calendar_today, size: 20.sp, color: AppColors.primary01),
                SizedBox(width: 12.w),
                Obx(
                      () => Text(
                    controller.selectedCustomDate.value != null
                        ? _formatDate(controller.selectedCustomDate.value!)
                        : LocaleKeys.choose_date.trans(),
                    style: AppTypography.s14.regular.copyWith(
                      color: controller.selectedCustomDate.value != null
                          ? AppColors.neutral01
                          : AppColors.neutral04,
                    ),
                  ),
                ),
                const Spacer(),
                Icon(Icons.arrow_drop_down, color: AppColors.neutral04),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildTimeSlotSection(
      BuildContext context,
      AssessmentEvaluationController controller,
      ) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          LocaleKeys.choose_time_slot.trans(),
          style: AppTypography.s14.medium.copyWith(color: AppColors.neutral02),
        ),
        SizedBox(height: 8.h),
        GridView.count(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          crossAxisCount: 2,
          childAspectRatio: 2.8,
          crossAxisSpacing: 8.w,
          mainAxisSpacing: 8.h,
          children: _getAvailableTimeSlots(controller)
              .map((timeSlot) => _buildCustomTimeSlot(timeSlot, controller))
              .toList(),
        ),
      ],
    );
  }

  List<String> _getAvailableTimeSlots(AssessmentEvaluationController controller) {
    final selectedStore = controller.selectedStore.value;
    if (selectedStore == null) return _getDefaultTimeSlots();

    final openHours = selectedStore.openHours;
    final timeRange = openHours.split(' - ');
    if (timeRange.length != 2) return _getDefaultTimeSlots();

    final openTime = _parseTime(timeRange[0].trim());
    final closeTime = _parseTime(timeRange[1].trim());
    if (openTime == null || closeTime == null) return _getDefaultTimeSlots();

    return _generateTimeSlots(openTime, closeTime);
  }

  List<String> _getDefaultTimeSlots() {
    return [
      '09:00-10:00','10:00-11:00','11:00-12:00','12:00-13:00',
      '13:00-14:00','14:00-15:00','15:00-16:00','16:00-17:00',
      '17:00-18:00','18:00-19:00','19:00-20:00','20:00-21:00','21:00-22:00',
    ];
  }

  DateTime? _parseTime(String timeStr) {
    try {
      final parts = timeStr.split(':');
      if (parts.length == 2) {
        final hour = int.parse(parts[0]);
        final minute = int.parse(parts[1]);
        return DateTime(2024, 1, 1, hour, minute);
      }
    } catch (_) {}
    return null;
  }

  List<String> _generateTimeSlots(DateTime openTime, DateTime closeTime) {
    final List<String> slots = [];
    DateTime current = openTime;
    while (current.add(const Duration(hours: 1)).isBefore(closeTime) ||
        current.add(const Duration(hours: 1)).isAtSameMomentAs(closeTime)) {
      final startTime = _formatTime(current);
      final endTime = _formatTime(current.add(const Duration(hours: 1)));
      slots.add('$startTime-$endTime');
      current = current.add(const Duration(hours: 1));
    }
    return slots;
  }

  String _formatTime(DateTime time) =>
      '${time.hour.toString().padLeft(2, '0')}:${time.minute.toString().padLeft(2, '0')}';

  String _formatDate(DateTime date) =>
      '${date.day.toString().padLeft(2, '0')}/${date.month.toString().padLeft(2, '0')}/${date.year}';

  Widget _buildCustomTimeSlot(
      String timeSlot,
      AssessmentEvaluationController controller,
      ) {
    final isDisabled = _isTimeSlotDisabled(timeSlot, controller);

    return Obx(() {
      final isSelected = controller.selectedCustomTimeSlot.value == timeSlot;
      return GestureDetector(
        onTap: isDisabled ? null : () => controller.selectCustomTimeSlot(timeSlot),
        child: Container(
          decoration: BoxDecoration(
            color: isDisabled
                ? AppColors.neutral06
                : isSelected
                ? AppColors.primary01.withOpacity(0.1)
                : Colors.white,
            borderRadius: BorderRadius.circular(8.r),
            border: Border.all(
              color: isDisabled
                  ? AppColors.neutral04
                  : isSelected
                  ? AppColors.primary01
                  : AppColors.neutral06,
            ),
          ),
          child: Center(
            child: Text(
              timeSlot,
              style: AppTypography.s12.regular.copyWith(
                color: isDisabled
                    ? AppColors.neutral04
                    : isSelected
                    ? AppColors.primary01
                    : AppColors.neutral01,
              ),
            ),
          ),
        ),
      );
    });
  }

  void _showDatePicker(
      BuildContext context,
      AssessmentEvaluationController controller,
      ) {
    final DateTime initialDate =
        controller.selectedCustomDate.value ?? DateTime.now();

    showDatePicker(
      context: context,
      initialDate: initialDate,
      firstDate: DateTime.now(),
      lastDate: DateTime.now().add(const Duration(days: 30)),
      builder: (context, child) {
        return Theme(
          data: Theme.of(context).copyWith(
            colorScheme: ColorScheme.light(primary: AppColors.primary01),
          ),
          child: child!,
        );
      },
    ).then((selectedDate) {
      if (selectedDate != null) {
        controller.selectCustomDate(selectedDate);
      }
    });
  }

  bool _isTimeSlotDisabled(
      String timeSlot,
      AssessmentEvaluationController controller,
      ) {
    final selectedDate = controller.selectedCustomDate.value;
    if (selectedDate == null) return false;

    final today = DateTime.now();
    final isToday = selectedDate.year == today.year &&
        selectedDate.month == today.month &&
        selectedDate.day == today.day;
    if (!isToday) return false;

    try {
      final timeParts = timeSlot.split('-');
      if (timeParts.length != 2) return false;

      final startParts = timeParts[0].trim().split(':');
      if (startParts.length != 2) return false;

      final startHour = int.tryParse(startParts[0]);
      final startMinute = int.tryParse(startParts[1]);
      if (startHour == null || startMinute == null) return false;

      final slotStart = DateTime(
        today.year, today.month, today.day, startHour, startMinute,
      );
      return slotStart.isBefore(today);
    } catch (_) {
      return false;
    }
  }

  String _getDefaultDateTime() {
    final now = DateTime.now();
    final today = '${now.day.toString().padLeft(2, '0')}/${now.month.toString().padLeft(2, '0')}';
    final nextHour = now.hour + 1;
    final timeSlot =
        '${nextHour.toString().padLeft(2, '0')}:00-${(nextHour + 1).toString().padLeft(2, '0')}:00';
    return '$today $timeSlot';
  }

  Widget _buildPhoneNumberSection(
      BuildContext context,
      AssessmentEvaluationController controller,
      ) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Icon(Icons.radio_button_off, size: 16, color: AppColors.primary01),
            RichText(
              text: TextSpan(
                text: ' ${LocaleKeys.contact_info_label.trans()}  ',
                style: AppTypography.s14.regular.copyWith(
                  color: AppColors.neutral01,
                ),
                children: [
                  TextSpan(
                    text: '*',
                    style: AppTypography.s14.medium.copyWith(
                      color: AppColors.error,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
        SizedBox(height: 8.h),

        // Contact name
        Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(8.r),
            border: Border.all(color: AppColors.neutral06, width: 1),
          ),
          child: TextField(
            decoration: InputDecoration(
              hintText: LocaleKeys.contact_name_hint.trans(),
              hintStyle: AppTypography.s14.regular.copyWith(
                color: AppColors.neutral04,
              ),
              border: InputBorder.none,
              enabledBorder: InputBorder.none,
              focusedBorder: InputBorder.none,
              contentPadding: EdgeInsets.symmetric(
                horizontal: 16.w,
                vertical: 12.h,
              ),
            ),
            style: AppTypography.s14.regular.copyWith(
              color: AppColors.neutral01,
            ),
            onChanged: controller.updateStoreContactName,
          ),
        ),
        Obx(
              () => controller.storeContactNameError.value != null
              ? Padding(
            padding: EdgeInsets.only(top: 4.h),
            child: Text(
              controller.storeContactNameError.value!,
              style: AppTypography.s12.regular.copyWith(
                color: AppColors.error,
              ),
            ),
          )
              : const SizedBox.shrink(),
        ),
        SizedBox(height: 16.h),

        // Phone number
        Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(8.r),
            border: Border.all(color: AppColors.neutral06, width: 1),
          ),
          child: TextField(
            keyboardType: TextInputType.phone,
            decoration: InputDecoration(
              hintText: LocaleKeys.phone_number_hint.trans(),
              hintStyle: AppTypography.s14.regular.copyWith(
                color: AppColors.neutral04,
              ),
              border: InputBorder.none,
              enabledBorder: InputBorder.none,
              focusedBorder: InputBorder.none,
              contentPadding: EdgeInsets.symmetric(
                horizontal: 16.w,
                vertical: 12.h,
              ),
            ),
            style: AppTypography.s14.regular.copyWith(
              color: AppColors.neutral01,
            ),
            onChanged: controller.updateStorePhoneNumber,
          ),
        ),
        Obx(
              () => controller.storePhoneNumberError.value != null
              ? Padding(
            padding: EdgeInsets.only(top: 4.h),
            child: Text(
              controller.storePhoneNumberError.value!,
              style: AppTypography.s12.regular.copyWith(
                color: AppColors.error,
              ),
            ),
          )
              : const SizedBox.shrink(),
        ),
      ],
    );
  }
}
