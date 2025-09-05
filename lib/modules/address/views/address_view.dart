import 'package:fido_box_demo01/core/assets/locale_keys.g.dart';
import 'package:fido_box_demo01/core/extensions/string_extension.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_typography.dart';
import '../controllers/address_controller.dart';

class AddressView extends GetView<AddressController> {
  AddressView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.neutral08,
      appBar: AppBar(
        title: Text(
          LocaleKeys.address.trans(),
          style: AppTypography.s20.medium.withColor(AppColors.neutral01),
        ),
        centerTitle: true,
        backgroundColor: AppColors.white,
        surfaceTintColor: Colors.transparent,
        elevation: 0.5,
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios_new_rounded),
          onPressed: () => Get.back(),
        ),
      ),
      body: Obx(() {
        return SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: EdgeInsets.symmetric(vertical: 10.r, horizontal: 16.r),
                child: Text(
                  LocaleKeys.address.trans(),
                  style: AppTypography.s16.semibold.withColor(AppColors.neutral03),
                ),
              ),
              Container(
                color: AppColors.white,
                child: ListView.builder(
                  shrinkWrap: true,
                  physics: NeverScrollableScrollPhysics(),
                  itemCount: controller.addressList.length + 1,
                  itemBuilder: (_, index) {
                    if (index == controller.addressList.length) {
                      return Padding(
                        padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 8.h),
                        child: TextButton.icon(
                          onPressed: controller.addNewAddress,
                          icon: Icon(Icons.add_circle_outline_outlined, color: AppColors.primary01),
                          label: Text(LocaleKeys.add_new_address.trans(), style: TextStyle(color: AppColors.primary01)),
                        ),
                      );
                    }

                    final item = controller.addressList[index];
                    return Padding(
                      padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 4.h),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Radio<bool>(
                            value: true,
                            groupValue: item.isDefault,
                            onChanged: (_) => controller.setDefaultAddress(index),
                            activeColor: AppColors.primary01,
                          ),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Expanded(
                                      child: RichText(
                                        text: TextSpan(
                                          text: item.name,
                                          style: AppTypography.s14.semibold.withColor(AppColors.neutral01),
                                          children: [
                                            TextSpan(
                                              text: '  ${item.phone}',
                                              style: AppTypography.s12.medium.withColor(AppColors.neutral03),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                    TextButton(
                                      onPressed: () => controller.editAddress(index),
                                      child: Text(
                                        LocaleKeys.address_fix.trans(),
                                        style: AppTypography.s14.regular.withColor(AppColors.neutral03),
                                      ),
                                    ),
                                  ],
                                ),
                                SizedBox(height: 4.h),
                                Text(item.street),
                                Text('Phường ${item.ward}, Quận ${item.district}'),
                                Text('TP. ${item.city}'),
                                if (item.isDefault)
                                  Container(
                                    margin: EdgeInsets.only(top: 6.h),
                                    padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 4.h),
                                    decoration: BoxDecoration(
                                      color: AppColors.primary04,
                                      border: Border.all(color:AppColors.primary01),
                                      borderRadius: BorderRadius.circular(4.r),
                                    ),
                                    child: Text(
                                      LocaleKeys.default1.trans(),
                                      style: TextStyle(
                                        fontSize: 12.sp,
                                        color: AppColors.primary01,
                                      ),
                                    ),
                                  ),
                                SizedBox(height: 12.h),
                              ],
                            ),
                          ),
                        ],
                      ),
                    );
                  },
                ),
              ),
            ],
          ),
        );
      }),
    );
  }
}
