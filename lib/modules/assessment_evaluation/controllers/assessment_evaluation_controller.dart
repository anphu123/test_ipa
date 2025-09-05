import 'dart:async';
import 'package:fido_box_demo01/router/app_page.dart';
import 'package:get/get.dart';
import '../../voucher_purchase/domain/voucher_model.dart';
import '../../list_store/domain/store_model.dart';
import '../../list_store/controllers/list_store_controller.dart';
import '../domain/evaluate_result_model.dart';
import 'package:get_storage/get_storage.dart';
import '../../home_pickup_zone/controllers/home_pickup_zone_controller.dart';

// ✅ i18n
import '../../../core/assets/locale_keys.g.dart';
import 'package:fido_box_demo01/core/extensions/string_extension.dart';

class AssessmentEvaluationController extends GetxController {
  late final EvaluateResultModel result;
  Timer? _countdownTimer;
  final RxString remainingTime = '24:00:00'.obs;
  DateTime? evaluationTime;
  final Rxn<VoucherModel> selectedVoucher = Rxn<VoucherModel>();
  final Rxn<StoreModel> selectedStore = Rxn<StoreModel>();

  // AtHome tab - date time selection
  final RxnString selectedDateTime = RxnString();
  final RxnString selectedDate = RxnString();
  final RxInt selectedDateIndex = 0.obs;

  // Store tab - date time selection (riêng biệt với AtHome)
  final Rxn<DateTime> selectedCustomDate = Rxn<DateTime>();
  final RxnString selectedCustomTimeSlot = RxnString();
  final RxnString selectedStoreDateTime = RxnString(); // DateTime riêng cho Store tab

  // Store tab - phone number (riêng biệt với AtHome)
  final RxnString storePhoneNumber = RxnString();
  final RxnString storeContactName = RxnString();

  // Store tab - validation states
  final RxBool isStoreContactNameValid = true.obs;
  final RxBool isStorePhoneNumberValid = true.obs;
  final RxnString storeContactNameError = RxnString();
  final RxnString storePhoneNumberError = RxnString();

  // Thêm các biến lưu trữ thông tin booking
  final RxnString savedContactName = RxnString();
  final RxnString savedPhoneNumber = RxnString();
  final RxnString savedAddress = RxnString();
  final RxnString savedDateTime = RxnString();
  final RxBool hasBookingHistory = false.obs;

  // Phương thức vận chuyển đã chọn (0: Cửa hàng, 1: Tại nhà, 2: Gửi hàng)
  final RxInt selectedPickupMethod = (-1).obs; // -1 = chưa chọn

  void selectDate(String date) {
    selectedDate.value = date;
  }

  void selectDateTime(String dateTime) {
    selectedDateTime.value = dateTime;
    print('🏠 AtHome tab - selectedDateTime: $dateTime');
    print('🏠 AtHome tab - selectedStoreDateTime: ${selectedStoreDateTime.value}');
    print('🏠 AtHome tab - selectedCustomTimeSlot: ${selectedCustomTimeSlot.value}');
    print('---');
  }

  void clearSelectedDateTime() {
    selectedDateTime.value = null;
  }

  void clearStoreDateTime() {
    selectedCustomDate.value = null;
    selectedCustomTimeSlot.value = null;
    selectedStoreDateTime.value = null;
  }

  void updateStorePhoneNumber(String phoneNumber) {
    storePhoneNumber.value = phoneNumber;
    _validateStorePhoneNumber(phoneNumber);
    print('🏪 Store tab - updateStorePhoneNumber: $phoneNumber');
  }

  void updateStoreContactName(String contactName) {
    storeContactName.value = contactName;
    _validateStoreContactName(contactName);
    print('🏪 Store tab - updateStoreContactName: $contactName');
  }

  /// Validate tên liên hệ real-time
  void _validateStoreContactName(String contactName) {
    final trimmed = contactName.trim();
    if (trimmed.isEmpty) {
      isStoreContactNameValid.value = false;
      // i18n
      storeContactNameError.value = LocaleKeys.store_contact_name_empty.trans();
    } else {
      isStoreContactNameValid.value = true;
      storeContactNameError.value = null;
    }
  }

  /// Validate số điện thoại real-time
  void _validateStorePhoneNumber(String phoneNumber) {
    final trimmed = phoneNumber.trim();
    if (trimmed.isEmpty) {
      isStorePhoneNumberValid.value = false;
      // i18n
      storePhoneNumberError.value = LocaleKeys.store_phone_empty.trans();
    } else {
      // Kiểm tra format số điện thoại
      final RegExp phoneRegex = RegExp(r'^(0|\+84)[3|5|7|8|9][0-9]{8}$');
      final cleanNumber = trimmed.replaceAll(' ', '').replaceAll('-', '');
      if (!phoneRegex.hasMatch(cleanNumber)) {
        isStorePhoneNumberValid.value = false;
        // i18n
        storePhoneNumberError.value = LocaleKeys.store_phone_invalid.trans();
      } else {
        isStorePhoneNumberValid.value = true;
        storePhoneNumberError.value = null;
      }
    }
  }

