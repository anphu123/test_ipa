import 'package:fido_box_demo01/core/extensions/string_extension.dart';
import 'package:fido_box_demo01/core/theme/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import '../../../core/assets/assets.gen.dart';
import '../../../core/assets/locale_keys.g.dart';
import '../../../core/theme/app_typography.dart';
import '../../fido_purchase/widgets/seller_review_card.dart';
import '../../list_store/controllers/list_store_controller.dart';

import '../controllers/assessment_evaluation_controller.dart';
import '../services/phone_number_service.dart';
import '../models/phone_number_model.dart';
import '../../voucher_purchase/domain/voucher_model.dart';
import '../widgets/evaluation_result_box.dart';
import '../widgets/store_pickup_bottom_sheet.dart';
import '../widgets/option_pick_up_order.dart';

import '../../../router/app_page.dart';

class AssessmentEvaluationView extends GetView<AssessmentEvaluationController> {
  const AssessmentEvaluationView({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          colors: [Color(0xFFFF6A00), AppColors.neutral08],
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          stops: [0.0, 0.25],
        ),
      ),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        extendBodyBehindAppBar: true,
        appBar: AppBar(
          title: Text(
            LocaleKeys.inspection_evaluation.trans(),
            style: AppTypography.s16.medium.withColor(AppColors.white),
          ),
          centerTitle: true,
          backgroundColor: Colors.transparent,
          elevation: 0,
          leading: IconButton(
            icon: const Icon(Icons.arrow_back, color: Colors.white),
            onPressed: () => Get.back(),
          ),
          actions: const [
            Padding(
              padding: EdgeInsets.only(right: 12),
              child: Icon(Icons.more_vert, color: Colors.white),
            ),
          ],
        ),
        body: GetBuilder<AssessmentEvaluationController>(
          builder: (controller) {
            return SingleChildScrollView(
              child: Container(
                margin: const EdgeInsets.only(top: 100),
                child: Column(
                  children: [
                    const EvaluationResultBox(),
                    Container(
                      padding: EdgeInsets.symmetric(
                        horizontal: 12.w,
                        vertical: 12.h,
                      ),
                      child: Column(
                        children: [
                          const OptionPickUpOrder(),
                          SizedBox(height: 26.h),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                LocaleKeys.user_reviews.trans(),
                                style: AppTypography.s16.semibold.withColor(
                                  AppColors.neutral01,
                                ),
                              ),
                              GestureDetector(
                                onTap: () => Get.toNamed(Routes.sellerReview),
                                child: Text(
                                  LocaleKeys.see_more.trans(),
                                  style: AppTypography.s14.regular.withColor(
                                    AppColors.primary01,
                                  ),
                                ),
                              ),
                            ],
                          ),
                          SizedBox(height: 12.h),
                          const SellerReviewCard(),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            );
          },
        ),
        bottomNavigationBar: _buildBottomButtons(),
      ),
    );
  }

  Widget _buildBottomButtons() {
    return Container(
      padding: EdgeInsets.all(16.w),
      decoration: BoxDecoration(
        color: AppColors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 10,
            offset: const Offset(0, -2),
          ),
        ],
      ),
      child: Row(
        children: [
          // CSKH (viết tắt) -> dùng key riêng cho nhãn ngắn nếu có, fallback giữ "CSKH"
          GestureDetector(
            onTap: () => Get.toNamed(Routes.supportchat),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Image.asset(Assets.images.icCskh.path),
                SizedBox(height: 4.h),
                Text(
                  (LocaleKeys.customer_service.trans()),
                  style: AppTypography.s12,
                ),
              ],
            ),
          ),
          SizedBox(width: 12.w),

