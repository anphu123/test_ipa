import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_typography.dart';
import '../../home_pickup_zone/controllers/home_pickup_zone_controller.dart';
import '../controllers/assessment_evaluation_controller.dart';
import '../pages/address_selection_page.dart';

// i18n
import '../../../core/assets/locale_keys.g.dart';
import 'package:fido_box_demo01/core/extensions/string_extension.dart';

class AtHomeContentWidget extends StatelessWidget {
  final Function(String, bool) buildTimeSlot;

  const AtHomeContentWidget({super.key, required this.buildTimeSlot});

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<AssessmentEvaluationController>();

    WidgetsBinding.instance.addPostFrameCallback((_) {
      _loadDefaultAddressIfNeeded(controller);
    });

    return GetX<AssessmentEvaluationController>(
      builder: (controller) {
        return Container(
          padding: EdgeInsets.all(12.w),
          decoration: const BoxDecoration(),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: 12.h),
              _buildAddressSection(),
              SizedBox(height: 12.h),
              _buildTimeSlotSection(context, controller),
            ],
          ),
        );
      },
    );
  }

  void _loadDefaultAddressIfNeeded(AssessmentEvaluationController controller) {
    if (controller.savedAddress.value == null ||
        controller.savedAddress.value!.isEmpty) {
      try {
        final homePickupController = Get.find<HomePickupZoneController>();

        var defaultAddress = homePickupController.getDefaultAddress();

        if (defaultAddress == null &&
            homePickupController.savedBookingList.isNotEmpty) {
          defaultAddress = homePickupController.savedBookingList.first;
          print('No default address found, using first address in list');
        }

        if (defaultAddress != null) {
          print('Loading address: ${defaultAddress['fullAddress']}');

          controller.savedAddress.value = defaultAddress['fullAddress'] ?? '';
          controller.savedContactName.value =
              defaultAddress['contactName'] ?? '';
          controller.savedPhoneNumber.value =
              defaultAddress['phoneNumber'] ?? '';
          controller.hasBookingHistory.value = true;

          controller.saveBookingInfo(
            contactName: defaultAddress['contactName'] ?? '',
            phoneNumber: defaultAddress['phoneNumber'] ?? '',
            address: defaultAddress['fullAddress'] ?? '',
            dateTime: '',
          );

          print(
            'Address loaded successfully: ${defaultAddress['isDefault'] == true ? "Default" : "First in list"}',
          );
        } else {
          print('No addresses found in list');
        }
      } catch (e) {
        print('Error loading address: $e');
      }
    }
  }

  void _forceLoadDefaultAddress(AssessmentEvaluationController controller) {
    try {
      final homePickupController = Get.find<HomePickupZoneController>();

      var selectedAddress = homePickupController.getDefaultAddress();
      String addressType = LocaleKeys.addr_type_default.trans();

      if (selectedAddress == null &&
          homePickupController.savedBookingList.isNotEmpty) {
        selectedAddress = homePickupController.savedBookingList.first;
        addressType = LocaleKeys.addr_type_first_in_list.trans();
      }

      if (selectedAddress != null) {
        print('Force loading address: ${selectedAddress['fullAddress']}');

        controller.savedAddress.value = selectedAddress['fullAddress'] ?? '';
        controller.savedContactName.value =
            selectedAddress['contactName'] ?? '';
        controller.savedPhoneNumber.value =
            selectedAddress['phoneNumber'] ?? '';
        controller.hasBookingHistory.value = true;

        controller.saveBookingInfo(
          contactName: selectedAddress['contactName'] ?? '',
          phoneNumber: selectedAddress['phoneNumber'] ?? '',
          address: selectedAddress['fullAddress'] ?? '',
          dateTime: '',
        );

        Get.snackbar(
          LocaleKeys.success.trans(),
          '${LocaleKeys.loaded_address_type.trans()}: $addressType\n${selectedAddress['fullAddress']}',
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: AppColors.success,
          colorText: Colors.white,
          duration: const Duration(seconds: 2),
        );
      } else {
        Get.snackbar(
          LocaleKeys.notification.trans(),
          LocaleKeys.no_saved_addresses.trans(),
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: AppColors.AS01,
          colorText: Colors.white,
          duration: const Duration(seconds: 3),
        );
      }
    } catch (e) {
      print('Error force loading address: $e');
      Get.snackbar(
        LocaleKeys.error.trans(),
        LocaleKeys.cannot_load_address_try_again.trans(),
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: AppColors.error,
        colorText: Colors.white,
        duration: const Duration(seconds: 3),
      );
    }
  }

  Widget _buildAddressSection() {
    final controller = Get.find<AssessmentEvaluationController>();

    return Obx(() {
      if (controller.hasBookingHistory.value) {
        return GestureDetector(
          onTap: () => _showAddressListDialog(controller),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Icon(
                Icons.radio_button_off,
                size: 16,
                color: AppColors.primary01,
              ),
              SizedBox(width: 8.w),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      '${controller.savedContactName.value} - ${controller.savedPhoneNumber.value}',
                      style: AppTypography.s11.regular,
                    ),
                    Text(
                      '${controller.savedAddress.value}',
                      style: AppTypography.s11.regular,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                    if (controller.savedDateTime.value?.isNotEmpty == true)
                      Text(
                        '${LocaleKeys.time_label_prefix.trans()} ${controller.savedDateTime.value}',
                        style: AppTypography.s11.regular,
                      ),
                  ],
                ),
              ),
              SizedBox(width: 8.w),
              Icon(
                Icons.keyboard_arrow_right,
                size: 16.sp,
                color: AppColors.neutral04,
              ),
            ],
          ),
        );
      }

      return Container(
        padding: EdgeInsets.all(12.w),
        decoration: BoxDecoration(
          color: AppColors.neutral08,
          borderRadius: BorderRadius.circular(8.r),
          border: Border.all(color: AppColors.neutral06),
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Icon(Icons.radio_button_off, size: 16, color: AppColors.primary01),
            SizedBox(width: 8.w),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    LocaleKeys.no_booking_info.trans(),
                    style: AppTypography.s12.medium.copyWith(
                      color: AppColors.neutral02,
                    ),
                  ),
                  SizedBox(height: 8.h),
                  Row(
                    children: [
                      Expanded(
                        child: ElevatedButton.icon(
                          onPressed: () => _forceLoadDefaultAddress(controller),
                          icon: const Icon(Icons.home, size: 16),
                          label: Text(LocaleKeys.load_address.trans()),
                          style: ElevatedButton.styleFrom(
                            backgroundColor: AppColors.primary01,
                            foregroundColor: Colors.white,
                          ),
                        ),
                      ),
                      SizedBox(width: 8.w),
                      Expanded(
                        child: OutlinedButton.icon(
                          onPressed: () => _showAddressListDialog(controller),
                          icon: const Icon(Icons.list, size: 16),
                          label: Text(LocaleKeys.choose_address.trans()),
                          style: OutlinedButton.styleFrom(
                            foregroundColor: AppColors.primary01,
                            side: BorderSide(color: AppColors.primary01),
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            SizedBox(width: 8.w),
            Icon(
              Icons.keyboard_arrow_right,
              size: 16.sp,
              color: AppColors.neutral04,
            ),
          ],
        ),
      );
    });
  }

  void refreshDefaultAddress() {
    try {
      final controller = Get.find<AssessmentEvaluationController>();
      controller.savedAddress.value = '';
      controller.hasBookingHistory.value = false;
      _loadDefaultAddressIfNeeded(controller);
    } catch (e) {
      print('Error refreshing address: $e');
    }
  }

  void checkAndLoadAddress() {
    try {
      final controller = Get.find<AssessmentEvaluationController>();
      _loadDefaultAddressIfNeeded(controller);
    } catch (e) {
      print('Error checking address: $e');
    }
  }

  void _syncWithHomeControllerSafe(
      AssessmentEvaluationController assessmentController,
      ) {
    try {
      final homeController = Get.find<HomePickupZoneController>();
      _syncWithHomeController(assessmentController, homeController);
    } catch (_) {}
  }

  void _syncWithHomeController(
      AssessmentEvaluationController assessmentController,
      HomePickupZoneController homeController,
      ) {
    final defaultAddress = homeController.getDefaultAddress();

    if (defaultAddress != null) {
      final currentAddress =
          assessmentController.savedAddress.value?.trim() ?? '';
      final defaultFullAddress =
          defaultAddress['fullAddress']?.toString().trim() ?? '';
      final defaultContactName =
          defaultAddress['contactName']?.toString().trim() ?? '';
      final defaultPhoneNumber =
          defaultAddress['phoneNumber']?.toString().trim() ?? '';

      if (currentAddress != defaultFullAddress &&
          defaultFullAddress.isNotEmpty) {
        print('Syncing with new default address: $defaultFullAddress');

        assessmentController.savedAddress.value = defaultFullAddress;
        assessmentController.savedContactName.value = defaultContactName;
        assessmentController.savedPhoneNumber.value = defaultPhoneNumber;
        assessmentController.hasBookingHistory.value = true;

        assessmentController.saveBookingInfo(
          contactName: defaultContactName,
          phoneNumber: defaultPhoneNumber,
          address: defaultFullAddress,
          dateTime: assessmentController.savedDateTime.value ?? '',
        );

        print('Address synced successfully');
      }
    }
  }

  static void forceSyncDefaultAddress() {
    try {
      final assessmentController = Get.find<AssessmentEvaluationController>();
      final homeController = Get.find<HomePickupZoneController>();

      final defaultAddress = homeController.getDefaultAddress();
      if (defaultAddress != null) {
        print(
          'Force syncing default address: ${defaultAddress['fullAddress']}',
        );

        assessmentController.savedAddress.value =
            defaultAddress['fullAddress'] ?? '';
        assessmentController.savedContactName.value =
            defaultAddress['contactName'] ?? '';
        assessmentController.savedPhoneNumber.value =
            defaultAddress['phoneNumber'] ?? '';
        assessmentController.hasBookingHistory.value = true;

        assessmentController.savedAddress.refresh();
        assessmentController.savedContactName.refresh();
        assessmentController.savedPhoneNumber.refresh();
        assessmentController.hasBookingHistory.refresh();

        assessmentController.saveBookingInfo(
          contactName: defaultAddress['contactName'] ?? '',
          phoneNumber: defaultAddress['phoneNumber'] ?? '',
          address: defaultAddress['fullAddress'] ?? '',
          dateTime: assessmentController.savedDateTime.value ?? '',
        );

        print('Force sync completed');
      }
    } catch (e) {
      print('Error force syncing: $e');
    }
  }

  void _showAddressListDialog(AssessmentEvaluationController controller) {
    try {
      if (!Get.isRegistered<HomePickupZoneController>()) {
        Get.put(HomePickupZoneController(), permanent: true);
      }

      Get.to(() => const AddressSelectionPage());
    } catch (e) {
      print('Error navigating to address selection: $e');
      Get.snackbar(
        LocaleKeys.error.trans(),
        LocaleKeys.cannot_open_address_list.trans(),
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: AppColors.error,
        colorText: Colors.white,
      );
    }
  }

  Widget _buildTimeSlotSection(
      BuildContext context,
      AssessmentEvaluationController controller,
      ) {
    return GestureDetector(
      onTap: () => _showDateTimePickerBottomSheet(context, controller),
      child: Row(
        children: [
          Icon(Icons.radio_button_off, size: 16.sp, color: AppColors.primary01),
          SizedBox(width: 8.w),
          Expanded(
            child: Text(
              controller.selectedDateTime.value ?? _getDefaultTimeSlot(),
              style: AppTypography.s12.regular.copyWith(
                color: AppColors.neutral01,
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
    );
  }

  void _showDateTimePickerBottomSheet(
      BuildContext context,
      AssessmentEvaluationController assessmentController,
      ) {
    Get.bottomSheet(
      Container(
        height: MediaQuery.of(context).size.height * 0.6,
        decoration: BoxDecoration(
          color: AppColors.white,
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
            Expanded(
              child: _buildDatePickerSection(context, assessmentController),
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
    final today = DateTime.now();
    final tomorrow = today.add(const Duration(days: 1));

    DateTime dayAfterTomorrow = today.add(const Duration(days: 2));
    while (dayAfterTomorrow.weekday == DateTime.saturday ||
        dayAfterTomorrow.weekday == DateTime.sunday) {
      dayAfterTomorrow = dayAfterTomorrow.add(const Duration(days: 1));
    }

    final todayStr =
        '${today.day.toString().padLeft(2, '0')}/${today.month.toString().padLeft(2, '0')}/${today.year}';
    final tomorrowStr =
        '${tomorrow.day.toString().padLeft(2, '0')}/${tomorrow.month.toString().padLeft(2, '0')}/${tomorrow.year}';
    final dayAfterTomorrowStr =
        '${dayAfterTomorrow.day.toString().padLeft(2, '0')}/${dayAfterTomorrow.month.toString().padLeft(2, '0')}/${dayAfterTomorrow.year}';

    return SizedBox(
      height: 400.h,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            decoration: BoxDecoration(color: AppColors.neutral07),
            child: Column(
              children: [
                _buildDateTab(
                  todayStr,
                  '(${LocaleKeys.today.trans()})',
                  0,
                  controller,
                ),
                _buildDateTab(
                  tomorrowStr,
                  '(${LocaleKeys.tomorrow.trans()})',
                  1,
                  controller,
                ),
                SizedBox(height: 8.h),
                _buildDateTab(
                  dayAfterTomorrowStr,
                  '(${_getDayOfWeek(dayAfterTomorrow)})',
                  2,
                  controller,
                ),
              ],
            ),
          ),
          Expanded(
            child: Obx(() {
              final timeSlots = _getTimeSlotsForSelectedDate(
                controller.selectedDateIndex.value,
              );
              final selectedDate = _getSelectedDateString(
                controller.selectedDateIndex.value,
              );

              return Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: timeSlots.map((slot) {
                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          slot['period'],
                          style: AppTypography.s14.medium.copyWith(
                            color: AppColors.neutral01,
                          ),
                        ),
                        Obx(() {
                          final isTimeSelected =
                              controller.selectedDateTime.value ==
                                  '$selectedDate ${slot['time']}';

                          final isDisabled = _isTimeSlotDisabled(
                              slot['time'], selectedDate, controller);

                          return GestureDetector(
                            onTap: isDisabled
                                ? null
                                : () => controller.selectDateTime(
                              '$selectedDate ${slot['time']}',
                            ),
                            child: Container(
                              width: double.infinity,
                              height: 40.h,
                              padding: EdgeInsets.symmetric(
                                vertical: 8.h,
                                horizontal: 12.w,
                              ),
                              decoration: BoxDecoration(
                                color: isDisabled
                                    ? AppColors.neutral06
                                    : isTimeSelected
                                    ? AppColors.primary05
                                    : AppColors.neutral08,
                                borderRadius: BorderRadius.circular(8.r),
                                border: Border.all(
                                  color: isDisabled
                                      ? AppColors.neutral04
                                      : isTimeSelected
                                      ? AppColors.primary01
                                      : Colors.transparent,
                                  width: isTimeSelected ? 2 : 1,
                                ),
                              ),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(
                                    slot['time'],
                                    style: AppTypography.s12.regular.copyWith(
                                      color: isDisabled
                                          ? AppColors.neutral04
                                          : AppColors.neutral01,
                                    ),
                                  ),
                                  SizedBox(width: 8.w),
                                  if (slot['isRecommended'])
                                    Container(
                                      padding: EdgeInsets.symmetric(
                                        horizontal: 8.w,
                                        vertical: 4.h,
                                      ),
                                      decoration: BoxDecoration(
                                        color: AppColors.AS02,
                                        borderRadius:
                                        BorderRadius.circular(4.r),
                                        border: Border.all(
                                          color: AppColors.AS01,
                                          width: 1,
                                        ),
                                      ),
                                      child: Text(
                                        LocaleKeys.recommended.trans(),
                                        style:
                                        AppTypography.s10.regular.copyWith(
                                          color: AppColors.AS01,
                                        ),
                                      ),
                                    ),
                                ],
                              ),
                            ),
                          );
                        }),
                        SizedBox(height: 8.h),
                      ],
                    );
                  }).toList(),
                ),
              );
            }),
          ),
        ],
      ),
    );
  }

  String _getDayOfWeek(DateTime date) {
    switch (date.weekday) {
      case DateTime.monday:
        return LocaleKeys.weekday_mon.trans();
      case DateTime.tuesday:
        return LocaleKeys.weekday_tue.trans();
      case DateTime.wednesday:
        return LocaleKeys.weekday_wed.trans();
      case DateTime.thursday:
        return LocaleKeys.weekday_thu.trans();
      case DateTime.friday:
        return LocaleKeys.weekday_fri.trans();
      case DateTime.saturday:
        return LocaleKeys.weekday_sat.trans();
      case DateTime.sunday:
      default:
        return LocaleKeys.weekday_sun.trans();
    }
  }

  List<String> _getMorningSlots() => ['09:00-12:00'];
  List<String> _getAfternoonSlots() => ['12:00-15:00', '15:00-18:00'];
  List<String> _getEveningSlots() => ['18:00-19:00'];

  Widget _buildDateTab(
      String date,
      String dayLabel,
      int index,
      AssessmentEvaluationController controller,
      ) {
    return Obx(() {
      final isSelected = controller.selectedDateIndex.value == index;
      return GestureDetector(
        onTap: () => controller.selectDateIndex(index),
        child: Container(
          padding: EdgeInsets.symmetric(vertical: 8.h, horizontal: 16.w),
          decoration: BoxDecoration(
            color: isSelected ? AppColors.white : Colors.transparent,
            borderRadius: BorderRadius.circular(8.r),
          ),
          child: Column(
            children: [
              Text(
                date,
                style: isSelected
                    ? AppTypography.s14.bold.withColor(AppColors.primary01)
                    : AppTypography.s14.regular
                    .withColor(AppColors.neutral01),
              ),
              Text(
                dayLabel,
                style: isSelected
                    ? AppTypography.s14.bold.withColor(AppColors.primary01)
                    : AppTypography.s14.regular
                    .withColor(AppColors.neutral01),
              ),
            ],
          ),
        ),
      );
    });
  }

  List<Map<String, dynamic>> _getTimeSlotsForSelectedDate(int dateIndex) {
    final slots = <Map<String, dynamic>>[];

    final morningSlots = _getMorningSlots();
    for (int i = 0; i < morningSlots.length; i++) {
      slots.add({
        'period': i == 0 ? LocaleKeys.morning.trans() : '',
        'time': morningSlots[i],
        'isRecommended': false,
      });
    }

    final afternoonSlots = _getAfternoonSlots();
    for (int i = 0; i < afternoonSlots.length; i++) {
      slots.add({
        'period': i == 0 ? LocaleKeys.afternoon.trans() : '',
        'time': afternoonSlots[i],
        'isRecommended': true,
      });
    }

    final eveningSlots = _getEveningSlots();
    for (int i = 0; i < eveningSlots.length; i++) {
      slots.add({
        'period': i == 0 ? LocaleKeys.evening.trans() : '',
        'time': eveningSlots[i],
        'isRecommended': false,
      });
    }

    return slots;
  }

  String _getSelectedDateString(int dateIndex) {
    final today = DateTime.now();
    DateTime selectedDate;

    switch (dateIndex) {
      case 0:
        selectedDate = today;
        break;
      case 1:
        selectedDate = today.add(const Duration(days: 1));
        break;
      case 2:
        selectedDate = today.add(const Duration(days: 2));
        while (selectedDate.weekday == DateTime.sunday) {
          selectedDate = selectedDate.add(const Duration(days: 1));
        }
        break;
      default:
        selectedDate = today;
    }

    return '${selectedDate.day.toString().padLeft(2, '0')}/${selectedDate.month.toString().padLeft(2, '0')}/${selectedDate.year}';
  }

  bool _isTimeSlotDisabled(
      String timeSlot,
      String selectedDate,
      AssessmentEvaluationController controller) {
    try {
      final dateParts = selectedDate.split('/');
      if (dateParts.length != 3) return false;

      final day = int.tryParse(dateParts[0]);
      final month = int.tryParse(dateParts[1]);
      final year = int.tryParse(dateParts[2]);
      if (day == null || month == null || year == null) return false;

      final selectedDateTime = DateTime(year, month, day);
      final now = DateTime.now();

      final isToday = selectedDateTime.year == now.year &&
          selectedDateTime.month == now.month &&
          selectedDateTime.day == now.day;

      if (!isToday) return false;

      final timeParts = timeSlot.split('-');
      if (timeParts.length != 2) return false;

      final startTime = timeParts[0].trim();
      final startTimeParts = startTime.split(':');
      if (startTimeParts.length != 2) return false;

      final startHour = int.tryParse(startTimeParts[0]);
      final startMinute = int.tryParse(startTimeParts[1]);
      if (startHour == null || startMinute == null) return false;

      final slotStartTime =
      DateTime(now.year, now.month, now.day, startHour, startMinute);

      return slotStartTime.isBefore(now);
    } catch (e) {
      print('Error parsing time slot: $timeSlot, selectedDate: $selectedDate, error: $e');
      return false;
    }
  }

  String _getDefaultTimeSlot() {
    final now = DateTime.now();
    final today =
        '${now.day.toString().padLeft(2, '0')}/${now.month.toString().padLeft(2, '0')}/${now.year}';

    final allSlots = <String>[];
    allSlots.addAll(_getMorningSlots());
    allSlots.addAll(_getAfternoonSlots());
    allSlots.addAll(_getEveningSlots());

    for (final slot in allSlots) {
      final startTime = slot.split('-')[0];
      final parts = startTime.split(':');
      final slotHour = int.parse(parts[0]);

      if (slotHour > now.hour) {
        return '$today $slot';
      }
    }

    final tomorrow = now.add(const Duration(days: 1));
    final tomorrowStr =
        '${tomorrow.day.toString().padLeft(2, '0')}/${tomorrow.month.toString().padLeft(2, '0')}/${tomorrow.year}';
    return '$tomorrowStr ${allSlots.first}';
  }
}