  /// Kiểm tra thông tin Store tab có hợp lệ không
  bool isStoreInfoValid() {
    final phoneNumber = storePhoneNumber.value?.trim() ?? '';
    final contactName = storeContactName.value?.trim() ?? '';

    if (contactName.isEmpty) {
      print('❌ ${LocaleKeys.store_contact_name_empty.trans()}');
      return false;
    }

    if (phoneNumber.isEmpty) {
      print('❌ ${LocaleKeys.store_phone_empty.trans()}');
      return false;
    }

    // Kiểm tra format số điện thoại
    final RegExp phoneRegex = RegExp(r'^(0|\+84)[3|5|7|8|9][0-9]{8}$');
    final cleanNumber = phoneNumber.replaceAll(' ', '').replaceAll('-', '');
    if (!phoneRegex.hasMatch(cleanNumber)) {
      print('❌ ${LocaleKeys.store_phone_invalid.trans()}');
      return false;
    }

    return true;
  }

  /// Trigger validation để hiển thị error messages khi nhấn nút xác nhận
  void validateStoreFields() {
    // Validate tên liên hệ
    final contactName = storeContactName.value?.trim() ?? '';
    _validateStoreContactName(contactName);

    // Validate số điện thoại
    final phoneNumber = storePhoneNumber.value?.trim() ?? '';
    _validateStorePhoneNumber(phoneNumber);
  }

  void selectCustomDate(DateTime date) {
    selectedCustomDate.value = date;
    print('🏪 Store tab - selectCustomDate: $date');
    print('🏪 Store tab - selectedDateTime: ${selectedDateTime.value}');
    // Cập nhật selectedStoreDateTime riêng cho Store tab
    _updateStoreDateTime();
  }

  void selectCustomTimeSlot(String timeSlot) {
    selectedCustomTimeSlot.value = timeSlot;
    print('🏪 Store tab - selectCustomTimeSlot: $timeSlot');
    print('🏪 Store tab - selectedDateTime: ${selectedDateTime.value}');
    // Cập nhật selectedStoreDateTime riêng cho Store tab
    _updateStoreDateTime();
  }

  // Phương thức để set phương thức vận chuyển
  void setPickupMethod(int methodIndex) {
    selectedPickupMethod.value = methodIndex;
  }

  // Kiểm tra xem đã chọn phương thức vận chuyển chưa
  bool get hasSelectedPickupMethod => selectedPickupMethod.value >= 0;

  // Lấy tên phương thức vận chuyển
  String get pickupMethodName {
    switch (selectedPickupMethod.value) {
      case 0:
        return LocaleKeys.pickup_store.trans();
      case 1:
        return LocaleKeys.pickup_home.trans();
      case 2:
        return LocaleKeys.pickup_ship.trans();
      default:
        return LocaleKeys.pickup_not_selected.trans();
    }
  }

  void selectDateIndex(int index) {
    selectedDateIndex.value = index;
  }

  void saveSelectedDateTime() {
    if (selectedDateTime.value != null) {
      print('Saved selected date time: ${selectedDateTime.value}');
    }
  }

  @override
  void onInit() {
    super.onInit();
    result = Get.arguments as EvaluateResultModel;
    evaluationTime = DateTime.now();
    startCountdown();
    // Load thông tin booking đã lưu trước đó
    loadBookingHistory();
  }

  void selectStore(StoreModel store) {
    selectedStore.value = store;
    print('AssessmentEvaluationController: Selected store ${store.name}');
  }

  void clearSelectedStore() {
    selectedStore.value = null;
  }

  /// Lấy cửa hàng hiện tại (đã chọn hoặc gần nhất)
  StoreModel? getCurrentStore() {
    // Nếu đã chọn cửa hàng, trả về cửa hàng đã chọn
    if (selectedStore.value != null) {
      return selectedStore.value;
    }

    // Nếu chưa chọn, lấy cửa hàng gần nhất từ ListStoreController
    try {
      if (Get.isRegistered<ListStoreController>()) {
        final storeController = Get.find<ListStoreController>();
        if (storeController.filteredStores.isNotEmpty) {
          return storeController.filteredStores.first; // Cửa hàng gần nhất
        }
      }
    } catch (e) {
      print('Error getting nearest store: $e');
    }

    return null;
  }

  /// Auto-select cửa hàng gần nhất nếu chưa chọn
  void autoSelectNearestStore() {
    if (selectedStore.value == null) {
      final nearestStore = getCurrentStore();
      if (nearestStore != null) {
        selectedStore.value = nearestStore;
        print('Auto-selected nearest store: ${nearestStore.name}');
      }
    }
  }