          // Gộp đơn hàng
          Expanded(
            child: GestureDetector(
              onTap: () => Get.toNamed(Routes.comingSoon),
              child: Container(
                height: 48.h,
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  border: Border.all(color: AppColors.neutral04),
                  borderRadius: BorderRadius.circular(8.r),
                ),
                child: Text(
                  LocaleKeys.merge_orders.trans(),
                  style: AppTypography.s16.regular.copyWith(
                    color: AppColors.neutral01,
                  ),
                ),
              ),
            ),
          ),
          SizedBox(width: 12.w),

          // Xác nhận
          Expanded(
            child: GestureDetector(
              onTap: () => _handleConfirmation(),
              child: Container(
                height: 48.h,
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  color: AppColors.primary01,
                  borderRadius: BorderRadius.circular(8.r),
                ),
                child: Text(
                  LocaleKeys.confirm.trans(),
                  style: AppTypography.s16.medium.copyWith(color: Colors.white),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  void _handleConfirmation() {
    // Chưa chọn phương thức
    if (!controller.hasSelectedPickupMethod) {
      Get.snackbar(
        LocaleKeys.notification.trans(),
        'Vui lòng chọn phương thức vận chuyển',
        snackPosition: SnackPosition.TOP,
        backgroundColor: AppColors.error,
        colorText: Colors.white,
      );
      return;
    }

    // Kiểm tra thông tin theo từng phương thức
    final selectedMethod = controller.selectedPickupMethod.value;
    switch (selectedMethod) {
      case 0: // Thu mua tại cửa hàng
        controller.validateStoreFields();
        if (!controller.isStoreInfoValid()) {
          return;
        }
        break;

      case 1: // Thu mua tại nhà
        if (controller.selectedDateTime.value == null) {
          final nearestTimeSlot = _getNearestAvailableTimeSlot();
          controller.selectDateTime(nearestTimeSlot);
        }

        final phoneNumber = controller.savedPhoneNumber.value?.trim() ?? '';
        final contactName = controller.savedContactName.value?.trim() ?? '';
        if (phoneNumber.isEmpty || contactName.isEmpty) {
          Get.snackbar(
            LocaleKeys.notification.trans(),
            'Vui lòng nhập đầy đủ thông tin liên hệ trong tab Thu mua tại nhà',
            snackPosition: SnackPosition.TOP,
            backgroundColor: AppColors.error,
            colorText: Colors.white,
          );
          return;
        }
        break;

      case 2: // Gửi hàng thu mua
        final phoneNumber2 = controller.savedPhoneNumber.value?.trim() ?? '';
        final contactName2 = controller.savedContactName.value?.trim() ?? '';
        if (phoneNumber2.isEmpty || contactName2.isEmpty) {
          Get.snackbar(
            LocaleKeys.notification.trans(),
            'Vui lòng nhập đầy đủ thông tin liên hệ trong tab Thu mua tại nhà',
            snackPosition: SnackPosition.TOP,
            backgroundColor: AppColors.error,
            colorText: Colors.white,
          );
          return;
        }
        break;
    }

    _printCurrentTabInfo();
    _showConfirmationDialog();
  }

  void _showConfirmationDialog() {
    final selectedMethod = controller.selectedPickupMethod.value;

    Get.bottomSheet(
      Container(
        padding: EdgeInsets.all(20.w),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(12.r),
            topRight: Radius.circular(12.r),
          ),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            // Header
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const SizedBox(width: 24),
                Expanded(
                  child: Text(
                    '${LocaleKeys.confirm.trans()} \n${_getDialogSubtitle(selectedMethod)} ',
                    maxLines: 2,
                    textAlign: TextAlign.center,
                    overflow: TextOverflow.ellipsis,
                    style: AppTypography.s16.bold.copyWith(
                      color: AppColors.neutral01,
                    ),
                  ),
                ),
                GestureDetector(
                  onTap: () => Get.back(),
                  child: Icon(
                    Icons.close,
                    color: AppColors.neutral03,
                    size: 24,
                  ),
                ),
              ],
            ),
            SizedBox(height: 16.h),

            // Cảnh báo
            Container(
              padding: EdgeInsets.all(12.w),
              decoration: BoxDecoration(
                color: AppColors.AW02,
                borderRadius: BorderRadius.circular(8.r),
              ),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Icon(Icons.warning_amber, color: AppColors.AW01, size: 20),
                  SizedBox(width: 8.w),
                  Expanded(
                    child: Text(
                      _getWarningMessage(selectedMethod),
                      style: AppTypography.s12.regular.copyWith(
                        color: AppColors.AW01,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: 20.h),

            // Info động
            ..._buildDynamicInfoRows(selectedMethod),
            SizedBox(height: 24.h),

            // Buttons
            Row(
              children: [
                Expanded(
                  child: GestureDetector(
                    onTap: () => Get.back(),
                    child: Container(
                      width: double.infinity,
                      height: 48.h,
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                        color: AppColors.white,
                        borderRadius: BorderRadius.circular(8.r),
                        border: Border.all(color: AppColors.neutral01),
                      ),
                      child: Text(
                        LocaleKeys.canceled.trans(),
                        style: AppTypography.s16.medium.copyWith(
                          color: Colors.black,
                        ),
                      ),
                    ),
                  ),
                ),
                SizedBox(width: 10.h),
                Expanded(
                  child: GestureDetector(
                    onTap: () async {
                      await _handleConfirmationWithPhoneNumber();

                      final orderData = _collectOrderData();
                      Get.back();

                      if (controller.selectedPickupMethod.value == 1) {
                        Get.toNamed(Routes.orderPurchase, arguments: orderData);
                      } else if (controller.selectedPickupMethod.value == 0) {
                        final currentStore = controller.getCurrentStore();
                        final storeOrderData =
                        Map<String, dynamic>.from(orderData);

                        if (currentStore != null) {
                          storeOrderData['storeId'] = currentStore.id;
                          storeOrderData['storeName'] = currentStore.name;
                          storeOrderData['storeDescription'] =
                              currentStore.description;
                          storeOrderData['storeImageUrl'] =
                              currentStore.imageUrl;
                          storeOrderData['storeDistrict'] =
                              currentStore.district;
                          storeOrderData['storeLatitude'] =
                              currentStore.latitude;
                          storeOrderData['storeLongitude'] =
                              currentStore.longitude;
                          storeOrderData['storeOpenHours'] =
                              currentStore.openHours;
                          storeOrderData['storeServices'] =
                              currentStore.services;
                          storeOrderData['storeCategories'] =
                              currentStore.categories;
                          storeOrderData['storeDistance'] =
                              currentStore.distance;

                          storeOrderData['storeAddress'] =
                          '${currentStore.name}, ${currentStore.district}';
                          storeOrderData['storePhoneNumber'] = '+84 123456789';
                        }

                        storeOrderData['pickupMethod'] = 'store_pickup';
                        storeOrderData['pickupMethodName'] =
                            LocaleKeys.buy_in_store.trans();

                        storeOrderData['contactName'] =
                            controller.storeContactName.value ?? '';
                        storeOrderData['phoneNumber'] =
                            controller.storePhoneNumber.value ?? '';

                        final selectedDate = controller.selectedCustomDate.value;
                        final selectedTimeSlot =
                            controller.selectedCustomTimeSlot.value;

                        if (selectedDate != null && selectedTimeSlot != null) {
                          final formattedDate =
                              '${selectedDate.day.toString().padLeft(2, '0')}/${selectedDate.month.toString().padLeft(2, '0')}/${selectedDate.year}';
                          storeOrderData['appointmentTime'] =
                          '$formattedDate $selectedTimeSlot';
                          storeOrderData['appointmentDate'] = formattedDate;
                          storeOrderData['appointmentTimeSlot'] =
                              selectedTimeSlot;
                        } else {
                          storeOrderData['appointmentTime'] =
                              controller.selectedStoreDateTime.value ??
                                  _getDefaultStoreDateTime();
                        }

                        storeOrderData['staffId'] = null;
                        storeOrderData['staffName'] = null;
                        storeOrderData['staffPhoneNumber'] = null;
                        storeOrderData['staffCompletedOrders'] = null;
                        storeOrderData['staffRating'] = null;

                        storeOrderData['orderType'] = 'store_pickup';
                        storeOrderData['createdAt'] =
                            DateTime.now().toIso8601String();
                        storeOrderData['orderSource'] =
                        'assessment_evaluation';

                        storeOrderData['isStoreInfoValid'] =
                            controller.isStoreInfoValid();
                        storeOrderData['hasSelectedStore'] =
                            currentStore != null;
                        storeOrderData['hasValidAppointment'] =
                            (selectedDate != null && selectedTimeSlot != null) ||
                                controller.selectedStoreDateTime.value != null;

                        storeOrderData['evaluationId'] =
                            DateTime.now().millisecondsSinceEpoch.toString();
                        storeOrderData['evaluationTime'] = controller
                            .evaluationTime
                            ?.toIso8601String() ??
                            DateTime.now().toIso8601String();
                        storeOrderData['remainingTime'] =
                            controller.remainingTime.value;

                        if (controller.selectedVoucher.value != null) {
                          final voucher = controller.selectedVoucher.value!;
                          storeOrderData['selectedVoucher'] = {
                            'id': voucher.id,
                            'amount': voucher.amount,
                            'condition': voucher.condition,
                            'expiry': voucher.expiry,
                            'expiryDate': voucher.expiryDate,
                            'status': voucher.status.name,
                            'discountAmount': voucher.discountAmount,
                            'discountPercentage': voucher.discountPercentage,
                          };
                        }

                        storeOrderData['selectedPickupMethodIndex'] =
                            controller.selectedPickupMethod.value;
                        storeOrderData['pickupMethodOptions'] = [
                          LocaleKeys.buy_in_store.trans(),
                          LocaleKeys.receive_at_home.trans(),
                          LocaleKeys.send_goods.trans(),
                        ];

                        storeOrderData['formValidation'] = {
                          'isStoreContactNameValid':
                          controller.isStoreContactNameValid.value,
                          'isStorePhoneNumberValid':
                          controller.isStorePhoneNumberValid.value,
                          'storeContactNameError':
                          controller.storeContactNameError.value,
                          'storePhoneNumberError':
                          controller.storePhoneNumberError.value,
                        };

                        storeOrderData['preferredLanguage'] = 'vi';
                        storeOrderData['specialRequests'] = '';
                        storeOrderData['notificationPreferences'] = {
                          'sms': true,
                          'email': false,
                          'push': true,
                        };

                        storeOrderData['navigationSource'] =
                        'assessment_evaluation';
                        storeOrderData['previousRoute'] =
                        '/assessment-evaluation';
                        storeOrderData['canGoBack'] = true;

                        Get.toNamed(Routes.orderPurchaseAtStore,
                            arguments: storeOrderData);
                      } else {
                        String methodName = '';
                        switch (controller.selectedPickupMethod.value) {
                          case 2:
                            methodName = LocaleKeys.send_goods.trans();
                            break;
                          default:
                            methodName = LocaleKeys.this_method.trans();
                        }

                        Get.snackbar(
                          LocaleKeys.notification.trans(),
                          '${methodName} ${LocaleKeys.feature_not_implemented.trans()}',
                          snackPosition: SnackPosition.TOP,
                          backgroundColor: Colors.orange,
                          colorText: Colors.white,
                          duration: const Duration(seconds: 3),
                          margin: EdgeInsets.all(16.w),
                          borderRadius: 8.r,
                          icon: const Icon(
                            Icons.info_outline,
                            color: Colors.white,
                          ),
                        );
                      }
                    },
                    child: Container(
                      width: double.infinity,
                      height: 48.h,
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                        color: AppColors.primary01,
                        borderRadius: BorderRadius.circular(8.r),
                      ),
                      child: Text(
                        LocaleKeys.confirm.trans(),
                        style: AppTypography.s16.medium.copyWith(
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
      isScrollControlled: true,
    );
  }

  String _getDialogSubtitle(int selectedMethod) {
    switch (selectedMethod) {
      case 0:
        return LocaleKeys.buy_in_store.trans();
      case 1:
        return LocaleKeys.receive_at_home.trans();
      case 2:
        return LocaleKeys.send_goods.trans();
      default:
        return LocaleKeys.purchase_service.trans();
    }
  }

  String _getWarningMessage(int selectedMethod) {
    switch (selectedMethod) {
      case 0:
        return LocaleKeys.note_buy_in_store.trans();
      case 1:
        return LocaleKeys.note_receive_at_home.trans();
      case 2:
        return LocaleKeys.note_send_goods.trans();
      default:
        return LocaleKeys.note_default.trans();
    }
  }

  List<Widget> _buildDynamicInfoRows(int selectedMethod) {
    switch (selectedMethod) {
      case 0:
        return [_buildStoreInfoColumn()];
      case 1:
        return [_buildHomeInfoRows()];
      case 2:
        return _buildShippingInfoRows();
      default:
        return [];
    }
  }

  Widget _buildStoreInfoColumn() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          LocaleKeys.contact_info.trans(),
          style: AppTypography.s14.medium.copyWith(color: AppColors.neutral01),
        ),
        SizedBox(height: 12.h),
        _buildInfoRow(Icons.person_outline, _getCustomerName()),
        SizedBox(height: 8.h),
        _buildInfoRow(Icons.phone_outlined, _getCustomerPhone()),
        SizedBox(height: 24.h),

        Text(
          LocaleKeys.store_address.trans(),
          style: AppTypography.s14.medium.copyWith(color: AppColors.neutral01),
        ),
        SizedBox(height: 12.h),
        Column(
          children: [
            _buildInfoRowWithIcon(Icons.location_on_outlined, _getStoreName()),
            SizedBox(height: 8.h),
            _buildAlignedInfoRow(Icons.phone_outlined, _getStorePhone()),
            SizedBox(height: 8.h),
            _buildAlignedInfoRow(Icons.location_on_outlined, _getStoreAddress()),
          ],
        ),

        SizedBox(height: 8.h),
        _buildInfoRow(Icons.access_time, _getStoreHours()),
      ],
    );
  }

  Widget _buildHomeInfoRows() {
    final selectedDateTime = controller.selectedDateTime.value;
    final savedDateTime = controller.savedDateTime.value;
    final displayDateTime =
        selectedDateTime ?? savedDateTime ?? _getDefaultHomeDateTime();

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildInfoRow(
          Icons.phone,
          controller.savedPhoneNumber.value ??
              LocaleKeys.phone_not_entered.trans(),
        ),
        SizedBox(height: 12.h),
        _buildInfoRow(
          Icons.location_on,
          controller.savedAddress.value ?? LocaleKeys.address_not_selected.trans(),
        ),
        SizedBox(height: 12.h),
        _buildInfoRow(Icons.access_time, displayDateTime),
      ],
    );
  }

  List<Widget> _buildShippingInfoRows() {
    return [
      _buildInfoRow(Icons.local_shipping, LocaleKeys.send_via_post.trans()),
      SizedBox(height: 12.h),
      _buildInfoRow(Icons.location_on, LocaleKeys.receive_address_fidobox.trans()),
      SizedBox(height: 12.h),
      _buildInfoRow(Icons.info_outline, LocaleKeys.processing_time.trans()),
    ];
  }

  Widget _buildInfoRow(IconData? icon, String value) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (icon != null)
          Padding(
            padding: EdgeInsets.only(right: 8.w, top: 2.h),
            child: Icon(icon, size: 20.w, color: AppColors.neutral04),
          ),
        Expanded(
          child: Text(
            value,
            style: AppTypography.s14.copyWith(color: AppColors.neutral01),
          ),
        ),
      ],
    );
  }

  String _getDefaultStoreDateTime() {
    final now = DateTime.now();
    final tomorrow = now.add(const Duration(days: 1));
    return '${tomorrow.day.toString().padLeft(2, '0')}/${tomorrow.month.toString().padLeft(2, '0')}/${tomorrow.year} 10:00-11:00';
  }

  String _getNearestAvailableTimeSlot() {
    final now = DateTime.now();
    final today =
        '${now.day.toString().padLeft(2, '0')}/${now.month.toString().padLeft(2, '0')}/${now.year}';

    final availableSlots = _getAtHomeTimeSlots();

    for (final slot in availableSlots) {
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
    return '$tomorrowStr ${availableSlots.first}';
  }

  List<String> _getAtHomeTimeSlots() {
    final List<String> slots = [];
    slots.addAll(['09:00-12:00']);
    slots.addAll(['12:00-15:00', '15:00-18:00']);
    slots.addAll(['18:00-19:00']);
    return slots;
  }

  String _getDefaultHomeDateTime() {
    final now = DateTime.now();
    final tomorrow = now.add(const Duration(days: 1));
    return '${tomorrow.day.toString().padLeft(2, '0')}/${tomorrow.month.toString().padLeft(2, '0')}/${tomorrow.year} 14:00-16:00';
  }

  void _printCurrentTabInfo() {
    final selectedMethod = controller.selectedPickupMethod.value;

    print('=== CONFIRMATION INFO ===');
    print('Pickup method: ${controller.pickupMethodName}');
    print('Selected index: $selectedMethod');

    switch (selectedMethod) {
      case 0:
        _printStoreInfo();
        break;
      case 1:
        _printHomeInfo();
        break;
      case 2:
        _printShippingInfo();
        break;
      default:
        print('Invalid method');
    }
  }

  void _printStoreInfo() {
    print('--- STORE INFO ---');
    final currentStore = controller.getCurrentStore();
    final isUserSelected = controller.selectedStore.value != null;

    if (currentStore != null) {
      print(
          'Status: ${isUserSelected ? "User selected" : "Nearest store suggestion"}');
      print('Name: ${currentStore.name}');
      print('District: ${currentStore.district}');
      print('Open hours: ${currentStore.openHours}');
      print('Description: ${currentStore.description}');
      print('Services: ${currentStore.services.join(", ")}');
      print('Categories: ${currentStore.categories.join(", ")}');
      print('Distance: ${currentStore.distance} km');
      print('Lat/Lng: ${currentStore.latitude}, ${currentStore.longitude}');
      print('ID: ${currentStore.id}');
    } else {
      print('No available store');
    }

    final selectedCustomDateTime =
        '${controller.selectedCustomDate.value} ${controller.selectedCustomTimeSlot.value}';
    print("Time slot: ${selectedCustomDateTime ?? _getDefaultStoreDateTime()}");

    try {
      if (Get.isRegistered<ListStoreController>()) {
        final storeController = Get.find<ListStoreController>();
        print('Total stores: ${storeController.stores.length}');
        print('Filtered stores: ${storeController.filteredStores.length}');
        print('Selected location: ${storeController.selectedLocation.value}');
        print('Nearest district: ${storeController.nearestDistrict.value}');
      }
    } catch (e) {
      print('Cannot get store list: $e');
    }
  }

  void _printHomeInfo() {
    print('--- HOME INFO ---');
    print('Phone: ${controller.savedPhoneNumber.value ?? "-"}');
    print('Address: ${controller.savedAddress.value ?? "-"}');
    print('Name: ${controller.savedContactName.value ?? "-"}');

    final selectedDateTime = controller.selectedDateTime.value;
    final savedDateTime = controller.savedDateTime.value;
    print('Selected DateTime: $selectedDateTime');
    print('Saved DateTime: $savedDateTime');
    print(
        'Display DateTime: ${selectedDateTime ?? savedDateTime ?? _getDefaultHomeDateTime()}');

    print('Has history: ${controller.hasBookingHistory.value}');
    print('Selected date: ${controller.selectedDate.value}');
    print('Selected date index: ${controller.selectedDateIndex.value}');
    print('Custom date: ${controller.selectedCustomDate.value}');
    print('Custom time slot: ${controller.selectedCustomTimeSlot.value}');
  }

  void _printShippingInfo() {
    print('--- SHIPPING INFO ---');
    print('Method: ${LocaleKeys.send_via_post.trans()}');
    print('Receive: ${LocaleKeys.receive_address_fidobox.trans()}');
    print('Processing: ${LocaleKeys.processing_time.trans()}');
    print('Note: ${LocaleKeys.note_send_goods.trans()}');
  }

  Future<void> _handleConfirmationWithPhoneNumber() async {
    final selectedMethod = controller.selectedPickupMethod.value;
    final phoneNumberService = PhoneNumberService();

    try {
      String phoneNumber;
      String contactName;
      final methodName = controller.pickupMethodName;

      String dateTime = '';
      String? address;
      String? storeName;

      switch (selectedMethod) {
        case 0: // Store
          phoneNumber = controller.storePhoneNumber.value!.trim();
          contactName = controller.storeContactName.value!.trim();
          dateTime =
              controller.selectedStoreDateTime.value ?? _getDefaultStoreDateTime();
          final currentStore = controller.getCurrentStore();
          storeName = currentStore?.name ?? LocaleKeys.store_name_default.trans();
          address = currentStore?.district ?? LocaleKeys.store_address_default.trans();
          break;

        case 1: // At home
          phoneNumber =
              controller.savedPhoneNumber.value ?? LocaleKeys.phone_not_entered.trans();
          contactName =
              controller.savedContactName.value ?? LocaleKeys.name_not_entered.trans();
          final selectedDateTime = controller.selectedDateTime.value;
          final savedDateTime = controller.savedDateTime.value;
          dateTime =
              selectedDateTime ?? savedDateTime ?? _getDefaultHomeDateTime();
          address =
              controller.savedAddress.value ?? LocaleKeys.address_not_selected.trans();
          break;

        case 2: // Shipping
          phoneNumber =
              controller.savedPhoneNumber.value ?? LocaleKeys.phone_not_entered.trans();
          contactName =
              controller.savedContactName.value ?? LocaleKeys.name_not_entered.trans();
          dateTime = LocaleKeys.date_time_send_goods.trans();
          address = LocaleKeys.send_goods_address.trans();
          break;

        default:
          phoneNumber = LocaleKeys.phone_not_entered.trans();
          contactName = LocaleKeys.name_not_entered.trans();
          break;
      }

      await phoneNumberService.saveConfirmationInfo(
        phoneNumber: phoneNumber,
        contactName: contactName,
        method: methodName,
        dateTime: dateTime,
        address: address,
        storeName: storeName,
        note: 'Xác nhận từ Assessment Evaluation',
      );

      if (selectedMethod == 1) {
        _navigateToOrderPurchaseView(
          phoneNumber: phoneNumber,
          contactName: contactName,
          dateTime: dateTime,
          address: address ?? '',
          methodName: methodName,
        );
      } else {
        Get.snackbar(
          LocaleKeys.success.trans(),
          'Đã xác nhận thông tin $methodName\nSố điện thoại: $phoneNumber',
          snackPosition: SnackPosition.TOP,
          backgroundColor: AppColors.success,
          colorText: Colors.white,
          duration: const Duration(seconds: 3),
        );
      }
    } catch (e) {
      Get.snackbar(
        LocaleKeys.error.trans(),
        'Có lỗi xảy ra khi lưu thông tin. Vui lòng thử lại.',
        snackPosition: SnackPosition.TOP,
        backgroundColor: AppColors.error,
        colorText: Colors.white,
      );
    }
  }

  String _getCustomerName() {
    try {
      return controller.storeContactName.value ?? 'Huynh Mai An Phú';
    } catch (_) {
      return 'Khách hàng';
    }
  }

  String _getCustomerPhone() {
    try {
      return controller.storePhoneNumber.value ?? '+84 123456789';
    } catch (_) {
      return '+84 123456789';
    }
  }

  String _getStoreName() {
    try {
      final currentStore = controller.getCurrentStore();
      return currentStore?.name ?? 'Trung tâm 2Hand';
    } catch (_) {
      return 'Trung tâm 2Hand';
    }
  }

  String _getStorePhone() {
    try {
      return '+84 123456789';
    } catch (_) {
      return '+84 123456789';
    }
  }

  String _getStoreAddress() {
    try {
      final currentStore = controller.getCurrentStore();
      return currentStore?.district ??
          '19 Tân Cảng, phường 25, quận Bình Thạnh, Thành phố Hồ Chí Minh';
    } catch (_) {
      return '19 Tân Cảng, phường 25, quận Bình Thạnh, Thành phố Hồ Chí Minh';
    }
  }

  String _getStoreHours() {
    try {
      final selectedStoreDateTime = controller.selectedStoreDateTime.value;
      if (selectedStoreDateTime != null) return selectedStoreDateTime;

      final now = DateTime.now();
      final formattedDate =
          '${now.day.toString().padLeft(2, '0')}/${now.month.toString().padLeft(2, '0')}/${now.year}';
      return '$formattedDate 18:00-19:00';
    } catch (_) {
      final now = DateTime.now();
      final formattedDate =
          '${now.day.toString().padLeft(2, '0')}/${now.month.toString().padLeft(2, '0')}/${now.year}';
      return '$formattedDate 18:00-19:00';
    }
  }

  Widget _buildAlignedInfoRow(IconData icon, String text) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(width: 24, height: 24, margin: const EdgeInsets.only(top: 2)),
        SizedBox(width: 12.w),
        Expanded(
          child: Text(
            text,
            style: AppTypography.s14.regular.copyWith(
              color: AppColors.neutral02,
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildInfoRowWithIcon(IconData icon, String text) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          width: 24,
          height: 24,
          margin: const EdgeInsets.only(top: 2),
          child: Icon(icon, color: AppColors.neutral03, size: 20),
        ),
        SizedBox(width: 12.w),
        Expanded(
          child: Text(
            text,
            style: AppTypography.s14.regular.copyWith(
              color: AppColors.neutral02,
            ),
          ),
        ),
      ],
    );
  }

  void _navigateToOrderPurchaseView({
    required String phoneNumber,
    required String contactName,
    required String dateTime,
    required String address,
    required String methodName,
  }) {
    final productInfo = controller.result;
    final selectedVoucher = controller.selectedVoucher.value;

    final orderData = {
      'phoneNumber': phoneNumber,
      'contactName': contactName,
      'address': address,
      'dateTime': dateTime,
      'method': methodName,
      'productModel': productInfo.model,
      'productCapacity': productInfo.capacity,
      'productVersion': productInfo.version,
      'warranty': productInfo.warranty,
      'lockStatus': productInfo.lockStatus,
      'cloudStatus': productInfo.cloudStatus,
      'batteryStatus': productInfo.batteryStatus,
      'appearance': productInfo.appearance,
      'display': productInfo.display,
      'repair': productInfo.repair,
      'screenRepair': productInfo.screenRepair,
      'functionality': productInfo.functionality,
      'evaluatedPrice': productInfo.evaluatedPrice,
      'selectedVoucher': selectedVoucher?.toJson(),
      'createdAt': DateTime.now().toIso8601String(),
    };

    if (controller.selectedPickupMethod.value == 1) {
      Get.toNamed(Routes.orderPurchase, arguments: orderData);
    } else {
      String methodNameKey;
      switch (controller.selectedPickupMethod.value) {
        case 0:
          methodNameKey = LocaleKeys.buy_in_store.trans();
          break;
        case 2:
          methodNameKey = LocaleKeys.send_goods.trans();
          break;
        default:
          methodNameKey = LocaleKeys.this_method.trans();
      }

      Get.snackbar(
        LocaleKeys.notification.trans(),
        '${methodNameKey} ${LocaleKeys.feature_not_implemented.trans()}',
        snackPosition: SnackPosition.TOP,
        backgroundColor: Colors.orange,
        colorText: Colors.white,
        duration: const Duration(seconds: 3),
        margin: EdgeInsets.all(16.w),
        borderRadius: 8.r,
        icon: const Icon(
          Icons.info_outline,
          color: Colors.white,
        ),
      );
    }
  }

  Map<String, dynamic> _collectOrderData() {
    final evaluateResult = controller.result;
    final selectedVoucher = controller.selectedVoucher.value;

    String phoneNumber = '';
    String contactName = '';
    String address = '';
    String dateTime = '';

    final selectedMethod = controller.selectedPickupMethod.value;

    if (selectedMethod == 1) {
      phoneNumber = controller.savedPhoneNumber.value ?? '';
      contactName = controller.savedContactName.value ?? '';
      address = controller.savedAddress.value ?? '';
      final selectedDateTime = controller.selectedDateTime.value;
      final savedDateTime = controller.savedDateTime.value;
      dateTime = selectedDateTime ?? savedDateTime ?? '';
    } else if (selectedMethod == 0) {
      phoneNumber = controller.storePhoneNumber.value ?? '';
      contactName = controller.storeContactName.value ?? '';
      final selectedStore = controller.selectedStore.value;
      address = selectedStore?.name ?? '';
      final selectedDate = controller.selectedCustomDate.value;
      final selectedTimeSlot = controller.selectedCustomTimeSlot.value;
      if (selectedDate != null && selectedTimeSlot != null) {
        dateTime =
        '${selectedDate.day}/${selectedDate.month}/${selectedDate.year} - $selectedTimeSlot';
      }
    }

    return {
      'phoneNumber': phoneNumber,
      'contactName': contactName,
      'address': address,
      'dateTime': dateTime,
      'productModel': evaluateResult.model,
      'productCapacity': evaluateResult.capacity,
      'productVersion': evaluateResult.version,
      'warranty': evaluateResult.warranty,
      'batteryStatus': evaluateResult.batteryStatus,
      'appearance': evaluateResult.appearance,
      'display': evaluateResult.display,
      'repair': evaluateResult.repair,
      'screenRepair': evaluateResult.screenRepair,
      'functionality': evaluateResult.functionality,
      'evaluatedPrice': evaluateResult.evaluatedPrice,
      'finalPrice': _calculateFinalPrice(evaluateResult.evaluatedPrice, selectedVoucher),
      'selectedVoucher': selectedVoucher?.toJson(),
      'pickupMethod': selectedMethod,
      'pickupMethodName': selectedMethod == 1
          ? LocaleKeys.receive_at_home.trans()
          : LocaleKeys.buy_in_store.trans(),
      'createdAt': DateTime.now().toIso8601String(),
    };
  }

  int _calculateFinalPrice(int basePrice, VoucherModel? voucher) {
    if (voucher == null) return basePrice;
    int discountAmount = 0;

    if (voucher.discountPercentage != null && voucher.discountPercentage! > 0) {
      discountAmount = (basePrice * voucher.discountPercentage! / 100).round();
    } else {
      discountAmount = voucher.discountAmount ?? 0;
    }

    // Nếu discountAmount là số âm (giảm giá), cộng để ra giá cuối
    return basePrice + discountAmount;
  }
}

class ValidationResult {
  final bool isValid;
  final String message;

  ValidationResult(this.isValid, this.message);
}
