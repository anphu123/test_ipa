// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import '../../../core/theme/app_colors.dart';
// import '../../../core/theme/app_typography.dart';
// import '../controllers/assessment_evaluation_controller.dart';
//
// class StorePickupBottomSheet {
//   static void show() {
//     Get.bottomSheet(
//       _StorePickupContent(),
//       isScrollControlled: true,
//       backgroundColor: Colors.transparent,
//     );
//   }
// }
//
// class _StorePickupContent extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     final controller = Get.find<AssessmentEvaluationController>();
//
//     return Container(
//       height: MediaQuery.of(context).size.height * 0.8,
//       decoration: BoxDecoration(
//         color: Colors.white,
//         borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
//       ),
//       child: Column(
//         children: [
//           // Header
//           _buildHeader(),
//
//           // Content
//           Expanded(
//             child: SingleChildScrollView(
//               padding: EdgeInsets.all(16),
//               child: Column(
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: [
//                   // Warning section
//                   _buildWarningSection(),
//                   SizedBox(height: 24),
//
//                   // Contact info section
//                   _buildContactInfoSection(),
//                   SizedBox(height: 24),
//
//                   // Store address section
//                   _buildStoreAddressSection(),
//                   SizedBox(height: 32),
//
//                   // Confirm button
//                   _buildConfirmButton(),
//                 ],
//               ),
//             ),
//           ),
//         ],
//       ),
//     );
//   }
//
//   Widget _buildHeader() {
//     return Container(
//       padding: EdgeInsets.all(16),
//       child: Row(
//         mainAxisAlignment: MainAxisAlignment.spaceBetween,
//         children: [
//           Text(
//             'Xác nhận thông tin',
//             style: AppTypography.s16.bold.copyWith(
//               color: AppColors.neutral01,
//             ),
//           ),
//           GestureDetector(
//             onTap: () => Get.back(),
//             child: Icon(
//               Icons.close,
//               color: AppColors.neutral03,
//               size: 24,
//             ),
//           ),
//         ],
//       ),
//     );
//   }
//
//   Widget _buildWarningSection() {
//     return Container(
//       padding: EdgeInsets.all(16),
//       decoration: BoxDecoration(
//         color: Colors.orange.withValues(alpha: 0.1),
//         borderRadius: BorderRadius.circular(8),
//         border: Border.all(
//           color: Colors.orange.withValues(alpha: 0.3),
//           width: 1,
//         ),
//       ),
//       child: Row(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           Icon(
//             Icons.warning_amber_rounded,
//             color: Colors.orange,
//             size: 20,
//           ),
//           SizedBox(width: 12),
//           Expanded(
//             child: Text(
//               'Vui lòng đảm bảo rằng thông tin nhận dạng/dịch vụ tại nhà chính xác, nếu không bạn ta sẽ không thể đến đúng địa điểm và đúng giờ hẹn.',
//               style: AppTypography.s12.regular.copyWith(
//                 color: Colors.orange.shade700,
//               ),
//             ),
//           ),
//         ],
//       ),
//     );
//   }
//
//   Widget _buildContactInfoSection() {
//     return Column(
//       crossAxisAlignment: CrossAxisAlignment.start,
//       children: [
//         Text(
//           'Thông tin liên hệ',
//           style: AppTypography.s16.medium.copyWith(
//             color: AppColors.neutral01,
//           ),
//         ),
//         SizedBox(height: 16),
//
//         // Dynamic contact info
//         _buildContactRow(
//           Icons.person_outline,
//           _getCustomerName(),
//         ),
//         SizedBox(height: 12),
//         _buildContactRow(
//           Icons.phone_outlined,
//           _getCustomerPhone(),
//         ),
//       ],
//     );
//   }
//
//   Widget _buildStoreAddressSection() {
//     return Column(
//       crossAxisAlignment: CrossAxisAlignment.start,
//       children: [
//         Text(
//           'Địa chỉ cửa hàng',
//           style: AppTypography.s16.medium.copyWith(
//             color: AppColors.neutral01,
//           ),
//         ),
//         SizedBox(height: 16),
//
//         // Dynamic store info
//         _buildContactRow(
//           Icons.location_on_outlined,
//           _getStoreName(),
//         ),
//         SizedBox(height: 12),
//         _buildContactRow(
//           Icons.phone_outlined,
//           _getStorePhone(),
//         ),
//         SizedBox(height: 12),
//         _buildAddressRow(
//           Icons.location_on_outlined,
//           _getStoreAddress(),
//         ),
//         SizedBox(height: 16),
//         _buildContactRow(
//           Icons.access_time,
//           _getStoreHours(),
//         ),
//       ],
//     );
//   }
//
//   Widget _buildContactRow(IconData icon, String text) {
//     return Row(
//       children: [
//         Container(
//           width: 24,
//           height: 24,
//           child: Icon(
//             icon,
//             color: AppColors.neutral03,
//             size: 20,
//           ),
//         ),
//         SizedBox(width: 12),
//         Text(
//           text,
//           style: AppTypography.s14.regular.copyWith(
//             color: AppColors.neutral01,
//           ),
//         ),
//       ],
//     );
//   }
//
//   Widget _buildAddressRow(IconData icon, String address) {
//     return Row(
//       crossAxisAlignment: CrossAxisAlignment.start,
//       children: [
//         Container(
//           width: 24,
//           height: 24,
//           child: Icon(
//             icon,
//             color: AppColors.neutral03,
//             size: 20,
//           ),
//         ),
//         SizedBox(width: 12),
//         Expanded(
//           child: Text(
//             address,
//             style: AppTypography.s14.regular.copyWith(
//               color: AppColors.neutral01,
//             ),
//           ),
//         ),
//       ],
//     );
//   }
//
//   Widget _buildConfirmButton() {
//     return SizedBox(
//       width: double.infinity,
//       child: ElevatedButton(
//         onPressed: () {
//           // Handle confirm action
//           _handleConfirm();
//         },
//         style: ElevatedButton.styleFrom(
//           backgroundColor: AppColors.error,
//           minimumSize: Size.fromHeight(50),
//           shape: RoundedRectangleBorder(
//             borderRadius: BorderRadius.circular(8),
//           ),
//         ),
//         child: Text(
//           'Xác nhận',
//           style: AppTypography.s16.medium.copyWith(
//             color: Colors.white,
//           ),
//         ),
//       ),
//     );
//   }
//
//   // Dynamic data methods
//   String _getCustomerName() {
//     // Try to get from user profile/storage
//     try {
//       // You can get from GetStorage, SharedPreferences, or user controller
//       // final userController = Get.find<UserController>();
//       // return userController.currentUser.value?.name ?? 'Khách hàng';
//
//       // For now, get from a hypothetical user service
//       return _getUserData('name') ?? 'Huynh Mai An Phú';
//     } catch (e) {
//       return 'Khách hàng';
//     }
//   }
//
//   String _getCustomerPhone() {
//     try {
//       return _getUserData('phone') ?? '+84 123456789';
//     } catch (e) {
//       return '+84 123456789';
//     }
//   }
//
//   String _getStoreName() {
//     try {
//       // Get from selected store or nearest store
//       return _getStoreData('name') ?? 'Trung tâm 2Hand';
//     } catch (e) {
//       return 'Trung tâm 2Hand';
//     }
//   }
//
//   String _getStorePhone() {
//     try {
//       return _getStoreData('phone') ?? '+84 123456789';
//     } catch (e) {
//       return '+84 123456789';
//     }
//   }
//
//   String _getStoreAddress() {
//     try {
//       return _getStoreData('address') ?? '19 Tân Cảng, phường 25, quận Bình Thạnh, Thành phố Hồ Chí Minh';
//     } catch (e) {
//       return '19 Tân Cảng, phường 25, quận Bình Thạnh, Thành phố Hồ Chí Minh';
//     }
//   }
//
//   String _getStoreHours() {
//     try {
//       // Get appointment time or current time
//       final appointmentTime = _getAppointmentTime();
//       if (appointmentTime != null) {
//         final formattedDate = '${appointmentTime.day.toString().padLeft(2, '0')}/${appointmentTime.month.toString().padLeft(2, '0')}/${appointmentTime.year}';
//         final timeSlot = _getTimeSlot(appointmentTime);
//         return '$formattedDate $timeSlot';
//       }
//
//       // Default to current date + default time
//       final now = DateTime.now();
//       final formattedDate = '${now.day.toString().padLeft(2, '0')}/${now.month.toString().padLeft(2, '0')}/${now.year}';
//       return '$formattedDate 18:00-19:00';
//     } catch (e) {
//       final now = DateTime.now();
//       final formattedDate = '${now.day.toString().padLeft(2, '0')}/${now.month.toString().padLeft(2, '0')}/${now.year}';
//       return '$formattedDate 18:00-19:00';
//     }
//   }
//
//   // Helper methods for data retrieval
//   String? _getUserData(String key) {
//     // Implement user data retrieval
//     // This could be from GetStorage, SharedPreferences, or a user controller
//     // final storage = GetStorage();
//     // return storage.read('user_$key');
//     return null; // Return null to use fallback values
//   }
//
//   String? _getStoreData(String key) {
//     // Implement store data retrieval
//     // This could be from API, local storage, or store controller
//     // final storeController = Get.find<StoreController>();
//     // return storeController.selectedStore.value?[key];
//     return null; // Return null to use fallback values
//   }
//
//   DateTime? _getAppointmentTime() {
//     // Get appointment time from controller or storage
//     // final controller = Get.find<AssessmentEvaluationController>();
//     // return controller.appointmentTime.value;
//     return null; // Return null to use current time
//   }
//
//   String _getTimeSlot(DateTime dateTime) {
//     // Generate time slot based on appointment time
//     final hour = dateTime.hour;
//     final nextHour = hour + 1;
//     return '${hour.toString().padLeft(2, '0')}:00-${nextHour.toString().padLeft(2, '0')}:00';
//   }
//
//   void _handleConfirm() {
//     // Handle confirmation logic
//     Get.back();
//
//     // Show success message or navigate to next step
//     Get.snackbar(
//       'Thành công',
//       'Đã xác nhận thông tin thu mua tại cửa hàng',
//       backgroundColor: AppColors.success,
//       colorText: Colors.white,
//       snackPosition: SnackPosition.TOP,
//     );
//   }
// }