  void startCountdown() {
    _countdownTimer?.cancel();
    _countdownTimer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (evaluationTime != null) {
        final elapsed = DateTime.now().difference(evaluationTime!);
        final remaining = const Duration(hours: 24) - elapsed;

        if (remaining.isNegative) {
          // i18n
          remainingTime.value = LocaleKeys.expired.trans();
          timer.cancel();
        } else {
          remainingTime.value = _formatDuration(remaining);
        }
      }
    });
  }

  String _formatDuration(Duration duration) {
    final hours = duration.inHours;
    final minutes = duration.inMinutes % 60;
    final seconds = duration.inSeconds % 60;
    return "${hours.toString().padLeft(2, '0')}:${minutes.toString().padLeft(2, '0')}:${seconds.toString().padLeft(2, '0')}";
  }

  void selectVoucher() async {
    final result = await Get.toNamed(Routes.walletVoucher);
    if (result is VoucherModel) {
      selectedVoucher.value = result;
    }
  }

  String getRemainingTime() => remainingTime.value;

  @override
  void onClose() {
    _countdownTimer?.cancel();
    super.onClose();
  }

  // Thêm method để lưu thông tin booking
  void saveBookingInfo({
    required String contactName,
    required String phoneNumber,
    required String address,
    required String dateTime,
  }) {
    savedContactName.value = contactName;
    savedPhoneNumber.value = phoneNumber;
    savedAddress.value = address;
    savedDateTime.value = dateTime;
    hasBookingHistory.value = true;

    // Lưu vào storage để persistent
    final storage = GetStorage();
    storage.write('booking_contact', contactName);
    storage.write('booking_phone', phoneNumber);
    storage.write('booking_address', address);
    storage.write('booking_datetime', dateTime);
    storage.write('has_booking_history', true);
  }

  // Load thông tin đã lưu
  void loadBookingHistory() {
    final storage = GetStorage();
    savedContactName.value = storage.read('booking_contact');
    savedPhoneNumber.value = storage.read('booking_phone');
    savedAddress.value = storage.read('booking_address');
    savedDateTime.value = storage.read('booking_datetime');
    hasBookingHistory.value = storage.read('has_booking_history') ?? false;

    // Nếu chưa có thông tin, tự động load địa chỉ mặc định
    if (!hasBookingHistory.value ||
        (savedAddress.value?.isEmpty ?? true) ||
        (savedContactName.value?.isEmpty ?? true)) {
      _loadDefaultAddressIfNeeded();
    }
  }

  // Tự động load địa chỉ mặc định nếu cần
  void _loadDefaultAddressIfNeeded() {
    try {
      final homePickupController = Get.find<HomePickupZoneController>();

      // Ưu tiên lấy địa chỉ mặc định trước
      var defaultAddress = homePickupController.getDefaultAddress();

      // Nếu không có địa chỉ mặc định, lấy địa chỉ đầu tiên trong danh sách
      if (defaultAddress == null &&
          homePickupController.savedBookingList.isNotEmpty) {
        defaultAddress = homePickupController.savedBookingList.first;
        print('No default address found, using first address in list');
      }

      if (defaultAddress != null) {
        print('Auto-loading address: ${defaultAddress['fullAddress']}');

        // Set địa chỉ vào controller
        savedAddress.value = defaultAddress['fullAddress'] ?? '';
        savedContactName.value = defaultAddress['contactName'] ?? '';
        savedPhoneNumber.value = defaultAddress['phoneNumber'] ?? '';
        hasBookingHistory.value = true;

        // Lưu vào storage để persistent
        saveBookingInfo(
          contactName: defaultAddress['contactName'] ?? '',
          phoneNumber: defaultAddress['phoneNumber'] ?? '',
          address: defaultAddress['fullAddress'] ?? '',
          dateTime: '', // Để trống vì chưa chọn thời gian
        );

        print('Default address auto-loaded successfully');
      } else {
        print('No addresses found to auto-load');
      }
    } catch (e) {
      print('Error auto-loading default address: $e');
      // HomePickupZoneController chưa được khởi tạo hoặc có lỗi
    }
  }

  /// Public method để auto-load địa chỉ mặc định (được gọi từ UI)
  void autoLoadDefaultAddress() {
    _loadDefaultAddressIfNeeded();
  }

  /// Cập nhật selectedStoreDateTime từ custom date và time slot (riêng cho Store tab)
  void _updateStoreDateTime() {
    if (selectedCustomDate.value != null && selectedCustomTimeSlot.value != null) {
      final date = selectedCustomDate.value!;
      final formattedDate = '${date.day.toString().padLeft(2, '0')}/'
          '${date.month.toString().padLeft(2, '0')}/'
          '${date.year}';
      final newDateTime = '$formattedDate ${selectedCustomTimeSlot.value}';

      // Cập nhật selectedStoreDateTime riêng cho Store tab
      selectedStoreDateTime.value = newDateTime;

      print('🏪 Store tab - _updateStoreDateTime: $newDateTime');
      print('🏪 Store tab - selectedDateTime vẫn là: ${selectedDateTime.value}');
      print('---');
    }
  }

  /// Reset trạng thái để đánh giá lại sản phẩm
  void resetEvaluationState() {
    // Reset voucher đã chọn
    selectedVoucher.value = null;

    // Reset pickup method về -1 (chưa chọn)
    selectedPickupMethod.value = -1;

    print('🔄 Reset pickup method, keep other info unchanged');
  }
}
