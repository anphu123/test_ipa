import 'package:fido_box_demo01/core/assets/locale_keys.g.dart';
import 'package:fido_box_demo01/core/extensions/ml_extension.dart';
import 'package:fido_box_demo01/core/extensions/string_extension.dart';
import 'package:fido_box_demo01/router/app_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:photo_view/photo_view.dart';
import 'package:photo_view/photo_view_gallery.dart';

import '../../../core/assets/assets.gen.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_typography.dart';
import '../controllers/detail_product_controller.dart';
import '../widgets/inspection_report_screen/accessory_list_card.dart';
import '../widgets/inspection_report_screen/inspection_explanation_section.dart';
// import '../controllers/detail_product_controller.dart'; // import đúng path controller của bạn

class InspectionReportScreen extends GetView<DetailProductController> {
  const InspectionReportScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      if (controller.isLoading.value) {
        return Padding(
          padding: EdgeInsets.all(16.w),
          child: const Center(child: CircularProgressIndicator()),
        );
      }
      if (controller.errorMessage.value.isNotEmpty) {
        return Padding(
          padding: EdgeInsets.all(16.w),
          child: Text(
            controller.errorMessage.value,
            style: AppTypography.s14.medium.withColor(AppColors.primary01),
          ),
        );
      }

      // UI chính
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildReportHeader(),
          Container(
            padding: EdgeInsets.all(8.r),
            color: AppColors.neutral08,

            child: Column(
              children: [
                _buildIntroBadge(),
                _productInfoCard(),
                SizedBox(height: 24,),
                InspectionExplanationSection(
                  items: [
                    ExplanationItem(
                      title: LocaleKeys.charger_note.trans(),
                      description:
                      LocaleKeys.open_machine_check.trans(),
                    ),
                    ExplanationItem(
                      title: LocaleKeys.replacement_repair.trans(),
                      description:
                      LocaleKeys.no_replacement.trans(),
                    ),
                    ExplanationItem(
                      title: LocaleKeys.platform_provide.trans(),
                      description:
                      LocaleKeys.platform_note.trans(),
                    ),
                  ],
                  onFeedbackTap: () {
                    /* TODO: mở form phản hồi */
                    Get.toNamed(Routes.supportchat);
                  },
                  infoLines: [
                    InfoLine(
                      LocaleKeys.checked_at_station.trans(),
                    ),
                    InfoLine(LocaleKeys.inspection_time.trans(), muted: true),
                    InfoLine(LocaleKeys.explanation_after_inspection.trans(),),
                  ],
                ),
              ],
            ),
          ),
        ],
      );
    });
  }

  // ===== Header "Kiểm định chính hãng"
  Widget _buildReportHeader() {
    return Stack(
      children: [
        Image.asset(
          Assets.images.bgKiemdinhchinhhang.path,
          width: double.infinity,
          fit: BoxFit.cover,
        ),
        Positioned.fill(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 8.h),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  LocaleKeys.official_inspection.trans(),
                  style: AppTypography.s10.medium.withColor(
                    AppColors.neutral01,
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  // ===== Tiêu đề + badge "Kiểm tra trực tiếp"
  Widget _buildIntroBadge() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Expanded(
              child: Text(
                LocaleKeys.inspection_report.trans(),
                maxLines: 2,
                style: AppTypography.s18.bold.withColor(AppColors.neutral01),
              ),
            ),
            Container(
              padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 4.h),
              decoration: BoxDecoration(
                color: AppColors.AE01,
                borderRadius: BorderRadius.circular(16.r),
              ),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Image.asset(
                    Assets.images.icKiemtratructiep.path,
                    height: 10.h,
                    fit: BoxFit.contain,
                  ),
                  SizedBox(width: 4.w),
                  Text(
                    LocaleKeys.direct_check.trans(),
                    style: AppTypography.s12.medium.withColor(AppColors.white),
                  ),
                ],
              ),
            ),
          ],
        ),
        SizedBox(height: 4.h),
      ],
    );
  }

  // ===== Card trắng: thông tin + các section
  Widget _productInfoCard() {
    final product = controller.product;

    return Container(
      color: AppColors.white,
      padding: EdgeInsets.all(8.r),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // tên sp + avatar + mã
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Expanded(
                    child: Text(
                      product.name.trML(),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: AppTypography.s16.semibold,
                    ),
                  ),
                  CircleAvatar(
                    radius: 18.r,
                    backgroundImage: Assets.images.avaShipper.provider(),
                  ),
                ],
              ),
              SizedBox(height: 4.h),
              Text(
                '${LocaleKeys.product_id.trans()} ${product.id}',
                style: AppTypography.s12.regular.withColor(AppColors.neutral04),
              ),
            ],
          ),

          SizedBox(height: 24.h),
          _appearanceSection(),
          SizedBox(height: 24.h),
          _specsSection(),
          SizedBox(height: 24.h),
          _exteriorPhotosSection(),
          SizedBox(height: 24.h),
          _batterySection(),
          SizedBox(height: 24.h),
          _otherChecksSection(),
          SizedBox(height: 24.h),
          AccessoryListCard(
                commonNote:   LocaleKeys.charger_note.trans(),
               extraItems: [
                 LocaleKeys.extra_item_box.trans(),
                 LocaleKeys.extra_item_sim_ejector.trans(),
                 LocaleKeys.extra_item_user_manual.trans(),
                 LocaleKeys.extra_item_certification.trans(),
            ],
          ),
        ],
      ),
    );
  }

  // ===== Ngoại hình: dùng RxBool trong controller
  Widget _appearanceSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          LocaleKeys.appearance_function.trans(),
          style: AppTypography.s16.semibold,
        ),
        SizedBox(height: 4.h),
        Obx(() {
          final expanded = controller.showMoreAppearance.value;
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                LocaleKeys.appearance_detail.trans(),
                maxLines: expanded ? null : 2,
                overflow: TextOverflow.ellipsis,
                style: AppTypography.s14.regular.withColor(AppColors.neutral04),
              ),
              GestureDetector(
                onTap: () => controller.showMoreAppearance.toggle(),
                child: Text(
                  expanded ? LocaleKeys.collapse.trans() : LocaleKeys.see_more.trans(),
                  style: AppTypography.s14.medium.withColor(
                    AppColors.primary01,
                  ),
                ),
              ),
            ],
          );
        }),
      ],
    );
  }

  // ===== Thông số: grid 3 cột + Xem thêm
  Widget _specsSection() {
    final specs = <Map<String, String>>[
      {'label': LocaleKeys.spec_sim.trans(), 'value': LocaleKeys.spec_dual_sim.trans()},
      {'label': LocaleKeys.spec_network_mode.trans(), 'value': LocaleKeys.spec_network_mode_val.trans()},
      {'label': LocaleKeys.spec_network_type.trans(), 'value': LocaleKeys.spec_network_mode_val.trans()},
      {'label': LocaleKeys.spec_chip.trans(), 'value': LocaleKeys.spec_chip_val.trans()},
      {'label': LocaleKeys.spec_battery_percent.trans(), 'value': LocaleKeys.spec_battery_percent_val.trans()},
      {'label': LocaleKeys.spec_battery_percent.trans(), 'value': LocaleKeys.spec_battery_percent_val.trans()},
      {'label': LocaleKeys.spec_ram.trans(), 'value': LocaleKeys.spec_ram_val.trans()},
      {'label': LocaleKeys.spec_rom.trans(), 'value': LocaleKeys.spec_rom_val.trans()},
      {'label': LocaleKeys.spec_fast_charge.trans(), 'value': LocaleKeys.spec_fast_charge_val.trans()},
    ];

    return Obx(() {
      final showAll = controller.showMoreSpecs.value;
      final items = showAll ? specs : specs.take(6).toList();

      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          GridView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: items.length,
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 3,
              mainAxisSpacing: 14.h,
              crossAxisSpacing: 14.w,
              mainAxisExtent: 60.h, // <-- tăng chiều cao ô (60–68.h tuỳ font)
            ),
            itemBuilder: (_, i) {
              final e = items[i];
              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Flexible(
                    child: Text(
                      e['value']!,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style: AppTypography.s12.semibold.copyWith(
                        color: AppColors.neutral02,
                      ),
                    ),
                  ),
                  //                  SizedBox(height: 2.h)
                  Text(
                    e['label']!,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: AppTypography.s12.regular
                        .withColor(AppColors.neutral04)
                        .copyWith(height: 1.1),
                  ),
                ],
              );
            },
          ),
          SizedBox(height: 8.h),
          if (specs.length > 6)
            Center(
              child: GestureDetector(
                onTap: controller.toggleSpecsExpanded,
                child: Text(
                  showAll ? LocaleKeys.collapse.trans() : LocaleKeys.see_more.trans(),
                  style: AppTypography.s14.medium.withColor(
                    AppColors.primary01,
                  ),
                ),
              ),
            ),
        ],
      );
    });
  }

  // ===== Ảnh ngoại hình: dùng controller.productImages
  Widget _exteriorPhotosSection() {
    final imgs = controller.productImages;
    if (imgs.isEmpty) return const SizedBox();

    // Chiều cao cụm ảnh (giảm/ tăng tuỳ UI)
    final double panelHeight = 150.h;
    final List<String> thumbs = imgs.length > 1 ? imgs.sublist(1) : const [];

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
             LocaleKeys.appearance_check.trans(),
              style: AppTypography.s16.medium.withColor(AppColors.neutral02),
            ),
            Row(
              children: [
                Icon(
                  Icons.report_gmailerrorred_sharp,
                  color: AppColors.neutral02,
                ),
                SizedBox(width: 4.w),
                Text(
                  LocaleKeys.usage_marks.trans(),
                  style: AppTypography.s12.regular.withColor(
                    AppColors.neutral02,
                  ),
                ),
                Icon(
                  Icons.keyboard_arrow_down_rounded,
                  color: AppColors.neutral02,
                ),
              ],
            ),
          ],
        ),
        SizedBox(height: 8.h),

        // Cụm ảnh
        SizedBox(
          height: panelHeight,
          child: Row(
            children: [
              // Ảnh lớn = phần tử đầu tiên
              Expanded(
                flex: 6,
                child: GestureDetector(
                  onTap: () => _openImagePreview(0),
                  child: Hero(
                    tag: 'inspect_0',
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(12.r),
                      child: SizedBox.expand(
                        child: Image.network(
                          imgs[0],
                          fit: BoxFit.cover,
                          errorBuilder:
                              (_, __, ___) => Container(
                                color: AppColors.neutral08,
                                alignment: Alignment.center,
                                child: const Icon(Icons.broken_image),
                              ),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
              SizedBox(width: 12.w),

              // Grid ảnh nhỏ = các phần tử 1..n-1
              Expanded(
                flex: 7,
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(12.r),
                  child: LayoutBuilder(
                    builder: (context, constraints) {
                      const crossCount = 3;
                      final double hPad = 6.r;
                      final double vPad = 6.r;
                      final double crossSpacing = 10.w;
                      final double mainSpacing = 10.h;
                      final int rows =
                          (thumbs.length + crossCount - 1) ~/ crossCount;

                      // kích thước khả dụng
                      final double gridW = constraints.maxWidth - hPad * 2;
                      final double gridH = constraints.maxHeight - vPad * 2;

                      // tính tỉ lệ để lấp kín chiều cao
                      final double cellW =
                          (gridW - crossSpacing * (crossCount - 1)) /
                          crossCount;
                      final double cellH =
                          rows > 0
                              ? (gridH - mainSpacing * (rows - 1)) / rows
                              : cellW;
                      final double ratio = cellW / cellH;

                      return GridView.builder(
                        padding: EdgeInsets.symmetric(
                          horizontal: hPad,
                          vertical: vPad,
                        ),
                        physics: const NeverScrollableScrollPhysics(),
                        // fill kín, không scroll
                        itemCount: thumbs.length,
                        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: crossCount,
                          mainAxisSpacing: mainSpacing,
                          crossAxisSpacing: crossSpacing,
                          childAspectRatio: ratio,
                        ),
                        itemBuilder: (_, idx) {
                          final i = idx + 1; // map về index thật
                          final url = imgs[i];
                          return GestureDetector(
                            onTap: () => _openImagePreview(i),
                            child: Hero(
                              tag: 'inspect_$i',
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(10.r),
                                child: Image.network(
                                  url,
                                  fit: BoxFit.cover,
                                  errorBuilder:
                                      (_, __, ___) =>
                                          const Icon(Icons.broken_image),
                                ),
                              ),
                            ),
                          );
                        },
                      );
                    },
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  // ===== Pin
  Widget _batterySection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text( LocaleKeys.battery_status.trans(), style: AppTypography.s16.semibold),
        SizedBox(height: 8.h),
        Row(
          children: [
            Expanded(
              flex: 3,
              child: Container(
                color: AppColors.neutral08,
                padding: EdgeInsets.all(8.r),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                  LocaleKeys.battery_health.trans(),
                      style: AppTypography.s14.regular.withColor(
                        AppColors.neutral04,
                      ),
                    ),
                    SizedBox(height: 4.h),
                    Text('80% - 85%', style: AppTypography.s14.medium),
                    SizedBox(height: 8.h),
                    LinearProgressIndicator(
                      value: 0.825,
                      color: AppColors.AS01,
                      backgroundColor: AppColors.neutral06,
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(width: 12.w),
            Expanded(
              flex: 3,
              child: Container(
                color: AppColors.neutral08,
                padding: EdgeInsets.all(8.r),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      LocaleKeys.replacement_status.trans(),
                      maxLines: 1,
                      style: AppTypography.s14.regular.withColor(
                        AppColors.neutral04,
                      ),
                    ),
                    SizedBox(height: 4.h),
                    Text(
                      LocaleKeys.no_replacement.trans(),
                      style: AppTypography.s14.medium,
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }

  // ===== Nhóm kiểm tra khác
  Widget _otherChecksSection() {
    // Có thể gắn từ API; ví dụ đặt sẵn details để demo
    final checks = <Map<String, dynamic>>[
      {
        'label': LocaleKeys.screen_check.trans(),
        'details': [
          {'name': LocaleKeys.touch.trans(), 'ok': true},
          {'name': LocaleKeys.dead_pixel.trans(), 'ok': true},
          {'name': LocaleKeys.screen_tint.trans(), 'ok': false},
          {'name': LocaleKeys.earpiece.trans(), 'ok': true},
        ],
      },
      {
        'label': 'Chức năng thiết bị',
        'details': [
          {'name': LocaleKeys.bluetooth.trans(), 'ok': true},
          {'name': LocaleKeys.wifi.trans(), 'ok': true},
          {'name': LocaleKeys.gps.trans(), 'ok': true},
          {'name': LocaleKeys.nfc.trans(), 'ok': false},
        ],
      },
      {
        'label':LocaleKeys.repair_water_damage.trans(),
        'details': [
          {'name': LocaleKeys.motherboard_seal.trans(), 'ok': true},
        ],
      },
    ];

    return Column(
      children: List.generate(checks.length, (index) {
        final item = checks[index];
        final details = (item['details'] as List<Map<String, dynamic>>);
        final count = details.length;

        return Obx(() {
          final expanded = controller.expandedOtherChecks.contains(index);
          return Column(
            children: [
              // Header row
              InkWell(
                onTap: () => controller.toggleOtherCheck(index),
                borderRadius: BorderRadius.circular(8.r),
                child: Padding(
                  padding: EdgeInsets.symmetric(vertical: 8.h),
                  child: Row(
                    children: [
                      // Nhãn
                      Expanded(
                        child: Text(
                          item['label'] as String,
                          style: AppTypography.s14.medium,
                        ),
                      ),
                      // icon info + số mục
                      Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Icon(
                            Icons.info_outline_rounded,
                            size: 16.w,
                            color: AppColors.neutral03,
                          ),
                          SizedBox(width: 6.w),
                          Text(
                            '$count ${LocaleKeys.repair_water_damage.trans()}',
                            style: AppTypography.s12.regular.withColor(
                              AppColors.neutral04,
                            ),
                          ),

                          SizedBox(width: 4.w),
                          AnimatedRotation(
                            turns: expanded ? 0.5 : 0.0, // xoay 180°
                            duration: const Duration(milliseconds: 200),
                            child: Icon(
                              Icons.keyboard_arrow_down_rounded,
                              size: 18.w,
                              color: AppColors.neutral03,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),

              // Nội dung chi tiết (dropdown)
              AnimatedSwitcher(
                duration: const Duration(milliseconds: 220),
                switchInCurve: Curves.easeOut,
                switchOutCurve: Curves.easeIn,
                child:
                    !expanded
                        ? const SizedBox.shrink()
                        : Padding(
                          key: ValueKey('expanded_$index'),
                          padding: EdgeInsets.only(
                            left: 0,
                            right: 0,
                            bottom: 8.h,
                          ),
                          child: Column(
                            children: List.generate(details.length, (i) {
                              final d = details[i];
                              final ok = d['ok'] as bool;
                              return Padding(
                                padding: EdgeInsets.symmetric(vertical: 6.h),
                                child: Row(
                                  children: [
                                    Icon(
                                      ok
                                          ? Icons.check_circle_rounded
                                          : Icons.cancel_rounded,
                                      size: 18.w,
                                      color:
                                          ok ? Colors.green : Colors.redAccent,
                                    ),
                                    SizedBox(width: 8.w),
                                    Expanded(
                                      child: Text(
                                        d['name'] as String,
                                        style: AppTypography.s14.regular
                                            .withColor(AppColors.neutral02),
                                      ),
                                    ),
                                    Text(
                                      ok ? 'Đạt' : 'Chưa đạt',
                                      style: AppTypography.s12.medium.withColor(
                                        ok ? Colors.green : Colors.redAccent,
                                      ),
                                    ),
                                  ],
                                ),
                              );
                            }),
                          ),
                        ),
              ),

              // Divider giữa các item
              // if (index != checks.length - 1)
              //   Divider(height: 12.h, color: Colors.grey[300]),
            ],
          );
        });
      }),
    );
  }
}

Future<void> _openImagePreview(int initialIndex) async {
  final images = Get.find<DetailProductController>().productImages;
  if (images.isEmpty) return;

  final pageCtrl = PageController(initialPage: initialIndex);

  await showGeneralDialog(
    context: Get.context!,
    barrierDismissible: true,
    barrierLabel: 'Image viewer',
    barrierColor: Colors.black87,
    transitionDuration: const Duration(milliseconds: 200),
    pageBuilder: (_, __, ___) => const SizedBox.shrink(),
    transitionBuilder: (ctx, anim, __, child) {
      final curved = Curves.easeOutCubic.transform(anim.value);
      return Opacity(
        opacity: anim.value,
        child: Transform.scale(
          scale: 0.98 + 0.02 * curved,
          child: Dialog(
            backgroundColor: Colors.black,
            insetPadding: EdgeInsets.zero,
            child: Stack(
              children: [
                PhotoViewGallery.builder(
                  pageController: pageCtrl,
                  backgroundDecoration: const BoxDecoration(
                    color: Colors.black,
                  ),
                  itemCount: images.length,
                  builder:
                      (ctx, i) => PhotoViewGalleryPageOptions(
                        imageProvider: NetworkImage(images[i]),
                        minScale: PhotoViewComputedScale.contained,
                        maxScale: PhotoViewComputedScale.covered * 3.0,
                        // Hero tag TRÙNG với tag ở thumbnail: 'inspect_$i'
                        heroAttributes: PhotoViewHeroAttributes(
                          tag: 'inspect_$i',
                        ),
                        errorBuilder:
                            (_, __, ___) => const Center(
                              child: Icon(
                                Icons.broken_image,
                                color: Colors.white70,
                                size: 40,
                              ),
                            ),
                      ),
                ),

                // Nút đóng
                Positioned(
                  top: MediaQuery.of(ctx).padding.top + 8,
                  right: 8,
                  child: IconButton(
                    icon: const Icon(Icons.close, color: Colors.white),
                    onPressed: () => Navigator.of(ctx).pop(),
                  ),
                ),

                // Badge chỉ số trang
                Positioned(
                  bottom: MediaQuery.of(ctx).padding.bottom + 16,
                  right: 16,
                  child: AnimatedBuilder(
                    animation: pageCtrl,
                    builder: (_, __) {
                      final page =
                          pageCtrl.hasClients && pageCtrl.page != null
                              ? pageCtrl.page!.round()
                              : initialIndex;
                      return Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 12,
                          vertical: 6,
                        ),
                        decoration: BoxDecoration(
                          color: Colors.black.withOpacity(0.6),
                          borderRadius: BorderRadius.circular(12),
                          border: Border.all(color: Colors.white10),
                        ),
                        child: Text(
                          '${page + 1}/${images.length}',
                          style: AppTypography.s12.medium.withColor(
                            Colors.white,
                          ),
                        ),
                      );
                    },
                  ),
                ),
              ],
            ),
          ),
        ),
      );
    },
  );

  // (tuỳ chọn) giải phóng controller khi đóng
  pageCtrl.dispose();
}

// void _openImagePreview(int index) {
//
//   final url = DetailProductController().productImages[index];
//   Get.dialog(
//     GestureDetector(
//       onTap: Get.back,
//       child: Container(
//         color: Colors.black87,
//         alignment: Alignment.center,
//         child: TweenAnimationBuilder<double>(
//           tween: Tween(begin: .95, end: 1),
//           duration: const Duration(milliseconds: 200),
//           curve: Curves.easeOutCubic,
//           builder: (_, scale, child) => Transform.scale(scale: scale, child: child),
//           child: Hero(
//             tag: 'inspect_$url\_$index',
//             child: InteractiveViewer(
//               minScale: 0.8,
//               maxScale: 4,
//               child: ClipRRect(
//                 borderRadius: BorderRadius.circular(12.r),
//                 child: Image.network(url, fit: BoxFit.contain),
//               ),
//             ),
//           ),
//         ),
//       ),
//     ),
//     barrierColor: Colors.black87,
//   );
// }
