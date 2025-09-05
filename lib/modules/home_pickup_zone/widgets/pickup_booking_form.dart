import 'dart:async';
import 'package:fido_box_demo01/core/assets/locale_keys.g.dart';
import 'package:fido_box_demo01/core/extensions/string_extension.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:keyboard_dismisser/keyboard_dismisser.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import '../../../core/theme/app_colors.dart';
import '../controllers/home_pickup_zone_controller.dart';
import '../domain/vietnam_address_data.dart';
import '../domain/address_geocoding_service.dart';
import 'components/address_input_field.dart';
import 'components/cascade_dropdown_field.dart';
import 'components/validation_status_widget.dart';
import 'components/current_location_button.dart';
import 'components/form_header.dart';
import 'components/submit_button.dart';

class PickupBookingForm extends StatefulWidget {
  final VoidCallback? onSubmit;
  final bool editMode;
  final bool editMode1;
  final Map<String, dynamic>? editData;
  final Function(Map<String, dynamic>)? onUpdate;

  const PickupBookingForm({
    Key? key,
    this.onSubmit,
    this.editMode1 = false,
    this.editMode = false,
    this.editData,
    this.onUpdate,
  }) : super(key: key);

  @override
  State<PickupBookingForm> createState() => _PickupBookingFormState();
}

class _PickupBookingFormState extends State<PickupBookingForm> {
  final _formKey = GlobalKey<FormState>();
  final _contactController = TextEditingController();
  final _phoneController = TextEditingController();
  final _cityController = TextEditingController();
  final _districtController = TextEditingController();
  final _wardController = TextEditingController();
  final _addressController = TextEditingController();

  final _controller = Get.find<HomePickupZoneController>();
  LatLng? _addressLocation;
  bool _isValidatingAddress = false;
  String? _addressValidationMessage;
  Timer? _debounceTimer;

  List<String> _availableDistricts = [];
  List<String> _availableWards = [];

  @override
  void initState() {
    super.initState();
    _addressController.addListener(_onAddressFieldChanged);

    if (widget.editMode && widget.editData != null) {
      _fillFormWithEditData();
    }
  }

  void _fillFormWithEditData() {
    final data = widget.editData!;
    setState(() {
      _contactController.text = data['contactName'] ?? '';
      _phoneController.text = data['phoneNumber'] ?? '';
      _addressController.text = data['street'] ?? '';
      _wardController.text = data['ward'] ?? '';
      _districtController.text = data['district'] ?? '';
      _cityController.text = data['city'] ?? '';
      if (data['latitude'] != null && data['longitude'] != null) {
        _addressLocation = LatLng(data['latitude'], data['longitude']);
      }
      if (_cityController.text.isNotEmpty) {
        _availableDistricts = VietnamAddressData.getDistrictsByCity(_cityController.text);
      }
      if (_districtController.text.isNotEmpty) {
        _availableWards = VietnamAddressData.getWardsByDistrict(_districtController.text);
      }
    });
  }

