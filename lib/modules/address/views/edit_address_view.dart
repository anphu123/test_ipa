// 📁 edit_address_view.dart
import 'package:fido_box_demo01/core/extensions/string_extension.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import '../../../core/assets/locale_keys.g.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_typography.dart';
import '../controllers/address_controller.dart';
import '../domain/address_model.dart';

class EditAddressView extends GetView<AddressController> {
  EditAddressView({super.key});

  @override
  Widget build(BuildContext context) {
    final address = controller.editingAddress.value;

    return Scaffold(
      backgroundColor: AppColors.neutral08,

      appBar: AppBar(
        title: Text(
          LocaleKeys.edit_address.trans(),
          style: AppTypography.s20.medium.withColor(AppColors.neutral01),
        ),
        centerTitle: true,
        backgroundColor: Colors.white,
        surfaceTintColor: Colors.transparent,
        elevation: 0.5,
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios_new_rounded),
          onPressed: () => Get.back(),
        ),
      ),
      body: ListView(
        padding: EdgeInsets.symmetric(vertical: 16.h),
        children: [
          _buildInfoSection(address),
          SizedBox(height: 12),
          _buildMapAndNoteSection(address),
          SizedBox(height: 12),
          _buildOptionsSection(),
          SizedBox(height: 20),
          _buildActionButtons(address),
        ],
      ),
    );
  }

  Widget _buildInfoSection(AddressModel address) {
    return Container(
      padding: EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(8),
      ),
      child: Column(
        children: [
          _buildInput(LocaleKeys.recipient_name.trans(), address.name, (v) => address.name = v),
          _divider(),
          _buildInput(LocaleKeys.phone_number.trans(), address.phone, (v) => address.phone = v),
          _divider(),
          _buildInput(LocaleKeys.province_district_ward.trans(), address.city, (v) {
            address.city = v;
            controller.onAddressFieldChanged();
          }),
          _divider(),
          _buildInput(LocaleKeys.province_district_ward.trans(), address.district, (v) {
            address.district = v;
            controller.onAddressFieldChanged();
          }),
          _divider(),
          _buildInput('Phường/Xã', address.ward, (v) {
            address.ward = v;
            controller.onAddressFieldChanged();
          }),
          _divider(),
          _buildInput(LocaleKeys.street_building_house.trans(), address.street, (v) {
            address.street = v;
            controller.onAddressFieldChanged();
          }),
        ],
      ),
    );
  }

  Widget _buildMapAndNoteSection(AddressModel address) {
    return Container(
      padding: EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(8),
      ),
      child: Column(
        children: [
          Obx(() {
            final latLng =
                controller.mapLatLng.value ??
                LatLng(
                  address.lat ?? controller.currentLatitude.value ?? 10.762622,
                  address.lng ??
                      controller.currentLongitude.value ??
                      106.660172,
                );
            return _buildGoogleMap(latLng);
          }),
          SizedBox(height: 12),
          _buildInput(LocaleKeys.note_address.trans(), address.note, (v) => address.note = v),
        ],
      ),
    );
  }

  Widget _buildOptionsSection() {
    return Container(
      padding: EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(8),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Obx(
            () => _buildSwitch(
              LocaleKeys.set_default_address.trans(),
              controller.editingAddress.value.isDefault,
              (v) => controller.editingAddress.update(
                (addr) => addr?.isDefault = v,
              ),
            ),
          ),
          Obx(
            () => _buildSwitch(
              LocaleKeys.set_pickup_address.trans(),
              controller.editingAddress.value.isPickup,
              (v) => controller.editingAddress.update(
                (addr) => addr?.isPickup = v,
              ),
            ),
          ),
          Obx(
            () => _buildSwitch(
              LocaleKeys.set_return_address.trans(),
              controller.editingAddress.value.isReturn,
              (v) => controller.editingAddress.update(
                (addr) => addr?.isReturn = v,
              ),
            ),
          ),
          SizedBox(height: 12),
          _buildTypeSelector(),
        ],
      ),
    );
  }

  Widget _buildActionButtons(AddressModel address) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 16.w), // ✅ Padding ngang
      child: Row(
        children: [
          Expanded(
            child: GestureDetector(
              onTap: () => controller.deleteAddress(address),
              child: Container(
                height: 44.h,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8),
                  color: AppColors.white,
                  border: Border.all(color: AppColors.primary01),
                ),
                child: Center(
                  child: Text(
                    LocaleKeys.delete_address.trans(),
                    style: TextStyle(color: AppColors.primary01),
                  ),
                ),
              ),
            ),
          ),
          SizedBox(width: 12),
          Expanded(
            child: GestureDetector(
              onTap: () => controller.saveEditedAddress(address),
              child: Container(
                height: 44.h,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8),
                  color: AppColors.primary01,
                  border: Border.all(color: AppColors.white),
                ),
                child: Center(
                  child: Text(
                    LocaleKeys.completed.trans(),
                    style: TextStyle(color: AppColors.white),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildInput(
    String label,
    String initialValue,
    Function(String) onChanged,
  ) {
    final controller = TextEditingController(text: initialValue);
    controller.selection = TextSelection.fromPosition(
      TextPosition(offset: controller.text.length),
    );

    return TextField(
      controller: controller,
      style: AppTypography.s14.copyWith(color: AppColors.neutral01),
      decoration: InputDecoration(
        labelText: label,
        labelStyle: AppTypography.s14.withColor(AppColors.neutral03),
        border: InputBorder.none,
      ),
      onChanged: onChanged,
    );
  }

  Widget _buildSwitch(String title, bool value, ValueChanged<bool> onChanged) {
    return ListTile(
      title: Text(title, style: TextStyle(fontSize: 16.sp)),
      trailing: CupertinoSwitch(
        value: value,
        onChanged: onChanged,
        activeColor: AppColors.primary01,
      ),
    );
  }
  Widget _buildTypeSelector() {
    return Obx(() {
      final address = controller.editingAddress.value;

      return Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(LocaleKeys.address_type.trans(), style: AppTypography.s16),
          SizedBox(width: 12),
          _buildTypeOption(
            label: LocaleKeys.office.trans(),
            isSelected: address.type == LocaleKeys.office.trans(),
            onTap: () {
              controller.editingAddress.update((addr) {
                addr?.type = LocaleKeys.office.trans();
              });
            },
          ),
          SizedBox(width: 8),
          _buildTypeOption(
            label: LocaleKeys.home.trans(),
            isSelected: address.type == LocaleKeys.home.trans(),
            onTap: () {
              controller.editingAddress.update((addr) {
                addr?.type = LocaleKeys.home.trans();
              });
            },
          ),
        ],
      );
    });
  }
  Widget _buildTypeOption({
    required String label,
    required bool isSelected,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 8.h),
        decoration: BoxDecoration(
          color: isSelected ? AppColors.primary01 : AppColors.neutral07,
          borderRadius: BorderRadius.circular(8),
        ),
        child: Text(
          label,
          style: AppTypography.s14.copyWith(
            color: isSelected ? Colors.white : AppColors.neutral04,
          ),
        ),
      ),
    );
  }

  Widget _buildGoogleMap(LatLng latLng) {
    return Container(
      height: 200,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.grey.shade300),
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(12),
        child: GoogleMap(
          initialCameraPosition: CameraPosition(target: latLng, zoom: 16),
          myLocationEnabled: true,
          myLocationButtonEnabled: true,
          zoomControlsEnabled: false,
          onTap: (LatLng tapped) {
            controller.editingAddress.update((addr) {
              addr?.lat = tapped.latitude;
              addr?.lng = tapped.longitude;
            });
            controller.mapLatLng.value = tapped;
          },
          markers: {
            Marker(markerId: const MarkerId('current'), position: latLng),
          },
        ),
      ),
    );
  }

  Widget _divider() => Container(
    height: 1,
    margin: EdgeInsets.symmetric(vertical: 12),
    color: AppColors.neutral07,
  );
}
