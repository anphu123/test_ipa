import 'package:fido_box_demo01/core/extensions/string_extension.dart';
import 'package:fido_box_demo01/modules/personal_profile/controllers/personal_profile_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:scrollable_positioned_list/scrollable_positioned_list.dart';

import '../../../core/assets/assets.gen.dart';
import '../../../core/assets/locale_keys.g.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_typography.dart';
import '../domain/list_area.dart';

class AreaScreen extends StatefulWidget {
  const AreaScreen({super.key});

  @override
  State<AreaScreen> createState() => _AreaScreenState();
}

class _AreaScreenState extends State<AreaScreen> {


  final ItemScrollController _scrollController = ItemScrollController();
  late Map<String, int> _indexMap;
  final controller = Get.find<PersonalProfileController>();

  @override
  void initState() {
    super.initState();
    _indexMap = _generateIndexMap();

    // Lấy vị trí hiện tại (nhưng không set làm mặc định)
    Future.delayed(Duration.zero, () async {
      await controller.requestAndGetCityName();
    });
  }

  Map<String, int> _generateIndexMap() {
    final map = <String, int>{};
    for (int i = 0; i < areas.length; i++) {
      final firstChar = areas[i][0].toUpperCase();
      map.putIfAbsent(firstChar, () => i);
    }
    return map;
  }

  void _scrollToLetter(String letter) {
    if (_indexMap.containsKey(letter)) {
      final index = _indexMap[letter]!;
      _scrollController.scrollTo(
        index: index,
        duration: const Duration(milliseconds: 300),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final letters = List.generate(26, (i) => String.fromCharCode(65 + i));

    return Scaffold(
      backgroundColor: AppColors.neutral08,
      appBar: AppBar(
        backgroundColor: AppColors.white,
        surfaceTintColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_new_rounded),
          onPressed: () => Get.back(),
        ),
        title: Text(
          LocaleKeys.area.trans(),
          style: AppTypography.s20.medium.withColor(AppColors.neutral01),
        ),
        centerTitle: true,
      ),
      body: Stack(
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: EdgeInsets.symmetric(vertical: 12.h, horizontal: 16.w),
                child: Text(
                  LocaleKeys.current_location.trans(),
                  style: AppTypography.s16.semibold.withColor(
                    AppColors.neutral01,
                  ),
                ),
              ),
              Obx(() {
                final detected = controller.detectedCity.value;
                final selected = controller.area.value;
                final isSelected = detected == selected;

                return GestureDetector(
                  onTap: () async {
                    if (detected.isNotEmpty) {
                      await controller.setArea(detected);
                     // Get.back(result: detected); // nếu muốn pop về luôn
                      result: detected;
                    } else {
                      await controller.requestAndGetCityName();
                    }
                  },
                  child: Container(
                   // margin: EdgeInsets.symmetric(horizontal: 16.w),
                    padding: EdgeInsets.all(16.w),
                    decoration: BoxDecoration(
                      color: AppColors.white,
                     // borderRadius: BorderRadius.circular(12.r),

                    ),
                    child: Row(
                      children: [
                         Container(
                           width: 26.w,
                           height: 26.w,
                           child: Image.asset(
                            Assets.images.icLocal.path,
                            color: AppColors.primary01,

                             fit: BoxFit.fill,
                                                   ),
                         ),
                        SizedBox(width: 12.w),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                LocaleKeys.enable_location_tip.trans(),
                                style: AppTypography.s14.medium.withColor(
                                  AppColors.neutral01,
                                ),
                              ),
                              SizedBox(height: 4.h),
                              Text(
                                detected.isNotEmpty
                                    ?  "$detected"
                                    : "Nhấn để lấy vị trí hiện tại",
                                style: AppTypography.s12.regular.withColor(
                                  AppColors.neutral04,
                                ),
                              ),
                            ],
                          ),
                        ),
                        if (isSelected)
                          Icon(Icons.check_circle, color: AppColors.primary01)

                      ],
                    ),
                  ),
                );
              }),
              const SizedBox(height: 8),
              Expanded(
                child: ScrollablePositionedList.builder(
                  itemScrollController: _scrollController,
                  itemCount: areas.length,
                  itemBuilder: (context, index) {
                    final current = areas[index];
                    final previous = index > 0 ? areas[index - 1] : null;
                    final currentChar = current[0].toUpperCase();
                    final showHeader =
                        previous == null ||
                        previous[0].toUpperCase() != currentChar;

                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        if (showHeader)
                          Container(
                            width: double.infinity,
                            padding: EdgeInsets.symmetric(
                              horizontal: 16.w,
                              vertical: 4.h,
                            ),
                            child: Text(
                              currentChar,
                              style: AppTypography.s16.semibold.withColor(
                                AppColors.neutral01,
                              ),
                            ),
                          ),
                        Container(
                          color: AppColors.white,
                          child: ListTile(
                            title: Text(current,style: AppTypography.s14.regular.withColor(AppColors.neutral01),),
                            trailing: Obx(
                              () =>
                                  controller.area.value == current
                                      ?  Icon(Icons.check_circle, color: AppColors.primary01)
                                      :  SizedBox.shrink(),
                            ),
                            onTap: () {
                              controller.setArea(current);
                            },
                          ),
                        ),

                      ],
                    );
                  },

                ),
              ),
            ],
          ),
          Positioned(
            right: 15,
            top: 150.h,
            bottom: 40.h,
            child: Column(
              children: [
                Text(LocaleKeys.all.trans(),style: AppTypography.s10.regular.withColor(AppColors.primary01),),
                Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children:
                  letters.map((letter) {
                    return GestureDetector(
                      onTap: () => _scrollToLetter(letter),
                      child: Padding(
                        padding: EdgeInsets.symmetric(vertical: 1.h), // Giảm spacing
                        child: Text(
                          letter,
                          style: AppTypography.s10.regular.copyWith(
                            color: AppColors.neutral01,
                          ),
                        ),
                      ),
                    );
                  }).toList(),
                ),
              ],
            ),
          ),

        ],
      ),
    );
  }
}
