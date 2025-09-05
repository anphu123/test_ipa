// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
//
// import '../../../core/theme/app_colors.dart';
// import '../../home_pickup_zone/controllers/home_pickup_zone_controller.dart';
// import '../../home_pickup_zone/widgets/pickup_booking_form.dart';
//
// class EditAddressPage extends StatelessWidget {
//   final Map<String, dynamic> addressData;
//
//   const EditAddressPage({
//     Key? key,
//     required this.addressData,
//   }) : super(key: key);
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       // Full screen - không có AppBar
//       body: PickupBookingForm(
//         editMode: true,
//         editData: addressData,
//         onUpdate: (updatedData) {
//           try {
//             // Đảm bảo HomePickupZoneController tồn tại
//             if (!Get.isRegistered<HomePickupZoneController>()) {
//               Get.put(HomePickupZoneController(), permanent: true);
//             }
//
//             final homePickupController = Get.find<HomePickupZoneController>();
//
//             // Cập nhật địa chỉ
//             homePickupController.updateBookingData(addressData['id'], updatedData);
//
//             // Navigate back sau khi cập nhật thành công
//             Get.back();
//
//             // Hiển thị thông báo thành công
//             Get.snackbar(
//               'Thành công',
//               'Địa chỉ đã được cập nhật',
//               snackPosition: SnackPosition.BOTTOM,
//               backgroundColor: AppColors.success,
//               colorText: Colors.white,
//               duration: Duration(seconds: 2),
//             );
//
//           } catch (e) {
//             // Xử lý lỗi
//             Get.snackbar(
//               'Lỗi',
//               'Không thể cập nhật địa chỉ: $e',
//               snackPosition: SnackPosition.BOTTOM,
//               backgroundColor: AppColors.error,
//               colorText: Colors.white,
//               duration: Duration(seconds: 3),
//             );
//           }
//         },
//       ),
//     );
//   }
// }
