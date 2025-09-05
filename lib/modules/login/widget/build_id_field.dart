import 'package:country_picker/country_picker.dart';
import 'package:fido_box_demo01/core/assets/assets.gen.dart';
import 'package:fido_box_demo01/core/assets/locale_keys.g.dart';
import 'package:fido_box_demo01/core/extensions/string_extension.dart';
import 'package:fido_box_demo01/core/theme/app_colors.dart';
import 'package:fido_box_demo01/core/theme/app_typography.dart';
import 'package:fido_box_demo01/modules/login/controllers/login_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class PhoneNumberField extends StatefulWidget {
  final TextEditingController controller;
  final ValueChanged<String>? onPhoneCodeChanged;

  const PhoneNumberField({
    super.key,
    required this.controller,
    this.onPhoneCodeChanged,
  });

  @override
  State<PhoneNumberField> createState() => _PhoneNumberFieldState();
}

class _PhoneNumberFieldState extends State<PhoneNumberField> {
  final LoginController controller = Get.find<LoginController>();

  Country _selectedCountry = Country(
    phoneCode: '84',
    countryCode: 'VN',
    e164Sc: 0,
    geographic: true,
    level: 1,
    name: 'Vietnam',
    example: '0912345678',
    displayName: 'Vietnam',
    displayNameNoCountryCode: 'Vietnam',
    e164Key: '',
  );

  @override
  void initState() {
    super.initState();
    widget.onPhoneCodeChanged?.call(_selectedCountry.phoneCode);
    controller.setPhoneCode(_selectedCountry.phoneCode);
  }

  void _openCountryPicker() {
    showCountryPicker(
      context: context,
      showPhoneCode: true,
      countryListTheme: CountryListThemeData(
        bottomSheetHeight: 400.h,
        borderRadius: BorderRadius.vertical(top: Radius.circular(8.r)),
        inputDecoration: InputDecoration(
          labelText: LocaleKeys.search.trans(),
          prefixIcon: Image.asset(Assets.images.icSearch.path),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8.r),
          ),
        ),
        textStyle: AppTypography.s14.regular.withColor(AppColors.neutral01),
      ),
      onSelect: (Country country) {
        setState(() {
          _selectedCountry = country;
        });
        widget.onPhoneCodeChanged?.call(country.phoneCode);
        controller.setPhoneCode(country.phoneCode);
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Obx(
          () => Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            LocaleKeys.phone_number.trans(),
            style: AppTypography.s14.regular.withColor(AppColors.neutral01),
          ),
          SizedBox(height: 6.h),
          Container(
            height: 56.h,
            decoration: BoxDecoration(
              border: Border.all(
                color: controller.phoneError.value.isNotEmpty
                    ? AppColors.primary01
                    : AppColors.neutral01,
              ),
              borderRadius: BorderRadius.circular(12.r),
            ),
            child: Row(
              children: [
                GestureDetector(
                  onTap: _openCountryPicker,
                  child: Container(
                    padding: EdgeInsets.symmetric(horizontal: 8.w),
                    child: Row(
                      children: [
                        Text(
                          _selectedCountry.flagEmoji,
                          style: AppTypography.s24,
                        ),
                        SizedBox(width: 8.w),
                        Text(
                          "+${_selectedCountry.phoneCode}",
                          style: AppTypography.s14.regular.withColor(AppColors.neutral01),
                        ),
                        Icon(Icons.arrow_drop_down, color: AppColors.neutral05),
                      ],
                    ),
                  ),
                ),
                VerticalDivider(color: Colors.grey.shade400),
                Expanded(
                  child: Padding(
                    padding: EdgeInsets.symmetric(horizontal: 12.w),
                    child: TextField(
                      controller: widget.controller,
                      keyboardType: TextInputType.phone,
                      decoration: const InputDecoration(
                        border: InputBorder.none,
                      ),
                      onChanged: (_) {
                        if (controller.phoneError.value.isNotEmpty) {
                          controller.phoneError.value = '';
                        }
                      },
                    ),
                  ),
                ),
              ],
            ),
          ),
          if (controller.phoneError.value.isNotEmpty) ...[
            SizedBox(height: 6.h),
            Padding(
              padding: EdgeInsets.only(left: 4.w),
              child: Text(
                controller.phoneError.value,
                style: AppTypography.s12.regular.copyWith(color: AppColors.primary01),
              ),
            ),
          ],
        ],
      ),
    );
  }
}
