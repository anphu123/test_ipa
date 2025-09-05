// 📁 address_controller.dart
import 'dart:async';

import 'package:geocoding/geocoding.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import '../domain/address_model.dart';
import '../views/edit_address_view.dart';

class AddressController extends GetxController {
  final box = GetStorage();
  final addressList = <AddressModel>[].obs;

  var editingAddress = AddressModel.empty().obs;
  var editingIndex = (-1).obs;

  // Vị trí hiện tại
  var currentLatitude = RxnDouble();
  var currentLongitude = RxnDouble();

  Timer? _debounce;
  final Rxn<LatLng> mapLatLng = Rxn<LatLng>();
  var errorMessage = ''.obs;

  @override
  void onInit() {
    super.onInit();
    loadAddresses();
    getCurrentLocation();
  }

  bool validateAddress(AddressModel address) {
    if (address.name.trim().isEmpty) {
      errorMessage.value = 'Vui lòng nhập họ và tên';
      return false;
    }
    if (address.phone.trim().isEmpty || address.phone.length < 9) {
      errorMessage.value = 'Số điện thoại không hợp lệ';
      return false;
    }
    if (address.city.trim().isEmpty ||
        address.district.trim().isEmpty ||
        address.ward.trim().isEmpty ||
        address.street.trim().isEmpty) {
      errorMessage.value = 'Vui lòng điền đầy đủ địa chỉ';
      return false;
    }

    errorMessage.value = '';
    return true;
  }

  void loadAddresses() {
    final saved = box.read<List>('addresses');
    if (saved != null) {
      addressList.assignAll(
        saved.map((e) => AddressModel.fromJson(Map<String, dynamic>.from(e))),
      );
    }
  }

  void saveAddresses() {
    box.write('addresses', addressList.map((e) => e.toJson()).toList());
  }

  void setDefaultAddress(int index) {
    for (int i = 0; i < addressList.length; i++) {
      addressList[i].isDefault = i == index;
    }
    addressList.refresh();
    saveAddresses();
  }

  void editAddress(int index) {
    editingAddress.value = addressList[index].copy();
    editingIndex.value = index;
    Get.to(() => EditAddressView());
  }

  void addNewAddress() {
    editingAddress.value = AddressModel.empty();
    editingIndex.value = -1;
    Get.to(() => EditAddressView());
  }

  void saveEditedAddress(AddressModel updated) {
    if (updated.isDefault) {
      for (var i = 0; i < addressList.length; i++) {
        addressList[i].isDefault = false;
      }
    }

    if (editingIndex.value == -1) {
      addressList.add(updated);
    } else {
      addressList[editingIndex.value] = updated;
    }

    addressList.refresh();
    saveAddresses();
    Get.back();
  }

  void deleteAddress(AddressModel address) {
    addressList.removeWhere(
      (item) =>
          item.name == address.name &&
          item.phone == address.phone &&
          item.street == address.street,
    );
    saveAddresses();
    Get.back();
  }

  Future<void> getCurrentLocation() async {
    bool serviceEnabled;
    LocationPermission permission;

    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      await Geolocator.openLocationSettings();
      return;
    }

    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        return;
      }
    }

    if (permission == LocationPermission.deniedForever) {
      return;
    }

    final position = await Geolocator.getCurrentPosition(
      desiredAccuracy: LocationAccuracy.high,
    );

    currentLatitude.value = position.latitude;
    currentLongitude.value = position.longitude;

    // Gán vị trí cho địa chỉ đang chỉnh sửa nếu chưa có
    if (editingAddress.value.lat == null || editingAddress.value.lng == null) {
      editingAddress.update((addr) {
        addr?.lat = position.latitude;
        addr?.lng = position.longitude;
      });
    }
  }

  Future<void> updateMapPositionFromAddress() async {
    final address = editingAddress.value;
    final fullAddress =
        '${address.street}, ${address.ward}, ${address.district}, ${address.city}';

    try {
      final locations = await locationFromAddress(fullAddress);
      if (locations.isNotEmpty) {
        final loc = locations.first;
        editingAddress.update((addr) {
          addr?.lat = loc.latitude;
          addr?.lng = loc.longitude;
        });
        mapLatLng.value = LatLng(loc.latitude, loc.longitude);
      }
    } catch (e) {
      print('Không tìm thấy vị trí: $e');
    }
  }

  void onAddressFieldChanged() {
    if (_debounce?.isActive ?? false) _debounce!.cancel();
    _debounce = Timer(Duration(milliseconds: 500), () {
      updateMapPositionFromAddress();
    });
  }
}
