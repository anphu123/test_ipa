import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../../core/assets/assets.gen.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_typography.dart';
import '../domain/store_model.dart';
import '../views/store_map_view.dart';
import '../controllers/list_store_controller.dart';
import '../services/phone_service.dart';

// i18n
import '../../../core/assets/locale_keys.g.dart';
import 'package:fido_box_demo01/core/extensions/string_extension.dart';

class StoreCard extends StatelessWidget {
  final StoreModel store;

  const StoreCard({Key? key, required this.store}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => Get.to(() => StoreMapView(store: store)),
      child: Container(
        padding: EdgeInsets.all(12.w),
        decoration: BoxDecoration(
          color: AppColors.white,
          borderRadius: BorderRadius.circular(12.r),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildHeader(),
            SizedBox(height: 12.h),
            _buildStoreInfo(),
            SizedBox(height: 12.h),
            _buildServices(),
            SizedBox(height: 12.h),
            _buildCategories(),
            SizedBox(height: 12.h),
            _buildAdditionalServices(),
          ],
        ),
      ),
    );
  }

  Widget _buildHeader() {
    return Row(
      children: [
        Expanded(
          child: Row(
            children: [
              Flexible(
                child: Text(
                  store.name,
                  style: AppTypography.s14.bold.withColor(AppColors.neutral01),
                  overflow: TextOverflow.ellipsis,
                  maxLines: 1,
                ),
              ),
              SizedBox(width: 4.w),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 4.w, vertical: 2.h),
                decoration: BoxDecoration(
                  color: AppColors.primary04,
                  borderRadius: BorderRadius.circular(2.r),
                  border: Border.all(color: AppColors.primary01),
                ),
                child: Text(
                  LocaleKeys.store_nearest_tag.trans(), // "Gần nhất"
                  style: AppTypography.s10.medium.copyWith(
                    color: AppColors.primary01,
                  ),
                ),
              ),
            ],
          ),
        ),
        SizedBox(width: 8.w),
        Icon(Icons.arrow_forward_ios, size: 16.sp, color: AppColors.neutral03),
      ],
    );
  }

  Widget _buildStoreInfo() {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        ClipRRect(
          borderRadius: BorderRadius.circular(8.r),
          child: SizedBox(
            width: 80.w,
            height: 80.w,
            child: Image.network(
              store.imageUrl,
              fit: BoxFit.cover,
              loadingBuilder: (context, child, loadingProgress) {
                if (loadingProgress == null) return child;
                return Container(
                  color: AppColors.neutral06,
                  child: Center(
                    child: CircularProgressIndicator(
                      strokeWidth: 2,
                      valueColor: AlwaysStoppedAnimation<Color>(
                        AppColors.primary01,
                      ),
                    ),
                  ),
                );
              },
              errorBuilder: (context, error, stackTrace) {
                return Container(
                  color: AppColors.neutral06,
                  child: Icon(
                    Icons.image_not_supported,
                    color: AppColors.neutral03,
                    size: 24.sp,
                  ),
                );
              },
            ),
          ),
        ),
        SizedBox(width: 12.w),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                store.description,
                style: AppTypography.s12.regular.copyWith(
                  color: AppColors.neutral01,
                ),
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
              ),
              SizedBox(height: 8.h),
              Row(
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Image.asset(Assets.images.icLocal.path),
                            SizedBox(width: 4.w),
                            Text(
                              // "Cách bạn Xkm"
                              '${LocaleKeys.store_distance_prefix.trans()} ${store.distance}${LocaleKeys.store_distance_unit.trans()}',
                              style: AppTypography.s12.regular.copyWith(
                                color: AppColors.neutral03,
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: 4.h),
                        Text(
                          // "Giờ mở cửa: 09:00 - 22:00"
                          '${LocaleKeys.store_open_hours_prefix.trans()} ${store.openHours}',
                          style: AppTypography.s12.regular.copyWith(
                            color: AppColors.neutral03,
                          ),
                        ),
                      ],
                    ),
                  ),
                  _buildContactButton(),
                ],
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildContactButton() {
    return GestureDetector(
      onTap: () => PhoneService.makePhoneCall(phoneNumber: '0817433226'),
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 6.h),
        decoration: BoxDecoration(
          border: Border.all(color: AppColors.primary01),
          borderRadius: BorderRadius.circular(16.r),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(Icons.call, size: 13.sp, color: AppColors.primary01),
            SizedBox(width: 4.w),
            Text(
              LocaleKeys.store_contact_btn.trans(), // "Liên hệ"
              style: AppTypography.s12.semibold.copyWith(
                color: AppColors.primary01,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildServices() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          '${LocaleKeys.store_purchase_prefix.trans()}', // "Thu mua:"
          style: AppTypography.s12.medium.copyWith(color: AppColors.neutral01),
        ),
        SizedBox(height: 6.h),
        Wrap(
          spacing: 6.w,
          runSpacing: 4.h,
          children: store.services
              .map(
                (service) => Container(
              padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 4.h),
              decoration: const BoxDecoration(color: AppColors.neutral07),
              child: Text(
                service, // nội dung lấy từ server -> giữ nguyên
                style: AppTypography.s11.medium.copyWith(
                  color: AppColors.neutral03,
                ),
              ),
            ),
          )
              .toList(),
        ),
      ],
    );
  }

  Widget _buildCategories() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          '${LocaleKeys.store_retail_prefix.trans()}', // "Bán lẻ:"
          style: AppTypography.s12.medium.copyWith(color: AppColors.neutral01),
        ),
        SizedBox(height: 6.h),
        Wrap(
          spacing: 6.w,
          runSpacing: 4.h,
          children: store.categories
              .map(
                (category) => Container(
              padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 4.h),
              decoration: const BoxDecoration(color: AppColors.neutral07),
              child: Text(
                category, // data động -> giữ nguyên
                style: AppTypography.s11.medium.copyWith(
                  color: AppColors.neutral03,
                ),
              ),
            ),
          )
              .toList(),
        ),
      ],
    );
  }

  Widget _buildAdditionalServices() {
    // Hai badge mẫu – có thể đổi sang key nếu bạn muốn i18n luôn:
    final services = [
      LocaleKeys.service_privacy_wipe.trans(),
      LocaleKeys.service_data_transfer.trans(),
    ];

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          '${LocaleKeys.store_services_prefix.trans()}', // "Dịch vụ:"
          style: AppTypography.s12.medium.copyWith(color: AppColors.neutral01),
        ),
        SizedBox(height: 6.h),
        Wrap(
          spacing: 6.w,
          runSpacing: 4.h,
          children: services
              .map(
                (service) => Container(
              padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 4.h),
              decoration: const BoxDecoration(color: AppColors.neutral07),
              child: Text(
                service,
                style: AppTypography.s11.medium.copyWith(
                  color: AppColors.neutral03,
                ),
              ),
            ),
          )
              .toList(),
        ),
      ],
    );
  }
}