  @override
  void dispose() {
    _debounceTimer?.cancel();
    _contactController.dispose();
    _phoneController.dispose();
    _cityController.dispose();
    _districtController.dispose();
    _wardController.dispose();
    _addressController.removeListener(_onAddressFieldChanged);
    _addressController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      constraints: BoxConstraints(
        maxHeight: widget.editMode1
            ? MediaQuery.of(context).size.height * 1.2
            : MediaQuery.of(context).size.height * 0.8,
      ),
      padding: EdgeInsets.all(20.w),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.vertical(top: Radius.circular(16.r)),
      ),
      child: KeyboardDismisser(
        child: SingleChildScrollView(
          child: Form(
            key: _formKey,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                FormHeader(
                  isClose: !widget.editMode1,
                  isBackButton: widget.editMode1,
                  title: widget.editMode
                      ? LocaleKeys.booking_edit_title.trans()
                      : LocaleKeys.booking_create_title.trans(),
                ),
                SizedBox(height: 24.h),

                _buildContactSection(),
                SizedBox(height: 24.h),

                _buildAddressSection(),
                SizedBox(height: 24.h),

                if (widget.editMode)
                  Row(
                    children: [
                      Expanded(
                        child: GestureDetector(
                          onTap: () => Get.back(),
                          child: Container(
                            padding: EdgeInsets.symmetric(vertical: 12.h),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(4.r),
                              border: Border.all(color: AppColors.neutral04),
                            ),
                            child: Center(
                              child: Text(LocaleKeys.cancel.trans()),
                            ),
                          ),
                        ),
                      ),
                      SizedBox(width: 16),
                      Expanded(
                        child: GestureDetector(
                          onTap: _isValidatingAddress ? null : _submitForm,
                          child: Container(
                            padding: EdgeInsets.symmetric(vertical: 12.h),
                            decoration: BoxDecoration(
                              color: _isValidatingAddress ? AppColors.neutral04 : AppColors.primary01,
                              borderRadius: BorderRadius.circular(8.r),
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                if (_isValidatingAddress)
                                  SizedBox(
                                    width: 16,
                                    height: 16,
                                    child: CircularProgressIndicator(
                                      strokeWidth: 2,
                                      valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                                    ),
                                  ),
                                if (_isValidatingAddress) SizedBox(width: 8),
                                Text(
                                  _isValidatingAddress
                                      ? LocaleKeys.processing.trans()
                                      : LocaleKeys.update.trans(),
                                  style: TextStyle(color: Colors.white, fontSize: 16, fontWeight: FontWeight.w500),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ],
                  )
                else
                  SubmitButton(
                    text: LocaleKeys.confirm_booking.trans(),
                    onPressed: _submitForm,
                    isLoading: _isValidatingAddress,
                  ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildContactSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        AddressInputField(
          label: LocaleKeys.contact_person_label.trans(),
          controller: _contactController,
          placeholder: LocaleKeys.contact_person_placeholder.trans(),
          isRequired: true,
          validator: (value) {
            if (value == null || value.trim().isEmpty) {
              return LocaleKeys.contact_person_required.trans();
            }
            return null;
          },
        ),
        SizedBox(height: 16.h),
        AddressInputField(
          label: LocaleKeys.phone_label.trans(),
          controller: _phoneController,
          placeholder: LocaleKeys.phone_placeholder.trans(),
          keyboardType: TextInputType.phone,
          isRequired: true,
          validator: (value) {
            if (value == null || value.trim().isEmpty) {
              return LocaleKeys.phone_required.trans();
            }
            final phoneRegex = RegExp(r'^[0-9]{9,10}$');
            if (!phoneRegex.hasMatch(value.trim())) {
              return LocaleKeys.phone_invalid.trans();
            }
            return null;
          },
        ),
      ],
    );
  }

  Widget _buildAddressSection() {
    final needCityFirst = LocaleKeys.select_city_first.trans();
    final needDistrictFirst = LocaleKeys.select_district_first.trans();

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        CascadeDropdownField(
          label: LocaleKeys.city_label.trans(),
          controller: _cityController,
          placeholder: LocaleKeys.city_placeholder.trans(),
          items: VietnamAddressData.getCities(),
          onChanged: _onCityChanged,
          isRequired: true,
        ),
        SizedBox(height: 16.h),
        CascadeDropdownField(
          label: LocaleKeys.district_label.trans(),
          controller: _districtController,
          placeholder: _cityController.text.isEmpty ? needCityFirst : LocaleKeys.district_placeholder.trans(),
          items: _availableDistricts,
          onChanged: _onDistrictChanged,
          isRequired: true,
        ),
        SizedBox(height: 16.h),
        CascadeDropdownField(
          label: LocaleKeys.ward_label.trans(),
          controller: _wardController,
          placeholder: _districtController.text.isEmpty ? needDistrictFirst : LocaleKeys.ward_placeholder.trans(),
          items: _availableWards,
          onChanged: _onWardChanged,
          isRequired: true,
        ),
        SizedBox(height: 16.h),
        AddressInputField(
          label: LocaleKeys.address_label.trans(),
          controller: _addressController,
          placeholder: LocaleKeys.address_placeholder.trans(),
          maxLines: 2,
          isRequired: true,
          showValidation: true,
          helperText: LocaleKeys.address_helper.trans(),
          isValidating: _isValidatingAddress,
          validationMessage: _addressValidationMessage,
          validator: (value) {
            if (value == null || value.trim().isEmpty) {
              return LocaleKeys.address_required.trans();
            }
            if (value.trim().length < 5) {
              return LocaleKeys.address_too_short.trans();
            }
            return null;
          },
        ),
        SizedBox(height: 16.h),
      ],
    );
  }

  void _onCityChanged(String? city) {
    if (city != null && city.isNotEmpty) {
      setState(() {
        _cityController.text = city;
        _availableDistricts = VietnamAddressData.getDistrictsByCity(city);
        _districtController.clear();
        _wardController.clear();
        _availableWards = [];
        _addressValidationMessage = null;
      });
      _triggerAddressValidation();
    }
  }

  void _onDistrictChanged(String? district) {
    if (district != null && district.isNotEmpty) {
      setState(() {
        _districtController.text = district;
        _availableWards = VietnamAddressData.getWardsByDistrict(district);
        _wardController.clear();
        _addressValidationMessage = null;
      });
      _triggerAddressValidation();
    }
  }

  void _onWardChanged(String? ward) {
    if (ward != null && ward.isNotEmpty) {
      setState(() {
        _wardController.text = ward;
        _addressValidationMessage = null;
      });
      _triggerAddressValidation();
    }
  }

  void _onAddressFieldChanged() {
    // Tắt auto-validate tạm thời
  }

  void _triggerAddressValidation() {
    // Tắt auto-validate tạm thời
  }

  bool _shouldValidateAddress() {
    return _cityController.text.trim().isNotEmpty &&
        _districtController.text.trim().isNotEmpty &&
        _wardController.text.trim().isNotEmpty &&
        _addressController.text.trim().length >= 5;
  }

  Future<void> _validateAddressLocation() async {
    if (_isValidatingAddress) return;

    setState(() {
      _isValidatingAddress = true;
      _addressValidationMessage = null;
    });

    try {
      final result = await AddressGeocodingService.geocodeAddress(
        streetAddress: _addressController.text.trim(),
        ward: _wardController.text.isNotEmpty ? _wardController.text : null,
        district: _districtController.text.isNotEmpty ? _districtController.text : null,
        city: _cityController.text.isNotEmpty ? _cityController.text : null,
      );

      if (!result.isSuccess) {
        setState(() {
          _addressValidationMessage = LocaleKeys.address_not_found.trans();
          _addressLocation = null;
        });
        return;
      }

      _addressLocation = result.coordinates!;

      final reverseResult = await AddressGeocodingService.reverseGeocode(_addressLocation!);
      if (reverseResult.isSuccess) {
        final isAddressValid = _validateAddressConsistency(reverseResult);
        if (!isAddressValid) {
          setState(() {
            _addressValidationMessage = LocaleKeys.address_mismatch.trans();
            _addressLocation = null;
          });
          return;
        }
      }

      _checkPickupZoneSupport(_addressLocation!);
    } catch (e) {
      setState(() {
        _addressValidationMessage = LocaleKeys.address_not_found.trans();
        _addressLocation = null;
      });
    } finally {
      setState(() {
        _isValidatingAddress = false;
      });
    }
  }

  bool _validateAddressConsistency(ReverseGeocodingResult reverseResult) {
    final selectedCity = _cityController.text.trim();
    final selectedDistrict = _districtController.text.trim();
    final selectedWard = _wardController.text.trim();

    final geocodedCity = reverseResult.city?.trim() ?? '';
    final geocodedDistrict = reverseResult.district?.trim() ?? '';
    final geocodedWard = reverseResult.ward?.trim() ?? '';

    bool isValid = true;
    if (geocodedCity.isNotEmpty) {
      if (!_isLocationMatch(selectedCity, geocodedCity)) isValid = false;
    }
    if (geocodedDistrict.isNotEmpty) {
      if (!_isLocationMatch(selectedDistrict, geocodedDistrict)) isValid = false;
    }
    if (geocodedWard.isNotEmpty) {
      if (!_isLocationMatch(selectedWard, geocodedWard)) isValid = false;
    }
    return isValid;
  }

  bool _isLocationMatch(String selected, String geocoded) {
    if (selected.isEmpty || geocoded.isEmpty) return false;
    final normalizedSelected = _normalizeLocationName(selected);
    final normalizedGeocoded = _normalizeLocationName(geocoded);
    return normalizedSelected == normalizedGeocoded ||
        normalizedGeocoded.contains(normalizedSelected) ||
        normalizedSelected.contains(normalizedGeocoded);
  }

  String _normalizeLocationName(String name) {
    String normalized = _removeDiacritics(name);
    return normalized
        .toLowerCase()
        .replaceAll('thanh pho ', '')
        .replaceAll('quan ', '')
        .replaceAll('huyen ', '')
        .replaceAll('phuong ', '')
        .replaceAll('xa ', '')
        .replaceAll('thi xa ', '')
        .replaceAll('thành phố ', '')
        .replaceAll('quận ', '')
        .replaceAll('huyện ', '')
        .replaceAll('phường ', '')
        .replaceAll('xã ', '')
        .replaceAll('thị xã ', '')
        .trim();
  }

  String _removeDiacritics(String input) {
    const vietnamese =
        'áàạảãâấầậẩẫăắằặẳẵ'
        'ÁÀẠẢÃÂẤẦẬẨẪĂẮẰẶẲẴ'
        'éèẹẻẽêếềệểễ'
        'ÉÈẸẺẼÊẾỀỆỂỄ'
        'óòọỏõôốồộổỗơớờợởỡ'
        'ÓÒỌỎÕÔỐỒỘỔỖƠỚỜỢỞỠ'
        'úùụủũưứừựửữ'
        'ÚÙỤỦŨƯỨỪỰỬỮ'
        'íìịỉĩ'
        'ÍÌỊỈĨ'
        'đĐ'
        'ýỳỵỷỹ'
        'ÝỲỴỶỸ';
    const latin =
        'aaaaaaaaaaaaaaaaa'
        'AAAAAAAAAAAAAAAAA'
        'eeeeeeeeeee'
        'EEEEEEEEEEE'
        'ooooooooooooooooooo'
        'OOOOOOOOOOOOOOOOOOO'
        'uuuuuuuuuuu'
        'UUUUUUUUUUU'
        'iiiii'
        'IIIII'
        'dD'
        'yyyyy'
        'YYYYY';
    String result = input;
    for (int i = 0; i < vietnamese.length; i++) {
      result = result.replaceAll(vietnamese[i], latin[i]);
    }
    return result;
  }

  void _fillFormFromReverseGeocode(ReverseGeocodingResult result) {
    setState(() {
      if (result.street?.isNotEmpty == true) _addressController.text = result.street!;
      if (result.ward?.isNotEmpty == true) _wardController.text = result.ward!;
      if (result.district?.isNotEmpty == true) {
        _districtController.text = result.district!;
        _availableWards = VietnamAddressData.getWardsByDistrict(result.district!);
      }
      if (result.city?.isNotEmpty == true) {
        _cityController.text = result.city!;
        _availableDistricts = VietnamAddressData.getDistrictsByCity(result.city!);
      }
    });
  }

  void _checkPickupZoneSupport(LatLng coordinates) {
    final isInZone = _controller.isAddressInPickupZone(coordinates);
    if (isInZone) {
      final zone = _controller.getPickupZoneForAddress(coordinates);
      setState(() {
        _addressValidationMessage = zone != null
            ? LocaleKeys.address_supported_zone.trans().replaceAll('{zone}', zone.name)
            : LocaleKeys.address_supported.trans();
      });
    } else {
      final nearestZone = _controller.findNearestPickupZone(coordinates);
      if (nearestZone != null) {
        final distance = _controller.calculateDistanceToZone(coordinates, nearestZone);
        setState(() {
          _addressValidationMessage = LocaleKeys.nearest_zone_suggestion
              .trans()
              .replaceAll('{zone}', nearestZone.name)
              .replaceAll('{distance}', distance.toStringAsFixed(1));

        });
      } else {
        setState(() {
          _addressValidationMessage = LocaleKeys.address_not_supported.trans();
        });
      }
    }
  }

  void _submitForm() {
    if (!_formKey.currentState!.validate()) return;

    if (_contactController.text.trim().isEmpty) {
      _showError(LocaleKeys.contact_person_required.trans());
      return;
    }

    final phone = _phoneController.text.trim();
    if (phone.isEmpty) {
      _showError(LocaleKeys.phone_required.trans());
      return;
    }
    if (phone.length < 10 || phone.length > 11 || !RegExp(r'^[0-9]+$').hasMatch(phone)) {
      _showError(LocaleKeys.phone_invalid.trans());
      return;
    }
    if (!phone.startsWith('0') && !phone.startsWith('84')) {
      _showError(LocaleKeys.phone_invalid_prefix.trans());
      return;
    }

    if (_cityController.text.trim().isEmpty ||
        _districtController.text.trim().isEmpty ||
        _wardController.text.trim().isEmpty ||
        _addressController.text.trim().isEmpty) {
      _showError(LocaleKeys.address_required_all.trans());
      return;
    }

    final formData = _collectFormData();

    if (widget.editMode) {
      widget.onUpdate?.call(formData);
      Get.close(1);
    } else {
      _controller.addBookingData(formData);
      final coordinates = _addressLocation ?? LatLng(10.8231, 106.6297);
      _controller.addBookingMarker(coordinates, formData['fullAddress'] as String);
      Get.back();
      widget.onSubmit?.call();
    }
  }

  Map<String, dynamic> _collectFormData() {
    final defaultLat = 10.8231;
    final defaultLng = 106.6297;

    final coordinates = _addressLocation ?? LatLng(defaultLat, defaultLng);
    final isInZone = _controller.isAddressInPickupZone(coordinates);
    final nearestZone = _controller.findNearestPickupZone(coordinates);

    final street = _addressController.text.trim();
    final ward = _wardController.text.trim();
    final district = _districtController.text.trim();
    final city = _cityController.text.trim();

    final fullAddress = [street, ward, district, city].where((part) => part.isNotEmpty).join(', ');

    return {
      'id': widget.editMode ? widget.editData!['id'] : DateTime.now().millisecondsSinceEpoch.toString(),
      'contactName': _contactController.text.trim(),
      'phoneNumber': _phoneController.text.trim(),
      'fullAddress': fullAddress,
      'street': street,
      'ward': ward,
      'district': district,
      'city': city,
      'note': '',
      'latitude': coordinates.latitude,
      'longitude': coordinates.longitude,
      'isInZone': isInZone,
      'nearestZone': nearestZone?.name ?? '',
      'distance': nearestZone != null
          ? _controller.calculateDistanceToZone(coordinates, nearestZone).toStringAsFixed(1)
          : '0',
      'createdAt': widget.editMode ? widget.editData!['createdAt'] : DateTime.now().millisecondsSinceEpoch,
      'isDefault': widget.editMode ? (widget.editData!['isDefault'] ?? false) : false,
    };
  }

  void _showError(String message) {
    Get.snackbar(
      LocaleKeys.error.trans(),
      message,
      snackPosition: SnackPosition.TOP,
      backgroundColor: AppColors.red600,
      colorText: Colors.white,
      duration: Duration(seconds: 3),
    );
  }
}
