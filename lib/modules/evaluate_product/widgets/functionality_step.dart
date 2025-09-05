import 'package:fido_box_demo01/core/assets/locale_keys.g.dart';
import 'package:fido_box_demo01/core/extensions/string_extension.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../core/assets/assets.gen.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_typography.dart';

class FunctionalityStep extends StatefulWidget {
  final ValueChanged<List<Map<String, dynamic>>> onSelected;

  const FunctionalityStep({super.key, required this.onSelected});

  @override
  State<FunctionalityStep> createState() => _FunctionalityStepState();
}

class _FunctionalityStepState extends State<FunctionalityStep> {
  final List<Map<String, dynamic>> options = [
    {'label': LocaleKeys.item_abnormal_vibration.trans(), 'icon': Assets.images.icRungbatthuong.path, 'offset': -50000},
    {'label': LocaleKeys.item_abnormal_sensor.trans(), 'icon': Assets.images.icCambienbatthuong.path, 'offset': -80000},
    {'label': LocaleKeys.item_abnormal_charging_port_headphone.trans(), 'icon': Assets.images.icCongsactainghebatthuong.path, 'offset': -70000},
    {'label': LocaleKeys.item_battery_swollen_leak.trans(), 'icon': Assets.images.icPinphong.path, 'offset': -120000},
    {'label': LocaleKeys.item_fingerprint_faceid_not_recognized.trans(), 'icon': Assets.images.icVantayfaceid.path, 'offset': -100000},
    {'label': LocaleKeys.item_button_slot_malfunction.trans(), 'icon': Assets.images.icNutbamkhecamloi.path, 'offset': -40000},
    {'label': LocaleKeys.item_mainboard_repaired.trans(), 'icon': Assets.images.icMainboarddasuachua.path, 'offset': -200000},
    {'label':LocaleKeys.item_signs_of_repair.trans(), 'icon': Assets.images.icCodauvetsuachua.path, 'offset': -100000},
    {'label': LocaleKeys.item_bent_frame.trans(), 'icon': Assets.images.icThanmaybicong.path, 'offset': -60000},
    {'label': LocaleKeys.item_water_damage.trans(), 'icon': Assets.images.icMaybivaonuoc.path, 'offset': -150000},
    {'label': LocaleKeys.item_bs_device.trans(), 'icon': Assets.images.icMaybs.path, 'offset': -100000},
    {'label': LocaleKeys.item_official_repair.trans(), 'icon': Assets.images.icMaybs.path, 'offset': -70000},
    {'label': LocaleKeys.item_serial_changed.trans(), 'icon': Assets.images.icThaydoiseri.path, 'offset': -90000},
    {'label': LocaleKeys.item_camera_spot_defect.trans(), 'icon': Assets.images.icCamerabidom.path, 'offset': -110000},
    {'label': LocaleKeys.item_abnormal_flash.trans(), 'icon': Assets.images.icFlashbatthuong.path, 'offset': -30000},
    {'label':LocaleKeys.item_slow_touch.trans(), 'icon': Assets.images.icCamungcham.path, 'offset': -40000},
    {'label': LocaleKeys.item_abnormal_signal.trans(), 'icon': Assets.images.icTinhieubatthuong.path, 'offset': -60000},
    {'label': LocaleKeys.item_abnormal_wifi_bluetooth_nfc.trans(), 'icon': Assets.images.icWifibatthuong.path, 'offset': -80000},
    {'label': LocaleKeys.item_abnormal_speaker_mic.trans(), 'icon': Assets.images.icLoamicbatthuong.path, 'offset': -50000},
  ];

  final RxList<Map<String, dynamic>> selected = <Map<String, dynamic>>[].obs;

  void toggleOption(Map<String, dynamic> option) {
    final label = option['label'];
    final existing = selected.indexWhere((e) => e['label'] == label);
    if (existing >= 0) {
      selected.removeAt(existing);
    } else {
      selected.add(option);
    }
    widget.onSelected(selected);
  }

  bool isSelected(String label) =>
      selected.any((e) => e['label'] == label);

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      return Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Text(
                  'Chức năng',
                  style: AppTypography.s14.regular.withColor(AppColors.neutral01),
                ),

                GestureDetector(
                    onTap:()=> Get.dialog(
                      AlertDialog(
                        backgroundColor: AppColors.white,
                        title: Text('Chức năng'),
                        content: Text('Chức năng'),
                        actions: [
                          TextButton(
                            onPressed: () => Get.back(),
                            child: const Text('OK'),
                          ),
                        ],
                      ),
                    ),
                    child: Icon(Icons.help_outline, size: 16, color: Colors.grey)),
              ],
            ),
            const SizedBox(height: 16),
            GridView.count(
              crossAxisCount: 2,
              shrinkWrap: true,
              mainAxisSpacing: 12,
              crossAxisSpacing: 12,
              physics: const NeverScrollableScrollPhysics(),
              childAspectRatio: 3.5,
              children: options.map((item) {
                final label = item['label']!;
                final iconPath = item['icon']!;
                final selectedNow = isSelected(label);

                return GestureDetector(
                  onTap: () => toggleOption(item),
                  child: Container(
                    decoration: BoxDecoration(
                      color: selectedNow
                          ? AppColors.white
                          : AppColors.neutral08,
                      border: Border.all(
                        color: selectedNow
                            ? AppColors.primary01
                            : Colors.transparent,
                        width: 1.5,
                      ),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    padding: const EdgeInsets.symmetric(horizontal: 12),
                    alignment: Alignment.centerLeft,
                    child: Row(
                      children: [
                        Image.asset(
                          iconPath,
                          width: 30,
                          height: 30,
                          color: AppColors.black,
                        ),
                        const SizedBox(width: 8),
                        Expanded(
                          child: Text(
                            label,
                            style: AppTypography.s12.regular.withColor(
                              AppColors.black,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              }).toList(),
            ),
          ],
        ),
      );
    });
  }
}
