import 'package:fido_box_demo01/core/assets/locale_keys.g.dart';
import 'package:fido_box_demo01/core/extensions/string_extension.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_typography.dart';
import '../../home_pickup_zone/controllers/home_pickup_zone_controller.dart';
import '../../home_pickup_zone/widgets/pickup_booking_form.dart';
import '../controllers/assessment_evaluation_controller.dart';

class AddressSelectionPage extends StatefulWidget {
  const AddressSelectionPage({Key? key}) : super(key: key);

  @override
  State<AddressSelectionPage> createState() => _AddressSelectionPageState();
}

class _AddressSelectionPageState extends State<AddressSelectionPage> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: AppColors.neutral01),
          onPressed: () => Get.back(),
        ),
        title: Text(
          LocaleKeys.choose_address.trans(),
          style: AppTypography.s16.bold.copyWith(color: AppColors.neutral01),
        ),
        centerTitle: true,
      ),
      body: _buildBody(),
      bottomNavigationBar: _buildBottomButton(),
    );
  }

  Widget _buildBody() {
    try {
      // Kiểm tra xem controller có tồn tại không
      if (!Get.isRegistered<HomePickupZoneController>()) {
        print('HomePickupZoneController not registered, creating new instance');
        Get.put(HomePickupZoneController());
      }

      final homePickupController = Get.find<HomePickupZoneController>();
      final assessmentController = Get.find<AssessmentEvaluationController>();

      // Đảm bảo data được load - trigger reactive update
      final originalAddressList = homePickupController.savedBookingList;

      // Force refresh nếu list rỗng
      if (originalAddressList.isEmpty) {
        homePickupController.reloadBookingList(); // Trigger reload
      }

      if (originalAddressList.isEmpty) {
        return _buildEmptyState();
      }

      // Sắp xếp địa chỉ: mặc định đầu tiên
      final addressList = List<Map<String, dynamic>>.from(originalAddressList);
      addressList.sort((a, b) {
        final aIsDefault = a['isDefault'] == true;
        final bIsDefault = b['isDefault'] == true;
        
        if (aIsDefault && !bIsDefault) return -1;
        if (!aIsDefault && bIsDefault) return 1;
        return 0;
      });

      // Tạo observable cho selection
      final selectedAddressId = ''.obs;
      
      // Set initial selection
      final currentAddress = assessmentController.savedAddress.value?.trim() ?? '';
      final currentContactName = assessmentController.savedContactName.value?.trim() ?? '';
      final currentPhoneNumber = assessmentController.savedPhoneNumber.value?.trim() ?? '';
      
      // Tìm địa chỉ hiện tại
      Map<String, dynamic> currentAddressData = {};
      
      if (currentContactName.isNotEmpty && currentPhoneNumber.isNotEmpty) {
        currentAddressData = addressList.firstWhere(
          (addr) => addr['contactName']?.toString().trim() == currentContactName && 
                   addr['phoneNumber']?.toString().trim() == currentPhoneNumber,
          orElse: () => <String, dynamic>{},
        );
      }
      
      if (currentAddressData.isNotEmpty) {
        selectedAddressId.value = currentAddressData['id']?.toString() ?? '';
      }

      return Container(
        color: AppColors.neutral06, // Background xám nhạt
        child: Obx(() {
          // Reactive rebuild khi homePickupController.savedBookingList thay đổi
          final currentList = homePickupController.savedBookingList;

          return ListView.builder(
            padding: EdgeInsets.zero,
            itemCount: currentList.length,
            itemBuilder: (context, index) {
              final address = currentList[index];
              return _buildAddressItem(address, assessmentController, selectedAddressId);
            },
          );
        }),
      );
    } catch (e) {
      print('Error in _buildBody: $e');
      return _buildErrorState(e.toString());
    }
  }

  Widget _buildEmptyState() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(Icons.location_off, size: 64, color: AppColors.neutral04),
          SizedBox(height: 16.h),
          Text(
            'Chưa có địa chỉ nào',
            style: AppTypography.s16.medium.copyWith(color: AppColors.neutral02),
          ),
          SizedBox(height: 8.h),
          Text(
            'Vui lòng thêm địa chỉ mới để tiếp tục',
            style: AppTypography.s12.regular.copyWith(color: AppColors.neutral03),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }

  Widget _buildErrorState([String? errorMessage]) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(Icons.error_outline, size: 64, color: AppColors.error),
          SizedBox(height: 16.h),
          Text(
            'Có lỗi xảy ra',
            style: AppTypography.s16.medium.copyWith(color: AppColors.error),
          ),
          SizedBox(height: 8.h),
          Text(
            errorMessage ?? 'Không thể tải danh sách địa chỉ',
            style: AppTypography.s12.regular.copyWith(color: AppColors.neutral03),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }

  Widget _buildBottomButton() {
    return Container(
      padding: EdgeInsets.all(16.w),
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 10,
            offset: Offset(0, -2),
          ),
        ],
      ),
      child: ElevatedButton.icon(
        onPressed: () {
          _showAddAddressDialog();
        },
        icon: Icon(Icons.add, size: 20),
        label: Text(LocaleKeys.add_new_address.trans()),
        style: ElevatedButton.styleFrom(
          backgroundColor: AppColors.primary01,
          foregroundColor: Colors.white,
          minimumSize: Size(double.infinity, 48.h),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8.r),
          ),
        ),
      ),
    );
  }

  Widget _buildAddressItem(Map<String, dynamic> address, AssessmentEvaluationController controller, RxString selectedAddressId) {
    final isDefault = address['isDefault'] == true;
    final addressId = address['id']?.toString() ?? '';

    return Obx(() {
      final isSelected = addressId.isNotEmpty && addressId == selectedAddressId.value;

      return GestureDetector(
        onTap: () {
          selectedAddressId.value = addressId;
          _selectAddress(address, controller);
        },
        child: Container(
          padding: EdgeInsets.all(16.w),
          margin: EdgeInsets.only(bottom: 1), // Tạo separator line
          decoration: BoxDecoration(
            color: Colors.white,
          ),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Radio button
              Container(
                margin: EdgeInsets.only(top: 2.h),
                child: Icon(
                  isSelected ? Icons.radio_button_checked : Icons.radio_button_off,
                  color: isSelected ? Colors.red : AppColors.neutral04,
                  size: 20,
                ),
              ),
              SizedBox(width: 16.w),

              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Tên và số điện thoại trên cùng 1 dòng
                    Row(
                      children: [
                        Expanded(
                          child: RichText(
                            text: TextSpan(
                              children: [
                                TextSpan(
                                  text: address['contactName'] ?? 'Không có tên',
                                  style: AppTypography.s14.medium.copyWith(
                                    color: AppColors.neutral01,
                                  ),
                                ),
                                TextSpan(
                                  text: ' ${address['phoneNumber'] ?? ''}',
                                  style: AppTypography.s14.regular.copyWith(
                                    color: AppColors.neutral03,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                        // Button "Sửa" có chức năng
                        GestureDetector(
                          onTap: () => _showEditAddressDialog(address),
                          child: Container(
                            padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 4.h),
                            decoration: BoxDecoration(
                              color: AppColors.primary01.withOpacity(0.1),
                              borderRadius: BorderRadius.circular(4),
                              border: Border.all(color: AppColors.primary01.withOpacity(0.3)),
                            ),
                            child: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Icon(
                                  Icons.edit_outlined,
                                  size: 12,
                                  color: AppColors.primary01,
                                ),
                                SizedBox(width: 4.w),
                                Text(
                                  LocaleKeys.address_fix.trans(),
                                  style: AppTypography.s12.regular.copyWith(
                                    color: AppColors.primary01,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 8.h),

                    // Địa chỉ chi tiết (nhiều dòng)
                    Text(
                      _formatAddress(address),
                      style: AppTypography.s12.regular.copyWith(
                        color: AppColors.neutral02,
                        height: 1.4,
                      ),
                      maxLines: 3,
                      overflow: TextOverflow.ellipsis,
                    ),

                    // Badge "Mặc định" nếu là địa chỉ mặc định
                    if (isDefault) ...[
                      SizedBox(height: 8.h),
                      Container(
                        padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 4.h),
                        decoration: BoxDecoration(
                          border: Border.all(color: AppColors.primary01, width: 1),
                          borderRadius: BorderRadius.circular(4.r),
                        ),
                        child: Text(
                          LocaleKeys.default1.trans(),
                          style: AppTypography.s10.regular.copyWith(
                            color:  AppColors.primary01,
                          ),
                        ),
                      ),
                    ],
                  ],
                ),
              ),
            ],
          ),
        ),
      );
    });
  }

  // Helper method để format địa chỉ theo design
  String _formatAddress(Map<String, dynamic> address) {
    final fullAddress = address['fullAddress']?.toString() ?? '';

    // Tách địa chỉ thành các phần
    final parts = fullAddress.split(',');
    if (parts.length >= 3) {
      // Ví dụ: "2A Điện Biên Phủ, Phường 25, Quận Bình Thạnh, TP. Hồ Chí Minh"
      // Hiển thị: "2A Điện Biên Phủ\nPhường 25, Quận Bình Thạnh\nTP. Hồ Chí Minh"
      final street = parts[0].trim();
      final ward = parts.length > 1 ? parts[1].trim() : '';
      final district = parts.length > 2 ? parts[2].trim() : '';
      final city = parts.length > 3 ? parts.sublist(3).join(', ').trim() : '';

      String formatted = street;
      if (ward.isNotEmpty && district.isNotEmpty) {
        formatted += '\n$ward, $district';
      }
      if (city.isNotEmpty) {
        formatted += '\n$city';
      }

      return formatted;
    }

    return fullAddress;
  }

  void _selectAddress(Map<String, dynamic> address, AssessmentEvaluationController controller) {
    print('Selecting address: ${address['fullAddress']}');

    // Cập nhật controller
    controller.savedAddress.value = address['fullAddress'] ?? '';
    controller.savedContactName.value = address['contactName'] ?? '';
    controller.savedPhoneNumber.value = address['phoneNumber'] ?? '';
    controller.hasBookingHistory.value = true;

    // Force refresh để đảm bảo UI update
    controller.savedAddress.refresh();
    controller.savedContactName.refresh();
    controller.savedPhoneNumber.refresh();
    controller.hasBookingHistory.refresh();

    // Lưu vào storage
    controller.saveBookingInfo(
      contactName: address['contactName'] ?? '',
      phoneNumber: address['phoneNumber'] ?? '',
      address: address['fullAddress'] ?? '',
      dateTime: controller.savedDateTime.value ?? '',
    );

    print('Address updated successfully: ${controller.savedAddress.value}');

    // Force trigger UI update
    Future.delayed(Duration(milliseconds: 100), () {
      controller.hasBookingHistory.value = false;
      controller.hasBookingHistory.value = true;
      controller.hasBookingHistory.refresh();
      Get.forceAppUpdate();
    });

    // Hiển thị thông báo và quay lại
    // Get.snackbar(
    //   'Đã chọn',
    //   '${address['contactName']} - ${address['phoneNumber']}',
    //   snackPosition: SnackPosition.BOTTOM,
    //   backgroundColor: AppColors.success,
    //   colorText: Colors.white,
    //   duration: Duration(seconds: 2),
    // );

    // Quay lại trang trước
    Future.delayed(Duration(milliseconds: 800), () {
      Get.back();
    });
  }
  void _showAddAddressDialog() {
    try {
      // Kiểm tra xem HomePickupZoneController đã tồn tại hay chưa
      if (!Get.isRegistered<HomePickupZoneController>()) {
        Get.put(HomePickupZoneController(), permanent: true);
      }

      final homePickupController = Get.find<HomePickupZoneController>();

      // Navigate đến page full screen để thêm địa chỉ mới
      Get.to(() => Scaffold(
        backgroundColor: AppColors.white,
        body: PickupBookingForm(
          editMode: false, // Chế độ thêm mới
          editMode1: true, // Full screen mode
          onSubmit: () {
            print('New address added successfully');
            // Refresh lại danh sách địa chỉ
            homePickupController.reloadBookingList();
          },
          onUpdate: (newData) {
            // Callback này sẽ không được gọi trong chế độ thêm mới
            // nhưng vẫn cần có để tránh lỗi
            print('New address data: $newData');
          },
        ),
      ));
    } catch (e) {
      print('Error opening add address form: $e');
      // Get.snackbar(
      //   'Lỗi',
      //   'Không thể mở trang thêm địa chỉ',
      //   snackPosition: SnackPosition.BOTTOM,
      //   backgroundColor: AppColors.error,
      //   colorText: Colors.white,
      // );
    }
  }
  /// Navigate đến trang sửa địa chỉ
  void _showEditAddressDialog(Map<String, dynamic> address) {
    try {
      // Đảm bảo HomePickupZoneController tồn tại
      if (!Get.isRegistered<HomePickupZoneController>()) {
        Get.put(HomePickupZoneController(), permanent: true);
      }

      final homePickupController = Get.find<HomePickupZoneController>();

      // Mở form edit
// Navigate đến page full screen
      Get.to(() => Scaffold(
        backgroundColor: AppColors.white,
        body: PickupBookingForm(
          editMode: true,
          editData: address,
          editMode1: true,
          onUpdate: (updatedData) {
            homePickupController.updateBookingData(address['id'], updatedData);
            Get.back();
            print('Address updated, navigating back');
          },
        ),
      ));
    } catch (e) {
      // Get.snackbar(
      //   'Lỗi',
      //   'Không thể mở trang chỉnh sửa',
      //   snackPosition: SnackPosition.BOTTOM,
      //   backgroundColor: AppColors.error,
      //   colorText: Colors.white,
      // );
    }
  }
}
